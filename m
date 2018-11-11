Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0AFC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 15:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EBF221104
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 15:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="NfwRY4vi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EBF221104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbeKLBD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 20:03:26 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44955 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728542AbeKLBDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 20:03:25 -0500
Received: by mail-pl1-f196.google.com with SMTP id s5-v6so3075634plq.11
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 07:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6QZsoPKFqAmrSyeny5H7QaB5ybJooYmpdsGKdez/6pk=;
        b=NfwRY4vikZ47ErGaxw8/+kOTdAPZ+PY8XFBbpXjHTJVj+knpVwGkUZYQlrYfVmTd2g
         xF+50mh7y7ltyeg1KW1Cm+GMMDbhOSoCqg54w9qaxM+h+znQr3616uZWZ9+BVnThocdx
         VjfVh8aku1dYfEc9trIF5atYKsBJ+HXCoQLyG1wb9LsPxOdGx6iAz4T/6e1XLbCaRWvu
         Qk/S9Tj6LZz/ZUFRV2oRWPetctxjVQ4hOzO1+gMk6xCT6irxr3PFMtC6F1SuQmMMHaCy
         abaLIVD+Yug0WY8wpGJTC47l8LQOruFypOW2FrpTqnBJ3vLXAdQkpN/jrOH8108i+CGC
         3ylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6QZsoPKFqAmrSyeny5H7QaB5ybJooYmpdsGKdez/6pk=;
        b=EBIT617DKc+dmpXGcmgS/fTqcpzUhg+npNWbgrxxN8xhaVItbGTVsFajZa/s22eTOU
         C0yz4XkGrrMJgmsgsuUXwm+7YMDiI2W9ZY1sCUcxeCj4wMUgE7+xQVkkid3WJ0mxjlXn
         cugvyGmojp4YqF0mxvWx0lN3/EYIpDWgi7oC7Bg+dQXbp9JxZrXDfN7S98F/HVJmdwA0
         MeAomDTYRCSyDoCtwfEKpRVyEFY3KeZkDQ4USoA/XmJ9HY0/fCZcT6RqktmatDFBPn/z
         SlOz5sfpZEHWsav+1UMlHvTbI479UJwDQEDIncng4ofRa60PPJoplIvpeZ4d2Tihs1L1
         5IJA==
X-Gm-Message-State: AGRZ1gLHTb3ijAJEe6tOp1ilCal464ov8Ptbdg1ZlzVtSDy5fxpRl/W7
        VF40TzrR2uyTtALzoHPzl30GXQ==
X-Google-Smtp-Source: AJdET5ehkrIkWhcpiWoMOHr0rH6ITtbJTKWFX+cusVmO7BTJv6YSrRQ/ScCND4yu7vwEvuaPiWtNXg==
X-Received: by 2002:a17:902:784c:: with SMTP id e12-v6mr16464147pln.185.1541949276367;
        Sun, 11 Nov 2018 07:14:36 -0800 (PST)
Received: from ?IPv6:2600:1010:b064:bb40:4943:9d87:c587:e641? ([2600:1010:b064:bb40:4943:9d87:c587:e641])
        by smtp.gmail.com with ESMTPSA id g8-v6sm14362521pfh.57.2018.11.11.07.14.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Nov 2018 07:14:35 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 resend 1/2] mm: Add an F_SEAL_FUTURE_WRITE seal to memfd
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A404)
In-Reply-To: <CAKOZuethQ3eaV4uoEXiffVMc_S0hyk1FGPB3iQHHnv4NadW1UQ@mail.gmail.com>
Date:   Sun, 11 Nov 2018 07:14:33 -0800
Cc:     Joel Fernandes <joel@joelfernandes.org>,
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
Content-Transfer-Encoding: quoted-printable
Message-Id: <91E8E1AA-859A-457A-8978-3EA39CBBF075@amacapital.net>
References: <CAG48ez0kQ4d566bXTFOYANDgii-stL-Qj-oyaBzvfxdV=PU-7g@mail.gmail.com> <20181110032005.GA22238@google.com> <69CE06CC-E47C-4992-848A-66EB23EE6C74@amacapital.net> <20181110182405.GB242356@google.com> <CAKOZuesQXRtthJTEr86LByH3gPpAdT-PQM0d1jqr131=zZNRKw@mail.gmail.com> <CAKOZueum8MtNvJ5P=W7_pRw62TdQdCgyjCwwbG1wezNboC1cxQ@mail.gmail.com> <20181110220933.GB96924@google.com> <907D942E-E321-4BD7-BED7-ACD1D96A3643@amacapital.net> <20181111023808.GA174670@google.com> <543A5181-3A16-438E-B372-97BEC48A74F8@amacapital.net> <20181111080945.GA78191@google.com> <CAKOZuethQ3eaV4uoEXiffVMc_S0hyk1FGPB3iQHHnv4NadW1UQ@mail.gmail.com>
To:     Daniel Colascione <dancol@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> On Nov 11, 2018, at 12:30 AM, Daniel Colascione <dancol@google.com> wrote:=

