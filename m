Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3684173-1519413892-2-12028437448981853371
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
    t=1519413891; b=u90zaauM5e6L/KtbVZJjhQkM9ts8ebntD+8M4CctX25Wkir
    lnNECutG+SOvv1cr+emuxSNzRiTKMRn22o0cHdB49ZxMf+TRUlrBU6EPJkV+pUbO
    1gyeGSOSDedz2p+WPd4nabNmQrrBkTGVIQd8p0VgswNo7TK1DNCflTSd6OIM1o9M
    x8k9mlmsuW5FreFmC5u+cuE+D8PkU5a/FqYjaEZrX9xx43AfbJSKQL0Nlqx8L6Zt
    nq7PYfznuLkJCpIdXaLeQmL+6JYizVjyDuogmMpQGtd2YLpfRSuSIP3V/AYhzwRb
    7aqvmFztjLEjJylvZ1iTblq8gqpH4pjzrpp7L1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519413891; bh=E0MAxPShpHiDOMLNJTAYjC6Y5O
    o5sDXN42FoVBFmZoo=; b=sP2IAeuNWjmLFgtzcjnykxkazpXx0U8+uqfjth8Fqe
    cFQ7AgZRF3eDaNvdP0ej2i33JkA+GcDUwE2hQIxnd/F/w3EWV8DfHm2gxk5nSkfX
    oiu0Ko24nwpJ8HWtj/p8SzvHjFkSFlPoP/ylbyqu0yzfUex4Z02KGKwI/QDbP2+s
    bJr8p4QsAzqTy0gCTsXhAgwLw2QFuRVoqlBF2DHhxKSYZT7QCpTN4aIWCSFgP1F4
    clMCHe2bgI6KeUwJq/C3dONHuxceEGcvfllPuLgDapp81iJSMjz3t4ijgkNm0LIz
    eaiUvbXeQRXCmPm7jPW5zI6uOdTB6FFiZ+VYjCJ8v6TA==
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
        id S934921AbeBWSxE (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:53:04 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47186 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935294AbeBWSxC (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:53:02 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 085/159] pinctrl: sunxi: Fix A64 UART mux value
Date: Fri, 23 Feb 2018 19:26:33 +0100
Message-Id: <20180223170753.833007577@linuxfoundation.org>
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


[ Upstream commit 7c5c2c2d18d778e51fd8b899965097168306031c ]

To use pin PF4 as the RX signal of UART0, we have to write 0b011 into
the respective pin controller register.
Fix the wrong value we had in our table so far.

Fixes: 96851d391d02 ("drivers: pinctrl: add driver for Allwinner A64 SoC")
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/sunxi/pinctrl-sun50i-a64.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pinctrl/sunxi/pinctrl-sun50i-a64.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-a64.c
@@ -428,7 +428,7 @@ static const struct sunxi_desc_pin a64_p
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "mmc0"),		/* D3 */
-		  SUNXI_FUNCTION(0x4, "uart0")),	/* RX */
+		  SUNXI_FUNCTION(0x3, "uart0")),	/* RX */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 5),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
