Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BF6C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 08:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A54A208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 08:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SNR+ElUS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A54A208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbeKKSSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 13:18:54 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:37688 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbeKKSSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 13:18:54 -0500
Received: by mail-vk1-f195.google.com with SMTP id 197so1336198vkf.4
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 00:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yK+PvOliLTKwct9uq94Xea/UJAz5DFGe9rEcRF1Cz2o=;
        b=SNR+ElUSvCEMTksb6hiu4n6B6vrHo+m9Dgr/C/Vo9RyAA1Vv4glLl+g1zkRzPVS6ln
         VgCVs08HBefEHdfwmZcd7a6LBKce/ikYzknMcj9RFHrKhJx7v01j0qWJZQQI/nInC/Lg
         SltSgUahDvvK7PLQHD9vCfk+FUYzwuyp/HTaPLQAzJ1swDm+C7B9f3/Y8M4EEJdMjVjp
         2qQSFqeLk2zGQdcLOqDQb9AVlaK5ecdR2p6MEH/erDuJZUElZT0UCCl56DowFEfqABR9
         9mszITj4onftS40LMaOKA6U47Ef6cO8tYxmao3+AAb+q77OqR541hN+sVm/k5XEGrSCo
         UtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yK+PvOliLTKwct9uq94Xea/UJAz5DFGe9rEcRF1Cz2o=;
        b=GQq5PDJLxPAsfv6/6SYRpkcXcLZjdknuKS11kywsU9DqQWWuLOKqVNCQq0pMWNKzey
         mUiWAupgbbpI7rBRS0o1Dg3Z4RNGRljSJYv2QiStTVxGk+gwSMpWOJ76Lkr0seNvDTXY
         QPui2StiaZPNIihIqsKirucHfJnrDJK4TCgT7BUGeOugsFdpQbgH5e5jtGXiaBza8VoD
         0VRFqfLdRp01Zri3sw2ipszJ/ETNGDuv/3+4BfPOz/vWou9nwROVItzgj7mTm2B0VjwC
         ditu/IYiFinlyjRSiULGjzW4eswlUmdOqhQGyIV1MDRi2BZbO+I+9zKxAUdhfgCx5P1e
         MMyw==
X-Gm-Message-State: AGRZ1gKEA3FLbz4w/8ecw3dYfnZarHhNyCn5+d7sDegZ4q32hGJlPn9I
        D/4FxHumvfRg4MC/2aIs62drWMK92SK559LmX6t2Z+QyasE=
X-Google-Smtp-Source: AJdET5c+lnwm41xbVakauXRwjl4hJv+H+Ure+rVNvtiVGdrmoc++K7ba9dY6KmyqdSrytp0YpI8B8tuOe50XOzyal7g=
X-Received: by 2002:a1f:a04b:: with SMTP id j72mr6399556vke.51.1541925058223;
 Sun, 11 Nov 2018 00:30:58 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Sun, 11 Nov 2018 00:30:57
 -0800 (PST)
In-Reply-To: <20181111080945.GA78191@google.com>
References: <CAG48ez0kQ4d566bXTFOYANDgii-stL-Qj-oyaBzvfxdV=PU-7g@mail.gmail.com>
 <20181110032005.GA22238@google.com> <69CE06CC-E47C-4992-848A-66EB23EE6C74@amacapital.net>
 <20181110182405.GB242356@google.com> <CAKOZuesQXRtthJTEr86LByH3gPpAdT-PQM0d1jqr131=zZNRKw@mail.gmail.com>
 <CAKOZueum8MtNvJ5P=W7_pRw62TdQdCgyjCwwbG1wezNboC1cxQ@mail.gmail.com>
 <20181110220933.GB96924@google.com> <907D942E-E321-4BD7-BED7-ACD1D96A3643@amacapital.net>
 <20181111023808.GA174670@google.com> <543A5181-3A16-438E-B372-97BEC48A74F8@amacapital.net>
 <20181111080945.GA78191@google.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Sun, 11 Nov 2018 00:30:57 -0800
Message-ID: <CAKOZuethQ3eaV4uoEXiffVMc_S0hyk1FGPB3iQHHnv4NadW1UQ@mail.gmail.com>
Subject: Re: [PATCH v3 resend 1/2] mm: Add an F_SEAL_FUTURE_WRITE seal to memfd
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Jann Horn <jannh@google.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        John Reck <jreck@google.com>,
        John Stultz <john.stultz@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        Khalid Aziz <khalid.aziz@oracle.com>, Lei.Yang@windriver.com,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>, marcandre.lureau@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Hugh Dickins <hughd@google.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 12:09 AM, Joel Fernandes <joel@joelfernandes.org> w=
rote:
> On Sat, Nov 10, 2018 at 07:40:10PM -0800, Andy Lutomirski wrote:
> [...]
>> >>>>>>> I see two reasonable solutions:
>> >>>>>>>
>> >>>>>>> 1. Don=E2=80=99t fiddle with the struct file at all. Instead mak=
e the inode flag
>> >>>>>>> work by itself.
>> >>>>>>
>> >>>>>> Currently, the various VFS paths check only the struct file's f_m=
ode to deny
>> >>>>>> writes of already opened files. This would mean more checking in =
all those
>> >>>>>> paths (and modification of all those paths).
>> >>>>>>
>> >>>>>> Anyway going with that idea, we could
>> >>>>>> 1. call deny_write_access(file) from the memfd's seal path which =
decrements
>> >>>>>> the inode::i_writecount.
>> >>>>>> 2. call get_write_access(inode) in the various VFS paths in addit=
ion to
>> >>>>>> checking for FMODE_*WRITE and deny the write (incase i_writecount=
 is negative)