>=20
>> On Sun, Nov 11, 2018 at 12:09 AM, Joel Fernandes <joel@joelfernandes.org>=
 wrote:
>> On Sat, Nov 10, 2018 at 07:40:10PM -0800, Andy Lutomirski wrote:
>> [...]
>>>>>>>>>> I see two reasonable solutions:
>>>>>>>>>>=20
>>>>>>>>>> 1. Don=E2=80=99t fiddle with the struct file at all. Instead make=
 the inode flag
>>>>>>>>>> work by itself.
>>>>>>>>>=20
>>>>>>>>> Currently, the various VFS paths check only the struct file's f_mo=
de to deny
>>>>>>>>> writes of already opened files. This would mean more checking in a=
ll those
>>>>>>>>> paths (and modification of all those paths).
>>>>>>>>>=20
>>>>>>>>> Anyway going with that idea, we could
>>>>>>>>> 1. call deny_write_access(file) from the memfd's seal path which d=
ecrements
>>>>>>>>> the inode::i_writecount.
>>>>>>>>> 2. call get_write_access(inode) in the various VFS paths in additi=
on to
>>>>>>>>> checking for FMODE_*WRITE and deny the write (incase i_writecount i=
s negative)
>>>>>>>>>=20
>>>>>>>>> That will prevent both reopens, and writes from succeeding. Howeve=
r I worry a
>>>>>>>>> bit about 2 not being too familiar with VFS internals, about what t=
he
>>>>>>>>> consequences of doing that may be.
>>>>>>>>=20
>>>>>>>> IMHO, modifying both the inode and the struct file separately is fi=
ne,
>>>>>>>> since they mean different things. In regular filesystems, it's fine=
 to
>>>>>>>> have a read-write open file description for a file whose inode gran=
ts
>>>>>>>> write permission to nobody. Speaking of which: is fchmod enough to
>>>>>>>> prevent this attack?
>>>>>>>=20
>>>>>>> Well, yes and no. fchmod does prevent reopening the file RW, but
>>>>>>> anyone with permissions (owner, CAP_FOWNER) can just fchmod it back.=
 A
>>>>>>> seal is supposed to be irrevocable, so fchmod-as-inode-seal probably=

>>>>>>> isn't sufficient by itself. While it might be good enough for Androi=
d
>>>>>>> (in the sense that it'll prevent RW-reopens from other security
>>>>>>> contexts to which we send an open memfd file), it's still conceptual=
ly
>>>>>>> ugly, IMHO. Let's go with the original approach of just tweaking the=

>>>>>>> inode so that open-for-write is permanently blocked.
>>>>>>=20
>>>>>> Agreed with the idea of modifying both file and inode flags. I was th=
inking
>>>>>> modifying i_mode may do the trick but as you pointed it probably coul=
d be
>>>>>> reverted by chmod or some other attribute setting calls.
>>>>>>=20
>>>>>> OTOH, I don't think deny_write_access(file) can be reverted from any
>>>>>> user-facing path so we could do that from the seal to prevent the fut=
ure
>>>>>> opens in write mode. I'll double check and test that out tomorrow.
>>>>>>=20
>>>>>>=20
>>>>>=20
>>>>> This seems considerably more complicated and more fragile than needed.=
 Just
>>>>> add a new F_SEAL_WRITE_FUTURE.  Grep for F_SEAL_WRITE and make the _FU=
TURE
>>>>> variant work exactly like it with two exceptions:
>>>>>=20
>>>>> - shmem_mmap and maybe its hugetlbfs equivalent should check for it an=
d act
>>>>> accordingly.
>>>>=20
>>>> There's more to it than that, we also need to block future writes throu=
gh
>>>> write syscall, so we have to hook into the write path too once the seal=
 is
>>>> set, not just the mmap. That means we have to add code in mm/shmem.c to=
 do
