Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3751363-1526637833-2-4401196004058860693
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526637832; b=WAzfxQQ7Cs24GD3ouqumoLYrY6VdtMDZJkaYLc+xPeerOPMRbr
    a13lvsz2wEw6kY+KrJ28U4DSDMwyKjYCbq+AS+/TZ9Te3tto+8/tY9n/WOyq3ShY
    IPfVif3VNYFwFZxrc+7TZZ0S+vFFARn7ITINJxrrNpvSxVPzhFr86byNws4iwbzn
    jP0XAMiBbfSV8DCuypTNRCjBZXrT96yCify+VfILMRtQppiENQYX5ji5VYbhzV6I
    l0ZOZzJh3G+hcN3PmeHF6ML0hUD1jK9GMPzYpcdY/mR0e2hFVRVAHOQ5Dz4xwFU4
    Gv1HD4T+7I8KDJXpeLsHtbiQNyMMbV83qnQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1526637832; bh=Bo0O4mTKsbGn+uge+9eNjMKSjMmn3j7OMeQ7vLjMZs
    E=; b=kV0xRvYGZM1TywH5nN5ehqLzb6+x6Uaxlanqd+G6W/MNo4x+sSZxcbOJKG
    1A/Pqh1MwYKB+UGQhQMHvXhNT3ilDGVVDNfjdvO+VYwGF6lv50z/kzBrlTrXKo1H
    q7MWU3Z7e9AY37S7rfPXKPZy+jhl0HMUO5uRMjdrtuO0WFy5eDPyR5WY1cHRJlaJ
    /vtzdn8587wtXdN+8Ihn2fUnm5GI5JLxFRzr0TmlfU4GQ0nJOzSsTuUgOSPQogLH
    ZlDGw9aR3vLtDDENpoF9xxeqRiItocOcYKNa2Rw/GPiPQzS3Qvh9INS4OC3NVM2y
    WZTF9+KybKQlA64q+oy/SfvJplCA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=c+nbiTaF x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=PZTLNM6k;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=c+nbiTaF x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=PZTLNM6k;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB5WUV4FaMq/MW699PDTdk9bn+DZ0iv8ReXGeBGFcXs6SzEgjJ5MAdRFc22/NmEko96CPVjZPQUT/VTgFTlwlCZX5i28CoFK0M7XTZH/iFzJv5F00qcx
    O/Pww3XoTLzPnuuoWdyqFi4v5XSHqPtfQqf1TEOLcIN6+S1FC4WQ78de+TV5o/oq8tAaBMvrcjuMUWOTqY2R39OXDCOTyA7nXzFUkT/FPBUbKrCqO/XHID33
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=p-nOP-kxAAAA:8 a=QyXUC8HyAAAA:8 a=20KFwNOVAAAA:8 a=oGMlB6cnAAAA:8
    a=VwQbUJbxAAAA:8 a=6aB9zNIcVPSQCmBHzbMA:9 a=QEXdDO2ut3YA:10
    a=XN2wCei03jY4uMu7D0Wg:22 a=NdAtdrkLVvyUPsUoGJp4:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752274AbeERKDu (ORCPT <rfc822;linux@kroah.com>);
        Fri, 18 May 2018 06:03:50 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:44113 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751589AbeERKDt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 May 2018 06:03:49 -0400
X-Google-Smtp-Source: AB8JxZrFiTYeQWHjnc2/SWsEYQMwbxB1RO3KGwkNgAbWXBkhsoeThYTZcESlcmE6ftGsF5GuGM6AlkpCjmpOw8v0DA0=
MIME-Version: 1.0
In-Reply-To: <20180518091721.7604-4-jslaby@suse.cz>
References: <20180518091721.7604-1-jslaby@suse.cz> <20180518091721.7604-4-jslaby@suse.cz>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 18 May 2018 12:03:48 +0200
X-Google-Sender-Auth: DuZVbs_NtOU_VSDakIB85GNA-qs
Message-ID: <CAJZ5v0gH-Zjd_VWv9wBrtvTjewHdyjEiRhR2GWpSS2huMcWKLw@mail.gmail.com>
Subject: Re: [PATCH v6 03/28] x86/asm/suspend: use SYM_DATA for data
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
> Some global data in the suspend code were marked as `ENTRY'. ENTRY was
> intended for functions and shall be paired with ENDPROC. ENTRY also
> aligns symbols which creates unnecessary holes here between data. Since
> we are dropping historical markings, make proper use of newly added
> SYM_DATA in this code.
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
>  arch/x86/kernel/acpi/wakeup_32.S | 2 +-
>  arch/x86/kernel/acpi/wakeup_64.S | 2 +-
>  arch/x86/kernel/head_32.S        | 6 ++----
>  arch/x86/kernel/head_64.S        | 5 ++---
>  4 files changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/kernel/acpi/wakeup_32.S b/arch/x86/kernel/acpi/wakeup_32.S
> index 4203d4f0c68d..feac1e5ecba0 100644
> --- a/arch/x86/kernel/acpi/wakeup_32.S
> +++ b/arch/x86/kernel/acpi/wakeup_32.S
> @@ -89,7 +89,7 @@ ret_point:
>
>  .data
>  ALIGN
> -ENTRY(saved_magic)     .long   0
> +SYM_DATA(saved_magic,  .long 0)
>  saved_eip:             .long 0
>
>  # saved registers
> diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
> index 510fa12aab73..551758f48eb7 100644
> --- a/arch/x86/kernel/acpi/wakeup_64.S
> +++ b/arch/x86/kernel/acpi/wakeup_64.S
> @@ -133,4 +133,4 @@ saved_rbx:          .quad   0
>  saved_rip:             .quad   0
>  saved_rsp:             .quad   0
>
> -ENTRY(saved_magic)     .quad   0
> +SYM_DATA(saved_magic,  .quad   0)
> diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
> index b59e4fb40fd9..80965fd75fea 100644
> --- a/arch/x86/kernel/head_32.S
> +++ b/arch/x86/kernel/head_32.S
> @@ -507,10 +507,8 @@ GLOBAL(early_recursion_flag)
>
>  __REFDATA
>         .align 4
> -ENTRY(initial_code)
> -       .long i386_start_kernel
> -ENTRY(setup_once_ref)
> -       .long setup_once
> +SYM_DATA(initial_code,         .long i386_start_kernel)
> +SYM_DATA(setup_once_ref,       .long setup_once)
>
>  /*
>   * BSS section
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index 8344dd2f310a..17543533642d 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -463,9 +463,8 @@ early_gdt_descr:
>  early_gdt_descr_base:
>         .quad   INIT_PER_CPU_VAR(gdt_page)
>
> -ENTRY(phys_base)
> -       /* This must match the first entry in level2_kernel_pgt */
> -       .quad   0x0000000000000000
> +/* This must match the first entry in level2_kernel_pgt */
> +SYM_DATA(phys_base, .quad 0x0000000000000000)
>  EXPORT_SYMBOL(phys_base)
>
>  #include "../../x86/xen/xen-head.S"
> --
> 2.16.3
>
