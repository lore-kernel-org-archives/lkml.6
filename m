Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6805ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 01:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C72F2156E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 01:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QoWFoChX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C72F2156E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391709AbeIVHNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 03:13:11 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:44220 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeIVHNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 03:13:11 -0400
Received: by mail-yw1-f68.google.com with SMTP id b2-v6so1767656ywe.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 18:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YtxDGdS5WmP2lpgriVIeW783vVNCcQhPNphyJiNhET0=;
        b=QoWFoChXF2sEtZL94gkMp1t2KvGA61shz9hwqw4qMSziQTQJF8texXvqQsAZ2NeUTc
         RuJdphWmXLZzVITrqCICXPUaOAn+ac6kIubFzZGDJvkSc3CNNcSLwd9aICjo3JqOVA8w
         NgybrMx3vGOS5MTHjsQounqbRLNh97MjBoB4y20fNbFuRB3QfEhswulnMDXijyrdCKbt
         Xyi0pK4tBaGGf7sFv0bX9XuiP2vGleSe1Ca8PatPAQxgPeWi9BQTForB690gews/v7CN
         tR752GUj6JAcqiggo/WfWQX1W0inSVcimgUK8FMnlO354NQemLA5hDoO1pncYyLlZXOC
         Ctew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YtxDGdS5WmP2lpgriVIeW783vVNCcQhPNphyJiNhET0=;
        b=jaBMSDKMY4GB4LgTQ6NzAhS1DqOcSXrlh99CdeBt0A7mmV7flTQWg9bzqhvP9A5ZsO
         P2DBWskDoYg/x2ndAelaqzlhX3ToWTO/DWV9npLQ5CaT5v9lUhTCMbD7aIoe/I5aX8ee
         jqtLiDg2W/uxq2veVeU1PoMzy2F5X7k/u2NSuaaWxSJnJ29yrdopSBYCibhmPmyeluKd
         2nza9O5lKgHrNduD0oSdv0XoJspT8PoU9aa8gOg/fecLg0xAC02BIi/lyVZF0sg+oANz
         GPjUXJnV72X+xOUOeicBUJhSvLrMqNJnUapyGW0NddSO7aagE06guRNEVCvysYfNVK77
         IZXQ==
X-Gm-Message-State: APzg51B1LeWoNtzShhWjtzHwZazvIiDClJgAlOAtKlqESULPVtw/37om
        S7xlpgXgqPfTBFf2b4BavCE=
X-Google-Smtp-Source: ANB0VdapYG6DLHdZ3J+Q7sbdYXdQdIPlpOqPf+2Ciqmk9e/iHGhJ2MxDgXhhUP9dGei34gVbUOHKfg==
X-Received: by 2002:a81:4b50:: with SMTP id y77-v6mr134197ywa.198.1537579301532;
        Fri, 21 Sep 2018 18:21:41 -0700 (PDT)
Received: from GANOO-Loonix.attlocal.net (99-14-205-87.lightspeed.btrgla.sbcglobal.net. [99.14.205.87])
        by smtp.gmail.com with ESMTPSA id m19-v6sm40545ywh.31.2018.09.21.18.21.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 18:21:40 -0700 (PDT)
From:   Pierce Griffiths <pierceagriffiths@gmail.com>
Cc:     pierceagriffiths@gmail.com, Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] torture-test modules: Remove unnecessary "ret" variables
Date:   Fri, 21 Sep 2018 20:21:31 -0500
Message-Id: <20180922012132.23373-1-pierceagriffiths@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove return variables (declared as "ret") in cases where,
depending on whether a condition evaluates as true, the result of a
function call can be immediately returned instead of storing the result in
the return variable. When the condition evaluates as false, the constant
initially stored in the return variable at declaration is returned instead.

Signed-off-by: Pierce Griffiths <pierceagriffiths@gmail.com>
---
 kernel/torture.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/kernel/torture.c b/kernel/torture.c
index 1ac24a826589..f4cec6db7f3c 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -233,16 +233,15 @@ torture_onoff(void *arg)
  */
 int torture_onoff_init(long ooholdoff, long oointerval)
 {
-	int ret = 0;
-
 #ifdef CONFIG_HOTPLUG_CPU
 	onoff_holdoff = ooholdoff;
 	onoff_interval = oointerval;
 	if (onoff_interval <= 0)
 		return 0;
-	ret = torture_create_kthread(torture_onoff, NULL, onoff_task);
-#endif /* #ifdef CONFIG_HOTPLUG_CPU */
-	return ret;
+	return torture_create_kthread(torture_onoff, NULL, onoff_task);
+#else /* #ifdef CONFIG_HOTPLUG_CPU */
+	return 0;
+#endif /* #else #ifdef CONFIG_HOTPLUG_CPU */
 }
 EXPORT_SYMBOL_GPL(torture_onoff_init);
 
@@ -513,15 +512,13 @@ static int torture_shutdown(void *arg)
  */
 int torture_shutdown_init(int ssecs, void (*cleanup)(void))
 {
-	int ret = 0;
-
 	torture_shutdown_hook = cleanup;
 	if (ssecs > 0) {
 		shutdown_time = ktime_add(ktime_get(), ktime_set(ssecs, 0));
-		ret = torture_create_kthread(torture_shutdown, NULL,
+		return torture_create_kthread(torture_shutdown, NULL,
 					     shutdown_task);
 	}
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(torture_shutdown_init);
 
@@ -619,13 +616,10 @@ static int torture_stutter(void *arg)
 /*
  * Initialize and kick off the torture_stutter kthread.
  */
-int torture_stutter_init(int s)
+int torture_stutter_init(const int s)
 {
-	int ret;
-
 	stutter = s;
-	ret = torture_create_kthread(torture_stutter, NULL, stutter_task);
-	return ret;
+	return torture_create_kthread(torture_stutter, NULL, stutter_task);
 }
 EXPORT_SYMBOL_GPL(torture_stutter_init);
 
-- 
2.19.0