>>>> that in all those handlers, to check for the seal (and hope we didn't m=
iss a
>>>> file_operations handler). Is that what you are proposing?
>>>=20
>>> The existing code already does this. That=E2=80=99s why I suggested grep=
ping :)
>>>=20
>>>>=20
>>>> Also, it means we have to keep CONFIG_TMPFS enabled so that the
>>>> shmem_file_operations write handlers like write_iter are hooked up. Cur=
rently
>>>> memfd works even with !CONFIG_TMPFS.
>>>=20
>>> If so, that sounds like it may already be a bug.
>=20
> Why shouldn't memfd work independently of CONFIG_TMPFS? In particular,
> write(2) on tmpfs FDs shouldn't work differently. If it does, that's a
> kernel implementation detail leaking out into userspace.
>=20
>>>>> - add_seals won=E2=80=99t need the wait_for_pins and mapping_deny_writ=
e logic.
>>>>>=20
>>>>> That really should be all that=E2=80=99s needed.
>>>>=20
>>>> It seems a fair idea what you're saying. But I don't see how its less
>>>> complex.. IMO its far more simple to have VFS do the denial of the oper=
ations
>>>> based on the flags of its datastructures.. and if it works (which I wil=
l test
>>>> to be sure it will), then we should be good.
>>>=20
>>> I agree it=E2=80=99s complicated, but the code is already written.  You s=
hould just
>>> need to adjust some masks.
>>>=20
>>=20
>> Its actually not that bad and a great idea, I did something like the
>> following and it works pretty well. I would say its cleaner than the old
>> approach for sure (and I also added a /proc/pid/fd/N reopen test to the
>> selftest and made sure that issue goes away).
>>=20
>> Side note: One subtelty I discovered from the existing selftests is once t=
he
>> F_SEAL_WRITE are active, an mmap of PROT_READ and MAP_SHARED region is
>> expected to fail. This is also evident from this code in mmap_region:
>>                if (vm_flags & VM_SHARED) {
>>                        error =3D mapping_map_writable(file->f_mapping);
>>                        if (error)
>>                                goto allow_write_and_free_vma;
>>                }
>>=20
>=20
> This behavior seems like a bug. Why should MAP_SHARED writes be denied
> here? There's no semantic incompatibility between shared mappings and
> the seal. And I think this change would represent an ABI break using
> memfd seals for ashmem, since ashmem currently allows MAP_SHARED
> mappings after changing prot_mask.

Hmm. I=E2=80=99m guessing the intent is that the mmap count should track wri=
table mappings in addition to mappings that could be made writable using mpr=
otect.  I think you could address this for SEAL_FUTURE in two ways:

1. In shmem_mmap, mask off VM_MAYWRITE if SEAL_FUTURE is set, or

2. Add a new vm operation that allows a vma to reject an mprotect attempt, l=
ike security_file_mprotect but per vma.  Then give it reasonable semantics f=
or shmem.

(1) probably gives the semantics you want for SEAL_FUTURE: old maps can be m=
protected, but new maps can=E2=80=99t.

>=20
>> ---8<-----------------------
>>=20
>> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
>> Subject: [PATCH] mm/memfd: implement future write seal using shmem ops
>>=20
>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>> ---
>> fs/hugetlbfs/inode.c |  2 +-
>> mm/memfd.c           | 19 -------------------
>> mm/shmem.c           | 13 ++++++++++---
>> 3 files changed, 11 insertions(+), 23 deletions(-)
>>=20
>> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
>> index 32920a10100e..1978581abfdf 100644
>> --- a/fs/hugetlbfs/inode.c
>> +++ b/fs/hugetlbfs/inode.c
>> @@ -530,7 +530,7 @@ static long hugetlbfs_punch_hole(struct inode *inode,=
 loff_t offset, loff_t len)
>>                inode_lock(inode);
>>=20
>>                /* protected by i_mutex */
>> -               if (info->seals & F_SEAL_WRITE) {
>> +               if (info->seals & (F_SEAL_WRITE | F_SEAL_FUTURE_WRITE)) {=

>>                        inode_unlock(inode);
>>                        return -EPERM;
>>                }
>=20
> Maybe we can always set F_SEAL_FUTURE_WRITE when F_SEAL_WRITE so we
> can just test one bit except where the F_SEAL_WRITE behavior differs
> from F_SEAL_FUTURE_WRITE.

This could plausibly confuse existing users that read the seal mask.=
