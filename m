Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-681467-1526297960-2-4454200337860667203
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526297960; b=nJzC+U3bPl7ll/eBrZVZEAxP8uenhdeKdNljEu6CkzsNLVMjs6
    gzC+4ROnD210qCm74SObHDuejCbtI46HEw/ygtCExo24uEQnlY0r14haI/Wba9ln
    jWu8AIkiP+/0UKmA03KyPxGdWLqGhuUOxmnIAmkV8e5FHLvg07/gLHORueuki/ay
    np2/RNpVk2RHM7DV+rA2PinOBmZDzUHGADFyU6ASQYgq/SV9gO/jcahB5PruOv2t
    gt+Kh3gGHcG993XNJzj1gwobCbNVmd/ScBaLmHUZGxFWSM5h8hHUQ3PahE9Vv0NQ
    iceRUI3X3qmfPedUDdjL5EbI7wOTpkfzKYdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526297960; bh=QiXSTDpT1ySf7IrP74C0+BEl5F+LIT
    PDQQXKVWG395U=; b=HlRLOtzrt8tNFU75++3uVQY0FbxpAS17uApG0Rmb/Jnk6y
    /RKKsSaAtKtCub0V+t07c8+v8K7aM0W0VMRhel6gN7RxNOhOfZXKpZzY6KbFN34S
    3YciQzNxHd7CnXBzfbMzCdsjO9qLvc4YXGv77zX2ANtiFu6hKULh0sz6StzkPa7A
    wQ+vJ/cPJBjPXqcmmYkZW1E1DVXVZ/I1jXJBMMBlZ41K66T+m8orf74LEl87KFuw
    hZzjYBkDT4ef1mcR+CM8w6ufZaBL1UFfZK3bTxsDrTcAo0KmGeMsDFCLyoFOxkGY
    zElwa+ClWBcnc/CqYGXMp2Q1oixFxgNdIBHkDsPw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=dUch3yCO x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=dUch3yCO x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAiSO26WZiaYXp7B++xV9eSyVSstw7oYZxqAkVT3JCr7Fj0w+zfd93GjJFv9vUeUD9JANNT5b/wRRdgoKGX3+kIWjCcm5GMeJfx2vXozTd/rdnX+xkUF
    rBL3164Hs3t5gHokOytKdqkx1HfC8Ssmsy33AYosTn35wi3bpsmHzAEMX5sIWc76bvxIyhgkdvR3HH+0M4R6wDC3PvGu1Iqtg2mvijbodQQso3TGRi4mecu+
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=IpJZQVW2AAAA:8 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=cldpNQUxMpDYN8E9lNUA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=IawgGOuG5U0WyFbmm1f5:22
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752148AbeENLjR (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 07:39:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:39156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751402AbeENLjQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 May 2018 07:39:16 -0400
Date: Mon, 14 May 2018 13:38:59 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Rosin <peda@axentia.se>, Jiri Slaby <jslaby@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-sh@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v3 2/3] platform: move the early platform device support
 to arch/sh
Message-ID: <20180514113859.GA6358@kroah.com>
References: <20180504132731.14574-1-brgl@bgdev.pl>
 <20180504132731.14574-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504132731.14574-3-brgl@bgdev.pl>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 04, 2018 at 03:27:30PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> SuperH is the only user of the current implementation of early platform
> device support. We want to introduce a more robust approach to early
> probing. As the first step - move all the current early platform code
> to arch/sh.
> 
> In order not to export internal drivers/base functions to arch code for
> this temporary solution - copy the two needed routines for driver
> matching from drivers/base/platform.c to arch/sh/drivers/platform_early.c.
> 
> Also: call early_platform_cleanup() from subsys_initcall() so that it's
> called after all early devices are probed.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
