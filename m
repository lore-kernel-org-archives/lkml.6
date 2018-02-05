Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3155980-1517855172-2-504921584415572309
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
    t=1517855171; b=F4PGEBMaCG1TJyiPqqNmFCCw+qad36FQ0WoyLoaLL+LIsD/
    tgJMkCMwRlN6fYFc4qn2iw1F2xwXPH4qU4V7/B+a80o+ureO0XfnoAZjYIAeqQoP
    +c2hJqzJeqv7MHQZSiQIkgqtaJBogkA1kMTY9zttX8ATu78uWGexESKKw4z8Wn/u
    aBU9b7gDBgB9tcSlMXN24dMoazJX6wnPVUvpwt0ehdEGpd3JEqQ2ya0JSlgHs4ie
    E1ETJWSqU8Pc5o2T0fEMXp9nzWKvJ5nxKR/mIlEjINJEv5k0dh3i6+jHdjO0RSHM
    C9A7hYy5BMWMhSANhq+aHIDcm2H3i5KwUWU27bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517855171; bh=f0YBKGdmqZZGYc6/6JYqVRjiit
    tYISs0YIw+amZwpAE=; b=uyuJwhZpO1WJXCCXcxXGUrdzMwOr5mDTFiScyAuC8o
    kHPFn06VO+YZ4AX1b1cIu+xOibL+TjLQ71o91kRLTr9Gzig4fTC3wAbDTq04rZ9E
    2XP6Rfi+TYruKI8xeP1BagkTeEPUTwOPFCUYmaFy3Kokphf72AUyXZBSuM7N8sCu
    eh6AjF8Zm3jYkPzjrlr7ZVLQ280MWwpQFWZg3ee3NNv0Q7Xg0hbCXY94qHMBz+Ls
    QOd1Fn9uX+DlZKZrBGKeVqsbA0zBf6lSntBq7g9HEKYMPzKxvY8Hz4iQpatEJtgn
    j4qXCsAkMFGKQxY0/7Lz3S41j1+fMCOzlaPE9V1JCeZg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753858AbeBES0E (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 13:26:04 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:52852 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753393AbeBESZ6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Feb 2018 13:25:58 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jesse Chan <jc@linux.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.15 20/60] pinctrl: pxa: pxa2xx: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE
Date: Mon,  5 Feb 2018 10:22:53 -0800
Message-Id: <20180205182214.758220705@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182213.902626065@linuxfoundation.org>
References: <20180205182213.902626065@linuxfoundation.org>
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

commit 0b9335cbd38e3bd2025bcc23b5758df4ac035f75 upstream.

This change resolves a new compile-time warning
when built as a loadable module:

WARNING: modpost: missing MODULE_LICENSE() in drivers/pinctrl/pxa/pinctrl-pxa2xx.o
see include/linux/module.h for more information

This adds the license as "GPL v2", which matches the header of the file.

MODULE_DESCRIPTION and MODULE_AUTHOR are also added.

Signed-off-by: Jesse Chan <jc@linux.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pinctrl/pxa/pinctrl-pxa2xx.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
+++ b/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
@@ -436,3 +436,7 @@ int pxa2xx_pinctrl_exit(struct platform_
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pxa2xx_pinctrl_exit);
+
+MODULE_AUTHOR("Robert Jarzmik <robert.jarzmik@free.fr>");
+MODULE_DESCRIPTION("Marvell PXA2xx pinctrl driver");
+MODULE_LICENSE("GPL v2");
