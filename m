Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE333C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 15:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89518254E3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 15:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linuxvaults.com header.i=@linuxvaults.com header.b="q2tyCDwJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89518254E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxvaults.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751469AbeF3PKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 11:10:16 -0400
Received: from crystal.urlnameserver.com ([99.198.127.110]:58807 "EHLO
        crystal.urlnameserver.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751331AbeF3PKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 11:10:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linuxvaults.com; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=C+FScEChrSFzgOCEYL4AsnTQRcEvBZqQCVMdcMqDtYk=; b=q2tyCDwJRx/L17E3iXIT4WHAQt
        AUwJyNv9fII9YbuOeyZyP3PStoIvMQ02g4nFBhOu8Wh08HSxxzHb1T5PYGN5FS6+T/seqfmhz7yKb
        T1m/yIS3XYNT/+1lcZNuYl/Q37CjVo/TE+B5MYOBfO62gaqz/uhK8GwsXAKSV96wsIOCv7cTIjfXg
        rRO44GOpIYsoVPC7y7YAYvcXD+R77fV83QW0CpF8vgTwYJdjBItQcOuO5qZu76YR69mVE9zN8Mshb
        eT/90ba9RH4aS1J5TuB+hONuUOfY3pHYii+zGYT3iKiULruiQPsaL88MGWA7oakmk97I0qhHR1wT4
        QXB6V+pQ==;
Received: from [206.189.122.65] (port=34076 helo=kernel.local.domain)
        by crystal.urlnameserver.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <tsuliman@linuxvaults.com>)
        id 1fZGvX-0005K6-Gh; Sat, 30 Jun 2018 09:32:39 -0500
From:   Tamir Suliman <tsuliman@linuxvaults.com>
To:     thomas.petazzoni@free-electrons.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org,
        Tamir Suliman <tsuliman@linuxvaults.com>
Subject: [PATCH 1/2] FBTFT: fb_sh: Fix alignment and style problems Fixed Coding style issues Signed-off-by: Tamir Suliman <tsuliman@linuxvaults.com>
Date:   Sat, 30 Jun 2018 14:32:39 +0000
Message-Id: <1530369159-23872-1-git-send-email-tsuliman@linuxvaults.com>
X-Mailer: git-send-email 1.8.3.1
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - crystal.urlnameserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxvaults.com
X-Get-Message-Sender-Via: crystal.urlnameserver.com: authenticated_id: tsuliman@linuxvaults.com
X-Authenticated-Sender: crystal.urlnameserver.com: tsuliman@linuxvaults.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 drivers/staging/fbtft/fb_sh1106.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/fbtft/fb_sh1106.c b/drivers/staging/fbtft/fb_sh1106.c
index 3fc18c0..c18763b 100644
--- a/drivers/staging/fbtft/fb_sh1106.c
+++ b/drivers/staging/fbtft/fb_sh1106.c
@@ -36,27 +36,27 @@ static int init_display(struct fbtft_par *par)
 	par->fbtftops.reset(par);
 
 	/* Set Display OFF */
-	write_reg(par, 0xAE);
+		write_reg(par, 0xAE);
 
 	/* Set Display Clock Divide Ratio/ Oscillator Frequency */
-	write_reg(par, 0xD5, 0x80);
+		write_reg(par, 0xD5, 0x80);
 
 	/* Set Multiplex Ratio */
-	write_reg(par, 0xA8, par->info->var.yres - 1);
+		write_reg(par, 0xA8, par->info->var.yres - 1);
 
 	/* Set Display Offset */
-	write_reg(par, 0xD3, 0x00);
+		write_reg(par, 0xD3, 0x00);
 
 	/* Set Display Start Line */
-	write_reg(par, 0x40 | 0x0);
+		write_reg(par, 0x40 | 0x0);
 
 	/* Set Segment Re-map */
 	/* column address 127 is mapped to SEG0 */
-	write_reg(par, 0xA0 | 0x1);
+		write_reg(par, 0xA0 | 0x1);
 
 	/* Set COM Output Scan Direction */
 	/* remapped mode. Scan from COM[N-1] to COM0 */
-	write_reg(par, 0xC8);
+		write_reg(par, 0xC8);
 
 	/* Set COM Pins Hardware Configuration */
 	if (par->info->var.yres == 64)
@@ -70,15 +70,15 @@ static int init_display(struct fbtft_par *par)
 		write_reg(par, 0xDA, 0x02);
 
 	/* Set Pre-charge Period */
-	write_reg(par, 0xD9, 0xF1);
+		write_reg(par, 0xD9, 0xF1);
 
 	/* Set VCOMH Deselect Level */
-	write_reg(par, 0xDB, 0x40);
+		write_reg(par, 0xDB, 0x40);
 
 	/* Set Display ON */
-	write_reg(par, 0xAF);
+		write_reg(par, 0xAF);
 
-	msleep(150);
+		msleep(150);
 
 	return 0;
 }
@@ -89,8 +89,8 @@ static void set_addr_win(struct fbtft_par *par, int xs, int ys, int xe, int ye)
 
 static int blank(struct fbtft_par *par, bool on)
 {
-	fbtft_par_dbg(DEBUG_BLANK, par, "%s(blank=%s)\n",
-		      __func__, on ? "true" : "false");
+	fbtft_par_dbg(DEBUG_BLANK, par, "%s(_func_=%s)\n",
+			__func__, on ? "true" : "false");
 
 	write_reg(par, on ? 0xAE : 0xAF);
 
-- 
1.8.3.1

