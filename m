Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728D4C43A1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 22:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21B7D21470
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 22:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="HK39ME0f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21B7D21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390655AbeGKW22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 18:28:28 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44633 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733146AbeGKW22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 18:28:28 -0400
Received: by mail-pf0-f193.google.com with SMTP id j3-v6so19275053pfh.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 15:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NC5Wll+Ta90LWa7k3YHEONHdQo3lP6YNOAIHcaPq1+E=;
        b=HK39ME0feC6LgQfKJIWgi4Z6wlPvIKWIpfRp4JSUx3Hzcfi1qult6Fnj8EfGQyewzg
         QPR9o+s+7yVUBLuRwuglutgvxSZZ40yD6WOLbJUEmPDTwaV29ScSPAvFE++4o5F7NG8n
         ICQT6Nio9+yK0UiDM7BNLUpAwpV/u9Iea4j/SePB3F+Q8vpdG5PjyKgnPahJ0qbTUX+F
         k1tcAv6Iv09C896C0N8RxxekS6NkXa7abLHt2kKXcQdKFWVdyaV+WaFRHPAxJUaj6p0U
         y7LTgYq+dlKCcIvelXicgVmtIXL1S+ykc/1V4D+IF/1aSq1SDKNr8+IXSs7/l2OZ8ZFV
         Pa0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NC5Wll+Ta90LWa7k3YHEONHdQo3lP6YNOAIHcaPq1+E=;
        b=m76+0JQxVboxIqj2254Kg+EquFy2zzfmNXIpjMOfblt4EzBpwWNkMGw38XmOSZn8WU
         rjVMCb9qhWElEQwS0U77rm1sgbxmXMO5i09Xx8F39SWw2I0+1IEFcqCF1sXbv6wVSRpk
         b2KWudtBLUNh1eOy9VpIn2apOcu9N1bJ5caGr6vEytYOYb1mJbOCeA5c3hgsLhTVDIhu
         cHSGUn7FwMEPUdSYKjcCxKPD5osMCAIW5zdRuFcyqtKRmYXbH5drFC+rSH4NKU/3UQqq
         XlJlnZxVNBoetHSse/0svNFbQSMqDKt9fGDlbXPxUomvKTPjyszfTKZzUFTYkKpn6nYK
         p5dw==
X-Gm-Message-State: AOUpUlE2WnSbBguXW3R1BoRa5zhW9PKEeay3K/Ybp+isPb7mhumv2eKd
        49eVRoG0P1VU+RQdlGGLQLWAqw==
X-Google-Smtp-Source: AAOMgpfaX5+MrPU/Sam4qzUAlWGk9zylnt2U7i7gAQ6gi0Uk4P6PR30RAl/2gg2ZPApc6aNXauezrw==
X-Received: by 2002:a62:8a4f:: with SMTP id y76-v6mr396246pfd.233.1531347720835;
        Wed, 11 Jul 2018 15:22:00 -0700 (PDT)
Received: from ?IPv6:2600:1010:b052:968:4f0:92ce:1385:5f3d? ([2600:1010:b052:968:4f0:92ce:1385:5f3d])
        by smtp.gmail.com with ESMTPSA id a15-v6sm20060710pfe.32.2018.07.11.15.21.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 15:21:59 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH v2 17/27] x86/cet/shstk: User-mode shadow stack support
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15F79)
In-Reply-To: <CAG48ez1OwQMmhQfHaauo+vneywsQ_ERKr4uVcQebC=GbdqZWtA@mail.gmail.com>
Date:   Wed, 11 Jul 2018 15:21:58 -0700
Cc:     yu-cheng.yu@intel.com, the arch/x86 maintainers <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, bsingharora@gmail.com,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Florian Weimer <fweimer@redhat.com>, hjl.tools@gmail.com,
        Jonathan Corbet <corbet@lwn.net>, keescook@chromiun.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        ravi.v.shankar@intel.com, vedvyas.shanbhogue@intel.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <A034EC34-13E7-4AEF-BB3C-FEF14143B601@amacapital.net>
