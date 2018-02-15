Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1906823-1518710496-2-11096338762521930579
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518710495; b=jZSVDtZ/rmlkU9fLZHpIc5/slB4gkuUP2MFKA3L/YG0Ubt6
    Xa4gvghcp3Pi0VZ03u1mj23j9RijSdUPOkMSyrvVyUdIOtzaGrjqK4oxielt6ala
    Z6ss3flYFHTDWMf8koqPm+Aeq3Ntq6LtX2QPPa/+uLAgwcfu5U61N8KqJMiTivhJ
    tqym9UyUbzjXkXwOyiPonqgx+kSFcPZUN5rLjcMeyb7otppQADzeZXtZ2+lkFQpo
    QieY9TU/GMxe0vN3h9u8jOygoa9r02HUO1rOdAf0st/h/5Fu0R6OPpcTm3K3DY3S
    IJY+Bhk/C/XL6ycEJ5eBG6Oij1VinK+oZW0q4NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518710495; bh=kYohN5qS8aK+BJyDiWGOWMsmyB
    WObwqRKSp5z7zc7SQ=; b=Pw0pgBUHem2bo1n26e/cIhR1ngRjbYZLFNEg+W3rlX
    q3D1eDMpe/cnGadwRRLr0V5WRyJ7QY9dTyqggjkopQDWhT0+gzS8q22etsOIdxFt
    ZJgLoF18DcizZXvd2KfiGkRO8L/KuB9tzJm8GZbTxw+BDhvRD8+mBxtv4YdJjpj0
    bwVO1dbcv5XMt0YL8NvN/70An0sYYUCV8Y1LFPRtrlAn0AHW9V62/J/nfd583j4v
    ZuQVe4rVpJFL6Dh7FXhdVwol/8bynMiCPNi+XkJpoCr7TwKI6QpUT4q0mreZ3q3p
    cawpsDIL8N08qK5xvX3dN7V8iWjRV8U01y/mDkcqTLqg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424757AbeBOPqw (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:46:52 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35942 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424749AbeBOPqs (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:46:48 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Peter Rosin <peda@axentia.se>
Subject: [PATCH 4.15 179/202] pinctrl: sx150x: Register pinctrl before adding the gpiochip
Date: Thu, 15 Feb 2018 16:17:59 +0100
Message-Id: <20180215151722.226424430@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
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

From: Peter Rosin <peda@axentia.se>

commit 1a1d39e1b8dd1d0f92a79da4fcc1ab0be3ae9bfc upstream.

Various gpiolib activity depend on the pinctrl to be up and kicking.
Therefore, register the pinctrl before adding a gpiochip.

Suggested-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pinctrl/pinctrl-sx150x.c |   35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

--- a/drivers/pinctrl/pinctrl-sx150x.c
+++ b/drivers/pinctrl/pinctrl-sx150x.c
@@ -1144,6 +1144,27 @@ static int sx150x_probe(struct i2c_clien
 	if (ret)
 		return ret;
 
+	/* Pinctrl_desc */
+	pctl->pinctrl_desc.name = "sx150x-pinctrl";
+	pctl->pinctrl_desc.pctlops = &sx150x_pinctrl_ops;
+	pctl->pinctrl_desc.confops = &sx150x_pinconf_ops;
+	pctl->pinctrl_desc.pins = pctl->data->pins;
+	pctl->pinctrl_desc.npins = pctl->data->npins;
+	pctl->pinctrl_desc.owner = THIS_MODULE;
+
+	ret = devm_pinctrl_register_and_init(dev, &pctl->pinctrl_desc,
+					     pctl, &pctl->pctldev);
+	if (ret) {
+		dev_err(dev, "Failed to register pinctrl device\n");
+		return ret;
+	}
+
+	ret = pinctrl_enable(pctl->pctldev);
+	if (ret) {
+		dev_err(dev, "Failed to enable pinctrl device\n");
+		return ret;
+	}
+
 	/* Register GPIO controller */
 	pctl->gpio.label = devm_kstrdup(dev, client->name, GFP_KERNEL);
 	pctl->gpio.base = -1;
@@ -1217,20 +1238,6 @@ static int sx150x_probe(struct i2c_clien
 					    client->irq);
 	}
 
-	/* Pinctrl_desc */
-	pctl->pinctrl_desc.name = "sx150x-pinctrl";
-	pctl->pinctrl_desc.pctlops = &sx150x_pinctrl_ops;
-	pctl->pinctrl_desc.confops = &sx150x_pinconf_ops;
-	pctl->pinctrl_desc.pins = pctl->data->pins;
-	pctl->pinctrl_desc.npins = pctl->data->npins;
-	pctl->pinctrl_desc.owner = THIS_MODULE;
-
-	pctl->pctldev = devm_pinctrl_register(dev, &pctl->pinctrl_desc, pctl);
-	if (IS_ERR(pctl->pctldev)) {
-		dev_err(dev, "Failed to register pinctrl device\n");
-		return PTR_ERR(pctl->pctldev);
-	}
-
 	return 0;
 }
 
