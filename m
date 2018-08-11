Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D513C46470
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 20:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0255A21A05
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 20:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khJxvAGi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0255A21A05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbeHKXBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 19:01:55 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46145 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727396AbeHKXBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 19:01:54 -0400
Received: by mail-lf1-f68.google.com with SMTP id l16-v6so8766988lfc.13;
        Sat, 11 Aug 2018 13:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eNoo+LB43HEuzKB7MjlaA6QwKj5MPnAdvMjJ0GsAR0I=;
        b=khJxvAGiJ9bDndO2moIdwRzAvyKbLjW9cdnbN0R5gITJtn3xdZHBxXwuNM/Et9pEQt
         SmSYb2HvEJmdeQrPq18obnEmA11l5HNpYqsBWePx4Xux4ZZOjpYeKiGs6SuWne3PvNQe
         xb6iDTb4lJe0MKPv3OgzFD6E7dftnbHBN+lIW5FSEIrxi7x6YxRP3Bo61usCFsmy+1rn
         xHyG6XhVUUVROixcv/iy4QXFDFQFMjy/D6CFlCPFO8+jtYWzLFlZmxjT/M3C26Mjs2Vx
         suaPSmHhFscXyHLl6T+V2ba1H+ygg0jlmzDTk3Xa+RyRhaWW4k06w962+wZiz8WEM5k7
         ijAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eNoo+LB43HEuzKB7MjlaA6QwKj5MPnAdvMjJ0GsAR0I=;
        b=pvP1W2PGBrDgXmDlYCkjuyIOj8p2ovm+V4dlEjbFo3NNFfnpmMEY/FwHiGw82d3Eha
         Kp9OxSjqRCLsLjEfKpB9FAcQ3Vjw2WgeeVtIt01VyALjYQP4gyiJsGaF+bAJuM5t/naR
         VTV8KlhVC0NmU7iOOlP5hKzF7dJWtEmkBuOFDN1hon3QBeLdCYGXWFGDhFGOLTYQPmoy
         KOolqkW0IDOvesLIqfIWMmpNyOMOwAnNcqwYn2hgK5WZI8Gkf/jgXsCUMnAfbJmeH4b6
         vvBiqueZ+EFgskltT7hFMdV5RiBZTGLKXZtsBiCcjZT+D2tnDEG3Gf8EeyAOeECTqAGb
         YlVw==
X-Gm-Message-State: AOUpUlHiHgZfi3QZXJqPZC2KMNlgiL4X7ZbpGpwEh3vQInGmCeBYO8vF
        6+RP94s5JfCk2ZGBvOFI5Zk=
X-Google-Smtp-Source: AA+uWPzZT1VeeGPMXjc0TQAt5ICWAlOXIe7+OIdYiUAcj/SoPgW0yDQWpL+3A5qLyFr/AHXER4TK+w==
X-Received: by 2002:a19:95c9:: with SMTP id x192-v6mr7220722lfd.37.1534019193590;
        Sat, 11 Aug 2018 13:26:33 -0700 (PDT)
Received: from localhost.localdomain (c-2ec2e3af-74736162.cust.telenor.se. [46.194.227.175])
        by smtp.gmail.com with ESMTPSA id d10-v6sm2430353lfk.63.2018.08.11.13.26.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Aug 2018 13:26:32 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] MAINTAINERS: add entry for ltc166x DAC driver
Date:   Sat, 11 Aug 2018 22:02:26 +0200
Message-Id: <20180811200226.28776-3-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.11.0.rc2
In-Reply-To: <20180811200226.28776-1-marcus.folkesson@gmail.com>
References: <20180811200226.28776-1-marcus.folkesson@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entry for ltc166x DAC driver and add myself as
maintainer of this driver.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9276da915d9d..2dc4c773fb2e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8363,6 +8363,13 @@ L:	linux-scsi@vger.kernel.org
 S:	Maintained
 F:	drivers/scsi/sym53c8xx_2/
 
+LTC166X DAC DRIVER
+M:	Marcus Folkesson <marcus.folkesson@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/dac/ltc166x.txt
+F:	drivers/iio/dac/ltc166x.c
+
 LTC4261 HARDWARE MONITOR DRIVER
 M:	Guenter Roeck <linux@roeck-us.net>
 L:	linux-hwmon@vger.kernel.org
-- 
2.11.0.rc2

