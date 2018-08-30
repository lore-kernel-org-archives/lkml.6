Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7C9C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB7B420658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiibwLdS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB7B420658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbeH3TsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:48:19 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37930 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbeH3TsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:48:17 -0400
Received: by mail-wm0-f67.google.com with SMTP id t25-v6so2496178wmi.3;
        Thu, 30 Aug 2018 08:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m9HSKer3qo7NlJvusjul6JsIn+NxC9/6alEw8B/KC/k=;
        b=iiibwLdS7N0B9ID4gjVEPs7HkFAeGvUubNGYDDNOV07qucdQKY13uaBNDTpIufpp0a
         qiFBm5mrsc2aKEcA1N+QN0YjRd+nIcgeDrWXY03HAma75dfrQayKUW5VF0Q6N743PyF7
         6hm006I4SoSicQPELV1Mn55HVrDiQ/69Z7F1W/7egJLYHlYNt7MGRhKF48kpI/EJ5J3V
         9R+LYZuuswJa+8RalklVMXEwq89BL0rqMyjcb5sSeB8RqdHoyZU8uyGk1WZsQakhHRdn
         bwMHZnamyja8uU5yaHUZGljp1MKRHNOEyD2AjA1OiT+kiPaxu5ADF8Nr9UjFG/S2P+q6
         wMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m9HSKer3qo7NlJvusjul6JsIn+NxC9/6alEw8B/KC/k=;
        b=JWcdasJLyMeyAzNdaxaqRjM7F1MAKJ1vbyn1Xvy/AgyjOv0qJnAs3P59GuDRleeSek
         +edcNbWO1UNGy4fIsmLo3PIkyRXyWZ3eyNslca4Ifs2scqooqMvSCaTja97jpl2nx0Ew
         vRCxGkk9MBUMkBis8yEvwELoX4LomWm5qJGVI09ZWr8WeAXQ0HDftigyIV5NKCNhPgk1
         B2WR7Ayv8b4YSxe+u43nyn5bMwEg5Nw/C7VpcJ+ZtcRVP10xvwGakzRC2auo6nQ2I2Yr
         FSKduWafZ2eiw8e2gGTgcpLEs1iZIRO74GicrRhzl4wL7TKwRGVrduCH5EHwNQMV1mJR
         MggQ==
X-Gm-Message-State: APzg51CbO9uyrTBJcPVGQ+b6fCX1kTTdn2JfP5SwLohdaCbn48PgFyio
        NGY8aaBeLhFrYVC4J8qbfhA=
X-Google-Smtp-Source: ANB0VdaFJAhWXJk78Cp9OiQ7ErZu6Y2oVsDKehJC0EBmwDHpPpfWkJ02s5JAn59gEXR0m8DSt46Ejw==
X-Received: by 2002:a1c:a8d0:: with SMTP id r199-v6mr2041463wme.97.1535643930663;
        Thu, 30 Aug 2018 08:45:30 -0700 (PDT)
Received: from debian-hp.wlan.uni-ulm.de (eduroam170-020.wlan.uni-ulm.de. [134.60.170.20])
        by smtp.gmail.com with ESMTPSA id j20-v6sm1362759wmh.9.2018.08.30.08.45.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 08:45:30 -0700 (PDT)
From:   Philipp Rossak <embed3d@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, linux@armlinux.org.uk,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, eugen.hristev@microchip.com,
        rdunlap@infradead.org, vilhelm.gray@gmail.com,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        geert+renesas@glider.be, lukas@wunner.de, icenowy@aosc.io,
        arnd@arndb.de, broonie@kernel.org, arnaud.pouliquen@st.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v3 11/30] iio: adc: add new compatibles
Date:   Thu, 30 Aug 2018 17:44:59 +0200
Message-Id: <20180830154518.29507-12-embed3d@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are now adding the new compatibles.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index a2027614ee0c..79b8efdab803 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -435,6 +435,18 @@ static const struct of_device_id sun4i_gpadc_of_id[] = {
 		.compatible = "allwinner,sun8i-a33-ths",
 		.data = &sun8i_a33_gpadc_data,
 	},
+	{
+		.compatible = "allwinner,sun4i-a10-gpadc",
+		.data = &sun4i_gpadc_data
+	},
+	{
+		.compatible = "allwinner,sun5i-a13-gpadc",
+		.data = &sun5i_gpadc_data
+	},
+	{
+		.compatible = "allwinner,sun6i-a31-gpadc",
+		.data = &sun6i_gpadc_data
+	},
 	{ /* sentinel */ }
 };
 
-- 
2.11.0

