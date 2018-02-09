Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1472218-1518185391-2-524728403528835168
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
    t=1518185390; b=o15aqJPn9IgvYcbv+dS0KwP2JtbbTDRRyY37yE6Z1a+HY/K
    kfr7DbH9DsZXPWlTP26EoiJ4RIW20xh9dBI7J3BkA5M2xfdiNQbqRj6xnZpAf2iS
    EsV6QLdmpukRgsbg7SOHHptnaj0j1OQJX/+SmZqyjfbDaTKoUS/NqdpDzy7PfPwM
    L4KPMgLiXQiZGg2BcDEhoNlCKcCUStDAefVtCWH50j/hXSD6g2bqd0FlZoKTUa2p
    KanEp4gUbNY2K6/HylpeBtsCqw42WgLWKfFBx9cnlPyra+vucY5ujOvljJ2T6uX/
    PpF/scSL7i1erGjcua5Y1Cf64nyW+fD/wG6vXIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518185390; bh=taXpUteJFSjjvAkXcIqX45GXvd
    3DrmXhwyvn0Pv6K3g=; b=PBl/f4+BSLAe+Wtrfu9OCJ+yp6a4IMWMTBfs5vQAYY
    Cxoor6mqoTNQ33w9p6WH4JjI9Qov9TZjyjKGuXrNIzpG4Bl6qVUn1WN/9jf8I8eH
    TWHgybfgFwhct4HasSg+6JfiYjT5B6sC9GoZWeVJWXP/wl/1tIxsCXeNpwrhV15a
    VL3bAjLQNAonTMv8tRN1elUJ82W1u9zqWK/cCOEe/sNZ5JzCKOK3ryewCBgUcA0Q
    6JyHKtQsUIFjnW2iTJN4qYdFLLrrU58rjzoCYeBfzlLvTYTWFQhdGc9N4uJlw7eo
    IcRcaYoUJZ5S3RIRD5xf0kSRXA/D7CFHfflndIEJ6p+g==
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
        id S1752915AbeBINm1 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:42:27 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:49836 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752862AbeBINmZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:42:25 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jesse Chan <jc@linux.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.9 13/92] pinctrl: pxa: pxa2xx: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE
Date: Fri,  9 Feb 2018 14:38:42 +0100
Message-Id: <20180209133932.216272000@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133931.211869118@linuxfoundation.org>
References: <20180209133931.211869118@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
