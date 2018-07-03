Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D3BC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E96208A4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linuxvaults.com header.i=@linuxvaults.com header.b="WvsQNv4b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78E96208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxvaults.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754630AbeGCHcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:32:02 -0400
Received: from crystal.urlnameserver.com ([99.198.127.110]:55287 "EHLO
        crystal.urlnameserver.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754218AbeGCHb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linuxvaults.com; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2djl80xM9DUJwMWAqR+Q99XMSOO26bDu7VeaXUmgL3s=; b=WvsQNv4b9USPBSzvnWfnmGRLln
        nmEpPTMw2xjc5iyIBugjJC3N3V5n3FEVoeIqe7FIA0Jq0XOTeQtfOVA3T+oARf9Mx+Ma7htPwYG2E
        Es6uIKAhSHhT8Kh7WRwsYN+gEgTKkRKDFqKFKFA94d1xHm5wcMt23Cfjidtqr3VeZy8i8q/KJAqbH
        R4F7NB5GKmLmj7cPqEjXGcthu9UWP1YFDDT2iRQ/veBOawYqZ6VMy/bYSTXEwTAp7Y4HkRlqB+JI1
        7f1zhM7DMZDV9GPO8wHge/xLOIo/OV+3Y6WO7RMWR/EOcV/ObLyqWXyZV9Ez2Po+mS5Fva8e7U/AT
        /iDJGVzg==;
Received: from [206.189.122.65] (port=34946 helo=kernel.local.domain)
        by crystal.urlnameserver.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <tsuliman@linuxvaults.com>)
        id 1faFmy-0006h7-2d; Tue, 03 Jul 2018 02:31:52 -0500
From:   Tamir Suliman <tsuliman@linuxvaults.com>
To:     w.d.hubbs@gmail.com, speakup@linux-speakup.org,
        gregkh@linuxfoundation.org
Cc:     dhowells@redhat.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, chris@the-brannons.com,
        tsuliman@linuxvaults.com
Subject: [PATCH 3/3] drivers/speakup: Fix style and coding warnings
Date:   Tue,  3 Jul 2018 07:31:20 +0000
Message-Id: <1530603080-1353-1-git-send-email-tsuliman@linuxvaults.com>
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

Fixed the following style/coding issues:
*updated ---help to the prefered new help texts which reduces the code/file size and fixes the warning messages
*Used else if instead of elese as else is not generally useful after a break or return, not sure if this is the acceptable but it resolved the warning messages.
*kstrtoul is used instead of the abosolete simple_strtoul

Signed-off-by: Tamir Suliman <tsuliman@linuxvaults.com>
---
 drivers/staging/speakup/Kconfig    | 43 ++++++++++++++------------------------
 drivers/staging/speakup/keyhelp.c  |  2 +-
 drivers/staging/speakup/kobjects.c |  4 ++--
 3 files changed, 19 insertions(+), 30 deletions(-)

diff --git a/drivers/staging/speakup/Kconfig b/drivers/staging/speakup/Kconfig
index efd6f45..2f282fd 100644
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
@@ -105,13 +103,11 @@ config SPEAKUP_SYNTH_DECPC
 	depends on m
 	depends on ISA || COMPILE_TEST
 	tristate "DECtalk PC (big ISA card) synthesizer support"
-	---help---
-
+	help
 		This is the Speakup driver for the DecTalk PC (full
 		length ISA) synthesizer.  You can say m to build it as
 		a module.  See the configuration help on the Speakup
 		choice above for more info.
-
 		In order to use the DecTalk PC driver, you must download
 		the dec_pc.tgz file from linux-speakup.org.  It is in
 		the pub/linux/goodies directory.  The dec_pc.tgz file
@@ -127,8 +123,7 @@ config SPEAKUP_SYNTH_DECPC
 config SPEAKUP_SYNTH_DTLK
 	tristate "DoubleTalk PC synthesizer support"
 	depends on ISA || COMPILE_TEST
-	---help---
-
+	help
 		This is the Speakup driver for the internal DoubleTalk
 		PC synthesizer.  You can say y to build it into the
 		kernel, or m to build it as a module.  See the
