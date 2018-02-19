Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3989416-1519035290-2-1174319422550589825
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519035290; b=rfdyhBcT3kX1fqmL2jEWFJR3EQ9FoLdqn0JirOGBvqAvVf3
    sBVo4CxOwJwwYfr+CfN1/Oom/Fo+BF0zUKDSvLnqfn8Ya1LHT76fvrTLweN5dJg7
    YZCb/s0OFzI2L1lsOMCwkfmR43qhEYa0MywDWUsKSxo6wRzXveGk0Dw/Ko1vrQ+B
    4cmhZ2FckLkRyjCpjvE2fQg0aMG9llul0xnOsCQwd/0XdrtGdi0iqA2TwZhJrbMf
    V8A0mmztjYDcRsL1AKOY0x1dF6uEK13ggaYEgP51DS5+C3J44c4fzakSSh6Z6cmq
    6caRqybjwGf4OAt9Zl7LZW21k9cxWxwLvRFo/mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519035290;
    bh=YypF0AsCEGINYErsUqxl6taiwphy9R62gNPfwBm3g2s=; b=U6QlWAnwoG8C
    mtDGrgPQwQdoG0zej4DPS4mlXvmEP9cgkzEl3opri3Bm8B9jBb9k+DNrPn0OG1Tq
    9HyO89cn6GJJVRt616p7gdyPJDYuar6NflNF2BfJw3r3iwpuVYjz03vuJM9XxXwZ
    ulXonaCflekItR1QI1WFTXEckl0dKgrmF0C8590OVEA99fQM9YD7iT/HDB5oPm/W
    4GCcML7Sq+aQsH4xfTiedXSfq3stuIejAR7hLiUq2EF6qw1JKBRe6AWSNszHJT1u
    //+8FsJajmxMSKsbJtxrYVXv+/lwlGr51mZ602ZZ86GcZF2f/y3OaOn7wjKGv//F
    +9kMgc/e/Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752474AbeBSKOr (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Feb 2018 05:14:47 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:51893 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752580AbeBSKOq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Feb 2018 05:14:46 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [4.9-stable 3/9] arm64: sunxi: always enable reset controller
Date: Mon, 19 Feb 2018 11:13:22 +0100
Message-Id: <20180219101343.2922561-4-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180219101343.2922561-1-arnd@arndb.de>
References: <20180219101343.2922561-1-arnd@arndb.de>
X-Provags-ID: V03:K0:tMCeZj4ZxRzuXKk+bs225PbrCm1K75mbKhfmWB6ArkiQeGAn+S9
 CJXPaDoBa7BcmNUrUy+eC9EHtDa/8tpoMoAgiJjPU/L3WUlLJwuUV+Yt9pbvrml3cnAKYwJ
 MMw/Fd4b4jZpeu+cNLtIWVlU+NlHzPpEr0qBsExUIj3lXa2RbEfqpbKdyi5+n/6Vxkd4/ns
 O5yvh609TJLk2PPd0O98w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2Tny1puwKZI=:Efxnl/p8rvwDrebzszd8/u
 Xh/n+Sia56i4+Gr2kzOr8bgMoFOwwsvZdEIChnaXR8gL/2KM9wHdGQTXGDUXlFvlBZWiFJk1c
 UuNGxyE7J4sdXGu3X6vTrc1u4bwPzVaUr6lIZpaBHXxEas5OqKYKPrBNmOiO7PunYu4qrC1EF
 KhB3zPbf1RHR9+3r3EpCu1PWtBx1YQlkCN2Kt9QxJ8neN0pes4S1+b7FXlO0+GMmq9gYzza6W
 5J5ddzufaRvTzeHFV0D8BJX+HWCXjWlIYOAuaKl3RN9m2qr/URWZPviB34UEPalcNIMyYvOdW
 L8UlBaw5gthWp5SPrfIYuXT0dnCcOocGBckc2kPCzvJxFH09Xv+SOXtVEtyPWaGkXY/V9n9U3
 ZafvkcYlNd4TYc7YVnX6YCXX3KAUIq3TMKO6uJl0FN9cIavqbufWjB8aukE4RpMLP9L8xxdMc
 UUZFRIZMF14yOTtCUwGE7m5766Y66qXDEeiviU9Tni9H/0Kif56bIzvYBzeoq3T7JqYlYCYYp
 Yh3oeMswB97NwluwGv84oe+yE/NTSszZt28Lajc9TX07F/oYMWw+g6Y+ChLrjxkUYbiBfvdAd
 aK77x7BO37nGaXlO3r8jXnpDn0nonSbfsRFoqbGrzRUt/4PRUIwdI7NXV8Z3ETJY6Hb9yBoT/
 /NqnKAz/7rS/Qr2AeGpKk+cJfdWODW486z5zRygQg7tpC5IYAoR6H1daz03EceGvbKyFf5KNX
 ogzlth8vonxfx1KHAcrY2gorvc1JCcuY4ofd1g==
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

commit 900a9020af7a023f9b64c919fddf8a7486108962 upstream.

The sunxi clk driver causes a link error when the reset controller
subsystem is disabled:

drivers/clk/built-in.o: In function `sun4i_ve_clk_setup':
:(.init.text+0xd040): undefined reference to `reset_controller_register'
drivers/clk/built-in.o: In function `sun4i_a10_display_init':
:(.init.text+0xe5e0): undefined reference to `reset_controller_register'
drivers/clk/built-in.o: In function `sunxi_usb_clk_setup':
:(.init.text+0x10074): undefined reference to `reset_controller_register'

We already force it to be enabled on arm32 and some other arm64 platforms,
but not on arm64/sunxi. This adds the respective Kconfig statements to
also select it here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
[arnd: manually rebased to 4.9]
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/Kconfig.platforms | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 101794f5ce10..08a4497f70a6 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -2,9 +2,11 @@ menu "Platform selection"
 
 config ARCH_SUNXI
 	bool "Allwinner sunxi 64-bit SoC Family"
+	select ARCH_HAS_RESET_CONTROLLER
 	select GENERIC_IRQ_CHIP
 	select PINCTRL
 	select PINCTRL_SUN50I_A64
+	select RESET_CONTROLLER
 	help
 	  This enables support for Allwinner sunxi based SoCs like the A64.
 
-- 
2.9.0
