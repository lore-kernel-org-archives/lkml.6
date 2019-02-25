Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31732C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9ECD218AD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="z32aNs4V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbfBYXwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 18:52:30 -0500
Received: from merlin.infradead.org ([205.233.59.134]:45538 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbfBYXwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 18:52:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=z1mwNJNRSq7/UFbguhczkMj/lZAICprMNrOmaMSUey0=; b=z32aNs4V5dri9PwM7VjY1XGvLQ
        6jk24WaEm67i8zPh07J8nVMIbEhk1Jme1rw3YT9CXIKlZCmFjQpoeeREmEzGSwuHA8LfB5YnVruNW
        /nMiSFWR3TrJCPplNkZsAThNkpNotqSUL25bN2LOAg9nP7UGJ2EzCqkUwxNwlTuu7DOebm12EpubN
        /3TdQ6EDvKN0QnmuO5Bbq507hBTwViKJ1R1QclWPKstfb+C/pYKY1iJJMCQet4SXky9ASv7faFGQ6
        6fAptcg34oLPRsnmWBj62vUY0FcRHh9c/JNwB0rFYiUckOup6+QGjrR8lWz8lvoOIkSLSe6dvtd7/
        1SS6WR8Q==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gyQ2j-0001m8-GN; Mon, 25 Feb 2019 23:52:17 +0000
To:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next & -mmotm] platform/x86: fix PCENGINES_APU2 Kconfig
 warning
Message-ID: <0788056c-1a0b-6e0e-0034-72f40f309eab@infradead.org>
Date:   Mon, 25 Feb 2019 15:52:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix Kconfig warning for PCENGINES_APU2 symbol:

WARNING: unmet direct dependencies detected for KEYBOARD_GPIO_POLLED
  Depends on [n]: !UML && INPUT [=y] && INPUT_KEYBOARD [=n] && GPIOLIB [=y]
  Selected by [y]:
  - PCENGINES_APU2 [=y] && X86 [=y] && X86_PLATFORM_DEVICES [=y]

Add INPUT_KEYBOARD dependency for KEYBOARD_GPIO_POLLED.
Add LEDS_CLASS dependency for LEDS_GPIO.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/platform/x86/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

--- mmotm-2019-0225-1340.orig/drivers/platform/x86/Kconfig
+++ mmotm-2019-0225-1340/drivers/platform/x86/Kconfig
@@ -1305,6 +1305,8 @@ config HUAWEI_WMI
 
 config PCENGINES_APU2
 	tristate "PC Engines APUv2/3 front button and LEDs driver"
+	depends on INPUT_KEYBOARD
+	depends on LEDS_CLASS
 	select GPIO_AMD_FCH
 	select KEYBOARD_GPIO_POLLED
 	select LEDS_GPIO

