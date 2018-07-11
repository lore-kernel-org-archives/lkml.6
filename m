Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D00C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9184320C0E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="gzvLYE2m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9184320C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390299AbeGKVkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 17:40:32 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:42651 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387546AbeGKVkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 17:40:31 -0400
Received: by mail-pf0-f194.google.com with SMTP id l9-v6so7588568pff.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 14:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xvkcAYA52KVnkWQ5u0hrBRpushf7GoDGYKnwRrDI2ak=;
        b=gzvLYE2meKrbFF7dwwKA3FubeAHKuqdxq9Nm24XKcskanLxHgCwgzVolH7e1KijwC3
         W9ZcBG+/wglBJPJcMEypLmnnzrvA1j7sHLyUkXocko6Qs2ymXmKWI1FxEFhG3Yk8BnMM
         ZZFoP59SgbDajxZSyFmANm30Gf2JbBws9ujKlzrKMA7WuQ5SyLI8DIx1+XuRIaMDfu+q
         iEcoBevv5OGxjVZr+n4mAA/YBhQ8KYT02uj5ZuIYxhZd1rUQ3HWjnYqK5lPA4K+uNT2u
         tkauBKhGSbRq6/D1OsX3f4WAjyOBYZLceMtOcxrSmto2Bu6I/kuVLsN3Ik8EIVBEM2eU
         Th7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xvkcAYA52KVnkWQ5u0hrBRpushf7GoDGYKnwRrDI2ak=;
        b=QaBEzCIFE3t5KlhOjQoj8pSKUMTvlaApq2NgPUZwKYBe2rYhEyGdnValmBzho0Wo8c
         Wwehx/P4CJfO6wHrK+BOVlepu1P5FUVyUIJ4AScq2/NEEUtl/yTDsOluOPh5TlGZDjLx
         qgtCxtg/mj2w3usMAzrvRo0GsBaXFcJzzcpKNFglFy0eKTJMpOhhcu1OHnjFqLxB/1u7
         Uc4+jSSRKiB756NvTj6Zhuh62L2s5SLqobJyltl4XXCJxLQ0DRgIoG/wvetsZv5onNP7
         4yChUugbg0L1GblSPP+BOQjRwoAY/VjBiuqtkaO3rSGgYrorg8d+Jsa8AREz0D/XteDi
         v05Q==
X-Gm-Message-State: AOUpUlHtjLj/507F0hqFKvsjaGWFJvntatd+MbruYHvEN8rsVyS5RNoM
        izExek++lMYZT5LjWx2NPHw57w==
X-Google-Smtp-Source: AAOMgpeBXqA9KWjiaYGzHkaqV3O0BCUSbLpd1ma3lfW9Wpn62dIZzh5DdZN8pDdw+UTzKzaXEvr9Ig==
X-Received: by 2002:a65:52cc:: with SMTP id z12-v6mr274134pgp.69.1531344853197;
        Wed, 11 Jul 2018 14:34:13 -0700 (PDT)
Received: from ?IPv6:2600:1010:b052:968:4f0:92ce:1385:5f3d? ([2600:1010:b052:968:4f0:92ce:1385:5f3d])
        by smtp.gmail.com with ESMTPSA id e82-v6sm51656936pfd.40.2018.07.11.14.34.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 14:34:12 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH v2 17/27] x86/cet/shstk: User-mode shadow stack support
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15F79)
In-Reply-To: <CAG48ez1ytOfQyNZMNPFp7XqKcpd7_aRai9G5s7rx0V=8ZG+r2A@mail.gmail.com>
Date:   Wed, 11 Jul 2018 14:34:10 -0700
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
Message-Id: <6F5FEFFD-0A9A-4181-8D15-5FC323632BA6@amacapital.net>
References: <20180710222639.8241-1-yu-cheng.yu@intel.com> <20180710222639.8241-18-yu-cheng.yu@intel.com> <CAG48ez1ytOfQyNZMNPFp7XqKcpd7_aRai9G5s7rx0V=8ZG+r2A@mail.gmail.com>
To:     Jann Horn <jannh@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 11, 2018, at 2:10 PM, Jann Horn <jannh@google.com> wrote:
>=20
>> On Tue, Jul 10, 2018 at 3:31 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote=
:
>>=20
>> This patch adds basic shadow stack enabling/disabling routines.
>> A task's shadow stack is allocated from memory with VM_SHSTK
>> flag set and read-only protection.  The shadow stack is
>> allocated to a fixed size.
>>=20
>> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> [...]
>> diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
>> new file mode 100644
>> index 000000000000..96bf69db7da7
>> --- /dev/null
>> +++ b/arch/x86/kernel/cet.c
> [...]
>> +static unsigned long shstk_mmap(unsigned long addr, unsigned long len)
>> +{
>> +       struct mm_struct *mm =3D current->mm;
>> +       unsigned long populate;
>> +
>> +       down_write(&mm->mmap_sem);
>> +       addr =3D do_mmap(NULL, addr, len, PROT_READ,
>> +                      MAP_ANONYMOUS | MAP_PRIVATE, VM_SHSTK,
>> +                      0, &populate, NULL);
>> +       up_write(&mm->mmap_sem);
>> +
>> +       if (populate)
>> +               mm_populate(addr, populate);
>> +
>> +       return addr;
>> +}
>=20
> How does this interact with UFFDIO_REGISTER?
>=20
> Is there an explicit design decision on whether FOLL_FORCE should be
> able to write to shadow stacks? I'm guessing the answer is "yes,
> FOLL_FORCE should be able to write to shadow stacks"? It might make
> sense to add documentation for this.

