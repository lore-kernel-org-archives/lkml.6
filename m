Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2757788-1519127882-2-14109429261352546217
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES endaro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519127882; b=CeNE6Vpx58yN5eQK3FN4QqvV1M4YQn3Psgvkocge1aha6Cm
    TQ09/F7chQ+/LDLB22nDFy4Mr4sgLlLEc7FpYcjSj87T5YY7rFzaD06s1LJlwjgx
    OYziADDEBv3oY5278lIS3BtsEYlI6wnxAxEcsKwv5MKXfbJEvOxQA81zm0CpbLNx
    DqMStjwAn0X6goHAbb0VPWAMqtoIDT/Sf7ewASJNVkIyCso7+36qnVddeDuDigL5
    LnbGcMvyEkUy6enYoJKZOuB/9ckaJLwNjDolBH9s35MDj0PngODEYKeEFSzRB3Mv
    6rAlOd5bi/QbzWYIwOWKQb/d3sL5A/kou8G12Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519127882;
    bh=O3zQnuMsyJ+iGP/Z7vaTKsP2M3zRctspLbZfNgRN8hU=; b=f8hT5GBwPKgU
    B6l8PoQjFvmJdVxO1HuljYWDk6DRKeEHaJ4HIk8OUHisXcvmITV2czd55+IdgeJA
    AtxIjQG31b7JwRvXmvdXv3jXoO0FiMiRZLjCeLXedctYsnhNlSclB+FVQA2ZL2SZ
    C2tHkUldu4WM0JYoAvAnrbCrLyLMyxr+kYd+kQU2WO7OzW+eM4MhcT3RB2e4Dx89
    Vbf1+i7X8hdeYKh+vKgUuvWcX3B4NVsJAfNZfoqNfXLfoIVyiL94nv8APzpjAIfG
    V3hvVlY1YyudhHleuh81TQZLcnJw7p/a/bPZjSWE/95pLR/V/vespJVWSkCWJOXR
    D+iDlPNxcA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751569AbeBTL5p (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 06:57:45 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:37593 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751566AbeBTL5n (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Feb 2018 06:57:43 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: stable@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-gpio@vger.kernel.org
Subject: [4.4-stable 01/22] gpio: xgene: mark PM functions as __maybe_unused
Date: Tue, 20 Feb 2018 12:54:48 +0100
Message-Id: <20180220115527.1806578-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180220115527.1806578-1-arnd@arndb.de>
References: <20180220115527.1806578-1-arnd@arndb.de>
X-Provags-ID: V03:K0:dUGZk+kvCgCJDZBqh0EahzGCYEGuzISKu+YXHXIAusBVL20Z4Hp
 XGM4OWC+HEIaVw/TlUYRevoGIzSQ3VGbFSHrx0OTgv4WDlJgw6AmIhtdUcuhac7TvLTfHsy
 7yzti1L2CQPVh0iSIZzRR5aU6Ng3Hg9+DXZ1P0VnsVKOLcSi+unUTI9eCajYTxGvWhahDT5
 TtF+DIQ+XEnpEn7jN073w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AUYM+Ufq0BQ=:fZjJtv+sGbkVMzg27+C2ba
 F5aPEWk3FAofrAOS+QzdHPk7l1P65hhaP9kKG06aWgRmbrjSf34w9psXAsCG4+sqAhG+YWu1S
 De1dt/lVBdDX+pOd74q6AYGE2yJat8ns3XreK7wSJBD+n2FEb2EQjNwOytSCpon73V6Aqtotz
 9O6tbDpnH6aAr5bwEW8tkw6mCNMSRp27TmBMNaeeEMWbNd7thTFWEt8OatCzjnXkgVdQihqGf
 +TMVOeDw3IVHpTlMHL/IhS1iGHDixU/kCZ1ClhtFdFiF5DyJpE52deIcrHFqjvQbj16FLOHDT
 fEb8iVd4GDRNlWlYS26nGX8ABI0CKKizTlLaiaUFtG6yFjq2yCDYkcVemaa6jsiCMBtug//u9
 j7KScaC593TLsYupQKtg2QvQVpnM/LHpK78CwrNpuq/IOQeIWJrfVHu8pNrKr/Ql+gP6AmO5u
 Fbnm0y31s6cF9jKTABF/EXhHeENr6R6Y4vdflq9KiGXBEeOxazYaoLByOA2SEDmZ4MfgYyo6Q
 O6gEQDACQzdEtc812wBDkaidaI3JQ+cwmC0JxpYoTPq7bjieFCrkR8sdol/Egqm+Z1kCW7PHx
 9c+Tz0rFQPdkz7gcj8AtFUgmUQ/S93M/VtZlVnMTgyz8ttYjtWv+CIVSCLRsRv1nuu4uYKtcL
 jlWtOeSoEGDUJIUNEult2VOs7ayjX+J+gwBZv0Z6Qp4Sc1HjWaUGI3xPPqjuRyRc9TMS36fF8
 r6hOP9bUGhNg0sinfRI+wR3x1U1DYcUvHjdBPA==
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When CONFIG_PM_SLEEP is disabled, we get a warning about unused functions:

drivers/gpio/gpio-xgene.c:155:12: warning: 'xgene_gpio_resume' defined but not used [-Wunused-function]
 static int xgene_gpio_resume(struct device *dev)
            ^~~~~~~~~~~~~~~~~
drivers/gpio/gpio-xgene.c:142:12: warning: 'xgene_gpio_suspend' defined but not used [-Wunused-function]
 static int xgene_gpio_suspend(struct device *dev)

The warnings are harmless and can be avoided by simplifying the code and marking
the functions as __maybe_unused.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
(cherry picked from commit b115bebc07f282067eccc06fd5aa3060ab1426da)
[arnd: backported to 4.4-stable]
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpio/gpio-xgene.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-xgene.c b/drivers/gpio/gpio-xgene.c
index 18a8182d4fec..7f1f32324504 100644
--- a/drivers/gpio/gpio-xgene.c
+++ b/drivers/gpio/gpio-xgene.c
@@ -42,9 +42,7 @@ struct xgene_gpio {
 	struct gpio_chip	chip;
 	void __iomem		*base;
 	spinlock_t		lock;
-#ifdef CONFIG_PM
 	u32			set_dr_val[XGENE_MAX_GPIO_BANKS];
-#endif
 };
 
 static inline struct xgene_gpio *to_xgene_gpio(struct gpio_chip *chip)
@@ -132,8 +130,7 @@ static int xgene_gpio_dir_out(struct gpio_chip *gc,
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int xgene_gpio_suspend(struct device *dev)
+static __maybe_unused int xgene_gpio_suspend(struct device *dev)
 {
 	struct xgene_gpio *gpio = dev_get_drvdata(dev);
 	unsigned long bank_offset;
@@ -146,7 +143,7 @@ static int xgene_gpio_suspend(struct device *dev)
 	return 0;
 }
 
-static int xgene_gpio_resume(struct device *dev)
+static __maybe_unused int xgene_gpio_resume(struct device *dev)
 {
 	struct xgene_gpio *gpio = dev_get_drvdata(dev);
 	unsigned long bank_offset;
@@ -160,10 +157,6 @@ static int xgene_gpio_resume(struct device *dev)
 }
 
 static SIMPLE_DEV_PM_OPS(xgene_gpio_pm, xgene_gpio_suspend, xgene_gpio_resume);
-#define XGENE_GPIO_PM_OPS	(&xgene_gpio_pm)
-#else
-#define XGENE_GPIO_PM_OPS	NULL
-#endif
 
 static int xgene_gpio_probe(struct platform_device *pdev)
 {
@@ -230,7 +223,7 @@ static struct platform_driver xgene_gpio_driver = {
 	.driver = {
 		.name = "xgene-gpio",
 		.of_match_table = xgene_gpio_of_match,
-		.pm     = XGENE_GPIO_PM_OPS,
+		.pm     = &xgene_gpio_pm,
 	},
 	.probe = xgene_gpio_probe,
 	.remove = xgene_gpio_remove,
-- 
2.9.0
