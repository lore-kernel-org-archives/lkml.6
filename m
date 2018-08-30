Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C344C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5423220658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRuOW3x+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5423220658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbeH3Tuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:50:46 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37044 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbeH3TsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:48:12 -0400
Received: by mail-wm0-f67.google.com with SMTP id n11-v6so2499231wmc.2;
        Thu, 30 Aug 2018 08:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C/2oeBXZG2toeVaxCNErDpJ78AmhA9HYwAbujF41JBk=;
        b=HRuOW3x+mL/ZvNRvFqJCIIeFQQNu9h/tJfKgB5v3MbBkDgBtiof62xHrmjNnc7pYqM
         iTmH5yX5OTmpd7WIYd2t0hm1AfJfJvvOpii7hA6Wv2/PWlQ9cqlCMLulmuinfmcFv+RI
         FIT2tBUcQUgWT9yDCNYl6zr2GmD6DCH9H2L4zUOXIIs8fJ9AvVTym/37wuYHDGtPZbVK
         RZ8zZMjrAKBIetYy4PLEIcqAI+bs3IzgFq0l2awbp4HQ9fJGd+oNltqacQQtJrgh0fcq
         3agh3monCyBTiiB8J8OKohDiQND+UWp9FKkwTBMYLSKctOwVxhFnING93jk6AhWF8HiD
         pqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C/2oeBXZG2toeVaxCNErDpJ78AmhA9HYwAbujF41JBk=;
        b=A4Ai7xlPSEEB6i4SN/DJmt7Mbf+2q6Bkdok3IHe7tD+mYmJEreSCrn+pW7o6V39EMI
         2WHyYHvm0P6LWSTQBY+qnpxKSxTkPca+swDpFTSxjJqaVTQzRYmt7Yr+GSChkeOWQZyx
         eOz1Yer56heGUFAaEoNwILrkIB/a7sIGLoztRbnpSgrZhBMFXhZzkSsdOOGUXBZK9UjW
         akThRaReYfV5mO//6q5nX/iEpz0BPAOa/JYOAWjIfqFbNzU91oJHhoaGZe5Pflo8wTPl
         ylN/Xwx1qYl8i7ZtypndPIsYB7s+cuGtMXp574Px9QaQvlXGCT1vFtOfRzectWq6xsaC
         rPHQ==
X-Gm-Message-State: APzg51DgoTJvO/gWLxiNPri1JXaBSEwCA8FO8NcQeaCMp+ArIukjdC/8
        hyfgEeoBoxWDwt+HUPmbBv4=
X-Google-Smtp-Source: ANB0VdY5OJC4oBNA4YlKI1hMCWl+v+fAxR7nO0Q/xPnW4zGhwma0BGpFRT3R5qxowVxN+zetieEcrw==
X-Received: by 2002:a1c:64c:: with SMTP id 73-v6mr2090110wmg.7.1535643925668;
        Thu, 30 Aug 2018 08:45:25 -0700 (PDT)
Received: from debian-hp.wlan.uni-ulm.de (eduroam170-020.wlan.uni-ulm.de. [134.60.170.20])
        by smtp.gmail.com with ESMTPSA id j20-v6sm1362759wmh.9.2018.08.30.08.45.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 08:45:25 -0700 (PDT)
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
Subject: [PATCH v3 06/30] iio: adc: remove ofnode options
Date:   Thu, 30 Aug 2018 17:44:54 +0200
Message-Id: <20180830154518.29507-7-embed3d@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we are merging the mfd dirver into the adc driver we don't need
two different probing functions. Thus we remove the ofnode options

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 666329940e1e..d6f00d3b802d 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -622,10 +622,7 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
 	indio_dev->info = &sun4i_gpadc_iio_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	if (pdev->dev.of_node)
-		ret = sun4i_gpadc_probe_dt(pdev, indio_dev);
-	else
-		ret = sun4i_gpadc_probe_mfd(pdev, indio_dev);
+	ret = sun4i_gpadc_probe_dt(pdev, indio_dev);
 
 	if (ret)
 		return ret;
-- 
2.11.0

