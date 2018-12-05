Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F774C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2302E20879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aac7roIA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2302E20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbeLERDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:03:08 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51640 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbeLERDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:03:04 -0500
Received: by mail-wm1-f66.google.com with SMTP id s14so14093592wmh.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 09:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6nbnJvAi8MiAFv+idmpPrgbmyBaPbkigzPuXBzF1Rw4=;
        b=aac7roIADiNT801vi3l98BSVGThvpUvVusL/D8HFS2Hc0Qk723+orhnBpltZpn0qA5
         fS73yIel0Ups0BploKAestFnGOcsKbb9tKmwyf9IzTKf+7WNMm+LIwvESKiHe8tQ1WEH
         TOSFP1DKoXPQAGFBXWvTTsdoGco95JFM+o8J8lPKeZBENtN53bvXXND9mv/XMR3BdQEr
         E2hZumI7DSWhpIAFfLGf9PwGgyu6SvMUpKa/oRcXo60FIm7WP+fAaXgViWxGTEgQzzvI
         sGFv9xwOXMF21bMzku5ZcVU7x87ZWsTe38eUsr9t5qOJ/fOiQ3rYxdlGfTT7IJMO3wzu
         PHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6nbnJvAi8MiAFv+idmpPrgbmyBaPbkigzPuXBzF1Rw4=;
        b=RRUGmS/tfi5ILW5Vye9OE4z3/SiV9OTb5fKMe8lg6HB1jPPYxNRp12HMM5MBsqRZlG
         cDvzr5ypYzaEfnDXLIGvqo2XmNOp5peoCoYPwc+o4xJ+WOoKQz9bf3rDMpYrEhAhKWVv
         JotiRcp7cYbdQLvRqteAu0EvvB+TCogKVEa0K1uGglD6h3ZG3CAs/nlOOmksmzZXETfR
         1/bwNBXQ7G0Fmvz46qjs8Nx3HfIuWFh0pErBgcjgLt37MoIf10SOcTbJ7ig4oOSd9x5f
         DPrxt7UOjnYevHox2uifUSBMPGZUU9l3aONsdyoK501s0lpVd8eEJdGgB+D7YoVxsCSO
         QDMA==
X-Gm-Message-State: AA+aEWY9TVDx6CtwkOeYIhVk7PUHDRiD10alCxOE2nuvlfoyz6tFNMyD
        zti+A0whu487EYlCvS1a0/c=
X-Google-Smtp-Source: AFSGD/WkP09S8JDIqN+8OE9/tb3MQVo7jodPXkZUiJN8Ah3wOPijSA2EhMCD56vM18YEHEG+sSxG2w==
X-Received: by 2002:a1c:c645:: with SMTP id w66mr17799554wmf.18.1544029381924;
        Wed, 05 Dec 2018 09:03:01 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id n127sm7949825wmd.20.2018.12.05.09.03.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 09:03:01 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 03/12] staging: rtl8188eu: simplify array initializations
Date:   Wed,  5 Dec 2018 18:02:38 +0100
Message-Id: <20181205170247.5401-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205170247.5401-1-straube.linux@gmail.com>
References: <20181205170247.5401-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplfy initialization of arrays with zero only values
to improve readability and save a line.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_wlan_util.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
index fac1c1c20b2f..76c7010c3a5c 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -455,9 +455,8 @@ void write_cam(struct adapter *padapter, u8 entry, u16 ctrl, u8 *mac, u8 *key)
 
 void clear_cam_entry(struct adapter *padapter, u8 entry)
 {
-	u8 null_sta[] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
-	u8 null_key[] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-			 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
+	u8 null_sta[ETH_ALEN] = {};
+	u8 null_key[16] = {};
 
 	write_cam(padapter, entry, 0, null_sta, null_key);
 }
-- 
2.19.2

