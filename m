Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3751363-1526637804-2-9701779081541036858
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526637804; b=G4H60v609ztaKfHTCMj3KxIdHaGI3KKPZzz7Tg5Uqw2lt1s+Dl
    VpAwXRL1XL2pnHUZemtPN8yHVJIq9V71F6kLZg15JzTtd3T4vL+hes8CSVMB4XBL
    sOTsUWzkxyWwmTUS48tCdaIRzWD1adkojfFDZ6IUfYxmY9hENTcFBDdybhkIIFal
    lLYZFS23LG5yyesjmZu2DE054RPVWKiVSqO7VE2T95zbUsQBPUeIBxsy2IEksXYA
    3k00pbbIZwGThPs3lJbWp8sWitd8ndrN1MREuQ05owmDQSZE2AZIMivxX+P9XIoR
    SzbgamzydQxlCkSygINN56iMY5tzD/3eh6PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1526637804; bh=Yzr375WXBHmbLy+qxyj3SWqbrS+zFQIgXhoHkgf2vl
    0=; b=fXG86RoMaILaudv72p3ja7jiolHMbnNloaAYKeqQ24cKzD/EqEPZPKzZGg
    /zVx/F/iaSoMMWZL7tybQ8lUuUvKU4odan7o6VIKn+6P8YzGQFp511LT4e6Yv6qu
    YyFUsYU6TzkPHAsj549+Y32GWLXYjPqFQ/B7NkUIycJLpvBGvO/rbXAwy7C6rdNy
    vG4DBC+vODA9FYrcGuU+lsEaXnBFyZK4w84QMupo3JZ9FsuNcSSFFIDn6Y6EnCXl
    +LvaRavfO2X8s5D9cthYcwJ2U3F/XPIg6/Ox5fwYnRt58FFy+3auAwayizRMUiaK
    Fo5fbwLHRmKlar50+ZRxBbSteidA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=C9/PRSUs x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=QjsPFZlW;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=C9/PRSUs x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=QjsPFZlW;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFypWirdzsQjK51AXA3gvpLGNBLI9BxJbUs9vpvBsa8wsuTB/rmzU6NeQm3WrbnDPty8Ntm9yGzxXb3Pjm/dr44hYAOjGfl2f3bgK8bd/uldt5WUxsaE
    JWMUmiRFfBUEIlKLbTdXUA/MjHTo5XO1waFg4ZoISnhe0Avk9cNWnKHM2ZklrnaHRkllVq7IaGjo2QokDm/xucvlEt46c2Eiho1LfMwrVNZthx/oyM2tpdOw
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=D19gQVrFAAAA:8 a=p-nOP-kxAAAA:8 a=QyXUC8HyAAAA:8 a=20KFwNOVAAAA:8
    a=oGMlB6cnAAAA:8 a=VwQbUJbxAAAA:8 a=1oeNb_wghgr4QZq8Xt4A:9 a=QEXdDO2ut3YA:10
    a=W4TVW4IDbPiebHqcZpNg:22 a=XN2wCei03jY4uMu7D0Wg:22 a=NdAtdrkLVvyUPsUoGJp4:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751581AbeERKDX (ORCPT <rfc822;linux@kroah.com>);
        Fri, 18 May 2018 06:03:23 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:41034 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752168AbeERKDV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 May 2018 06:03:21 -0400
X-Google-Smtp-Source: AB8JxZrDZTjWQaPruL70yiumtxD+2v14WvIiKLYVRVgngmIGNaOLuVKCPxx8bwuG7+ykEyjq8x/R/1bycDjpTOXvC70=
MIME-Version: 1.0
In-Reply-To: <20180518091721.7604-3-jslaby@suse.cz>
References: <20180518091721.7604-1-jslaby@suse.cz> <20180518091721.7604-3-jslaby@suse.cz>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 18 May 2018 12:03:20 +0200
X-Google-Sender-Auth: sKunSjCpImGYVkcQ0phG2NW5hz4
Message-ID: <CAJZ5v0jz-qzA-k0+6PvyALbwzpnRyB5SQpbDr9g-THiz7ZwH3g@mail.gmail.com>
Subject: Re: [PATCH v6 02/28] x86/asm/suspend: drop ENTRY from local data
To: Jiri Slaby <jslaby@suse.cz>
Cc: Ingo Molnar <mingo@redhat.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 18, 2018 at 11:16 AM, Jiri Slaby <jslaby@suse.cz> wrote:
> ENTRY was intended for functions and shall be paired with ENDPROC.
> ENTRY also aligns symbols which creates unnecessary holes here between
> data.
>
> So drop ENTRY from saved_eip in wakeup_32 and many saved_* in wakeup_64,
> as these symbols are local only.
>
> We could use SYM_DATA_LOCAL for these symbols, but it was discouraged
> earlier [1].
>
> [1] https://lkml.org/lkml/2017/4/27/244
>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: linux-pm@vger.kernel.org

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  arch/x86/kernel/acpi/wakeup_32.S |  2 +-
>  arch/x86/kernel/acpi/wakeup_64.S | 12 ++++++------
>  2 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/kernel/acpi/wakeup_32.S b/arch/x86/kernel/acpi/wakeup_32.S
> index 0c26b1b44e51..4203d4f0c68d 100644
> --- a/arch/x86/kernel/acpi/wakeup_32.S
> +++ b/arch/x86/kernel/acpi/wakeup_32.S
> @@ -90,7 +90,7 @@ ret_point:
>  .data
>  ALIGN
>  ENTRY(saved_magic)     .long   0
> -ENTRY(saved_eip)       .long   0
> +saved_eip:             .long 0
>
>  # saved registers
>  saved_idt:     .long   0,0
> diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
> index 50b8ed0317a3..510fa12aab73 100644
> --- a/arch/x86/kernel/acpi/wakeup_64.S
> +++ b/arch/x86/kernel/acpi/wakeup_64.S
> @@ -125,12 +125,12 @@ ENTRY(do_suspend_lowlevel)
>  ENDPROC(do_suspend_lowlevel)
>
>  .data
> -ENTRY(saved_rbp)       .quad   0
> -ENTRY(saved_rsi)       .quad   0
> -ENTRY(saved_rdi)       .quad   0
> -ENTRY(saved_rbx)       .quad   0
> +saved_rbp:             .quad   0
> +saved_rsi:             .quad   0
> +saved_rdi:             .quad   0
> +saved_rbx:             .quad   0
>
> -ENTRY(saved_rip)       .quad   0
> -ENTRY(saved_rsp)       .quad   0
> +saved_rip:             .quad   0
> +saved_rsp:             .quad   0
>
>  ENTRY(saved_magic)     .quad   0
> --
> 2.16.3
>
