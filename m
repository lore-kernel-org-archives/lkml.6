Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71A1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691AA2086E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EN51PIVe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 691AA2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbeJKAu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 20:50:26 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33097 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbeJKAuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 20:50:25 -0400
Received: by mail-oi1-f196.google.com with SMTP id a203-v6so4771878oib.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 10:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Spo6Hpsu3fevxBQ+LbjXEPJmX+IcDfW+MvgF4Qv4GnM=;
        b=EN51PIVeaM/FhJfL/G+wzPluDj1fKcnmu/poBF294L3nZz6gXbaplB9Z/idL/gl9xw
         fFPdlQTjhOe1JNdP9q84ZYPgQt68/J0ozAf4iUQ6v12Hows991m+C7C/Od5SoYhvlVMT
         tZ11Vl6zB5YgaDr/+1CYMFp7mwl6vPYVpZO/fk24y4GAt59O++UdGRLRBgJi+dWjsJPt
         40+EEt9W6CTXjGw64ZVd4AqhcCv0rc9X36L2HhY2KoPE1ouqqTCMV+fyVFElHPcHql1T
         5+syrIFgJk6rZuk1htGjvdyUZdAx/5jw4rnvvkaRY+iW924Qb+6OHUD7Ejf03t7TfyLn
         2qCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Spo6Hpsu3fevxBQ+LbjXEPJmX+IcDfW+MvgF4Qv4GnM=;
        b=XtLR98xqcCqapdHYJA225fmEoR0M5PilGKlzX1GyK2Dvlj7XrgnAPz47mEV1zmevNF
         2vOPSemjTeFZodUif/UVxIszTBbvQ6JJtCCUKYkRGiuPA+1TTjvO0mADVIdrvYwqeSPx
         sPb5NseKAPQUQYmZRw8jJksa+VOKS88rjnzG2VsChebS80fU4rRpVGnrzAiC1s6DaMQw
         p4/Sr4xR6PNA6br0413cghU4VJH4q+ZpI2mj82KWHhCDoOVUHM3U78yWkRIMTG7eEXRe
         fSq8b1eD3zfHlwiisF304iYa4u5fUNTNVMGavltBzzs6IKEf8U8jYy/eqosvYu71vQO9
         IMfQ==
X-Gm-Message-State: ABuFfoiD0gwlascSHJ8xuDbBzG7A0aaNZiOX3psmi3IpmS29xYZ0ePK0
        pU9YcHDI2bXpxqDyaR83WdbuJCBMKfXbz1/pV+FEzg==
X-Google-Smtp-Source: ACcGV637wGlN59jZMSL3kDE2pVOwxYWaXuda/7+xpsWIiZOFh6gwwa6fprE9cL2OZA4JEAd8Ab9iVvFPK1cIno5QkWg=
X-Received: by 2002:aca:efd6:: with SMTP id n205-v6mr2115657oih.3.1539192436724;
 Wed, 10 Oct 2018 10:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <20181010152736.99475-1-jannh@google.com> <20181010171944.GJ5873@dhcp22.suse.cz>
In-Reply-To: <20181010171944.GJ5873@dhcp22.suse.cz>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 10 Oct 2018 19:26:50 +0200
Message-ID: <CAG48ez04KK62doMwsTVN4nN8y_wmv7hn+4my2jk5VXKL0wP7Lg@mail.gmail.com>
Subject: Re: [PATCH] mm: don't clobber partially overlapping VMA with MAP_FIXED_NOREPLACE
To:     Michal Hocko <mhocko@suse.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        abdhalee@linux.vnet.ibm.com, joel@jms.id.au,
        Kees Cook <keescook@chromium.org>, jasone@google.com,
        davidtgoldblatt@gmail.com, trasz@freebsd.org,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Daniel Micay <danielmicay@gmail.com>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 7:19 PM Michal Hocko <mhocko@suse.com> wrote:
> On Wed 10-10-18 17:27:36, Jann Horn wrote:
> > Daniel Micay reports that attempting to use MAP_FIXED_NOREPLACE in an
> > application causes that application to randomly crash. The existing check
> > for handling MAP_FIXED_NOREPLACE looks up the first VMA that either
> > overlaps or follows the requested region, and then bails out if that VMA
> > overlaps *the start* of the requested region. It does not bail out if the
> > VMA only overlaps another part of the requested region.
>
> I do not understand. Could you give me an example?

