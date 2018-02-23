Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3704313-1519413903-2-11867157531127815221
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
    t=1519413903; b=xEwhZR0Fbt8pBz9a6FNbzLfFOmNuQ1KSLSp5vyFdx+xk9wQ
    wXXp7RG1K9aFqvUffbx+RuQlg/pm9VC5uM2gO0JT0HNX81dOMe1ADsv0W+lslkRJ
    1dah2Nf9TsSX5gldM/DfmZBHw1N/+HDU4CqnekXubdx89Ll+5CycbGtLoe512ZfO
    3G52Q9sU5lIo0/k/DeqeDxPGtCG7u60uJEmqqH1lXhI4XPltWEDQR0J18sotepz3
    Y/k7Y7fDRYMPomY9r+ZpkT1vxa5tmDkHnc2CEN/7vz9zH4XplAMQ/t1X3xiX7B18
    hmOFuk4FKI80LzT/8vpr38WHXiPMAsc3BVCQojw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519413903; bh=Ii5kSDBqt3LIYccraSRUXOm1OO
    Jnr4krjl6ORd/zAsU=; b=WJzf6cDu41wqjBJPbSm0iKy50isHQWKmNuOW5nhagM
    7tMBbkzKezfpYg69vMBmR6SNPwVmVbyvvpbUm/zm5ZuldySvMVBlzJ8xgvXTf1vs
    q2Y6s60PKbvQB48NbfsSpiS+a8nBegq8aTdcFs048hDXHkgQtZg0i5J7LqBCwLPF
    wg4b6W/V4RK7VMXmCTaCxTgB4LcZp41z7rvYM91hhjX/shN6xdu9mP93MssJcKtQ
    qGXsRWi21wD9jAj2vORaS+lYtX/tj7ZaP6xCTZtuxMbsjEFoq0xNEZ8NC+qGUr5v
    7J1hOKgwUbQZdBjSKaBKBXVY6h3QXmDSHl9VDVCpBMfg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935280AbeBWSxB (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:53:01 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47172 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934921AbeBWSxA (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:53:00 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 084/159] pinctrl: sunxi: Fix A80 interrupt pin bank
Date: Fri, 23 Feb 2018 19:26:32 +0100
Message-Id: <20180223170753.737248779@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andre Przywara <andre.przywara@arm.com>


[ Upstream commit 6ad4cc8d1ac483e0fd33f605fb2788b0ecf51ed4 ]

On the A80 the pins on port B can trigger interrupts, and those are
assigned to the second interrupt bank.
Having two pins assigned to the same interrupt bank/pin combination does
not look healthy (instead more like a copy&paste bug from pins PA14-PA16),
so fix the interrupt bank for pins PB14-PB16, which is actually 1.

I don't have any A80 board, so could not test this.

Fixes: d5e9fb31baa2 ("pinctrl: sunxi: Add A80 pinctrl muxing options")
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c
@@ -145,19 +145,19 @@ static const struct sunxi_desc_pin sun9i
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x3, "mcsi"),		/* MCLK */
-		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 14)),	/* PB_EINT14 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 14)),	/* PB_EINT14 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 15),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x3, "mcsi"),		/* SCK */
 		  SUNXI_FUNCTION(0x4, "i2c4"),		/* SCK */
-		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 15)),	/* PB_EINT15 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 15)),	/* PB_EINT15 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 16),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x3, "mcsi"),		/* SDA */
 		  SUNXI_FUNCTION(0x4, "i2c4"),		/* SDA */
-		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 16)),	/* PB_EINT16 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 16)),	/* PB_EINT16 */
 
 	/* Hole */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 0),
