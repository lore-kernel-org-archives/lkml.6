Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F1DC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8000621738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="cTbvSyZi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfA1SNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:13:33 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43493 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbfA1SNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:13:31 -0500
Received: by mail-wr1-f67.google.com with SMTP id r10so19127664wrs.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 10:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fNWFoC3BVYguxhRUMdCWIfb/Rl7MMG8+du2R0BO4wEY=;
        b=cTbvSyZi34BO7xbHL7VjC4d2IpWNxC+mgHDwmQWegRazQajEzWNV54xiBuCNp/moMT
         HROWKjnIbA7JvT2vO0syVqfu//FmOgrFwOLFNMtFi8pr8Tq0FtjLa5c9XCQIPsJH+zFD
         O+ZmTWk8/TBzXmYurL45pGsohZ3RAFrIvQfh9yQjOZgoX64mDLyQTZ+BYrlE5eGcpG1/
         TIjagMrZ8OPw/H8XWS4X7b7MGTEqyDLEEV2H1aGaH1KBOtOY9feCWLsSr1mNjaN1I4zt
         JljKvlmlLdzx2ZiYL9oUi/OIsx4xBYVDpM/Z/GP0Dca+swMhlWhhXODudJBAycQKL4RG
         8ZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fNWFoC3BVYguxhRUMdCWIfb/Rl7MMG8+du2R0BO4wEY=;
        b=NHUOektiuD86I4H4iuDLlraH7X+IOHgbsqT3o/zT0gC/hQYgs3rWaZOdmYGSQcNVPb
         Lb64nkjbquEwiK+D9GZFuPd6Uq6vovBoxkrH0Kc21LzJ60DC0LW4Ar8y4C8WEDlgm60K
         NVlbiDRyN06C+eJ+niTHjZG8sB1u+XzsW96GgRGbD/r82DOOXhq/lCNkV0qagmu4d1rt
         TNAflH062jSIqVIDFGLBDVhjd52roft87woTjFGNO9h6SoWUVkyh+9poePY+/caDbmb2
         FzVdD0i13i3WtCpGzyR4ScOw7rpZ6MOl+qhoEplzgRTAT8pSLSFp13ZhqhS8+gkiRRTA
         fnhg==
X-Gm-Message-State: AJcUukdDvN2BKyWwU4juGISgZlGwSplMFc5NCwB4lWkbuWCRSpEbV511
        YsvdaXmQzh9pmGB1hzrr+blEeA==
X-Google-Smtp-Source: ALg8bN7PbaATt/necB5hsHVmNzRxYe2SlsqLJaqmZdEnsDm4GHzSTuTL0Th3+7/lHl3HDWA40aHnMQ==
X-Received: by 2002:adf:8323:: with SMTP id 32mr21979595wrd.176.1548699209700;
        Mon, 28 Jan 2019 10:13:29 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id y185sm110654wmg.34.2019.01.28.10.13.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 10:13:29 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 2/2] reset: meson: add g12a compatible string
Date:   Mon, 28 Jan 2019 19:13:15 +0100
Message-Id: <20190128181316.30814-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128181316.30814-1-jbrunet@baylibre.com>
References: <20190128181316.30814-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible for the new g12a SoC family.

Tested-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/reset/reset-meson.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
index 5242e0679df7..a8f6549b3af4 100644
--- a/drivers/reset/reset-meson.c
+++ b/drivers/reset/reset-meson.c
@@ -134,6 +134,7 @@ static const struct of_device_id meson_reset_dt_ids[] = {
 	 { .compatible = "amlogic,meson8b-reset" },
 	 { .compatible = "amlogic,meson-gxbb-reset" },
 	 { .compatible = "amlogic,meson-axg-reset" },
+	 { .compatible = "amlogic,meson-g12a-reset" },
 	 { /* sentinel */ },
 };
 
-- 
2.20.1

