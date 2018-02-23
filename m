Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3723396-1519415097-2-1984877217812653142
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519415096; b=jvUKtAfrJ46JFNaFrbUSDadcZC8PwG5l2o4YZp07gUgkPW4
    275rH1sHtJN2yGvz+AlFEnlSFthPaSarrzh+1hyXfpHBYIhTAizMCFcBHkrQxafM
    K1+9PfXBEv2faqtHVChMaeUpS3F3ym2/YYiQn3rzS/kFL1X8YPYjhCvY1/CqiE5u
    YMriJem8xzTfJO7irpyVxjJNwaUctj3qJwW/StYIeNzk/69EIE+cmZCR/bl+Y64T
    OMFmJTMH+6/+4fFuga/AWJhdgVFvdQN5FtORuaqaZ0cy+ZBr+0dOEVrLmbUhrvJy
    reCeNNCLVndTwwaSpALtUjeq4tjpownVBROSVvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415096; bh=/eeddx5EBfb9N3sAeafP9o0me7
    +JU2LyxLyzSP3MSV4=; b=Eidisj+jYFqN/cGSXFZN3Q1uivDBiLoCho94aY2EEF
    9/amEHkcNxr+ZysIfmFDOGR24a7NQ/FEDS1rDSNndd+miz58ulyuN/8HO+y45XBO
    qIeU7x1WtDCWhHh1tJKqa5q3D6+b0AlMUu5cjrUhZa1ZcBQB1Mt8AryeQb9WfCwS
    6F90Lb8Wgtj01UFydLKMMds01TgKHIJvStZR6zjPNFWhsnZFRIKfzcUFEOl3kNiT
    /VrQZ1oyf5SzNvmgrEOfZXmtyd8wsvvSBIocl6sgUce68GBR3usN80MhQH24l2mg
    DmMABWOveRbqw/0q4DoAxyJ6LOtnziEb8p9G6OBAqIyQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934352AbeBWSsT (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:48:19 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44844 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934335AbeBWSsO (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:48:14 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tobias Regnery <tobias.regnery@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 4.9 132/145] clk: meson: gxbb: fix build error without RESET_CONTROLLER
Date: Fri, 23 Feb 2018 19:27:18 +0100
Message-Id: <20180223170741.839015929@linuxfoundation.org>
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

commit dbed87a9d3a857a86f602775b5845f5f6d9652b5 upstream.

With CONFIG_RESET_CONTROLLER=n we see the following link error in the
meson gxbb clk driver:

drivers/built-in.o: In function 'gxbb_aoclkc_probe':
drivers/clk/meson/gxbb-aoclk.c:161: undefined reference to 'devm_reset_controller_register'

Fix this by selecting the reset controller subsystem.

Fixes: f8c11f79912d ("clk: meson: Add GXBB AO Clock and Reset controller driver")
Signed-off-by: Tobias Regnery <tobias.regnery@gmail.com>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
[narmstrong: Added fixes-by tag]
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/meson/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -14,6 +14,7 @@ config COMMON_CLK_MESON8B
 config COMMON_CLK_GXBB
 	bool
 	depends on COMMON_CLK_AMLOGIC
+	select RESET_CONTROLLER
 	help
 	  Support for the clock controller on AmLogic S905 devices, aka gxbb.
 	  Say Y if you want peripherals and CPU frequency scaling to work.
