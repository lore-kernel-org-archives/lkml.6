Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98589C46472
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 04:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 550B421916
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 04:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCQFJiYE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 550B421916
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732477AbeHGGRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 02:17:22 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35027 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbeHGGRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 02:17:22 -0400
Received: by mail-qk0-f193.google.com with SMTP id u21-v6so10544316qku.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 21:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VgaOUPwUXLZVVmcbgbYommSVmVgHIVLkqJLTkRjfTsI=;
        b=hCQFJiYEjTYbY1jM5Gnsr0NsBCKaOiOTfn13puwp5ocXFW0rULuYKH2/R02g+rZETw
         eJEshNK1iRYbwYgerA8azPjRxHeDHYj1rJ2zBZOcMfSY4z2otzGtpOKgfKFRL55qoW9U
         qqGr62+QB9sAOCQ+xgpuZDT/TQ9fwNy91DxMyd5lgrAlLpMwgIFktRQV3YbQX9Lcns2M
         3TPKMLR0ezf2DE32DBufDurCc/sZjOsM2rbDOe7P8NXvPdP9G/zdjTIn7R6FkjhJCMax
         j8RVjyRkvlVSCpQ4cLSfmx6mR1HzBHeVSW0FWCATCNG9FLWhluSLBS2MWessGeXs+oqX
         aSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VgaOUPwUXLZVVmcbgbYommSVmVgHIVLkqJLTkRjfTsI=;
        b=mGVaki7Ddu5wmKkl9fhs4BdafmHpBzh5YbsfzYMTck/7GrZnPXP4OyFwAQNVoxDf2K
         P/ylV8BEWq5j/DtFwuS2pWORdov3Xuqiz2+IMKBrASkF5xookUo5CZV+B4CJOwnwLFlp
         eReUOYZ6eVaFoR5QynZE8imb+7ByVHPomFEqW+F72Cu6TdJ4G7Hx3XEKV1HSLoooLiYw
         SvMKyxMTuvFInbI7sk6y3T2orvcLseQ6pkW6i2KEqLerwdvdkSwhkw0HFGUxJxsevWA4
         R9B6JxH0TkVm+Oa4R4EIec3lH8eurXj3e/7GrENGTtrzFxTjkdwQisY0l56CApfB4cso
         4CLQ==
X-Gm-Message-State: AOUpUlF8KT676IV6PJYtqFYGqKRBLF6SGZIeYFOgLFfbfEbQPlZChPXE
        DMzMu06+p7L4ABP5WuAfiQI=
X-Google-Smtp-Source: AAOMgpeZBE8GHQXt4B2nx9cmVoTtQ0taJoqqJhiikOOtNQgU4rl3DDRM/zmGjpX5GZKKkBlNLMkwIw==
X-Received: by 2002:a37:2aa6:: with SMTP id q38-v6mr16227167qkq.270.1533614701241;
        Mon, 06 Aug 2018 21:05:01 -0700 (PDT)
Received: from WindFlash ([201.82.148.26])
        by smtp.gmail.com with ESMTPSA id h68-v6sm139997qkc.97.2018.08.06.21.04.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 21:05:00 -0700 (PDT)
Date:   Tue, 7 Aug 2018 01:04:56 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] staging: fbtft: Changes udelay(n) to usleep_range(n, n
 + 1). - Style
Message-ID: <4822329bce6607da8bd434a083724569b61210ff.1533614243.git.leobras.c@gmail.com>
References: <cover.1533614243.git.leobras.c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1533614243.git.leobras.c@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 drivers/staging/fbtft/fb_agm1264k-fl.c |  2 +-
 drivers/staging/fbtft/fb_ra8875.c      |  4 ++--
 drivers/staging/fbtft/fb_tinylcd.c     |  2 +-
 drivers/staging/fbtft/fb_upd161704.c   | 19 +++++++++----------
 drivers/staging/fbtft/fb_watterott.c   |  4 ++--
 5 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/fbtft/fb_agm1264k-fl.c b/drivers/staging/fbtft/fb_agm1264k-fl.c
index f6f30f5bf15a..c936950ce56d 100644
--- a/drivers/staging/fbtft/fb_agm1264k-fl.c
+++ b/drivers/staging/fbtft/fb_agm1264k-fl.c
@@ -85,7 +85,7 @@ static void reset(struct fbtft_par *par)
 	dev_dbg(par->info->device, "%s()\n", __func__);
 
 	gpio_set_value(par->gpio.reset, 0);
-	udelay(20);
+	usleep_range(20, 21);
 	gpio_set_value(par->gpio.reset, 1);
 	mdelay(120);
 }
diff --git a/drivers/staging/fbtft/fb_ra8875.c b/drivers/staging/fbtft/fb_ra8875.c
index 5d3b76ca74d8..e2a62677b65b 100644
--- a/drivers/staging/fbtft/fb_ra8875.c
+++ b/drivers/staging/fbtft/fb_ra8875.c
@@ -217,7 +217,7 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
 	}
 	len--;
 
