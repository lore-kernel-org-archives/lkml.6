Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CD0C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFDE1216F6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4qMTl/C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFDE1216F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbeHHKvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 06:51:54 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41473 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbeHHKvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 06:51:53 -0400
Received: by mail-lf1-f65.google.com with SMTP id v22-v6so973711lfe.8;
        Wed, 08 Aug 2018 01:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5jNYqFGqsTmLYU6EQCX6nydD2pP0Mk0WiscwC0aLeX4=;
        b=G4qMTl/ChPL2O7zYJKYkvXi7KU4LXYll7arQMbCle28asVGMoVh0WFnwmtkCbTGBDw
         mu5MO6HXy7k7vnDAsw6y6WmgXxLN89gRRrmn+FCMddJpvzd8zqnob2At3vT3OpbbcxEa
         aC81wLam711eCV/+fTrih/g4omxupquaNnQBJLrymseE8lsQ8HNOU61tLrO6F5e21Hja
         lkjGlrNA730RLhBR6b6AFksRwCMHfoeb5a4voEwj4AXYpSdvOgTQHl9poJpHwUloCcpW
         5JNIIjV6qVutmO1f4aZRUbTb9rIo3ufZ5PlQOVt5TkIa4zAFC4TvBoxHhADAgP/7sPe/
         Aoug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5jNYqFGqsTmLYU6EQCX6nydD2pP0Mk0WiscwC0aLeX4=;
        b=SjTlzX6pXWnYlM4QeJWf2zoQ+tsKZnt8lgMfXNUXEYAyR1wSF0SFnVXmKToJY6FQV2
         S/Km4SlUFuTjkpQiRUKAfnYzBALLnHIIBVUhZrOg8rKuW1V0sbdBqrBYZjhb3xStHbmO
         rXVmRgDEYg9giCVFPgTJPR3XXGJmvKUSXBBKQFxD56hYNW4O9S13OX2qqbvE+7a3PaPM
         lza14GHLjlzxnAAQzxor7Twf6Dq7Z5SJJfawaifXXDuJRhJ+Xc4zv8V8DYGhQenyWLUZ
         1ctKAu8yskHmIJJnbcoALDr+OMpmT6WYtUk8pxslQB4OOOofFouqr3sDsuNfZ5hRHCuQ
         yLPA==
X-Gm-Message-State: AOUpUlEA5tEMzDYhNLyS0NiW14C6G5K+ltVoGFMIzfrCBeM5cMsG3b9C
        vHAAoVcCjEmvJ9W9jbHL0u8=
X-Google-Smtp-Source: AA+uWPxx943O/+Yw2eJt50rV1DMiI9yHA2kcaTqyvIvrA35//U0MlL3mktOZ78aC13xEqZBjXO5m3A==
X-Received: by 2002:a19:d819:: with SMTP id p25-v6mr1227226lfg.36.1533717193285;
        Wed, 08 Aug 2018 01:33:13 -0700 (PDT)
Received: from localhost.localdomain (c-2ec252a3-74736162.cust.telenor.se. [46.194.82.163])
        by smtp.gmail.com with ESMTPSA id f136-v6sm708782lfe.71.2018.08.08.01.33.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 01:33:12 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] MAINTAINERS: Add entry for mcp3911 ADC driver
Date:   Wed,  8 Aug 2018 10:09:17 +0200
Message-Id: <20180808080917.2427-3-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.11.0.rc2
In-Reply-To: <20180808080917.2427-1-marcus.folkesson@gmail.com>
References: <20180808080917.2427-1-marcus.folkesson@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for mcp3911 ADC driver and add myself and
Kent Gustavsson as maintainers of this driver.

Co-Developed-by: Kent Gustavsson <kent@minoris.se>
Signed-off-by: Kent Gustavsson <kent@minoris.se>
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Notes:
    v4:
    	- add Kent as co-developer
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

