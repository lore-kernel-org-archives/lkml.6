Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752240AbeBHQxX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 11:53:23 -0500
Received: from mail-ua0-f195.google.com ([209.85.217.195]:41012 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752208AbeBHQxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 11:53:22 -0500
X-Google-Smtp-Source: AH8x226sYFkhTW4/XU1wSi010AlsPqIDYl5XSIhhqhlTLRg0seGRlGqP3kzi0kMoi4iNn3ktoB9mjt2OfB8+/qXCO4g=
MIME-Version: 1.0
In-Reply-To: <1518106267799.61329@mentor.com>
References: <20171212162612.GB10595@n2100.armlinux.org.uk> <1513098352501.51185@mentor.com>
 <20171212172034.GC10595@n2100.armlinux.org.uk> <CAOuPNLiTf040ZOyEroq4oy=5Bz1LScmE-vpR3xdjXBGuCKcxMA@mail.gmail.com>
 <20171213111718.GJ10595@n2100.armlinux.org.uk> <CAOuPNLgM8OxP8cV9goAUDtXgxjhcfoe27M0Q=Ty1BVAPD5aipQ@mail.gmail.com>
 <20171213171530.GM10595@n2100.armlinux.org.uk> <1513186632784.96495@mentor.com>
 <20171213173956.GN10595@n2100.armlinux.org.uk> <CAOuPNLgZL0N0OuTUEVR6vFjykBtLeR+t0pvn3FSKsA4UqG-UGQ@mail.gmail.com>
 <20171214102148.GO10595@n2100.armlinux.org.uk> <CAOuPNLgj8c0a1gDESQDatoa4GU_PYu8TK1NJ0KKkVfjW7zvsdA@mail.gmail.com>
 <1518106267799.61329@mentor.com>
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Thu, 8 Feb 2018 22:23:20 +0530
Message-ID: <CAOuPNLj8k0AdsOUJSgdZFNKPM0Q5bbjkSxrOCcCo+tniiXOCCw@mail.gmail.com>
Subject: Re: [VDSO]: vdso_test failing on arm 32 bit
To: "Lynch, Nathan" <Nathan_Lynch@mentor.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
        "david.brown@linaro.org" <david.brown@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 8, 2018 at 9:41 PM, Lynch, Nathan <Nathan_Lynch@mentor.com> wrote:
>> I commented the device tree reading property:
>> arm,cpu-registers-not-fw-configured , from the arch/arm/kernel/vdso.c
>
> Don't do that, please. The presence of that property indicates that the counter is not suitable for use by the OS. There is nothing we can do in Linux to make the VDSO useful on this system; that is why it gets disabled at runtime.
>
> The timing measurements you get are likely tainted by garbage results from the VDSO itself.

OK thank you for your feedback.

But, we wanted to know, why vdso call timing is very high here. What
does this timing indicates?
gettimeofday: vdso: 4171 nsec/call

1) How to decide whether to enable or disable VDSO in the system, if
its not suitable.
Because in a VDSO enabled system, when we use gettimeofday API, we see
that its not falling back to the systemically, but may rather return a
garbage value from vdso itself.
If that is the case, shall we disable CONFIG_VDSO itself or keep it as it is ?

Please suggest your opinion.

2) Can you list down 1-2 arm 32-bit board, where VDSO can work perfectly ?

This will be really helpful for us to take some decision.


Thank You!
Pintu