-	udelay(100);
+	usleep_range(100, 101);
 
 	if (len) {
 		buf = (u8 *)par->buf;
@@ -238,7 +238,7 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
 
 	/* restore user spi-speed */
 	par->fbtftops.write = fbtft_write_spi;
-	udelay(100);
+	usleep_range(100, 101);
 }
 
 static int write_vmem16_bus8(struct fbtft_par *par, size_t offset, size_t len)
diff --git a/drivers/staging/fbtft/fb_tinylcd.c b/drivers/staging/fbtft/fb_tinylcd.c
index e463b0ddf16d..3b2af1becca8 100644
--- a/drivers/staging/fbtft/fb_tinylcd.c
+++ b/drivers/staging/fbtft/fb_tinylcd.c
@@ -41,7 +41,7 @@ static int init_display(struct fbtft_par *par)
 			     0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
 	write_reg(par, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
 	write_reg(par, MIPI_DCS_EXIT_SLEEP_MODE);
-	udelay(250);
+	usleep_range(250, 251);
 	write_reg(par, MIPI_DCS_SET_DISPLAY_ON);
 
 	return 0;
diff --git a/drivers/staging/fbtft/fb_upd161704.c b/drivers/staging/fbtft/fb_upd161704.c
index acc425fdf34e..10794f81b66e 100644
--- a/drivers/staging/fbtft/fb_upd161704.c
+++ b/drivers/staging/fbtft/fb_upd161704.c
@@ -36,27 +36,26 @@ static int init_display(struct fbtft_par *par)
 
 	/* oscillator start */
 	write_reg(par, 0x003A, 0x0001);	/*Oscillator 0: stop, 1: operation */
-	udelay(100);
-
+	usleep_range(100, 101);
 	/* y-setting */
 	write_reg(par, 0x0024, 0x007B);	/* amplitude setting */
-	udelay(10);
+	usleep_range(10, 11);
 	write_reg(par, 0x0025, 0x003B);	/* amplitude setting */
 	write_reg(par, 0x0026, 0x0034);	/* amplitude setting */
-	udelay(10);
+	usleep_range(10, 11);
 	write_reg(par, 0x0027, 0x0004);	/* amplitude setting */
 	write_reg(par, 0x0052, 0x0025);	/* circuit setting 1 */
-	udelay(10);
+	usleep_range(10, 11);
 	write_reg(par, 0x0053, 0x0033);	/* circuit setting 2 */
 	write_reg(par, 0x0061, 0x001C);	/* adjustment V10 positive polarity */
-	udelay(10);
+	usleep_range(10, 11);
 	write_reg(par, 0x0062, 0x002C);	/* adjustment V9 negative polarity */
 	write_reg(par, 0x0063, 0x0022);	/* adjustment V34 positive polarity */
-	udelay(10);
+	usleep_range(10, 11);
 	write_reg(par, 0x0064, 0x0027);	/* adjustment V31 negative polarity */
-	udelay(10);
+	usleep_range(10, 11);
 	write_reg(par, 0x0065, 0x0014);	/* adjustment V61 negative polarity */
-	udelay(10);
+	usleep_range(10, 11);
 	write_reg(par, 0x0066, 0x0010);	/* adjustment V61 negative polarity */
 
 	/* Basical clock for 1 line (BASECOUNT[7:0]) number specified */
@@ -64,7 +63,7 @@ static int init_display(struct fbtft_par *par)
 
 	/* Power supply setting */
 	write_reg(par, 0x0019, 0x0000);	/* DC/DC output setting */
-	udelay(200);
+	usleep_range(200, 201);
 	write_reg(par, 0x001A, 0x1000);	/* DC/DC frequency setting */
 	write_reg(par, 0x001B, 0x0023);	/* DC/DC rising setting */
 	write_reg(par, 0x001C, 0x0C01);	/* Regulator voltage setting */
diff --git a/drivers/staging/fbtft/fb_watterott.c b/drivers/staging/fbtft/fb_watterott.c
index bfd1527f20f7..9ad4307a50c8 100644
--- a/drivers/staging/fbtft/fb_watterott.c
+++ b/drivers/staging/fbtft/fb_watterott.c
@@ -83,7 +83,7 @@ static int write_vmem(struct fbtft_par *par, size_t offset, size_t len)
 			par->txbuf.buf, 10 + par->info->fix.line_length);
 		if (ret < 0)
 			return ret;
-		udelay(300);
+		usleep_range(300, 301);
 	}
 
 	return 0;
@@ -122,7 +122,7 @@ static int write_vmem_8bit(struct fbtft_par *par, size_t offset, size_t len)
 			par->txbuf.buf, 10 + par->info->var.xres);
 		if (ret < 0)
 			return ret;
-		udelay(700);
+		usleep_range(700, 701);
 	}
 
 	return 0;
-- 
2.18.0

