Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7097DC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA23224F9
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="kVgZ/vBo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X2RB2g7c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AA23224F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934697AbeGFTXn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 15:23:43 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:43712 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934463AbeGFTXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 15:23:39 -0400
Received: by mail-yb0-f194.google.com with SMTP id x10-v6so4966377ybl.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 12:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=+XAmXzMAcqZoH2fLwSNIPZWvfUPc2O9SgGIeUGnWoOk=;
        b=kVgZ/vBosBDC6rLU22ap77TBU5zohwZPPamw24JgVeke0Ji8dpYnnlIqgkNQSy4r0B
         u272uHPl7nOEhaXp6IcE8XVAOrKK3o1jW1l5HsqhedxM72w6wFkeDYpA4f8oU1M4y7u4
         SW/g93qil1ljEB1yCBG45Sa88OlbD0fSqUSOfrbRxO1qeQDgsFAJPybdYU5qgQ4qVCF6
         byDICfRr4oQmZqefhmfndEzUsaLLgXkGu8bSoWSg51Z2d9/48Hipbz/j7dZ7wz8MMHo/
         yzrV55C0ZRCg+LCctY1c1rJA8pasGQCXThaMzedb4WEjUAhsB6kPX34Mnoi4EbrptHvz
         MbOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=+XAmXzMAcqZoH2fLwSNIPZWvfUPc2O9SgGIeUGnWoOk=;
        b=X2RB2g7cMosMbfBDX4d1/889L3KUai+IXp+qJxtPgptYwPlSGLQGF+/j4M5ZFNdTOw
         6EtnbRFHTRj5TOJ8BHe5Ul4CmHs7Zlu/SgT6+DeOq1crBGaJXYLXU1asRiwt9ljA/yGT
         8le9vuO/NWkfj4DZ/Cx3zRztEbLN03lP2KDQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=+XAmXzMAcqZoH2fLwSNIPZWvfUPc2O9SgGIeUGnWoOk=;
        b=Xk8qU4XRy2YEMjaOPEnRq0KEc/5TwQ0kklg0x/gZQOs4TjuDlvaNWBiC8wlfSOr2M4
         9EJG0BBMkl047cypA9ah5eKgiSHCh5Q4Zx0zxeJ8mRY11F+1tDfpktfff54qiQKxVOcc
         w/3ElM3iv6PNKcmRD5LGNLX6o1GnB90eMcz//BnB0poiEWLTGuNmvYUS76/4uQZsesOi
         Fgqfzjiwec6J9cgoFixVtGsTH8hUHpbhSnJ7YXiFuK9hDmLC6U5RBozXD+GlK8Rbsj2Y
         Ah6J4K3ggV3lCo6TBFwu9wzyRDUGyJjEnSNOTG6nvuUYQcE77SYUwQrnjR2lo/9xEpyT
         z3Qw==
X-Gm-Message-State: APt69E1oNK+R8dYOP6SFvXWxgaw9c0Kgd6SpaIDkZW5gIth5ZInk8pkh
        iZFsU9VYqZ6aSllZ1Zm8Mvrg2re6Rf+3j1s3fhnluKQg
X-Google-Smtp-Source: AAOMgpcJx8KPBJF+dREYbvCL/GyUCzlPzFWMTyqxqD51fvDcvTh4kLk8NdAdSV5rdzEDICoGdykwNerJt+5A9ZkHQ0M=
X-Received: by 2002:a25:ce8e:: with SMTP id x136-v6mr6003078ybe.118.1530905019148;
 Fri, 06 Jul 2018 12:23:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Fri, 6 Jul 2018 12:23:38 -0700 (PDT)
In-Reply-To: <20180706071323.GA7959@techadventures.net>
References: <20180705145539.9627-1-osalvador@techadventures.net>
 <CAGXu5jL4O_qwwAHmW1C8q77Jv1fe_1JCq6iFxC73VySBkvHSQw@mail.gmail.com> <20180706071323.GA7959@techadventures.net>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 6 Jul 2018 12:23:38 -0700
X-Google-Sender-Auth: qmrbFh7xsFJ5uPW_nB4k_fKS7rU
Message-ID: <CAGXu5jJXC39v_asc9EKkYWMdUvKxdj7Z1fjH+=fwdeOVm0cfpw@mail.gmail.com>
Subject: Re: [PATCH] fs, elf: Make sure to page align bss in load_elf_library
To:     Oscar Salvador <osalvador@techadventures.net>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 12:13 AM, Oscar Salvador
<osalvador@techadventures.net> wrote:
> On Thu, Jul 05, 2018 at 08:44:18AM -0700, Kees Cook wrote:
>> On Thu, Jul 5, 2018 at 7:55 AM,  <osalvador@techadventures.net> wrote:
>> > From: Oscar Salvador <osalvador@suse.de>
>> >
>> > The current code does not make sure to page align bss before calling
>> > vm_brk(), and this can lead to a VM_BUG_ON() in __mm_populate()
>> > due to the requested lenght not being correctly aligned.
>> >
>> > Let us make sure to align it properly.
>> >
>> > Signed-off-by: Oscar Salvador <osalvador@suse.de>
>> > Tested-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
>> > Reported-by: syzbot+5dcb560fe12aa5091c06@syzkaller.appspotmail.com
>>
>> Wow. CONFIG_USELIB? I'm surprised distros are still using this. 32-bit
>> only, and libc5 and earlier only.
>>
>> Regardless, this appears to match the current bss alignment logic in
>> the main elf loader, so:
>>
>> Acked-by: Kees Cook <keescook@chromium.org>
>>
>> -Kees
>>
>> > ---
>> >  fs/binfmt_elf.c | 5 ++---
>> >  1 file changed, 2 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
>> > index 0ac456b52bdd..816cc921cf36 100644
>> > --- a/fs/binfmt_elf.c
>> > +++ b/fs/binfmt_elf.c
>> > @@ -1259,9 +1259,8 @@ static int load_elf_library(struct file *file)
>> >                 goto out_free_ph;
>> >         }
>> >
>> > -       len = ELF_PAGESTART(eppnt->p_filesz + eppnt->p_vaddr +
>> > -                           ELF_MIN_ALIGN - 1);
>> > -       bss = eppnt->p_memsz + eppnt->p_vaddr;
>> > +       len = ELF_PAGEALIGN(eppnt->p_filesz + eppnt->p_vaddr);
>> > +       bss = ELF_PAGEALIGN(eppnt->p_memsz + eppnt->p_vaddr);
>> >         if (bss > len) {
>> >                 error = vm_brk(len, bss - len);
>> >                 if (error)
>> > --
>> > 2.13.6
>> >
> CC Andrew
>
> Hi Andrew,
>
> in case this patch gets accepted, does it have to go through your tree?
> Or is it for someone else to take it?

(FWIW, binfmt_elf changes have traditionally gone through -mm, yes.)

-Kees

-- 
Kees Cook
Pixel Security
