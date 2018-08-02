Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A05C46463
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D323D21566
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSbFtHmE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D323D21566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731948AbeHBVcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 17:32:22 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40734 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728708AbeHBVcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 17:32:22 -0400
Received: by mail-lj1-f194.google.com with SMTP id j19-v6so2931368ljc.7;
        Thu, 02 Aug 2018 12:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VNX6nSfiv+40gzs67H87mfYLCeqZIwWSiY010Qj0R0A=;
        b=DSbFtHmETjkZLdWe4gvDCdBsOgpbBFdBGyBnbWLBp0uwiqw5cofD6e8wPm/oxhM0o4
         qLf6nQfHKnN8NpJ+rbS1gVUVRylzSL3XAWk41EJtjMO7ApBQuf9yg1OE7sQgdHLjtGJ1
         +uHGWWMr+VRIzUeph+2F9BR1w5iXPgf70Z0LC/xzWDtXT3ife6oEF3VoxrejBwCeBsmZ
         2YkePihEme8LVPPqKM+Eb5HgZp2tua3QYLZEvzCR4jV5QLRSrDkyCWDSjJbkbF1/5jVv
         FUuutJ+Tpg+7gUEdHmExzUVQeJ1UcSn404nWo8o9qiTIlOFvf0YCeL41DSO9r/MmY7jD
         XmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VNX6nSfiv+40gzs67H87mfYLCeqZIwWSiY010Qj0R0A=;
        b=hEVmjWrkeSINFk3DISKslKKphLhUb90kh7zF0F9+TtiQvf8V6pMJ3U6auEEmRrPf9q
         jj1fBf1pWmCEGke1gMOEje36tKU4utYSmcbSBXTEYuaXq7e7SC2AJiqS39RUEPWwLPvi
         FOkF4pFmUYAjRCF4UQaLoqdptjUj+nxTFmb9azgnZdtIdW2K6+wYE3L0OC1Oa/9CKGKj
         eTolirByVT/505tNrT8j7HGt/Z5mnCD7ynTGX7K2pCIdl8qKmHXVgy+tEP/seVjv/rlG
         BvbD8dcMozWX6Dush7YZyoCVWJQsxuEUgv9wtkFxVKA4fkX6eAm/vO2unlXzrlDzE9Cm
         Czyw==
X-Gm-Message-State: AOUpUlG6cXWlM2GZ4su4fmYF4sw9vxMQx0vR46Rsh3sEQPvXD5W3+l6N
        Uv5+Y03T8IqEHQW7ZhE+NtA=
X-Google-Smtp-Source: AAOMgpccOUmF5v/VqwyC7zTTUlXZDBZLhbO5IaTKFzC/Dza5dtyC9HFMeSNMueu5K0z0TF3VOE/6WA==
X-Received: by 2002:a2e:1dc8:: with SMTP id w69-v6mr3377413lje.110.1533238786604;
        Thu, 02 Aug 2018 12:39:46 -0700 (PDT)
Received: from localhost.localdomain (c-2ec26f15-74736162.cust.telenor.se. [46.194.111.21])
        by smtp.gmail.com with ESMTPSA id m71-v6sm534508lje.84.2018.08.02.12.39.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 12:39:45 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] MAINTAINERS: Add entry for mcp3911 ADC driver
Date:   Thu,  2 Aug 2018 21:15:54 +0200
Message-Id: <20180802191554.20176-3-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.11.0.rc2
In-Reply-To: <20180802191554.20176-1-marcus.folkesson@gmail.com>
References: <20180802191554.20176-1-marcus.folkesson@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for mcp3911 ADC driver and add myself and
Kent Gustavsson as maintainers of this driver.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Signed-off-by: Kent Gustavsson <kent@minoris.se>
---

Notes:
    v3:
    	- no changes
    v2:
    	- no changes

 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 79bb02ff812f..9276da915d9d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9271,6 +9271,14 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/microchip/lan743x_*
 
+MICROCHIP / ATMEL MCP3911 ADC DRIVER
+M:	Marcus Folkesson <marcus.folkesson@gmail.com>
+M:	Kent Gustavsson <kent@minoris.se>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+F:	drivers/iio/adc/mcp3911.c
+F:	Documentation/devicetree/bindings/iio/adc/mcp3911.txt
+
 MICROCHIP USB251XB DRIVER
 M:	Richard Leitner <richard.leitner@skidata.com>
 L:	linux-usb@vger.kernel.org
-- 
2.11.0.rc2