@@ -138,8 +133,7 @@ config SPEAKUP_SYNTH_DTLK
 config SPEAKUP_SYNTH_KEYPC
 	tristate "Keynote Gold PC synthesizer support"
 	depends on ISA || COMPILE_TEST
-	---help---
-
+	help
 		This is the Speakup driver for the Keynote Gold
 		PC synthesizer.  You can say y to build it into the
 		kernel, or m to build it as a module.  See the
@@ -148,8 +142,7 @@ config SPEAKUP_SYNTH_KEYPC
 
 config SPEAKUP_SYNTH_LTLK
 	tristate "DoubleTalk LT/LiteTalk synthesizer support"
----help---
-
+	help
 		This is the Speakup driver for the LiteTalk/DoubleTalk
 		LT synthesizer.  You can say y to build it into the
 		kernel, or m to build it as a module.  See the
@@ -158,8 +151,7 @@ config SPEAKUP_SYNTH_LTLK
 
 config SPEAKUP_SYNTH_SOFT
 	tristate "Userspace software synthesizer support"
-	---help---
-
+	help
 		This is the software synthesizer device node.  It will
 		register a device /dev/softsynth which midware programs
 		and speech daemons may open and read to provide kernel
@@ -169,8 +161,7 @@ config SPEAKUP_SYNTH_SOFT
 
 config SPEAKUP_SYNTH_SPKOUT
 	tristate "Speak Out synthesizer support"
-	---help---
-
+	help
 		This is the Speakup driver for the Speakout synthesizer.
 		 You can say y to build it into the kernel, or m to
 		build it as a module.  See the configuration help on the
@@ -178,8 +169,7 @@ config SPEAKUP_SYNTH_SPKOUT
 
 config SPEAKUP_SYNTH_TXPRT
 	tristate "Transport synthesizer support"
-	---help---
-
+	help
 		This is the Speakup driver for the Transport
 		synthesizer.  You can say y to build it into the kernel,
 		or m to build it as a module.  See the configuration
@@ -187,8 +177,7 @@ config SPEAKUP_SYNTH_TXPRT
 
 config SPEAKUP_SYNTH_DUMMY
 	tristate "Dummy synthesizer driver (for testing)"
-	---help---
-
+	help
 		This is a dummy Speakup driver for plugging a mere serial
 		terminal.  This is handy if you want to test speakup but
 		don't have the hardware.  You can say y to build it into
diff --git a/drivers/staging/speakup/keyhelp.c b/drivers/staging/speakup/keyhelp.c
index 5f1bda3..a1bbe8f 100644
--- a/drivers/staging/speakup/keyhelp.c
+++ b/drivers/staging/speakup/keyhelp.c
@@ -167,7 +167,7 @@ int spk_handle_help(struct vc_data *vc, u_char type, u_char ch, u_short key)
 		synth_printf("%s\n", spk_msg_get(MSG_HELP_INFO));
 		build_key_data(); /* rebuild each time in case new mapping */
 		return 1;
-	} else {
+	} else if {
 		name = NULL;
 		if ((type != KT_SPKUP) && (key > 0) && (key <= num_key_names)) {
 			synth_printf("%s\n",
diff --git a/drivers/staging/speakup/kobjects.c b/drivers/staging/speakup/kobjects.c
index f1f9022..a98a0a4 100644
--- a/drivers/staging/speakup/kobjects.c
+++ b/drivers/staging/speakup/kobjects.c
@@ -154,7 +154,7 @@ static ssize_t chars_chartab_store(struct kobject *kobj,
 			continue;
 		}
 
-		index = simple_strtoul(cp, &temp, 10);
+		index = simple_kstrtoul(cp, &temp, 10);
 		if (index > 255) {
 			rejected++;
 			cp = linefeed + 1;
@@ -787,7 +787,7 @@ static ssize_t message_store_helper(const char *buf, size_t count,
 			continue;
 		}
 
-		index = simple_strtoul(cp, &temp, 10);
+		index = simple_ktrtoul(cp, &temp, 10);
 
 		while ((temp < linefeed) && (*temp == ' ' || *temp == '\t'))
 			temp++;
-- 
1.8.3.1

