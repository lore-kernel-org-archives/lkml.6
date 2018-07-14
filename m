Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3658ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 12:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A64020890
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 12:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1VoePR4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A64020890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbeGNNMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 09:12:12 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43890 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbeGNNMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 09:12:12 -0400
Received: by mail-ed1-f67.google.com with SMTP id b20-v6so1048684edt.10
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 05:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GCP3uu8YHtYdLiHxm0hBBX5r+wyHtS25hKEnbsnHUV4=;
        b=M1VoePR4isxRnMGLwOCCYL0iwg+fmv24/SlKIiuJMtsmncNGjqiblMN281VXV/X9Bk
         KEY1ppMLpBgFYZCU1bD+X0as8gqPldEPidF1HOsd1yt9u50WE2n55HVZjvT2lXgIEnSB
         431gkgOC25F/oQGoE42rX7xPyNKpaGo9p7Q5c9gZeaEjKYqKamiVAoXBc7XqHKjk6C1C
         7DtCHRBZ5jBmI1c+xjX4jBjV4ov2I61zBkiDHOntcf9/iYgUsL5qRsljlf5fTvAIYorV
         YdTfVUErIkpUJZNA6EwWoSIadG6TrzJZgyWftntL8C2xdu+zzNdvonoKLOqCjhyUlSe8
         nC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GCP3uu8YHtYdLiHxm0hBBX5r+wyHtS25hKEnbsnHUV4=;
        b=RuITXIHw+7SPHYgzWWxhRaDcx18s4Qy8Pl+jZdgNoIbHdZt/H/GpxiTDLkSwflpu94
         L4xgxxJ+ByobYeLCiSJix0kzbVUQ50LODghI9tFkK4TH2stpeUhjdNxWOUmcLTi6mw44
         4/Tx5uY7f9ft1vXz3eIMU3h496ep0C/YLJUfhtRsQEcFaabkcmSAl8ML7xDefHujgI7U
         wipCpaNcJ61lwIWN41PveYursfvaxPXmsWdgcsEivnKg5V6czpitc3+e5pTCl7okVkRF
         56/oV4ydN6XNqG5NBhiT2wvN+qN6UyARZRVx+6mYydm0+ythBWRSTYbu3VKBQXGNiON8
         4caA==
X-Gm-Message-State: AOUpUlGjx1um28WjOWjx2gTzTPc5qTeX6Q4LE0fULzOTXSw0tmH1JvXE
        ZYFoum710Jk4W8uX2h9mYnaHf7E0pNE=
X-Google-Smtp-Source: AAOMgpepANyxOVPDpS9iYANC42HGVm0FFBdgWgGhp2E+a1Y9mhyafgQiiWcvZ7R59alJ+++JGoEcrQ==
X-Received: by 2002:a50:e146:: with SMTP id i6-v6mr10712080edl.204.1531572790885;
        Sat, 14 Jul 2018 05:53:10 -0700 (PDT)
Received: from arch.localdomain (x4db2bd54.dyn.telefonica.de. [77.178.189.84])
        by smtp.gmail.com with ESMTPSA id n10-v6sm16577396edr.59.2018.07.14.05.53.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Jul 2018 05:53:10 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/6] staging: rtl8188eu: rename variable
Date:   Sat, 14 Jul 2018 14:52:39 +0200
Message-Id: <20180714125241.15509-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180714125241.15509-1-straube.linux@gmail.com>
References: <20180714125241.15509-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable to avoid CamelCase.
tmpV16 -> tmpv16

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_efuse.c | 26 +++++++++++-----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_efuse.c b/drivers/staging/rtl8188eu/core/rtw_efuse.c
index 004b786de37e..93d20bc758e7 100644
--- a/drivers/staging/rtl8188eu/core/rtw_efuse.c
+++ b/drivers/staging/rtl8188eu/core/rtw_efuse.c
@@ -32,29 +32,29 @@ enum{
 void efuse_power_switch(struct adapter *pAdapter, u8 write, u8 pwrstate)
 {
 	u8 tempval;
-	u16	tmpV16;
+	u16 tmpv16;
 
 	if (pwrstate) {
 		usb_write8(pAdapter, REG_EFUSE_ACCESS, EFUSE_ACCESS_ON);
 
 		/*  1.2V Power: From VDDON with Power Cut(0x0000h[15]), default valid */
-		tmpV16 = usb_read16(pAdapter, REG_SYS_ISO_CTRL);
-		if (!(tmpV16 & PWC_EV12V)) {
-			tmpV16 |= PWC_EV12V;
-			 usb_write16(pAdapter, REG_SYS_ISO_CTRL, tmpV16);
+		tmpv16 = usb_read16(pAdapter, REG_SYS_ISO_CTRL);
+		if (!(tmpv16 & PWC_EV12V)) {
+			tmpv16 |= PWC_EV12V;
+			 usb_write16(pAdapter, REG_SYS_ISO_CTRL, tmpv16);
 		}
 		/*  Reset: 0x0000h[28], default valid */
-		tmpV16 =  usb_read16(pAdapter, REG_SYS_FUNC_EN);
-		if (!(tmpV16 & FEN_ELDR)) {
-			tmpV16 |= FEN_ELDR;
-			usb_write16(pAdapter, REG_SYS_FUNC_EN, tmpV16);
+		tmpv16 =  usb_read16(pAdapter, REG_SYS_FUNC_EN);
+		if (!(tmpv16 & FEN_ELDR)) {
+			tmpv16 |= FEN_ELDR;
+			usb_write16(pAdapter, REG_SYS_FUNC_EN, tmpv16);
 		}
 
 		/*  Clock: Gated(0x0008h[5]) 8M(0x0008h[1]) clock from ANA, default valid */
-		tmpV16 = usb_read16(pAdapter, REG_SYS_CLKR);
-		if ((!(tmpV16 & LOADER_CLK_EN))  || (!(tmpV16 & ANA8M))) {
-			tmpV16 |= (LOADER_CLK_EN | ANA8M);
-			usb_write16(pAdapter, REG_SYS_CLKR, tmpV16);
+		tmpv16 = usb_read16(pAdapter, REG_SYS_CLKR);
+		if ((!(tmpv16 & LOADER_CLK_EN))  || (!(tmpv16 & ANA8M))) {
+			tmpv16 |= (LOADER_CLK_EN | ANA8M);
+			usb_write16(pAdapter, REG_SYS_CLKR, tmpv16);
 		}
 
 		if (write) {
-- 
2.18.0

