Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3684173-1519413560-5-8467663066061119513
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
    t=1519413560; b=AscGGnEVhZeGDmSaGD980OmSvLymfOQHmor18eluhJqnHrU
    rTr9zbtn2MCU6xh9hbpVLI6FP6Nv21CaLd3Fz212QQwpqcWyFagzn6QIZYbWhZAX
    xcicK1c9ymDSQ6jh4V0+039PiCZ68kJ1H5fchxCY3d5hAAeo1FbY61dkFh7qprJT
    rol8khhdanotRKunmUbbTT/DMQejsNtLCMKsMEYTFTbWcno4gS+z16NaE2h7bsUp
    bjMx/UfKfTmAQ3bIItTx5ffNAsJ8fjj9xjF5q63oS+JrX8zsDxk781V+P0GsYrdW
    uKMycQRNuMwmEPxTuelKH5ZX17/Pbsf7PzePlpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519413560; bh=0wxrhoiy/I6/LAxI+rqOPEz3mK
    hNUvrqiCR8UUsGXOg=; b=Ud0PgjAGHZAUi/IBfMTkfarc7k/FMtb50yzS7cDTIX
    Kush0Vlifl32QE+Cc/Bdo4wod3xfFdJpQAekx6Ctt1KNn1IsBqeQJ3+OmDrbj42e
    XdP1yQale0BBiNy5woQkGKsB2KfG0XnGvC3r1Hr1jWx9OItJMShngbPgiILEakpu
    DAPGeCoWILbXRK/4tgWpJjRoIouNieiS9rwQ0j+7V1/RW5lGHlND7Bzdhckovm95
    vA6vsdg9RBMzd06vl9vLJNcAuzFAedx6855WBL8kzxjcCvvMWwLcPnltcMasT5Bi
    GXW0Cx12EDXLk3JoM04RpNzf3TMIzlMhzXDcewskZF6A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964964AbeBWSy1 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:54:27 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47782 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964920AbeBWSy0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:54:26 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 076/159] pinctrl: denverton: Fix UART2 RTS pin mode
Date: Fri, 23 Feb 2018 19:26:24 +0100
Message-Id: <20180223170752.809712275@linuxfoundation.org>
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

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


[ Upstream commit 4bd6683da2e64590bdc27ecf7e61ad8376861768 ]

UART2 RTS is mode 2 of the pin.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/intel/pinctrl-denverton.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pinctrl/intel/pinctrl-denverton.c
+++ b/drivers/pinctrl/intel/pinctrl-denverton.c
@@ -207,7 +207,7 @@ static const unsigned int dnv_uart0_pins
 static const unsigned int dnv_uart0_modes[] = { 2, 3, 1, 1 };
 static const unsigned int dnv_uart1_pins[] = { 94, 95, 96, 97 };
 static const unsigned int dnv_uart2_pins[] = { 60, 61, 62, 63 };
-static const unsigned int dnv_uart2_modes[] = { 1, 1, 2, 2 };
+static const unsigned int dnv_uart2_modes[] = { 1, 2, 2, 2 };
 static const unsigned int dnv_emmc_pins[] = {
 	142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152,
 };