FOLL_FORCE should be able to write them, IMO. Otherwise we=E2=80=99ll need a=
 whole new debugging API.

By the time an attacker can do FOLL_FORCE writes, the attacker can directly m=
odify *text*, and CET is useless.  We should probably audit all uses of FOLL=
_FORCE and remove as many as we can get away with.

>=20
> Should the kernel enforce that two shadow stacks must have a guard
> page between them so that they can not be directly adjacent, so that
> if you have too much recursion, you can't end up corrupting an
> adjacent shadow stack?

I think the answer is a qualified =E2=80=9Cno=E2=80=9D. I would like to inst=
ead enforce a general guard page on all mmaps that don=E2=80=99t use MAP_FOR=
CE. We *might* need to exempt any mmap with an address hint for compatibilit=
y.

My commercial software has been manually adding guard pages on every single m=
map done by tcmalloc for years, and it has caught a couple bugs and costs es=
sentially nothing.

Hmm. Linux should maybe add something like Windows=E2=80=99 =E2=80=9Creserve=
d=E2=80=9D virtual memory. It=E2=80=99s basically a way to ask for a VA rang=
e that explicitly contains nothing and can be subsequently be turned into so=
mething useful with the equivalent of MAP_FORCE.

>=20
>> +int cet_setup_shstk(void)
>> +{
>> +       unsigned long addr, size;
>> +
>> +       if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
>> +               return -EOPNOTSUPP;
>> +
>> +       size =3D in_ia32_syscall() ? SHSTK_SIZE_32:SHSTK_SIZE_64;
>> +       addr =3D shstk_mmap(0, size);
>> +
>> +       /*
>> +        * Return actual error from do_mmap().
>> +        */
>> +       if (addr >=3D TASK_SIZE_MAX)
>> +               return addr;
>> +
>> +       set_shstk_ptr(addr + size - sizeof(u64));
>> +       current->thread.cet.shstk_base =3D addr;
>> +       current->thread.cet.shstk_size =3D size;
>> +       current->thread.cet.shstk_enabled =3D 1;
>> +       return 0;
>> +}
> [...]
>> +void cet_disable_free_shstk(struct task_struct *tsk)
>> +{
>> +       if (!cpu_feature_enabled(X86_FEATURE_SHSTK) ||
>> +           !tsk->thread.cet.shstk_enabled)
>> +               return;
>> +
>> +       if (tsk =3D=3D current)
>> +               cet_disable_shstk();
>> +
>> +       /*
>> +        * Free only when tsk is current or shares mm
>> +        * with current but has its own shstk.
>> +        */
>> +       if (tsk->mm && (tsk->mm =3D=3D current->mm) &&
>> +           (tsk->thread.cet.shstk_base)) {
>> +               vm_munmap(tsk->thread.cet.shstk_base,
>> +                         tsk->thread.cet.shstk_size);
>> +               tsk->thread.cet.shstk_base =3D 0;
>> +               tsk->thread.cet.shstk_size =3D 0;
>> +       }
>> +
>> +       tsk->thread.cet.shstk_enabled =3D 0;
>> +}
