Return-Path: <maco@android.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526370362; cv=none;
        d=google.com; s=arc-20160816;
        b=asGSHvPlldVy7d2s4Szb2BPTbE6MxOHduL7SPf7OKFk3Hl37oODPQJn8BRss/D8g+D
         iyDbvjdT4exe61rqApY07ZIUeVV6OxNenv6gnp+7+AsZYvdG0M9215YHD6Yp9Qq9r3BM
         vBj8QRFctoqhg442AQucC2HCTToG/yCgVGPMHd4+5eL52KCLpvHQxbTkVHP87oquB7aZ
         bIedSwhiu1sAEY88IQsj10tV6mUUXaII6FBUbkPDn9d+v7EA5MfzF2J/JvZs049aksU3
         H2TLjPjICXNOl5rkjqwXBO6nsE/k+ocq4M+b0UszlIEtxWT0lhJ+B3fySZT49LV3lHVI
         HHfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature
         :arc-authentication-results;
        bh=34IV/9TJKLpPf2RAETbIYSu4E5PE1Kwu0aOyMq9Hf6c=;
        b=mU+OUEfGR4fyUEbADjzTnmKkSsBmeQlafWGF8+vfRW70O0nx/yp0XpIttSYyZds2LX
         X+T3gYsPdwK86OrQ23rEVxzYYd53hyFUA1LwcPoB5UGfdk6U1973czlTbDqV0rV/vQ7R
         l8bbgGXSxG45DylkFu0m1rOR41YrihuaEYLTuk5KCDofp+86ZjGTNfDG3hgQaEQxstiC
         1gAcEJc/xn5igkry5muh0//6u3Yap2EY0wq0Iexg+whLSUkwKCqNqbNwqL7c1KIRw07k
         Wj4bW8DpwjT1fqRW5Gw9uKhOi0lKoReuPAPbSE1/f2VdTdjuzJed1qADlAcTOs3adXxc
         fkWQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@android.com header.s=20161025 header.b=mDMVhP3K;
       spf=pass (google.com: domain of maco@android.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=maco@android.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=android.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@android.com header.s=20161025 header.b=mDMVhP3K;
       spf=pass (google.com: domain of maco@android.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=maco@android.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=android.com
X-Google-Smtp-Source: AB8JxZqRQXfmy3bCEyRrJZa8JTn057q9U2pp+PaKl3Sne7jRaSOqokdFj9jz3BHTVrfkXvgl2Hs7NtngOU9Gur0P1rw=
MIME-Version: 1.0
In-Reply-To: <20180515062732.GA183759@rodete-desktop-imager.corp.google.com>
References: <20180507141537.4855-1-minchan@kernel.org> <20180507172829.GA66161@joelaf.mtv.corp.google.com>
 <20180508105101.GB8209@rodete-desktop-imager.corp.google.com>
 <20180508230813.GA102094@joelaf.mtv.corp.google.com> <20180509064023.GD8209@rodete-desktop-imager.corp.google.com>
 <20180509231941.GA4790@joelaf.mtv.corp.google.com> <20180515062732.GA183759@rodete-desktop-imager.corp.google.com>
From: Martijn Coenen <maco@android.com>
Date: Tue, 15 May 2018 09:46:01 +0200
Message-ID: <CAB0TPYHseQ-Lx4guzykjxY9xP2yP5Kga+oZMTmC7Bb7XXRAFFQ@mail.gmail.com>
Subject: Re: [PATCH v6] ANDROID: binder: change down_write to down_read
To: Minchan Kim <minchan.kernel@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>, LKML <linux-kernel@vger.kernel.org>,
	Ganesh Mahendran <opensource.ganesh@gmail.com>, Joe Perches <joe@perches.com>,
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
	Todd Kjos <tkjos@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599815073448562806?=
X-GMAIL-MSGID: =?utf-8?q?1600515328762444244?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 15, 2018 at 8:27 AM, Minchan Kim <minchan.kernel@gmail.com> wro=
te:
> Hi Joel,
>
> Sorry for the late response. I was off.
>
> On Wed, May 09, 2018 at 04:19:41PM -0700, Joel Fernandes wrote:
>> On Wed, May 09, 2018 at 03:40:23PM +0900, Minchan Kim wrote:
>> > On Tue, May 08, 2018 at 04:08:13PM -0700, Joel Fernandes wrote:
>> > > On Tue, May 08, 2018 at 07:51:01PM +0900, Minchan Kim wrote:
>> > > > On Mon, May 07, 2018 at 10:28:29AM -0700, Joel Fernandes wrote:
>> > > > > On Mon, May 07, 2018 at 11:15:37PM +0900, Minchan Kim wrote:
>> > > > > > binder_update_page_range needs down_write of mmap_sem because
>> > > > > > vm_insert_page need to change vma->vm_flags to VM_MIXEDMAP unl=
ess
>> > > > > > it is set. However, when I profile binder working, it seems
>> > > > > > every binder buffers should be mapped in advance by binder_mma=
p.
>> > > > > > It means we could set VM_MIXEDMAP in binder_mmap time which is
>> > > > > > already hold a mmap_sem as down_write so binder_update_page_ra=
nge
>> > > > > > doesn't need to hold a mmap_sem as down_write.
>> > > > > > Please use proper API down_read. It would help mmap_sem conten=
tion
>> > > > > > problem as well as fixing down_write abuse.
>> > > > > >
>> > > > > > Ganesh Mahendran tested app launching and binder throughput te=
st
>> > > > > > and he said he couldn't find any problem and I did binder late=
ncy
>> > > > > > test per Greg KH request(Thanks Martijn to teach me how I can =
do)
>> > > > > > I cannot find any problem, too.
>> > > > > >
>> > > > > > Cc: Ganesh Mahendran <opensource.ganesh@gmail.com>
>> > > > > > Cc: Joe Perches <joe@perches.com>
>> > > > > > Cc: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
>> > > > > > Cc: Todd Kjos <tkjos@google.com>
>> > > > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> > > > > > Reviewed-by: Martijn Coenen <maco@android.com>
>> > > > > > Signed-off-by: Minchan Kim <minchan@kernel.org>
>> > > > > > ---
>> > > > > >  drivers/android/binder.c       | 4 +++-
>> > > > > >  drivers/android/binder_alloc.c | 6 +++---
>> > > > > >  2 files changed, 6 insertions(+), 4 deletions(-)
>> > > > > >
>> > > > > > diff --git a/drivers/android/binder.c b/drivers/android/binder=
.c
>> > > > > > index 4eab5be3d00f..7b8e96f60719 100644
>> > > > > > --- a/drivers/android/binder.c
>> > > > > > +++ b/drivers/android/binder.c
>> > > > > > @@ -4730,7 +4730,9 @@ static int binder_mmap(struct file *filp=
, struct vm_area_struct *vma)
>> > > > > >             failure_string =3D "bad vm_flags";
>> > > > > >             goto err_bad_arg;
>> > > > > >     }
>> > > > > > -   vma->vm_flags =3D (vma->vm_flags | VM_DONTCOPY) & ~VM_MAYW=
RITE;
>> > > > > > +   vma->vm_flags |=3D VM_DONTCOPY | VM_MIXEDMAP;
>> > > > > > +   vma->vm_flags &=3D ~VM_MAYWRITE;
>> > > > > > +
>> > > > > >     vma->vm_ops =3D &binder_vm_ops;
>> > > > > >     vma->vm_private_data =3D proc;
>> > > > > >
>> > > > > > diff --git a/drivers/android/binder_alloc.c b/drivers/android/=
binder_alloc.c
>> > > > > > index 5a426c877dfb..4f382d51def1 100644
>> > > > > > --- a/drivers/android/binder_alloc.c
>> > > > > > +++ b/drivers/android/binder_alloc.c
>> > > > > > @@ -219,7 +219,7 @@ static int binder_update_page_range(struct=
 binder_alloc *alloc, int allocate,
>> > > > > >             mm =3D alloc->vma_vm_mm;
>> > > > > >
>> > > > > >     if (mm) {
>> > > > > > -           down_write(&mm->mmap_sem);
>> > > > > > +           down_read(&mm->mmap_sem);
>> > > > >
>> > > > >
>> > > > > Nice. Is there a need to hold the reader-lock at all here? Just =
curious what
>> > > > > else is it protecting (here or in vm_insert_page).
>> > > >
>> > > > It should protect vm_area_struct. IOW, when we try insert page int=
o virtual address area,
>> > > > vma shouldn't be changed(ie, unmap/collapse/split).
>> > >
>> > > When you say unmap, are you talking about pages being unmapped from =
the VMA
>> > > or something else?
>> >
>> > I mean to destroy vm_area_struct itself as well as unmap pages.
>> >
>> > >
>> > > For the collapse/split part, the binder VMA (vm_area_struct) itself =
isn't
>> > > changed after the initial mmap (AFAIK) so I don't see a need for pro=
tection
>> > > there.
>> >
>> > There is no way to unmap in runtime? What happens if some buggy applic=
ations
>> > do unmap by mistake?
>> > Cannot we access those B's vma from A context?
>> > If B process is exiting, the VMA would be gone while A is accessing.
>>
>> If the VMA is gone, then why is it a good idea to map pages into it anyw=
ay?
>
> Hmm, sorry about that. I couldn't understand your point.

I think Joel may have meant that if the VMA is gone (forex because the
process unmaps or dies), we shouldn't allocate pages into that VMA
anymore. I don't think we do that currently - we check if the vma is
still valid before allocating.

>
>>
>> About the unmap at runtime part, your commit message was a bit confusing=
. You
>> said "every binder buffers should be mapped in advance by binder_mmap." =
but I
>> think the new binder shrinker mechanism doesn't make that true anymore.
>
> It's good point. I didn't know know that.
> When I see binder_vm_fault, it emits SIGBUS. That means shrinker cannot z=
ap pages
> process is using, I think. IOW, every pages for binder are mapped at mmap=
 time
> and is never mapped in runtime by page fault. Right?

Right - the address range is allocated once, and an initial amount of
pages is mapped into it. For every transaction into that process, we
will see if there's enough pages, and if not allocate so that we have
enough of them - so this is not done by page fault. The shrinker won't
touch pages for which a transaction is in progress. Of course a
process itself could still try to read from an unallocated address,
but in that case returning SIGBUS and having that process crash seems
fine.

I'm also not sure the read lock is needed, but I would need to read a
whole lot more code to convince myself it's not.

>
> Thanks.
>
>>
>> The unmap by mistake point is a valid one I guess.
>>
>> thanks,
>>
>>  - Joel
>>
