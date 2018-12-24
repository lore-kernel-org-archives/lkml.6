Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D52DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 10:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE3920675
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 10:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cl/KEm+1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725769AbeLXKMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 05:12:30 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50450 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbeLXKM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 05:12:29 -0500
Received: by mail-wm1-f68.google.com with SMTP id n190so10831722wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 02:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=bLcAzQ30yuHPWMYONJiolPfpkxIxi962aHNmasvuAnU=;
        b=cl/KEm+1lMski4efGkcr9UkqcjR4p41HBSpxUOf8c9Kk+NVayGOdb7RcZV1jRD95zQ
         FY1S/LQaI63LXbnxtPj1obDmVohRDOUwSyy7IP+u/wQc3OMTUpYLqIsY81xrzL1w4gXY
         ps2/wBBh5XT8uMsvK0oGK2eIw9ZmeOvLPlq0DYoPcWb8gghoXaAieb7VcMEEDeH7aYvT
         NO+PKUFe8JL3YhHJY/u+cpAF5CQoFMkDk2/3Nj2bJOOmGc3RVaSMQ6N7VUL9QsaLIXJI
         yHnOdb1+tJmj99cAWgLCGzGg2Q6qXCBj3KL/QuzuXRMNtj8UpGJiX4YAC2yEAF6V9ewa
         0llg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=bLcAzQ30yuHPWMYONJiolPfpkxIxi962aHNmasvuAnU=;
        b=bJcUQw9tZeowLWqqHMHBJkTsGuF58PhbKXo7tsGX+t0cBv+8BFoCeo7E0tTTYjqNXS
         kogvfDY/LzfwZBRpxsRkrd9eFu9unD/vzYpbw1FmEV2P0CkFoof+Wx/KjkEKx8bsXcp4
         zoVpJtuDrQelL3yauFLquwAcLdzel8NJ1/gdszsUT6CwlxhIQubBCL61Uo8rWX2aADRP
         5yeiiQTtIopl8xa5o/qbwzCGSSxG9QUdQODFWjr6qKGlmL2ukVOliXjtZNV1OFHDAvlf
         za9U3MFkyEltpcS0/I2zfNP5eW7LQPC8rAS37Zmiv9vI88CCQTRD6fbgNK4uHyj+uGPK
         JAVw==
X-Gm-Message-State: AA+aEWaY49IExmhbEMp9X3JbqQoFRqPNU7dzC+efFN+O0uXq5LzE18jb
        XD5+Wx6c4hFvkhoKopqsvVbj0oBX
X-Google-Smtp-Source: ALg8bN5A8FqbvgVgdHrgFG90N7bReJyoTOQsyltPWQ0YKtW5Onf2HNYRBX6kACFNnKGqfA8Aac337w==
X-Received: by 2002:a1c:c44c:: with SMTP id u73mr12319689wmf.45.1545646345328;
        Mon, 24 Dec 2018 02:12:25 -0800 (PST)
Received: from dan-VirtualBox ([2.126.8.253])
        by smtp.gmail.com with ESMTPSA id t70sm28211575wmd.36.2018.12.24.02.12.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Dec 2018 02:12:24 -0800 (PST)
Date:   Mon, 24 Dec 2018 10:12:23 +0000
From:   Daniel Smith <daniel.bazinga@gmail.com>
To:     William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Daniel Smith <daniel.bazinga@gmail.com>,
        speakup <speakup@linux-speakup.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] staging: speakup: Fix coding style
Message-ID: <20181224101118.GA21642@dan-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaced text ---help--- with help as per style check patch recommendation

Signed-off-by: Daniel <daniel.bazinga@gmail.com>
---
 drivers/staging/speakup/Kconfig | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/speakup/Kconfig b/drivers/staging/speakup/Kconfig
index efd6f4560d3e..d8ec780f7741 100644
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
2.17.1

