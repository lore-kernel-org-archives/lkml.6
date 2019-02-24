Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7269C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 13:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D76E20663
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 13:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rGz2EQzn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbfBXNLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 08:11:51 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34586 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbfBXNLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 08:11:51 -0500
Received: by mail-pf1-f195.google.com with SMTP id u9so3217143pfn.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 05:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=XjHSOSLiPzh5VF/Fq/eNpydo5Ui4GiETw7iqJYxH3oQ=;
        b=rGz2EQznCx3iN5dckh/v+qeSiNduPH/4ESKrIl0dnjVuUDm5LqTli0iooaedKVwrrO
         LqnZHF67PJJAs2h4VOGawZZlfYGGP3S1pU+UT8FTnnFlS+o+T6wWjasfHEYRdf5duKKr
         gD18QoLrDKhNycvbHgpN0gYgVp7CAP7/yQEA81hQJLkVBx/iP4LKeUxiEkOZK/pSKwAO
         o3ib2+qWvmpuYDl57rrVv7zuMHN7pTksg/wqGRER2lFFZZ6ZNf7mw8P+8Pb/dyTyqthe
         uI4RTzGVQ+k9A0u0ItHnUNIoKRDeD9sKJuk+0SHeSqWjda1OYYfCTNTMv0LbxdTZ4r/T
         HDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=XjHSOSLiPzh5VF/Fq/eNpydo5Ui4GiETw7iqJYxH3oQ=;
        b=MudD05gBRtKHlVhs01x431JZRUVzX5jTsfLm9VlR7kokw+NKAX2AvLgkKX0ArbKbN6
         vVjKd2GpuF9hqciLN22jlgAi0DsS9IjrzLvDrIWeFyvzMjk8RuU7wd26wOKK8uuxLwzw
         bYaQR0j1ODN1NVh0YAH0vCiC4YFWoRq9LxR7hZD4ebT7RxfYkNEXwufYE/1WxGzoKetF
         83CYj8jnEu4v/bD5cnfxkx3Te7LSQFnH4+OyXcOSAhYH1Od40+gDAvaWOPzXjtCDsmfz
         0w0r6WYLpYyLwQVaFjZpOCq6Z/4aAbDBo8QWJidHNlFD5ptjxU9cS5gCI5+a1bOev3TA
         6Z3g==
X-Gm-Message-State: AHQUAubfnExp04ljWr1BucB/Oy4p+i7g9tb24OVT/bERhNh9yX9SvE/J
        C6FInmXgs9KsfNZ5QrsGLyU=
X-Google-Smtp-Source: AHgI3IYzCwj0CYKKHh/SK+dn6zniispgifA2vrxDRSn8zKbP7Gjadbvvoe4hZ9U8uTbMTIwoKJXgRw==
X-Received: by 2002:a63:ef05:: with SMTP id u5mr13148279pgh.177.1551013910447;
        Sun, 24 Feb 2019 05:11:50 -0800 (PST)
Received: from bharath12345-Inspiron-5559 ([103.110.42.33])
        by smtp.gmail.com with ESMTPSA id j9sm10413461pfc.67.2019.02.24.05.11.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 05:11:50 -0800 (PST)
Date:   Sun, 24 Feb 2019 18:41:42 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     w.d.hubbs@gmail.com
Cc:     chris@the-brannons.com, kirk@reisers.ca,
        samuel.thibault@ens-lyon.org, gregkh@linuxfoundation.org,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging : speakup: Fix format issues in Kconfig
Message-ID: <20190224131142.GA9871@bharath12345-Inspiron-5559>
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
Changes since v1:
	- Allign help and removed redundant spaces.
---
 drivers/staging/speakup/Kconfig | 42 ++++++++++++++++-------------------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/speakup/Kconfig b/drivers/staging/speakup/Kconfig
index efd6f45..4a78ab1 100644
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
@@ -84,8 +84,7 @@ config SPEAKUP_SYNTH_BNS
 
 config SPEAKUP_SYNTH_DECTLK
 	tristate "DECtalk Express synthesizer support"
