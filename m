Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1538793-1527776214-2-135379902436563491
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527776214; b=J9yqF8pycn3+DtUQcPajURo6yh/7w2VO/fKq6HuXpXKWCO03KZ
    53lFXx2uFxHT2dzVCAhXo62b13r6+T5R3PssHhqklWyHNi6LIGyIJTSWPiek0F7d
    lHZUn6xnQqrKPLef4JUiPKOJyVfs3sNGo0SRTJm2tEbjSqwoIbLu/eURooFh2y2G
    74ARXKkQWdLMYapEHrpaSH4iNsFPCxUrJkyswI7tXM+hEMKqe9CYFEW33PGKBi4F
    A8k3p0poS2SWkB6V0/iGJWWWW06F6hSMo/iNNk7LHpkDG/wgQXeaAwiQ3QyZ1aaX
    MAbT0EJvItm/yJoBhE1X8f7RxKRpJpOptqbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527776214; bh=kFjeQM24ZmgNXBmSmTfziRIhEl2mFg
    iFJnlWGT+Sz38=; b=XkkR3xgIjB7q+N0gIinBG+MYA1sCA1d2lbt/XPGwNjNYvc
    oaQ4UWR2WolIZwlTNGNVj8VicWqHH0DWCCGJtdYIKYblbf7f+n2UbBRGpK84HBIR
    SPgfAbeWz3a8Jiz3B2JPvh67EbZR4N/I31H9va1ORiU3pm5t7FtPtkPfklp5/EGh
    yV21MPNxaaLFFup/YhcHUOXOH5EJZezqBnuAmpR9fjm0XpUSFTVsBcEikEZEl7Sf
    g07hQC9Lg7iKcUEMxfk68ccsWXoOyEJmUIL7G7qjOXFzkcDu5Lchb5rGkeLGXi/f
    hHQO16vmpzQXRPIXMJErcE1ah9HY1VwTcm8Zj8uQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=atomide.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=atomide.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKhXEBl0473gKKeoLxlXwrzPyhZxBpf9EXJRNnkHGulaQXkdB+wGkH0IYZ/nPhqtMWuTYF01gdrJZ5g4Ha7RnCaURZz/LBirsQ1jYT6q2mkCDYNfuNkE
    FpfxR0QYpO7R62nY7ry1U/A5/f8LKq1bPoTxSe2FeQuUcaFYHI6d4pWRjpx0UWZK2/+Zckov0ictMW3s5mayprKbF56ULKyv2nPsRoNW2ZVnmyFOVvrF2Old
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=tBb2bbeoAAAA:8 a=fGHavi-Pyp-EdYj7GfYA:9 a=CjuIK1q_8ugA:10
    a=Oj-tNtZlA1e06AYgeCfH:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755283AbeEaOQv (ORCPT <rfc822;linux@kroah.com>);
        Thu, 31 May 2018 10:16:51 -0400
Received: from muru.com ([72.249.23.125]:45468 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755274AbeEaOQv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 31 May 2018 10:16:51 -0400
Date: Thu, 31 May 2018 07:16:45 -0700
From: Tony Lindgren <tony@atomide.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rich Felker <dalias@libc.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Frank Rowand <frowand.list@gmail.com>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES"
        <linux-arch@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jiri Slaby <jslaby@suse.com>,
        devicetree <devicetree@vger.kernel.org>,
        David Lechner <david@lechnology.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Johan Hovold <johan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 00/12] introduce support for early platform drivers
Message-ID: <20180531141645.GM5705@atomide.com>
References: <20180511162028.20616-1-brgl@bgdev.pl>
 <CAL_JsqL3CWFSpKEGoGwQDxCQ04g4uT1hiDTxXzjz4XTjPbfsoQ@mail.gmail.com>
 <CAMRc=McDNYQ5uk8EyRkDf8eh9q7tyF=t7PcUd6DBLqXcseJ3AQ@mail.gmail.com>
 <CAL_JsqJ=DdkDR3LtnTMHPUpwaUbjPEBgkaCV8ja+p-mTvWZuYA@mail.gmail.com>
 <20180530194032.982.41562@harbor.lan>
 <CAL_Jsq+7=NGj57k=E5GAuDmW7Uu_YkHJXf8jSyc_ad3r1op4yA@mail.gmail.com>
 <CAMuHMdUY+-_72DHg9Tim2d4E24k5KskQxm52bHSyrSYLbZDr2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUY+-_72DHg9Tim2d4E24k5KskQxm52bHSyrSYLbZDr2g@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

* Geert Uytterhoeven <geert@linux-m68k.org> [180531 06:45]:
> Yes, they should all be drivers.
> 
> Assuming clocksources, clockevents, or primary interrupt controllers are
> special, and thus forcing everyone to use OF_DECLARE for the whole
> subsystem, doesn't fly everywhere.
> 
> Clockevents and interrupt controllers can have a module clock.
> All three can be part of a PM Domain, which requires a struct device to
> be handled properly.

I agree it sure would be nice to have all these as drivers. I believe
SoC specific clockevent using SoC specific clocks is the reason why some
clocks cannot currently be drivers.

Regards,

Tony
