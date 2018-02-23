Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3723396-1519415061-2-12169819454573034679
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
    t=1519415060; b=F9rvYTaOZUCJDAK0YYEkwiDDmuWg8aDqqfn40WWCcJvDTEZ
    KrA9r+o51Nr+9hTkB1UxK9OElmCjhhZ2/0QrkrSNEZwlB3mUItkYd/6ae8ZXaCtz
    CuaAFjneNbd6+dCV0bl9pNpdWy9kiGEU2Eh/R3TglBPIGuGdt2QW/7SbsZN9hwTg
    j0zre/KDQAvT56PgLfsYMm+biJvd2oun6i0BubLqqdMtNYiPB+pMNNpk8RvjTREd
    dYOqG3dhqYNK+nYhH4qsQNeL3jJ+R5FpEdJpteLNdwkghfEF582X6/eCbb3/MQr8
    DbvAyFxM5oYhOhsEuZZ5tNhiUBBBJJFotECVZAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415060; bh=2sxCQNa+0YSwquUZo/y3Q2bTuu
    hZJFrITfGgt8AaAIs=; b=wzfYTS2HWdP05b2lCDiGKqcO44Wwyy6pnvWZMfJkZi
    6G92Y/aoK9RuA7gLE9GE9CxP440R6oXwMa4SWfDXvpJH0F6UAqJM3Nlt9HTcWXil
    tOgs5cNWVm/hHOH5+y6hCOMivt6cZsF0buJ4wY0DtIqNdJO5NpYllk84JZu4BZxe
    M6NSbGtkoH2zpnscJwf2UvEnf3U25ICgEGvXZA/ou3s42iZKKWasuvfnnX8epVrN
    CTVd8LnjQN5aApDoi23RfN2D8dyUAJn2UcDeiJV3Vc74RxP87G+lY2C+2i3RsEes
    ImdjUFPjr73NTiJqMrolQ97OmQTrFqjF+MTwEx2uXAZg==
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
        id S934378AbeBWSsX (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:48:23 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44914 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934335AbeBWSsX (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:48:23 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 4.9 135/145] arm64: sunxi: always enable reset controller
Date: Fri, 23 Feb 2018 19:27:21 +0100
Message-Id: <20180223170742.193676184@linuxfoundation.org>
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/Kconfig.platforms |    2 ++
 1 file changed, 2 insertions(+)

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
 
