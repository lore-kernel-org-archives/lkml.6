Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C3CC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1339220851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1339220851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=manty.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbeLLVFv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 16:05:51 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:40134 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbeLLVFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 16:05:50 -0500
Received: by mail-io1-f66.google.com with SMTP id n9so15995706ioh.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 13:05:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Rf41uZdMtiyXTwgRlpXC1NU6Vo5EBXiTbJNXeXuE3s4=;
        b=XXSyCSfvZpculkFasMlDgT/DoHcSjlBTBozozLwC/uBerWc2p4k7SUSr2eIX9PTIub
         gMQsfI+fLMsIWx/F11aooLGDEvnAH4s3nkXIMlFdOC39OLVzqbDGiBcj5jnEfgTb2JsM
         KoEQPnCKjN0w0Zeiw3SqPtorXL4kuZblvuUnYy6qboCTnaSegbqbpaPyxv8X8ucJKoOl
         YWl0dklsIvbzkVtEwgalLfcY0Epn3cg4y1eV7xUdQUbfgJI45HcOVTvQ96Yd7k6RxYy7
         /Fk9BqhJRArddzeDF1to87vPTgHTMqIG0mtErUZ7trdJ41pUVUdVLTKCZH91MnjBZKjr
         1kjA==
X-Gm-Message-State: AA+aEWahJwJf5UyCkx/+N53Rh7tVXU1oVwfMpm+EH206h7jhnlF/uy8M
        4vwejxgVP5OymKB9utt+1JgtShHHiHs=
X-Google-Smtp-Source: AFSGD/UK/UAs08sM9TUZpTjccENRRVPX+37T4F1gFp1mgA2bE8vrPglZ+sR70y4N3IuwTRyXplqOAA==
X-Received: by 2002:a6b:d20f:: with SMTP id q15mr19203327iob.100.1544648749069;
        Wed, 12 Dec 2018 13:05:49 -0800 (PST)
Received: from mail-it1-f175.google.com (mail-it1-f175.google.com. [209.85.166.175])
        by smtp.gmail.com with ESMTPSA id l11sm7888145iob.24.2018.12.12.13.05.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 13:05:48 -0800 (PST)
Received: by mail-it1-f175.google.com with SMTP id z7so515867iti.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 13:05:48 -0800 (PST)
X-Received: by 2002:a02:c943:: with SMTP id u3mr8733551jao.96.1544648748057;
 Wed, 12 Dec 2018 13:05:48 -0800 (PST)
MIME-Version: 1.0
From:   Santiago Garcia Mantinan <manty@manty.net>
Date:   Wed, 12 Dec 2018 22:05:36 +0100
X-Gmail-Original-Message-ID: <CAJk_L2EcMH58D44b4EogPYk=-NczwbVsbdL-HMUL9ZShKTo3YQ@mail.gmail.com>
Message-ID: <CAJk_L2EcMH58D44b4EogPYk=-NczwbVsbdL-HMUL9ZShKTo3YQ@mail.gmail.com>
Subject: [PATCH] arm: bcm2835-audio: Document the device tree node to enable
 bcm2835-audio driver
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes it posible to use the bcm2835-audio driver on the Raspberry.

In drivers/staging/vc04_services/bcm2835-audio/TODO Michael Zoran says
that this is to be done, in fact as we noted on
https://bugs.debian.org/856505 without this patch the driver is not
loaded and when loaded it doesn't do a thing.

After applying the patch on both 4.19.X and 4.20-rc5 you get the
driver autoloaded and working sound on hdmi and on the minijack
(selection done through amixer cset).

I'd like this patch to be applied so that people with a Raspberry can
get sound out of it.

Signed-off-by: Santiago García Mantiñán <manty@manty.net>
---
 arch/arm/boot/dts/bcm283x.dtsi                   | 5 +++++
 drivers/staging/vc04_services/bcm2835-audio/TODO | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 31b29646b14c..120e8f85617d 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -634,6 +634,11 @@
         vc4: gpu {
             compatible = "brcm,bcm2835-vc4";
         };
+
+        audio: audio {
+            compatible = "brcm,bcm2835-audio";
+            brcm,pwm-channels = <8>;
+        };
     };

     clocks {
diff --git a/drivers/staging/vc04_services/bcm2835-audio/TODO
b/drivers/staging/vc04_services/bcm2835-audio/TODO
index 73d41fa631ac..5611c88978e2 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/TODO
+++ b/drivers/staging/vc04_services/bcm2835-audio/TODO
@@ -5,7 +5,7 @@
 *****************************************************************************


-1) Document the device tree node
+1) Document the device tree node (DONE)

 The downstream tree(the tree that the driver was imported from) at
 http://www.github.com/raspberrypi/linux uses this node:
-- 
2.19.2

Regards
--
Manty/BestiaTester -> http://manty.net
