Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224ACC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D8420844
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="HYqf2z5e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390596AbfA1QiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:38:14 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41795 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390283AbfA1QiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:38:10 -0500
Received: by mail-wr1-f65.google.com with SMTP id x10so18766004wrs.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 08:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fyBQQHTr8PUOvMNC5TSDB366cWfD8A0+KHCn5LVVNH8=;
        b=HYqf2z5eD3+QLpuQsIa8Phc08x0KnTYkWPWdqhent4WHaKgV4AbHrdtuSEnDNKkNea
         scxM5Kd1hkFVFFI5IHpusyuIjntVpb2gnbFpH79sCOqq5mBgtfdPApxIgeCI0uoboDz7
         CmTfvBuda3ITtikhX8QxoAqgbZAQgO/hztL1G88Gyxh6/tf2cqnOxQ6OKQGiCFlpfKq8
         7Ld2pI88cmWYyySZhmb1YoxRZF0HfbJauuKsWpbg9ssVMXAv3mh09+s0BgXqfyLxXxxH
         ghdjIouftGV65Hgm1OLT7E7tq70USf2NZLEJlM8dJ8EREsqhBC09RG5Na/qrCNvsNWyJ
         +BTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fyBQQHTr8PUOvMNC5TSDB366cWfD8A0+KHCn5LVVNH8=;
        b=RCC75bN5t6XrkemvmDTQahGmme++L6OXw5UcjulFN4VIrN1E8NDqUNc4qaFuRUiFc8
         6jyH5zHedLMKQ9CkFGj1SeXOmEmTnfTY3rOOLFalWZs4dJprNjgFWmhYWnZXnqnROpdD
         m60o4f5Y+jkCM6kfNJfxHQ23qMzDQWVAQ3tLLbBkmCDNA7dPsm4Zy2d1mAv17CJgsgJn
         G+B0OmJA1JlYx9WI/uwhKMkB0GP+h+r5xpnEoZfxeZ256Y7Tla9QgB7BYoQ6AvH6hPX9
         rbV3MuSj3uwV4skm6lFeps2MGQjfVpMrHyhrESbXnlyi5Ff8qa5wWvw3dz8gSfIZZL+M
         Aguw==
X-Gm-Message-State: AJcUukfudIyMGRNbAjFkCd1XKTnbXRYvHDTp5i85GrtybXqhPfdx4X/c
        t5KLTAHAZluMdautM44j8tqwLQ==
X-Google-Smtp-Source: ALg8bN4/B4SWxIm7vCUbRYvn874M1dL1HvhVWIsz6SyWTxC8hna3Zz/YBgIob2CzSREhZRSEL60eAA==
X-Received: by 2002:adf:eec9:: with SMTP id a9mr22139027wrp.242.1548693489225;
        Mon, 28 Jan 2019 08:38:09 -0800 (PST)
Received: from loys-ubuntu-BY1835A49200471.thefacebook.com ([2620:10d:c092:180::1:d40b])
        by smtp.googlemail.com with ESMTPSA id s3sm52388982wmj.23.2019.01.28.08.38.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jan 2019 08:38:08 -0800 (PST)
From:   Loys Ollivier <lollivier@baylibre.com>
To:     devicetree@vger.kernel.org, Johan Hovold <johan@kernel.org>
Cc:     Loys Ollivier <lollivier@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 3/4] gnss: add mtk receiver type support
Date:   Mon, 28 Jan 2019 17:38:00 +0100
Message-Id: <1548693481-1162-4-git-send-email-lollivier@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548693481-1162-1-git-send-email-lollivier@baylibre.com>
References: <1548693481-1162-1-git-send-email-lollivier@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an MTK (Mediatek) type to the "GNSS_TYPE" attribute.

Note that MTK receivers support a subset of NMEA 0183 with vendor
extensions.

Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
---

v3:
Moved the gnss_type_names string addition to this patch.
Edited the commit message to remove the reference to a vendor protocol.

v2: renamed from GTOP to MTK.

 drivers/gnss/core.c  | 1 +
 include/linux/gnss.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gnss/core.c b/drivers/gnss/core.c
index 4291a0dd22aa..320cfca80d5f 100644
--- a/drivers/gnss/core.c
+++ b/drivers/gnss/core.c
@@ -334,6 +334,7 @@ static const char * const gnss_type_names[GNSS_TYPE_COUNT] = {
 	[GNSS_TYPE_NMEA]	= "NMEA",
 	[GNSS_TYPE_SIRF]	= "SiRF",
 	[GNSS_TYPE_UBX]		= "UBX",
+	[GNSS_TYPE_MTK]		= "MTK",
 };
 
 static const char *gnss_type_name(struct gnss_device *gdev)
diff --git a/include/linux/gnss.h b/include/linux/gnss.h
index 43546977098c..36968a0f33e8 100644
--- a/include/linux/gnss.h
+++ b/include/linux/gnss.h
@@ -22,6 +22,7 @@ enum gnss_type {
 	GNSS_TYPE_NMEA = 0,
 	GNSS_TYPE_SIRF,
 	GNSS_TYPE_UBX,
+	GNSS_TYPE_MTK,
 
 	GNSS_TYPE_COUNT
 };
-- 
2.7.4

