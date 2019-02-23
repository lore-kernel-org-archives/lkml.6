Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8B3C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 20:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D56020675
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 20:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oPXhC+9t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbfBWUV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 15:21:28 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39577 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfBWUV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 15:21:27 -0500
Received: by mail-pl1-f194.google.com with SMTP id 101so2647368pld.6
        for <linux-kernel@vger.kernel.org>; Sat, 23 Feb 2019 12:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=DqTK8M5CQHD+rV96zS9c2nzqgbbDOo3HiW1+jEHg7Fs=;
        b=oPXhC+9tJrlt5N4t4PhrGVTkkEFOfQf3TlXZ4gKlg2l3ant16hdrdjwzmRMD/3L04O
         YrWkYBn02hojtmuvNUzrqwb0ryaHS817ZPFdeBvLw96+8093daLl4IP+cfVVTQHlj5KI
         z7U5ZOxjlSzRe5Jodby+/Gvh9xV5Y9H/HA253AKJrsQMXlJEctNh71h7gZu1cdn081ag
         N3BwT4bwZZGbQTIVu1cSi26pVLmc9NUN1zDQPvebisgW/hySQJbWmcvPL0ANsMT0O7BU
         QKTvp/7XwDi2UXXDotgNag2PZP7a5zFkmgDEHqYP97vM0yEs/vwulI8XgM/8pQ0ltfDc
         IPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=DqTK8M5CQHD+rV96zS9c2nzqgbbDOo3HiW1+jEHg7Fs=;
        b=a+YrAN0OjOYi4tmc4roQBi91xm2QKF3jjKWLzhv3jUN2jFrInDBf9wzRBVgctu8f15
         WP5tB5gaiaoBxTeEpZxJjALsdCAp/VB8QW1B/VQ+wehpVF5fZ4H1HwgjlOiWNIPwv08+
         YHcwJ7dVpMHA8FxOciCoEUXZ2Sa5eTrPGPACKZAu+7zeTcG5on55YSat4feIW7l7dvMy
         lKGWtnO9qtu4sps6HLqe80txEd1v2Fa8T1j5RsybbrvDTu3Zm4AyxcNbLXFgomKYZpQl
         bmi68tITnjuD4efzK6q+kJVYTpBn1C0OpQepcLbsqnEurTFo9zJHxeTl8Z6QqEwMOP+N
         fPTA==
X-Gm-Message-State: AHQUAuZ0YLbyxiyPkwx6e+cpeDj/ZJCRl4BH3+sVBWaewkyUXLhvbJsm
        1LiDZDFz7w3KbcIPRkcRu2s=
X-Google-Smtp-Source: AHgI3IZS3GmaOeqYoOW1RtiECte1UR4uhyPsjVydCw0ZHGOhVsmTJri3V/Oo46M93jAzPMy/4ZhmVA==
X-Received: by 2002:a17:902:b190:: with SMTP id s16mr3889017plr.13.1550953286661;
        Sat, 23 Feb 2019 12:21:26 -0800 (PST)
Received: from bharath12345-Inspiron-5559 ([103.110.42.34])
        by smtp.gmail.com with ESMTPSA id x1sm8053123pge.73.2019.02.23.12.21.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 12:21:25 -0800 (PST)
Date:   Sun, 24 Feb 2019 01:51:17 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     w.d.hubbs@gmail.com
Cc:     chris@the-brannons.com, kirk@reisers.ca,
        samuel.thibault@ens-lyon.org, gregkh@linuxfoundation.org,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging : speakup: replace ---help--- with help in Kconfig
Message-ID: <20190223202117.GA6455@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the checkpatch.pl warning to replace ---help--- with help in
Kconfig.

Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
 drivers/staging/speakup/Kconfig | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/speakup/Kconfig b/drivers/staging/speakup/Kconfig
index efd6f45..d8ec780 100644
--- a/drivers/staging/speakup/Kconfig
+++ b/drivers/staging/speakup/Kconfig
@@ -3,7 +3,7 @@ menu "Speakup console speech"
 config SPEAKUP
 	depends on VT
 	tristate "Speakup core"
-	---help---
+	help
 		This is the Speakup screen reader.  Think of it as a
 		video console for blind people.  If built in to the
 		kernel, it can speak everything on the text console from
@@ -43,7 +43,7 @@ config SPEAKUP
 if SPEAKUP
 config SPEAKUP_SYNTH_ACNTSA
 	tristate "Accent SA synthesizer support"
-	---help---
+	help
 		This is the Speakup driver for the Accent SA
 		synthesizer.  You can say y to build it into the kernel,
 		or m to build it as a module.  See the configuration
@@ -52,7 +52,7 @@ config SPEAKUP_SYNTH_ACNTSA
 config SPEAKUP_SYNTH_ACNTPC
 	tristate "Accent PC synthesizer support"
 	depends on ISA || COMPILE_TEST