Sure.

=======
user@debian:~$ cat mmap_fixed_simple.c
#include <sys/mman.h>
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#ifndef MAP_FIXED_NOREPLACE
#define MAP_FIXED_NOREPLACE 0x100000
#endif

int main(void) {
  char *p;

  errno = 0;
  p = mmap((void*)0x10001000, 0x4000, PROT_NONE,
MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED_NOREPLACE, -1, 0);
  printf("p1=%p err=%m\n", p);

  errno = 0;
  p = mmap((void*)0x10000000, 0x2000, PROT_READ,
MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED_NOREPLACE, -1, 0);
  printf("p2=%p err=%m\n", p);

  char cmd[100];
  sprintf(cmd, "cat /proc/%d/maps", getpid());
  system(cmd);

  return 0;
}
user@debian:~$ gcc -o mmap_fixed_simple mmap_fixed_simple.c
user@debian:~$ ./mmap_fixed_simple
p1=0x10001000 err=Success
p2=0x10000000 err=Success
10000000-10002000 r--p 00000000 00:00 0
10002000-10005000 ---p 00000000 00:00 0
564a9a06f000-564a9a070000 r-xp 00000000 fe:01 264004
  /home/user/mmap_fixed_simple
564a9a26f000-564a9a270000 r--p 00000000 fe:01 264004
  /home/user/mmap_fixed_simple
564a9a270000-564a9a271000 rw-p 00001000 fe:01 264004
  /home/user/mmap_fixed_simple
564a9a54a000-564a9a56b000 rw-p 00000000 00:00 0                          [heap]
7f8eba447000-7f8eba5dc000 r-xp 00000000 fe:01 405885
  /lib/x86_64-linux-gnu/libc-2.24.so
7f8eba5dc000-7f8eba7dc000 ---p 00195000 fe:01 405885
  /lib/x86_64-linux-gnu/libc-2.24.so
7f8eba7dc000-7f8eba7e0000 r--p 00195000 fe:01 405885
  /lib/x86_64-linux-gnu/libc-2.24.so
7f8eba7e0000-7f8eba7e2000 rw-p 00199000 fe:01 405885
  /lib/x86_64-linux-gnu/libc-2.24.so
7f8eba7e2000-7f8eba7e6000 rw-p 00000000 00:00 0
7f8eba7e6000-7f8eba809000 r-xp 00000000 fe:01 405876
  /lib/x86_64-linux-gnu/ld-2.24.so
7f8eba9e9000-7f8eba9eb000 rw-p 00000000 00:00 0
7f8ebaa06000-7f8ebaa09000 rw-p 00000000 00:00 0
7f8ebaa09000-7f8ebaa0a000 r--p 00023000 fe:01 405876
  /lib/x86_64-linux-gnu/ld-2.24.so
7f8ebaa0a000-7f8ebaa0b000 rw-p 00024000 fe:01 405876
  /lib/x86_64-linux-gnu/ld-2.24.so
7f8ebaa0b000-7f8ebaa0c000 rw-p 00000000 00:00 0
7ffcc99fa000-7ffcc9a1b000 rw-p 00000000 00:00 0                          [stack]
7ffcc9b44000-7ffcc9b47000 r--p 00000000 00:00 0                          [vvar]
7ffcc9b47000-7ffcc9b49000 r-xp 00000000 00:00 0                          [vdso]
ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0
  [vsyscall]
user@debian:~$ uname -a
Linux debian 4.19.0-rc6+ #181 SMP Wed Oct 3 23:43:42 CEST 2018 x86_64 GNU/Linux
user@debian:~$
=======

As you can see, the first page of the mapping at 0x10001000 was clobbered.

> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 5f2b2b184c60..f7cd9cb966c0 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1410,7 +1410,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
> >       if (flags & MAP_FIXED_NOREPLACE) {
> >               struct vm_area_struct *vma = find_vma(mm, addr);
> >
> > -             if (vma && vma->vm_start <= addr)
> > +             if (vma && vma->vm_start < addr + len)
>
> find_vma is documented to - Look up the first VMA which satisfies addr <
> vm_end, NULL if none.
> This means that the above check guanratees that
>         vm_start <= addr < vm_end
> so an overlap is guanrateed. Why should we care how much we overlap?

"an overlap is guaranteed"? I have no idea what you're trying to say.