-	---help---
-
+	help
 		This is the Speakup driver for the DecTalk Express
 		synthesizer.  You can say y to build it into the kernel,
 		or m to build it as a module.  See the configuration
@@ -93,8 +92,7 @@ config SPEAKUP_SYNTH_DECTLK
 
 config SPEAKUP_SYNTH_DECEXT
 	tristate "DECtalk External (old) synthesizer support"
-	---help---
-
+	help
 		This is the Speakup driver for the DecTalk External
 		(old) synthesizer.  You can say y to build it into the
 		kernel, or m to build it as a module.  See the
@@ -105,8 +103,7 @@ config SPEAKUP_SYNTH_DECPC
 	depends on m
 	depends on ISA || COMPILE_TEST
 	tristate "DECtalk PC (big ISA card) synthesizer support"
-	---help---
-
+	help
 		This is the Speakup driver for the DecTalk PC (full
 		length ISA) synthesizer.  You can say m to build it as
 		a module.  See the configuration help on the Speakup
@@ -127,8 +124,7 @@ config SPEAKUP_SYNTH_DECPC
 config SPEAKUP_SYNTH_DTLK
 	tristate "DoubleTalk PC synthesizer support"
 	depends on ISA || COMPILE_TEST
-	---help---
-
+	help
 		This is the Speakup driver for the internal DoubleTalk
 		PC synthesizer.  You can say y to build it into the
 		kernel, or m to build it as a module.  See the
@@ -138,8 +134,7 @@ config SPEAKUP_SYNTH_DTLK
 config SPEAKUP_SYNTH_KEYPC
 	tristate "Keynote Gold PC synthesizer support"
 	depends on ISA || COMPILE_TEST
-	---help---
-
+	help
 		This is the Speakup driver for the Keynote Gold
 		PC synthesizer.  You can say y to build it into the
 		kernel, or m to build it as a module.  See the
@@ -148,8 +143,7 @@ config SPEAKUP_SYNTH_KEYPC
 
 config SPEAKUP_SYNTH_LTLK
 	tristate "DoubleTalk LT/LiteTalk synthesizer support"
----help---
-
+	help
 		This is the Speakup driver for the LiteTalk/DoubleTalk
 		LT synthesizer.  You can say y to build it into the
 		kernel, or m to build it as a module.  See the
@@ -158,8 +152,7 @@ config SPEAKUP_SYNTH_LTLK
 
 config SPEAKUP_SYNTH_SOFT
 	tristate "Userspace software synthesizer support"
-	---help---
-
+	help
 		This is the software synthesizer device node.  It will
 		register a device /dev/softsynth which midware programs
 		and speech daemons may open and read to provide kernel
@@ -169,8 +162,7 @@ config SPEAKUP_SYNTH_SOFT
 
 config SPEAKUP_SYNTH_SPKOUT
 	tristate "Speak Out synthesizer support"
-	---help---
-
+	help
 		This is the Speakup driver for the Speakout synthesizer.
 		 You can say y to build it into the kernel, or m to
 		build it as a module.  See the configuration help on the
@@ -178,8 +170,7 @@ config SPEAKUP_SYNTH_SPKOUT
 
 config SPEAKUP_SYNTH_TXPRT
 	tristate "Transport synthesizer support"
-	---help---
-
+	help
 		This is the Speakup driver for the Transport
 		synthesizer.  You can say y to build it into the kernel,
 		or m to build it as a module.  See the configuration
@@ -187,8 +178,7 @@ config SPEAKUP_SYNTH_TXPRT
 
 config SPEAKUP_SYNTH_DUMMY
 	tristate "Dummy synthesizer driver (for testing)"
-	---help---
-
+	help
 		This is a dummy Speakup driver for plugging a mere serial
 		terminal.  This is handy if you want to test speakup but
 		don't have the hardware.  You can say y to build it into
-- 
2.7.4

