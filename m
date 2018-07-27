Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96299C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 310D720891
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g92F7uNG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 310D720891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbeG0KQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 06:16:30 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46820 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729445AbeG0KQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 06:16:29 -0400
Received: by mail-pl0-f67.google.com with SMTP id t17-v6so2033130ply.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 01:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=swhpbMnO8PQ9Ki7kjcQWeLbnkGdvLurNRqgcbKdvtd0=;
        b=g92F7uNG9JZGd7SOoTD64G8nPa8bJyb/RxKcMkWJMD7xMlcQJlJIlhmSbi8QW2hvml
         neTo8YfsV8uocs0n9dFbjhJ4qQ9aqBI2PNP6pj8Ke607KfgXVFBJ+Jk9t8ckEXYNHPfi
         0hkTJxBOlOO65Hr2XwE5eTdLlMeVzbrGSSp30XtIsfwcCSW0XzufXvMdiWu7odUf1UoU
         LPFAH7AN884KW6e3Tn1eqBkYgl7XryJzVT8/GfKbAXiJqfxgV0FZ8NbAIKTNsFrQ+dci
         /DGEh2aBUo60pl72OISaqbCF9ZwthFfMAaAQW2w1LJIX5dP0K5D1ooOzieMDEGIA0ruE
         WHAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=swhpbMnO8PQ9Ki7kjcQWeLbnkGdvLurNRqgcbKdvtd0=;
        b=S4vD2n/0cS7iLmUhx1qG8wIBCtoG85q8J7YRt2VLwgJ9A6QiG7xr4B60It/eVRp1sK
         zL1NwZ8AtlAe/gWZeqqmn2bFHBBkOgv589kFgR09LAIbparHSRUa2Mtdt485pgUTDMXg
         5hnqS+VNkjKgVS+lgQ8qrJm1X0C/dmlEjcszlRrzNemIXmxj1VQ+y4CtmCHVVJC85XUK
         HtNpOt5QcaHV6FRduyOUFQ1Eb42oXiQKjvfe4kz8EX2sExAglKuGvACuMxb1TWwr3MYw
         NHJjV8fytGcB61gAtpCCXMDZPbKZrvi49QVGK0nIWBj4GUlC8CLbajReOsL2DxPSCD5x
         728g==
X-Gm-Message-State: AOUpUlHA3avCw2p0zPZ8R59vI81skJRfGXOFfl86CjKT0aRUlLRsHm5q
        40TjH5BfdcuieeKn/Q6fun8=
X-Google-Smtp-Source: AAOMgpfsrl+ZeMj5CxmMd66Vr5UfOqMhYOXgs+4AhY2RH4yN29v66ONoX6S412I5Hb39bWYsEE26yg==
X-Received: by 2002:a17:902:7b87:: with SMTP id w7-v6mr5289517pll.142.1532681736095;
        Fri, 27 Jul 2018 01:55:36 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:8ca7:1cde:b1e6:2647])
        by smtp.gmail.com with ESMTPSA id r19-v6sm4967184pgo.68.2018.07.27.01.55.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 01:55:35 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, jussi@sonarnerd.net,
        nob77413@gmail.com, kai.heng.feng@canonical.com,
        elfring@users.sourceforge.net, daniel@zonque.org,
        ruslan.bilovol@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] sound: usb: quirks: Replace mdelay() with msleep() and usleep_range()
Date:   Fri, 27 Jul 2018 16:55:28 +0800
Message-Id: <20180727085528.5802-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snd_usb_select_mode_quirk(), snd_usb_set_interface_quirk() and 
snd_usb_ctl_msg_quirk() are never called in atomic context.
They call mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep() and usleep_range().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 sound/usb/quirks.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index acbeb52f6fd6..9eed650c54d4 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1181,7 +1181,7 @@ int snd_usb_select_mode_quirk(struct snd_usb_substream *subs,
 		if (err < 0)
 			return err;
 
-		mdelay(20); /* Delay needed after setting the interface */
+		msleep(20); /* Delay needed after setting the interface */
 
 		/* Vendor mode switch cmd is required. */
 		if (fmt->formats & SNDRV_PCM_FMTBIT_DSD_U32_BE) {
@@ -1202,7 +1202,7 @@ int snd_usb_select_mode_quirk(struct snd_usb_substream *subs,
 				return err;
 
 		}
-		mdelay(20);
+		msleep(20);
 	}
 	return 0;
 }
@@ -1249,7 +1249,7 @@ void snd_usb_set_interface_quirk(struct usb_device *dev)
 	switch (USB_ID_VENDOR(chip->usb_id)) {
 	case 0x23ba: /* Playback Design */
 	case 0x0644: /* TEAC Corp. */
-		mdelay(50);
+		msleep(50);
 		break;
 	}
 }
@@ -1269,7 +1269,7 @@ void snd_usb_ctl_msg_quirk(struct usb_device *dev, unsigned int pipe,
 	 */
 	if (USB_ID_VENDOR(chip->usb_id) == 0x23ba &&
 	    (requesttype & USB_TYPE_MASK) == USB_TYPE_CLASS)
-		mdelay(20);
+		msleep(20);
 
 	/*
 	 * "TEAC Corp." products need a 20ms delay after each
@@ -1277,14 +1277,14 @@ void snd_usb_ctl_msg_quirk(struct usb_device *dev, unsigned int pipe,
 	 */
 	if (USB_ID_VENDOR(chip->usb_id) == 0x0644 &&
 	    (requesttype & USB_TYPE_MASK) == USB_TYPE_CLASS)
-		mdelay(20);
+		msleep(20);
 
 	/* ITF-USB DSD based DACs functionality need a delay
 	 * after each class compliant request
 	 */
 	if (is_itf_usb_dsd_dac(chip->usb_id)
 	    && (requesttype & USB_TYPE_MASK) == USB_TYPE_CLASS)
-		mdelay(20);
+		msleep(20);
 
 	/* Zoom R16/24, Logitech H650e, Jabra 550a needs a tiny delay here,
 	 * otherwise requests like get/set frequency return as failed despite
@@ -1294,7 +1294,7 @@ void snd_usb_ctl_msg_quirk(struct usb_device *dev, unsigned int pipe,
 	     chip->usb_id == USB_ID(0x046d, 0x0a46) ||
 	     chip->usb_id == USB_ID(0x0b0e, 0x0349)) &&
 	    (requesttype & USB_TYPE_MASK) == USB_TYPE_CLASS)
-		mdelay(1);
+		usleep_range(1000, 2000);
 }
 
 /*
-- 
2.17.0

