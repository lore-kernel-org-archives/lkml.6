Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2951739-1517591805-2-11516641424554090823
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517591805; b=rJO5f9ZePdL3qMziffpd5e/PZif79fCXNrpELKBD/BjXSE0
    n/Whws84k+dDQ67kEP5zlDVQHgjP7WQvQnYzbxp/JcMyw8BjTG/vDhT1gCP/xV9v
    R0yfznpMXcVNHhpVMbVt6tQwBk80s98098bFKZJuJ5Ts0FcEkyN9Mnbw5MxotTBP
    /eSw4XxQNJGVD553i6g9jl3AOSGZPfgITqvEPoBWAU2LbIv75dCah1/gZfQYfr1E
    I+7snQ/dn9zfDW5bIQstG7OIUYdqJkFU28RK4wFpzQhZWkdDsEzMenG8E0KBHgw2
    Yc2umdg3SUPKF/BHK5xbjdT1CUCWiBR5AGv8ujg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591805; bh=r2k8pymWmmYKtTD3j8VP87oldQ
    faphIMc2yG8P9u7Fg=; b=ryWOuuV3hMmsIAN9LllQHFFCWpx/tnziXi+JJcnjo/
    xIBAp9JWjxguRZZFRn8MbSnAS0tE05ApSNtmuXWdvBLpjReJuA4177Eph8wZF797
    kRfawUHZygWpkfRUSnL90zYRdw7mj0RoGfYAVsNIGIsumonNio8wGuGILwALpTdd
    +tz41mgP4aYUuDJoV7Sp+50syT9/5f2xKfyMZRP7l/Nf2v7obYGGXVZU+USv4lRO
    p2RxFdzF3MMgtpLjury+ra7c0i9d9MrKHENKO18g1RZo1AKnUh02pG5Ihcoyam/s
    LE2jVVfkTIei17YupleAsq27PN6T4M53ZwMCq1umWkCQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753576AbeBBRQk (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:16:40 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:41044 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753850AbeBBRQi (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:16:38 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jesse Chan <jc@linux.com>,
        Alban Bedel <albeu@free.fr>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.15 20/55] gpio: ath79: add missing MODULE_DESCRIPTION/LICENSE
Date: Fri,  2 Feb 2018 17:58:38 +0100
Message-Id: <20180202140828.258547579@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140826.117602411@linuxfoundation.org>
References: <20180202140826.117602411@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jesse Chan <jc@linux.com>

commit 539340f37e6d6ed4cd93e8e18c9b2e4eafd4b842 upstream.

This change resolves a new compile-time warning
when built as a loadable module:

WARNING: modpost: missing MODULE_LICENSE() in drivers/gpio/gpio-ath79.o
see include/linux/module.h for more information

This adds the license as "GPL v2", which matches the header of the file.

MODULE_DESCRIPTION is also added.

Signed-off-by: Jesse Chan <jc@linux.com>
Acked-by: Alban Bedel <albeu@free.fr>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpio/gpio-ath79.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/gpio/gpio-ath79.c
+++ b/drivers/gpio/gpio-ath79.c
@@ -324,3 +324,6 @@ static struct platform_driver ath79_gpio
 };
 
 module_platform_driver(ath79_gpio_driver);
+
+MODULE_DESCRIPTION("Atheros AR71XX/AR724X/AR913X GPIO API support");
+MODULE_LICENSE("GPL v2");
