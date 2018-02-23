Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3759000-1519415343-2-12328663565223387204
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519415343; b=GyNPDFbYcheihvD6vs65Td2mZ+S5UEtGPQAzm0i8XrVHzxZ
    GuCaItV8IXaa8QThHN5wsYbo6bOaWi9LdA4HvZtC4eQ4ikQsqIuFvfC9lyEX/RpR
    nBS4v19ch34eEVyS56ln97Gj4/6jB9iXCmqHy+LUjfZwzkkaLiH6iGysU1j5sHsz
    nuxoCRXomR6aAt9UXVd/vQoKOzTLjhE6hphXROP60ELpqakQALm7WEsE8P62xBef
    tY+QWLAGgNQIetS1q4hbSbhhvnf83UGrMoETb4wnMm4N8ZC7lbdlv8Vk70p77VYj
    IHQjUj7NHmfMgUYrAdP1eKAlMJZs4KpAAlBLc3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415343; bh=I/IGhRbhGUYX8A0F3lVP+4AC42
    zCQ+cGcVPzCaF7pus=; b=rfLnN97Qwa8hF/xenBirMXafHvtr+TZBDQaVYk0FZp
    qacIPO87uiW5hmKtgaDXReE1F3fSOhprbpN/ti8qbH5YLMgqGDKi84pJC2qUcC9R
    AXWGw8xCBOETq7VylJLUBNeUFQg8DEY4Iw6VMfrMlYI4paRhJSDOqRHjdDS2kUnB
    8l4MGhHxGUcZK7CjsulNNQOl1vs588YhohhfKNUw0DM12kcsdIlYtkQzhzSEIsmS
    Dl3ebDbFrjmkATENnnFpCOI5J1bNkdZg6P8NiCdvikaHORvDxqBu9pArJ53vSV0X
    ch+iH4y++7G74WoIxQ6XOkBL1o56PwrkIzJo2g5vbCYg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934077AbeBWSrB (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:47:01 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44130 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934058AbeBWSq6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:46:58 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.9 105/145] gpio: xgene: mark PM functions as __maybe_unused
Date: Fri, 23 Feb 2018 19:26:51 +0100
Message-Id: <20180223170738.367353878@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit b115bebc07f282067eccc06fd5aa3060ab1426da upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpio/gpio-xgene.c |   13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

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
 
 static int xgene_gpio_get(struct gpio_chip *gc, unsigned int offset)
@@ -138,8 +136,7 @@ static int xgene_gpio_dir_out(struct gpi
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int xgene_gpio_suspend(struct device *dev)
+static __maybe_unused int xgene_gpio_suspend(struct device *dev)
 {
 	struct xgene_gpio *gpio = dev_get_drvdata(dev);
 	unsigned long bank_offset;
@@ -152,7 +149,7 @@ static int xgene_gpio_suspend(struct dev
 	return 0;
 }
 
-static int xgene_gpio_resume(struct device *dev)
+static __maybe_unused int xgene_gpio_resume(struct device *dev)
 {
 	struct xgene_gpio *gpio = dev_get_drvdata(dev);
 	unsigned long bank_offset;
@@ -166,10 +163,6 @@ static int xgene_gpio_resume(struct devi
 }
 
 static SIMPLE_DEV_PM_OPS(xgene_gpio_pm, xgene_gpio_suspend, xgene_gpio_resume);
-#define XGENE_GPIO_PM_OPS	(&xgene_gpio_pm)
-#else
-#define XGENE_GPIO_PM_OPS	NULL
-#endif
 
 static int xgene_gpio_probe(struct platform_device *pdev)
 {
@@ -241,7 +234,7 @@ static struct platform_driver xgene_gpio
 		.name = "xgene-gpio",
 		.of_match_table = xgene_gpio_of_match,
 		.acpi_match_table = ACPI_PTR(xgene_gpio_acpi_match),
-		.pm     = XGENE_GPIO_PM_OPS,
+		.pm     = &xgene_gpio_pm,
 	},
 	.probe = xgene_gpio_probe,
 };
