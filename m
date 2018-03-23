Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153886-1521805549-2-16061184578119661572
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
    t=1521805548; b=MCEuFghrzihFF+QuWJ9H1jqRBuqVX93OfZr4yWfOTDO/GIM
    ofiSQEuUpc5ipmFJii2qF78A3lBGu1nLFHdHCAd+lFCjS33WbaKYINKnz9tHx0UH
    0q2sIw2LcrN6DGhJduKH/MHyljFcYzQ8mLVd7TGffhCj84byjTgOkxrdJ0mZiktv
    TSUqqoX1cQuo0UHyE/87ewDokKkw537WqmPgd98vh/NGzCe0Y3qj6wrAAqrhzlHP
    U1/HsEC3cXxh1G8LI4EWzl8wsqPL4LaOqK0vBu2CRT+JQ1Q3/hfmM+0jHj8EDt3m
    mGhLvvtyMQeD1WAK5JMUB6H42iTGAv6ddsYlURg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521805548; bh=2pjz0KYs7UWGjuF+u2o8p3hBq4
    g8HXbMZF4QqxtF3mY=; b=ENiUTc9xZS+c1aO93KKwr/2wG7hgT4ZGf/FXZxHJex
    xi2FUdzke2J5N/MPlGA+ojfG7l57Xu53jYzB1XdY8gQtI5Z0LFiEZqY2yvjwg9zH
    nmdkmh5hICMmJYAExcVeGEhPFh0FeeJItcn04NMuF87f2bXYH3LMp5JUfauIWAsq
    K5MVW0vcdKIa4YNPyx41Thf1mirOCcOBsZlrT1sajbqFNfLdmleCLNWJ5UvBI/FG
    lBCIrY9jQiXHevH1uwWaQbQkFw8lNnBOv/LoDtpUO/3PMFqRvC0i0thFvN50RjKb
    HZRP2FoPDA09vKfEq2axxCoLBC9UjZCsu38IvKJU3BdA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
        id S1754449AbeCWLpe (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 07:45:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38620 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754365AbeCWKDE (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:03:04 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 50/77] pinctrl: rockchip: enable clock when reading pin direction register
Date: Fri, 23 Mar 2018 10:54:24 +0100
Message-Id: <20180323094145.600454435@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094142.260022880@linuxfoundation.org>
References: <20180323094142.260022880@linuxfoundation.org>
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

From: Brian Norris <briannorris@chromium.org>


[ Upstream commit 5c9d8c4f6b8168738a26bcf288516cc3a0886810 ]

We generally leave the GPIO clock disabled, unless an interrupt is
requested or we're accessing IO registers. We forgot to do this for the
->get_direction() callback, which means we can sometimes [1] get
incorrect results [2] from, e.g., /sys/kernel/debug/gpio.

Enable the clock, so we get the right results!

[1] Sometimes, because many systems have 1 or mor interrupt requested on
each GPIO bank, so they always leave their clock on.

[2] Incorrect, meaning the register returns 0, and so we interpret that
as "input".

Signed-off-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/pinctrl-rockchip.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -1989,8 +1989,16 @@ static int rockchip_gpio_get_direction(s
 {
 	struct rockchip_pin_bank *bank = gpiochip_get_data(chip);
 	u32 data;
+	int ret;
 
+	ret = clk_enable(bank->clk);
+	if (ret < 0) {
+		dev_err(bank->drvdata->dev,
+			"failed to enable clock for bank %s\n", bank->name);
+		return ret;
+	}
 	data = readl_relaxed(bank->reg_base + GPIO_SWPORT_DDR);
+	clk_disable(bank->clk);
 
 	return !(data & BIT(offset));
 }
