Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1841884-1518709617-2-18041737936879848260
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
    t=1518709616; b=guX7apOsBf644T/L/eR130FY5f2HNntcOp84g4oAwtS7gh0
    7BP/OOUwt9b4eUf/k/nEPNt73OAudeETYdHSrbbvrvV+puGMW69TOttuJRQpKYHo
    8UOClUROzmPP3E6+tgRxDLZ+7DQGJXeIU8zh5qyD35nsy6OstHbk2AnH66oZPm5d
    UEydeACgmrSHomPZV0YyiuByW7j5nRc3ua9pirYXQt1qjfEe0OSvoqILWpmdzm+j
    aZ9M+Oah9CfNvJcV1qlDrKhGBreBbLScMmsKisjXY5UTkNMuPO/u2eERvfCSj5AW
    sKsKhXhAZon7SBiZS1ZtfX0Pg3uh9XFYagJJN7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518709616; bh=3q0/9ThgcQmtX2lv2Ue1NyzcD1
    AbznGC3Sk4XznoDr0=; b=DN4KZJGsTz0HebmVcBAmVjLq+2a7cyuhJoqHcYUFpK
    ng8Od39ubJjzEqvf5TZ8To9glXKfNIzMLw7I3BDMaWLzmUr9o+hzkP95BSx0oASf
    VXV+DQxl2TEJt7Tlw+Bqejz+mwJobbZOaXwQTJ7H8+tBCMWW5ByclVvZa6VmTWHG
    PmK29AQ7BhMkC5yGHDrUgfojIoJCqlJf5jt848dH3x4laWKMa1iasB8u5m8u3YCA
    3NB3o5yBfbqv2Eq+vjYnxXuszOrQosvFy2PoFvcktvegF97ckyxOED0FI/56l2JE
    oEKvOtDEtyAYXsV1ioTUH2MxIbRkVMwCQPUrKAlrTQqw==
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
        id S1424752AbeBOPqw (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:46:52 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35960 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424685AbeBOPqv (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:46:51 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Peter Rosin <peda@axentia.se>
Subject: [PATCH 4.15 180/202] pinctrl: sx150x: Add a static gpio/pinctrl pin range mapping
Date: Thu, 15 Feb 2018 16:18:00 +0100
Message-Id: <20180215151722.282779075@linuxfoundation.org>
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

commit b930151e5b55a0e62a3aad06876de891ac980471 upstream.

Without such a range, gpiolib fails with -EPROBE_DEFER, pending the
addition of the range. So, without a range, gpiolib will keep
deferring indefinitely.

Fixes: 9e80f9064e73 ("pinctrl: Add SX150X GPIO Extender Pinctrl Driver")
Fixes: e10f72bf4b3e ("gpio: gpiolib: Generalise state persistence beyond sleep")
Suggested-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pinctrl/pinctrl-sx150x.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/pinctrl/pinctrl-sx150x.c
+++ b/drivers/pinctrl/pinctrl-sx150x.c
@@ -1193,6 +1193,11 @@ static int sx150x_probe(struct i2c_clien
 	if (ret)
 		return ret;
 
+	ret = gpiochip_add_pin_range(&pctl->gpio, dev_name(dev),
+				     0, 0, pctl->data->npins);
+	if (ret)
+		return ret;
+
 	/* Add Interrupt support if an irq is specified */
 	if (client->irq > 0) {
 		pctl->irq_chip.name = devm_kstrdup(dev, client->name,
