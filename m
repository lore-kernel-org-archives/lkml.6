Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3759000-1519415408-2-6845603044448457402
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
    t=1519415407; b=b5hKzQi7V4keJVcVICZf7mWJVZgdkkoJiWFo+q/fIktb0j/
    HwUIFgE5EPz+bmEuKlfDaAWLYKyQ8Vntv7SFcoLlQ/kyhPu96z8c0au5j0+65+ux
    VSvHsUBC+n17DonvwuTxmN4XCfiYDAsWlNJOsYw28xhjvjkdxZE6lLwnyC3TV192
    fxyemQV2xuPsEVeIgeWxVK8vsp6NTd//BMadxuFhHDu4buVqcMqrs2Zf6f1D3Dma
    vPwpyQLAXyeekjfOtPG0bLNgPZRI6iDTbiJ/P4CFs5jwTtHrzH1hftYdCE+L1dWd
    y19JR+saC9mRKchECg5zMMAqFrJizqesJfzyR/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415407; bh=t8Johfu/NoAAIi/OqYhT/PED50
    BgRyO9EzXlkPul+98=; b=P8yJvzL819/Wt1oj0XIPv9kjFe9XksYuhM2bcdy0js
    Vs5la771mApWkD+4QWAqrCdUFsHnENTFawBXuLMJKHEXbgVN08EpGDuZJPd1H+Ws
    Yyd8P6SEG1RPNLkUpVLbByKLO3FgaicJ5E+Svr56lVEvSund5erDsKIx6kNa/7Ap
    2RVCjVg8jUIMUaa0p/OfNu8zoGnOF22WbJoKHFBEzKUTzq9xhbATgnTyQkMl1pe6
    /AHWfnYS0gtNMNbbNVd4cC2efH5QMsN4DuZWNzi1j7ank8bn3hAU5M00wBAn5bCz
    uvHYXHrJbCsdYTUV2rl1IWkhgIafn5mNyFm95ufHlXgA==
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
        id S933503AbeBWTtt (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 14:49:49 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:43700 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933975AbeBWSqW (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:46:22 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tobias Regnery <tobias.regnery@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 4.9 093/145] clk: sunxi-ng: fix build error without CONFIG_RESET_CONTROLLER
Date: Fri, 23 Feb 2018 19:26:39 +0100
Message-Id: <20180223170736.828352470@linuxfoundation.org>
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

From: Tobias Regnery <tobias.regnery@gmail.com>

commit aa01338c018469274848a973bcbd287ef341937c upstream.

With CONFIG_RESET_CONTROLLER=n we get the following link error in the
sunxi-ng clk driver:

drivers/built-in.o: In function `sunxi_ccu_probe':
mux-core.c:(.text+0x12fe68): undefined reference to 'reset_controller_register'
mux-core.c:(.text+0x12fe68): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol 'reset_controller_register'

Fix this by adding the appropriate select statement.

Signed-off-by: Tobias Regnery <tobias.regnery@gmail.com>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/sunxi-ng/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/clk/sunxi-ng/Kconfig
+++ b/drivers/clk/sunxi-ng/Kconfig
@@ -1,6 +1,7 @@
 config SUNXI_CCU
 	bool "Clock support for Allwinner SoCs"
 	depends on ARCH_SUNXI || COMPILE_TEST
+	select RESET_CONTROLLER
 	default ARCH_SUNXI
 
 if SUNXI_CCU
