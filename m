Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CBBC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 19:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B1DA2075E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 19:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Faf2DVmf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B1DA2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbeJAC3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 22:29:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35466 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728518AbeJAC1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 22:27:44 -0400
Received: by mail-wr1-f68.google.com with SMTP id w5-v6so2278637wrt.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 12:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YDWY3hQ2dVkUo86+jA23B8Jm+Olp5KSftp1W0Z7dvEM=;
        b=Faf2DVmfiAlXCeHuvg0ivAhQ3VqtXigCsDBk/JGbrhJy6taDaEB2FX2wLy1TrbcJ+u
         NpJT4sW+z9zRWbL1/moOQKQWtciaS/UmBmtQtUId2GtIcUin5V/9kUZPfOc7eJLGJ2nf
         GcVrsam/Exx1dyV898ngWuYo3jeFNaJLzI/sqhR/6URSZ1PhRxSymCKV+/GSl1bVRGRy
         6CzPHwKNrKhHWZ7bNL47MJrX7JKffJG5InWXXiZaZSGpi9Re+snVthBg5pLfXds4mwg6
         /yTCOXKFLW55io7UZ/+KC4z90OV1AiRGv7wC4BgJU9Wb8UsmrFotDZBPYFvAIleu8x2D
         Ag7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YDWY3hQ2dVkUo86+jA23B8Jm+Olp5KSftp1W0Z7dvEM=;
        b=dQ16lBiT8Mn0hIPFyGWIPVuHI3OVIK/XpOrNApcoAJA/cWVmtWYq+Fw2nddMWVH/3H
         CjHiVl+D8FZ1xT1dcRvwzMmDer0YEobniFR3uXCyQz3GFjWfUUUthGNtcblj85KZeYsH
         2SCbS+dQByfAo+PcVJRDv27daO9PnKJl5Jj62EN6AUG31fiSlKbFA92ujCJYY3dUP32W
         VQkHWj9dh4/H/3E13DizIRlP8RMgpY1IN0erCl7WodXMyYgGm82/Kjv0hAq18VXKzPua
         YGhpj/HYrkSkss9W2yr7JRgDB1YCJkdmjuoBciHgn8tCeZqaLAZqoG6vxlCi0v97EcFf
         wxUw==
X-Gm-Message-State: ABuFfohZtHjsPqzMgNUWeJfxrfgMK+N966g9MgagSEE/j9/gZK9SQIbw
        PgUteRIr7z6K4pJKj78KA0A=
X-Google-Smtp-Source: ACcGV62N384R2YiDKZPYJAQRcTyx5JIpAjPUGNi3Rpio/8R6vLjAXQQRgydg5NQWaBCYvd3x9juM2w==
X-Received: by 2002:adf:afdd:: with SMTP id y29-v6mr5315177wrd.176.1538337203664;
        Sun, 30 Sep 2018 12:53:23 -0700 (PDT)
Received: from localhost.localdomain (ip1f12fd19.dynamic.kabel-deutschland.de. [31.18.253.25])
        by smtp.gmail.com with ESMTPSA id w26-v6sm6500775wmi.27.2018.09.30.12.53.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 12:53:23 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 03/19] staging: rtl8188eu: remove wrapper odm_SignalScaleMapping()
Date:   Sun, 30 Sep 2018 21:52:54 +0200
Message-Id: <20180930195310.1531-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930195310.1531-1-straube.linux@gmail.com>
References: <20180930195310.1531-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function odm_SignalScaleMapping() is just a wrapper for
odm_SignalScaleMapping_92CSeries().

Rename odm_SignalScaleMapping_92CSeries() to odm_SignalScaleMapping()
and remove the wrapper.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/odm_hwconfig.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/odm_hwconfig.c b/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
index 9d63afd4f99f..6cc1f1f6448d 100644
--- a/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
+++ b/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
@@ -26,7 +26,7 @@ static u8 odm_QueryRxPwrPercentage(s8 AntPower)
 
 /*  2012/01/12 MH MOve some signal strength smooth method to MP HAL layer. */
 /*  IF other SW team do not support the feature, remove this section.?? */
-static s32 odm_SignalScaleMapping_92CSeries(struct odm_dm_struct *dm_odm, s32 CurrSig)
+static s32 odm_SignalScaleMapping(struct odm_dm_struct *dm_odm, s32 CurrSig)
 {
 	s32 RetSig = 0;
 
@@ -49,11 +49,6 @@ static s32 odm_SignalScaleMapping_92CSeries(struct odm_dm_struct *dm_odm, s32 Cu
 	return RetSig;
 }
 
-static s32 odm_SignalScaleMapping(struct odm_dm_struct *dm_odm, s32 CurrSig)
-{
-	return odm_SignalScaleMapping_92CSeries(dm_odm, CurrSig);
-}
-
 static u8 odm_EVMdbToPercentage(s8 Value)
 {
 	/*  -33dB~0dB to 0%~99% */
-- 
2.19.0