-	---help---
+	help
 		This is the Speakup driver for the accent pc
 		synthesizer.  You can say y to build it into the kernel,
 		or m to build it as a module.  See the configuration
@@ -60,7 +60,7 @@ config SPEAKUP_SYNTH_ACNTPC
 
 config SPEAKUP_SYNTH_APOLLO
 	tristate "Apollo II synthesizer support"
-	---help---
+	help
 		This is the Speakup driver for the Apollo II
 		synthesizer.  You can say y to build it into the kernel,
 		or m to build it as a module.  See the configuration
@@ -68,7 +68,7 @@ config SPEAKUP_SYNTH_APOLLO
 
 config SPEAKUP_SYNTH_AUDPTR
 	tristate "Audapter synthesizer support"
-	---help---
+	help
 		This is the Speakup driver for the Audapter synthesizer.
 		 You can say y to build it into the kernel, or m to
 		build it as a module.  See the configuration help on the
@@ -76,7 +76,7 @@ config SPEAKUP_SYNTH_AUDPTR
 
 config SPEAKUP_SYNTH_BNS
 	tristate "Braille 'n' Speak synthesizer support"
-	---help---
+	help
 		This is the Speakup driver for the Braille 'n' Speak
 		synthesizer.  You can say y to build it into the kernel,
 		or m to build it as a module.  See the configuration
@@ -84,7 +84,7 @@ config SPEAKUP_SYNTH_BNS
 
 config SPEAKUP_SYNTH_DECTLK
 	tristate "DECtalk Express synthesizer support"
-	---help---
+	help
 
 		This is the Speakup driver for the DecTalk Express
 		synthesizer.  You can say y to build it into the kernel,
@@ -93,7 +93,7 @@ config SPEAKUP_SYNTH_DECTLK
 
 config SPEAKUP_SYNTH_DECEXT
 	tristate "DECtalk External (old) synthesizer support"
-	---help---
+	help
 
 		This is the Speakup driver for the DecTalk External
 		(old) synthesizer.  You can say y to build it into the
@@ -105,7 +105,7 @@ config SPEAKUP_SYNTH_DECPC
 	depends on m
 	depends on ISA || COMPILE_TEST
 	tristate "DECtalk PC (big ISA card) synthesizer support"
-	---help---
+	help
 
 		This is the Speakup driver for the DecTalk PC (full
 		length ISA) synthesizer.  You can say m to build it as
@@ -127,7 +127,7 @@ config SPEAKUP_SYNTH_DECPC
 config SPEAKUP_SYNTH_DTLK
 	tristate "DoubleTalk PC synthesizer support"
 	depends on ISA || COMPILE_TEST
-	---help---
+	help
 
 		This is the Speakup driver for the internal DoubleTalk
 		PC synthesizer.  You can say y to build it into the
@@ -138,7 +138,7 @@ config SPEAKUP_SYNTH_DTLK
 config SPEAKUP_SYNTH_KEYPC
 	tristate "Keynote Gold PC synthesizer support"
 	depends on ISA || COMPILE_TEST
-	---help---
+	help
 
 		This is the Speakup driver for the Keynote Gold
 		PC synthesizer.  You can say y to build it into the
@@ -148,7 +148,7 @@ config SPEAKUP_SYNTH_KEYPC
 
 config SPEAKUP_SYNTH_LTLK
 	tristate "DoubleTalk LT/LiteTalk synthesizer support"
----help---
+help
 
 		This is the Speakup driver for the LiteTalk/DoubleTalk
 		LT synthesizer.  You can say y to build it into the
@@ -158,7 +158,7 @@ config SPEAKUP_SYNTH_LTLK
 
 config SPEAKUP_SYNTH_SOFT
 	tristate "Userspace software synthesizer support"
-	---help---
+	help
 
 		This is the software synthesizer device node.  It will
 		register a device /dev/softsynth which midware programs
@@ -169,7 +169,7 @@ config SPEAKUP_SYNTH_SOFT
 
 config SPEAKUP_SYNTH_SPKOUT
 	tristate "Speak Out synthesizer support"
-	---help---
+	help
 
 		This is the Speakup driver for the Speakout synthesizer.
 		 You can say y to build it into the kernel, or m to
@@ -178,7 +178,7 @@ config SPEAKUP_SYNTH_SPKOUT
 
 config SPEAKUP_SYNTH_TXPRT
 	tristate "Transport synthesizer support"
-	---help---
+	help
 
 		This is the Speakup driver for the Transport
 		synthesizer.  You can say y to build it into the kernel,
@@ -187,7 +187,7 @@ config SPEAKUP_SYNTH_TXPRT
 
 config SPEAKUP_SYNTH_DUMMY
 	tristate "Dummy synthesizer driver (for testing)"
-	---help---
+	help
 
 		This is a dummy Speakup driver for plugging a mere serial
 		terminal.  This is handy if you want to test speakup but
-- 
2.7.4

