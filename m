Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FBAC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C70D20869
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2ILiutFb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C70D20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbeIDARQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 20:17:16 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41996 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728425AbeIDARP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 20:17:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6nuLRGck1UzCxuwUpWnweXKdLF7HZpPsIMJVdQZfddA=; b=2ILiutFbR6siTD9jgPjo0Rf+GT
        nGprhmyCH7G9UVkLHmSDSj6b4xcNrlAFRRCtwcG/B3TsJOtujcqDNRNvFDcx17RfoNIHKEwZJDGNJ
        T3/ZUvb/1c6ouo9QHYJqWDG7lyeCNHnRXZsGMZrlOVS7ASnlX0P99rLRXrX0200h5hTlS3rscehWg
        dbkaEkvNpvEdJ+v6Oc988fcFe6CZ1eHSXVZN9RZ8uuTBQ+BuyymV502bn8bRTWkAk6LCOTLkIvRIn
        04YcJWwBcSxij2Wow0kt9YViXCn9/2Z+3TWjVzAfHPfgC7fvt1VQxSvkVD4QfKqNUVLbQ3Sc2ELI6
        jdGdpFdw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fwuwe-00020N-3h; Mon, 03 Sep 2018 19:55:32 +0000
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>, Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] gpio: fix kernel-doc notation warning for 'request_key'
Message-ID: <e80a35c7-a9f4-46bf-7036-11375f368ba5@infradead.org>
Date:   Mon, 3 Sep 2018 12:55:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kernel-doc warning for missing struct member 'request_key':

../include/linux/gpio/driver.h:142: warning: Function parameter or member 'request_key' not described in 'gpio_irq_chip'

Fixes: 39c3fd58952d ("kernel/irq: Extend lockdep class for request mutex")

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org
---
 include/linux/gpio/driver.h |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- lnx-419-rc2.orig/include/linux/gpio/driver.h
+++ lnx-419-rc2/include/linux/gpio/driver.h
@@ -66,9 +66,15 @@ struct gpio_irq_chip {
 	/**
 	 * @lock_key:
 	 *
-	 * Per GPIO IRQ chip lockdep classes.
+	 * Per GPIO IRQ chip lockdep class for IRQ lock.
 	 */
 	struct lock_class_key *lock_key;
+
+	/**
+	 * @request_key:
+	 *
+	 * Per GPIO IRQ chip lockdep class for IRQ request.
+	 */
 	struct lock_class_key *request_key;
 
 	/**


