Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-463584-1526685427-2-9599840371530967336
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526685426; b=h3qPLjc8pvy4UMWsw8FrUIY4OE0iC38t4MjPax9zJy9RX+ysHF
    gyqHNUgxFMtadN4A0l+zkwesv/42CQxOJR0v5WXnQTnHoNrnO9pSFPH24NWHkThb
    SZEvCOJmmy7KC5rnRFccx4QWXZPoM2XiEJkwfqqpdRp95BP4FJC/Q37lkA6LfvHD
    PVImCa0kIHcMHlW6rhm5IBCR9bV54F46YmGebreJ4zHCbI2EyRv6m0oEkTXxBSfo
    ufTsDsjYwRWP95qh73S4WcN7clRfqO7471xNkg3/bHcRfUDcbRatcG0ifw0uRfcm
    X0riUofN/qUF5FhfkDBuHiWAA+3s6czUeFuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1526685426; bh=ExLrQIymnLyO6E0eE+eCBprLfAYJBJ5lYN8YrECCQE
    k=; b=k7k5XlZ3cw8b5umeMkcq+dD2SXUllQEjxbM6MmsOaGRaZLALc7D2MNfsnv
    ebXqLb5XokcKX6qLKXwtXWQKds4dwAoGwDYMhBM4tEr5bb48GduLaCsCNlIRjBAA
    maGFjpMDhhIE6du6bjTgmitkQOGEZewQaCmEkPinu0NlIEeGXE7lUpEJPSnwea/G
    pt45aH9rlStDq5urvfpznrjbvWj33Jf4GWAx27h/ih0PwVePYdgF4/Reo7QPgq06
    FcFQjISEaZ11bUe1qqP/2si7zPathxRdLHpC5tAzvnORJNjCCECy+P0i3Pg1wkVr
    VZsMJXG21ESNSRFzhxYiqJXASYKQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=ibOZxchG x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=PjFMCoK+;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=ibOZxchG x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=PjFMCoK+;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFI7W3TnA4R2B31f8gv7arRucM9VKmVWKm7H+Ub7njds+rujVbf+8Foo3fJOYUuJAmFmAPoz9TbVuXQ3+Nnhcz1trYcLjuNk9dYD65BTrLHXt//12mds
    hwRtYduqyzjG8N2l+TYjrBt9zh7bUp5QU1JaFNiWF/buovAe/SuChX/FF5lDg5B4WfohrMduDNTMThh6JYoHZo2xVlsyKs/mEqXUt6wb0z34xsftCfe0hEe8
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=wijiZ99obDcA:10 a=VUJBJC2UJ8kA:10 a=pGLkceISAAAA:8 a=ZDQ4JU7le8R4Ckc1zZoA:9
    a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751888AbeERXRE (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 19:17:04 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:55935 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751700AbeERXRD (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 18 May 2018 19:17:03 -0400
X-Google-Smtp-Source: AB8JxZqXc1NLIK/Eo63keT9b9E52DbWaw9ORFGRLapxCuKqK7y6OMW08+cJ6gADQulg0jy52nNuFdQWs/+wStyT0dcY=
MIME-Version: 1.0
In-Reply-To: <CAJwJo6ZwEZiQYDQqLkfP0+mRgmc+X=H02M=fFZZykWN4A3s-FQ@mail.gmail.com>
References: <20180517233510.24996-1-dima@arista.com> <1526600442.28243.39.camel@arista.com>
 <CALCETrUDX=4FHU0e8SZ9Rr_AnAes+5jjzKCrrVmS1mddHQyeVQ@mail.gmail.com> <CAJwJo6ZwEZiQYDQqLkfP0+mRgmc+X=H02M=fFZZykWN4A3s-FQ@mail.gmail.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Sat, 19 May 2018 00:16:42 +0100
Message-ID: <CAJwJo6Y1+Zrriox6WTZtFhDuUkMRed3FXv8Nte=YLgkQd3p9vw@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: Drop TS_COMPAT on 64-bit exec() syscall
To: Andy Lutomirski <luto@kernel.org>
Cc: Dmitry Safonov <dima@arista.com>,
        LKML <linux-kernel@vger.kernel.org>, izbyshev@ispras.ru,
        Alexander Monakov <amonakov@ispras.ru>,
        Borislav Petkov <bp@suse.de>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-MM <linux-mm@kvack.org>, X86 ML <x86@kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-05-19 0:10 GMT+01:00 Dmitry Safonov <0x7f454c46@gmail.com>:
> Sure.
> I'm on Intel actually:
> cpu family    : 6
> model        : 142
> model name    : Intel(R) Core(TM) i7-7600U CPU @ 2.80GHz
>
> But I usually test kernels in VM. So, I use virt-manager as it's
> easier to manage
> multiple VMs. The thing is that I've chosen "Copy host CPU configuration"
> and for some reason, I don't quite follow virt-manager makes model "Opteron_G4".
> I'm on Fedora 27, virt-manager 1.4.3, qemu 2.9.1(qemu-2.9.1-2.fc26).

Hmm, the reason it chooses AMD emulation looks like a bug in virt-manager:
When I try IvyBridge CPU, it gives the following error:
> Error starting domain: the CPU is incompatible with host CPU: Host CPU does not
> provide required features: vme, x2apic, tsc-deadline, avx, f16c, rdrand

Which to my naive mind is by the reason that "tsc-deadline" is not written with
a dash in cpuinfo:
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts
rep_good nopl xtopology nonstop_tsc cpuid aperfmperf tsc_known_freq
pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma
cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt
tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch
cpuid_fault epb invpcid_single pti tpr_shadow vnmi flexpriority ept
vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms invpcid rtm mpx
rdseed adx smap clflushopt intel_pt xsaveopt xsavec xgetbv1 xsaves
ibpb ibrs stibp dtherm ida arat pln pts hwp hwp_notify hwp_act_window
hwp_epp

But that just my naive suppose.

Thanks,
             Dmitry