>> >>>>>>
>> >>>>>> That will prevent both reopens, and writes from succeeding. Howev=
er I worry a
>> >>>>>> bit about 2 not being too familiar with VFS internals, about what=
 the
>> >>>>>> consequences of doing that may be.
>> >>>>>
>> >>>>> IMHO, modifying both the inode and the struct file separately is f=
ine,
>> >>>>> since they mean different things. In regular filesystems, it's fin=
e to
>> >>>>> have a read-write open file description for a file whose inode gra=
nts
>> >>>>> write permission to nobody. Speaking of which: is fchmod enough to
>> >>>>> prevent this attack?
>> >>>>
>> >>>> Well, yes and no. fchmod does prevent reopening the file RW, but
>> >>>> anyone with permissions (owner, CAP_FOWNER) can just fchmod it back=
. A
>> >>>> seal is supposed to be irrevocable, so fchmod-as-inode-seal probabl=
y
>> >>>> isn't sufficient by itself. While it might be good enough for Andro=
id
>> >>>> (in the sense that it'll prevent RW-reopens from other security
>> >>>> contexts to which we send an open memfd file), it's still conceptua=
lly
>> >>>> ugly, IMHO. Let's go with the original approach of just tweaking th=
e
>> >>>> inode so that open-for-write is permanently blocked.
>> >>>
>> >>> Agreed with the idea of modifying both file and inode flags. I was t=
hinking
>> >>> modifying i_mode may do the trick but as you pointed it probably cou=
ld be
>> >>> reverted by chmod or some other attribute setting calls.
>> >>>
>> >>> OTOH, I don't think deny_write_access(file) can be reverted from any
>> >>> user-facing path so we could do that from the seal to prevent the fu=
ture
>> >>> opens in write mode. I'll double check and test that out tomorrow.
>> >>>
>> >>>
>> >>
>> >> This seems considerably more complicated and more fragile than needed=
. Just
>> >> add a new F_SEAL_WRITE_FUTURE.  Grep for F_SEAL_WRITE and make the _F=
UTURE
>> >> variant work exactly like it with two exceptions:
>> >>
>> >> - shmem_mmap and maybe its hugetlbfs equivalent should check for it a=
nd act
>> >> accordingly.
>> >
>> > There's more to it than that, we also need to block future writes thro=
ugh
>> > write syscall, so we have to hook into the write path too once the sea=
l is
>> > set, not just the mmap. That means we have to add code in mm/shmem.c t=
o do
>> > that in all those handlers, to check for the seal (and hope we didn't =
miss a
>> > file_operations handler). Is that what you are proposing?
>>
>> The existing code already does this. That=E2=80=99s why I suggested grep=
ping :)
>>
>> >
>> > Also, it means we have to keep CONFIG_TMPFS enabled so that the
>> > shmem_file_operations write handlers like write_iter are hooked up. Cu=
rrently
>> > memfd works even with !CONFIG_TMPFS.
>>
>> If so, that sounds like it may already be a bug.

Why shouldn't memfd work independently of CONFIG_TMPFS? In particular,
write(2) on tmpfs FDs shouldn't work differently. If it does, that's a
kernel implementation detail leaking out into userspace.

>> >> - add_seals won=E2=80=99t need the wait_for_pins and mapping_deny_wri=
te logic.
>> >>
>> >> That really should be all that=E2=80=99s needed.
>> >
>> > It seems a fair idea what you're saying. But I don't see how its less
>> > complex.. IMO its far more simple to have VFS do the denial of the ope=
rations
>> > based on the flags of its datastructures.. and if it works (which I wi=
ll test
>> > to be sure it will), then we should be good.
>>
>> I agree it=E2=80=99s complicated, but the code is already written.  You =
should just
>> need to adjust some masks.
>>
>
> Its actually not that bad and a great idea, I did something like the
> following and it works pretty well. I would say its cleaner than the old
> approach for sure (and I also added a /proc/pid/fd/N reopen test to the
> selftest and made sure that issue goes away).
>
> Side note: One subtelty I discovered from the existing selftests is once =
the
> F_SEAL_WRITE are active, an mmap of PROT_READ and MAP_SHARED region is
> expected to fail. This is also evident from this code in mmap_region:
>                 if (vm_flags & VM_SHARED) {
>                         error =3D mapping_map_writable(file->f_mapping);
>                         if (error)
>                                 goto allow_write_and_free_vma;
>                 }
>

This behavior seems like a bug. Why should MAP_SHARED writes be denied
here? There's no semantic incompatibility between shared mappings and
the seal. And I think this change would represent an ABI break using
memfd seals for ashmem, since ashmem currently allows MAP_SHARED
mappings after changing prot_mask.

> ---8<-----------------------
>
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> Subject: [PATCH] mm/memfd: implement future write seal using shmem ops
>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  fs/hugetlbfs/inode.c |  2 +-
>  mm/memfd.c           | 19 -------------------
>  mm/shmem.c           | 13 ++++++++++---
>  3 files changed, 11 insertions(+), 23 deletions(-)
>
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 32920a10100e..1978581abfdf 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -530,7 +530,7 @@ static long hugetlbfs_punch_hole(struct inode *inode,=
 loff_t offset, loff_t len)
>                 inode_lock(inode);
>
>                 /* protected by i_mutex */
> -               if (info->seals & F_SEAL_WRITE) {
> +               if (info->seals & (F_SEAL_WRITE | F_SEAL_FUTURE_WRITE)) {
>                         inode_unlock(inode);
>                         return -EPERM;
>                 }

Maybe we can always set F_SEAL_FUTURE_WRITE when F_SEAL_WRITE so we
can just test one bit except where the F_SEAL_WRITE behavior differs
from F_SEAL_FUTURE_WRITE.
