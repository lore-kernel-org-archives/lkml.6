Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153886-1521806938-2-18157294778051482361
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521806938; b=ShgjWeCb2svBcUIb4yc6jz4DTCCrGUUimmNlFlvmMmShoqz
    GAYHmHAwYUECA/AAgJMzhAA3c5su6LN5F/mdOEMRqbD2cckPBmRoJ4kkkKGmsK4r
    i5vg39lvQocDTkGFdHGd2o7Fo9OdQ00AZCfsqJaTE7uk0gV60eHEdQgCvIsdn3en
    1Zfo9qPy3XJFgTnW4FXdv8VeCl4Jgl4qVkDFCTWL7Eo4y461I1Tx64gPByjpl0Hj
    D3jhjz0bgfNDMbLMRJOPz6oQ49EaOEziiamTlGfjnLA6XCWHBEzLVtZ+p25NfUHg
    ml1P6MTvyqfF3agAvrVP+koj97/8OV+SMnFJ1Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521806938; bh=reqJ0xM02M2lcVogkjF8xdx2Qo
    SW6GynVza/9QWI/lY=; b=ZXeKYavludplqGyt8lSRhY3GqB1fc1E7j6CMHJBA+O
    R2M5XdC3vtRs39tjBQrK/Ff2bwdccIZhlkdz3k571XcFRQwdhkjKTu+/bzzjvKSe
    221A4AAJCvEkokvdGofioXo9t850O13Uqmg30OSGoxedL5DMUlqVzxZLYwXM4z83
    dv69gQ/auFl554/NzLMorOZPyjbRralXA4ORbwIASZw9mn2+Pj0yKaI2W1SIcujs
    jFPHtueqh+OQHNFNSvA0z+bHGActrhL3tF2ZI7D0QKbe/0sX6hoEow+iIRjP3k2o
    woufkBf4/p9v9Hm9JFem3z/DNPTraZwZTYk1qSMgJDEA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753130AbeCWJ6c (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 05:58:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35706 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753113AbeCWJ61 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:58:27 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 58/84] pinctrl: Really force states during suspend/resume
Date: Fri, 23 Mar 2018 10:54:12 +0100
Message-Id: <20180323095420.776620158@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323095411.913234798@linuxfoundation.org>
References: <20180323095411.913234798@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Fainelli <f.fainelli@gmail.com>


[ Upstream commit 981ed1bfbc6c4660b2ddaa8392893e20a6255048 ]

In case a platform only defaults a "default" set of pins, but not a
"sleep" set of pins, and this particular platform suspends and resumes
in a way that the pin states are not preserved by the hardware, when we
resume, we would call pinctrl_single_resume() -> pinctrl_force_default()
-> pinctrl_select_state() and the first thing we do is check that the
pins state is the same as before, and do nothing.

In order to fix this, decouple the actual state change from
pinctrl_select_state() and move it pinctrl_commit_state(), while keeping
the p->state == state check in pinctrl_select_state() not to change the
caller assumptions. pinctrl_force_sleep() and pinctrl_force_default()
are updated to bypass the state check by calling pinctrl_commit_state().

[Linus Walleij]
The forced pin control states are currently only used in some pin
controller drivers that grab their own reference to their own pins.
This is equal to the pin control hogs: pins taken by pin control
devices since there are no corresponding device in the Linux device
hierarchy, such as memory controller lines or unused GPIO lines,
or GPIO lines that are used orthogonally from the GPIO subsystem
but pincontrol-wise managed as hogs (non-strict mode, allowing
simultaneous use by GPIO and pin control). For this case forcing
the state from the drivers' suspend()/resume() callbacks makes
sense and should semantically match the name of the function.

Fixes: 6e5e959dde0d ("pinctrl: API changes to support multiple states per device")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/core.c |   24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -1189,19 +1189,16 @@ struct pinctrl_state *pinctrl_lookup_sta
 EXPORT_SYMBOL_GPL(pinctrl_lookup_state);
 
 /**
- * pinctrl_select_state() - select/activate/program a pinctrl state to HW
+ * pinctrl_commit_state() - select/activate/program a pinctrl state to HW
  * @p: the pinctrl handle for the device that requests configuration
  * @state: the state handle to select/activate/program
  */
-int pinctrl_select_state(struct pinctrl *p, struct pinctrl_state *state)
+static int pinctrl_commit_state(struct pinctrl *p, struct pinctrl_state *state)
 {
 	struct pinctrl_setting *setting, *setting2;
 	struct pinctrl_state *old_state = p->state;
 	int ret;
 
-	if (p->state == state)
-		return 0;
-
 	if (p->state) {
 		/*
 		 * For each pinmux setting in the old state, forget SW's record
@@ -1265,6 +1262,19 @@ unapply_new_state:
 
 	return ret;
 }
+
+/**
+ * pinctrl_select_state() - select/activate/program a pinctrl state to HW
+ * @p: the pinctrl handle for the device that requests configuration
+ * @state: the state handle to select/activate/program
+ */
+int pinctrl_select_state(struct pinctrl *p, struct pinctrl_state *state)
+{
+	if (p->state == state)
+		return 0;
+
+	return pinctrl_commit_state(p, state);
+}
 EXPORT_SYMBOL_GPL(pinctrl_select_state);
 
 static void devm_pinctrl_release(struct device *dev, void *res)
@@ -1430,7 +1440,7 @@ void pinctrl_unregister_map(const struct
 int pinctrl_force_sleep(struct pinctrl_dev *pctldev)
 {
 	if (!IS_ERR(pctldev->p) && !IS_ERR(pctldev->hog_sleep))
-		return pinctrl_select_state(pctldev->p, pctldev->hog_sleep);
+		return pinctrl_commit_state(pctldev->p, pctldev->hog_sleep);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pinctrl_force_sleep);
@@ -1442,7 +1452,7 @@ EXPORT_SYMBOL_GPL(pinctrl_force_sleep);
 int pinctrl_force_default(struct pinctrl_dev *pctldev)
 {
 	if (!IS_ERR(pctldev->p) && !IS_ERR(pctldev->hog_default))
-		return pinctrl_select_state(pctldev->p, pctldev->hog_default);
+		return pinctrl_commit_state(pctldev->p, pctldev->hog_default);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pinctrl_force_default);