References: <20180710222639.8241-1-yu-cheng.yu@intel.com> <20180710222639.8241-18-yu-cheng.yu@intel.com> <CAG48ez1ytOfQyNZMNPFp7XqKcpd7_aRai9G5s7rx0V=8ZG+r2A@mail.gmail.com> <6F5FEFFD-0A9A-4181-8D15-5FC323632BA6@amacapital.net> <CAG48ez1OwQMmhQfHaauo+vneywsQ_ERKr4uVcQebC=GbdqZWtA@mail.gmail.com>
To:     Jann Horn <jannh@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jul 11, 2018, at 2:51 PM, Jann Horn <jannh@google.com> wrote:
>=20
> On Wed, Jul 11, 2018 at 2:34 PM Andy Lutomirski <luto@amacapital.net> wrot=
e:
>>> On Jul 11, 2018, at 2:10 PM, Jann Horn <jannh@google.com> wrote:
>>>=20
>>>> On Tue, Jul 10, 2018 at 3:31 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wro=
te:
>>>>=20
>>>> This patch adds basic shadow stack enabling/disabling routines.
>>>> A task's shadow stack is allocated from memory with VM_SHSTK
>>>> flag set and read-only protection.  The shadow stack is
>>>> allocated to a fixed size.
>>>>=20
>>>> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
>>> [...]
>>>> diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
>>>> new file mode 100644
>>>> index 000000000000..96bf69db7da7
>>>> --- /dev/null
>>>> +++ b/arch/x86/kernel/cet.c
>>> [...]
>>>> +static unsigned long shstk_mmap(unsigned long addr, unsigned long len)=

>>>> +{
>>>> +       struct mm_struct *mm =3D current->mm;
>>>> +       unsigned long populate;
>>>> +
>>>> +       down_write(&mm->mmap_sem);
>>>> +       addr =3D do_mmap(NULL, addr, len, PROT_READ,
>>>> +                      MAP_ANONYMOUS | MAP_PRIVATE, VM_SHSTK,
>>>> +                      0, &populate, NULL);
>>>> +       up_write(&mm->mmap_sem);
>>>> +
>>>> +       if (populate)
>>>> +               mm_populate(addr, populate);
>>>> +
>>>> +       return addr;
>>>> +}
> [...]
>>> Should the kernel enforce that two shadow stacks must have a guard
>>> page between them so that they can not be directly adjacent, so that
>>> if you have too much recursion, you can't end up corrupting an
>>> adjacent shadow stack?
>>=20
>> I think the answer is a qualified =E2=80=9Cno=E2=80=9D. I would like to i=
nstead enforce a general guard page on all mmaps that don=E2=80=99t use MAP_=
FORCE. We *might* need to exempt any mmap with an address hint for compatibi=
lity.
>=20
> I like this idea a lot.
>=20
>> My commercial software has been manually adding guard pages on every sing=
le mmap done by tcmalloc for years, and it has caught a couple bugs and cost=
s essentially nothing.
>>=20
>> Hmm. Linux should maybe add something like Windows=E2=80=99 =E2=80=9Crese=
rved=E2=80=9D virtual memory. It=E2=80=99s basically a way to ask for a VA r=
ange that explicitly contains nothing and can be subsequently be turned into=
 something useful with the equivalent of MAP_FORCE.
>=20
> What's the benefit over creating an anonymous PROT_NONE region? That
> the kernel won't have to scan through the corresponding PTEs when
> tearing down the mapping?

Make it more obvious what=E2=80=99s happening and avoid accounting issues?  W=
hat I=E2=80=99ve actually used is MAP_NORESERVE | PROT_NONE, but I think thi=
s still counts against the VA rlimit. But maybe that=E2=80=99s actually the d=
esired behavior.


