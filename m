Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA85C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 559502077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLuhidC8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 559502077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbeIEMi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 08:38:56 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:39842 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbeIEMi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 08:38:56 -0400
Received: by mail-oi0-f67.google.com with SMTP id c190-v6so11966967oig.6;
        Wed, 05 Sep 2018 01:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tCjhQ5cqegcviTdmxrXwm2yrVYly1aDzHjBQabJ5/j4=;
        b=CLuhidC8x8/IpjxiYQ2JIolYBREm/pyevKTet3ON/GhZPUzqt6D3iPTU7/jRjHseox
         njtViV/9/qRMtUHrzSwftPM8Srh/D1Qb1nIJBODjZC0/b9x9VF63skm27WIl4CgvL2di
         FhzTpk7MGxVlPf2rWmOkSiMS4QDeHewBpPfRl5MoQhVdhCqF5DEtHGvF5194cVcb8R+s
         nUJOpAezKvutn52K7AzWLIVvURFR47ydIrjhl7rWnqWkxH6p1NjP0Q2bJCeSAjRknUsn
         xsm6NFrnW0Qh2xR6AAfkXLnRaOKq8vc1q6Var6M5zbtEEIz3pLriIFyX6F6GAw52s9g+
         6xXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tCjhQ5cqegcviTdmxrXwm2yrVYly1aDzHjBQabJ5/j4=;
        b=PEjHuQvqrDbGvYofnjS6zRPPIOCGNfFJmDUjBPsQI6pkxb1nz0DgqFAP6jytA4kKxG
         uAYCDv5YUX8enK2WjK4hSQFePV+3THAT771mqCIRkHHyfX/ydQx4E3hBdkLLnRVhywxc
         KWPrqCMNL7BeNZ19hOdTkA25J332y2IK14rHFiMrtxMtDWvZOc3fZFo6DjldG8FBT/X3
         NWgk8SzQOERqDBfmHLUJiaEhMvdo8siEcxXEoGM97tu2DX7dL/iWtlkd8IZwrZGW8KCn
         mysRsBcp1kp0vEu+bXkgjc2jhFB8mfy0ZRhPDY321SUIAl/7QNhz8VwoTiA95DC6wGN4
         5Eeg==
X-Gm-Message-State: APzg51BC0BJOoNlhbLyeM2L0qbMgT8SDk2vrGutyKsOs9uCJ4EKj+qH4
        7NPILAJsLBmZRne6Sm+8miRPSB7wg8qgL6RJ+7s=
X-Google-Smtp-Source: ANB0VdaGwlBEl3hnueFI7LbMiMHMjVL4EstorVyYFQU9KmDoIo87JgUO2yf0+yMjOKJ/bRn/Ennvb5fXtsfcQxjLKMM=
X-Received: by 2002:aca:494b:: with SMTP id w72-v6mr21833693oia.293.1536134994077;
 Wed, 05 Sep 2018 01:09:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAJDTihz-rFb2SGaxZsQnXGnee_2qW_ynhPe=tZ4yzQBSV_KQ1g@mail.gmail.com>
 <20180904075347.GH11854@BitWizard.nl> <CAJDTihzqn3whQ47uUOxGYk4Je4S10ehNEQCtfb=j--iCsdDqgQ@mail.gmail.com>
 <82ffc434137c2ca47a8edefbe7007f5cbecd1cca.camel@redhat.com>
 <CAJDTihw7T8WLme09W8VHCRfiALq4fxg1ZsywcSjn6hXsAw5wRw@mail.gmail.com> <cd137e88c9e882200c08c7336aa7b5a1c84a7ba3.camel@redhat.com>
In-Reply-To: <cd137e88c9e882200c08c7336aa7b5a1c84a7ba3.camel@redhat.com>
From:   =?UTF-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>
Date:   Wed, 5 Sep 2018 16:09:42 +0800
Message-ID: <CAJDTihzO0Y0ZE8em2LqT-Ac-Kga7W51Uwwb2uv9oTFhkJ8vKgA@mail.gmail.com>
Subject: Re: POSIX violation by writeback error
To:     jlayton@redhat.com
Cc:     R.E.Wolff@bitwizard.nl, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 4, 2018 at 11:44 PM Jeff Layton <jlayton@redhat.com> wrote:
>
> On Tue, 2018-09-04 at 22:56 +0800, =E7=84=A6=E6=99=93=E5=86=AC wrote:
> > On Tue, Sep 4, 2018 at 7:09 PM Jeff Layton <jlayton@redhat.com> wrote:
> > >
> > > On Tue, 2018-09-04 at 16:58 +0800, Trol wrote:
> > > > On Tue, Sep 4, 2018 at 3:53 PM Rogier Wolff <R.E.Wolff@bitwizard.nl=
> wrote:
> > > >
> > > > ...
> > > > > >
> > > > > > Jlayton's patch is simple but wonderful idea towards correct er=
ror
> > > > > > reporting. It seems one crucial thing is still here to be fixed=
. Does
> > > > > > anyone have some idea?
> > > > > >
> > > > > > The crucial thing may be that a read() after a successful
> > > > > > open()-write()-close() may return old data.
> > > > > >
> > > > > > That may happen where an async writeback error occurs after clo=
se()
> > > > > > and the inode/mapping get evicted before read().
> > > > >
> > > > > Suppose I have 1Gb of RAM. Suppose I open a file, write 0.5Gb to =
it
> > > > > and then close it. Then I repeat this 9 times.
> > > > >
> > > > > Now, when writing those files to storage fails, there is 5Gb of d=
ata
> > > > > to remember and only 1Gb of RAM.
> > > > >
> > > > > I can choose any part of that 5Gb and try to read it.
> > > > >
> > > > > Please make a suggestion about where we should store that data?
> > > >
> > > > That is certainly not possible to be done. But at least, shall we r=
eport
> > > > error on read()? Silently returning wrong data may cause further da=
mage,
> > > > such as removing wrong files since it was marked as garbage in the =
old file.
> > > >
> > >
> > > Is the data wrong though? You tried to write and then that failed.
> > > Eventually we want to be able to get at the data that's actually in t=
he
> > > file -- what is that point?
> >
> > The point is silently data corruption is dangerous. I would prefer gett=
ing an
> > error back to receive wrong data.
> >
>
> Well, _you_ might like that, but there are whole piles of applications
> that may fall over completely in this situation. Legacy usage matters
> here.
>
> > A practical and concrete example may be,
> > A disk cleaner program that first searches for garbage files that won't=
 be used
> > anymore and save the list in a file (open()-write()-close()) and wait f=
or the
> > user to confirm the list of files to be removed.  A writeback error occ=
urs
> > and the related page/inode/address_space gets evicted while the user is
> > taking a long thought about it. Finally, the user hits enter and the
> > cleaner begin
> > to open() read() the list again. But what gets removed is the old list
> > of files that
> > was generated several months ago...
> >
> > Another example may be,
> > An email editor and a busy mail sender. A well written mail to my boss =
is
> > composed by this email editor and is saved in a file (open()-write()-cl=
ose()).
> > The mail sender gets notified with the path of the mail file to queue i=
t and
> > send it later. A writeback error occurs and the related
> > page/inode/address_space gets evicted while the mail is still waiting i=
n the
> > queue of the mail sender. Finally, the mail file is open() read() by th=
e sender,
> > but what is sent is the mail to my girlfriend that was composed yesterd=
ay...
> >
> > In both cases, the files are not meant to be persisted onto the disk.
> > So, fsync()
> > is not likely to be called.
> >
>
> So at what point are you going to give up on keeping the data? The
> fundamental problem here is an open-ended commitment. We (justifiably)
> avoid those in kernel development because it might leave the system
> without a way out of a resource crunch.
>
> > >
> > > If I get an error back on a read, why should I think that it has
> > > anything at all to do with writes that previously failed? It may even
> > > have been written by a completely separate process that I had nothing=
 at
> > > all to do with.
> > >
> > > > As I can see, that is all about error reporting.
> > > >
> > > > As for suggestion, maybe the error flag of inode/mapping, or the en=
tire inode
> > > > should not be evicted if there was an error. That hopefully won't t=
ake much
> > > > memory. On extreme conditions, where too much error inode requires =
staying
> > > > in memory, maybe we should panic rather then spread the error.
> > > >
> > > > >
> > > > > In the easy case, where the data easily fits in RAM, you COULD wr=
ite a
> > > > > solution. But when the hardware fails, the SYSTEM will not be abl=
e to
> > > > > follow the posix rules.
> > > >
> > > > Nope, we are able to follow the rules. The above is one way that fo=
llows the
> > > > POSIX rules.
> > > >
> > >
> > > This is something we discussed at LSF this year.
> > >
> > > We could attempt to keep dirty data around for a little while, at lea=
st
> > > long enough to ensure that reads reflect earlier writes until the err=
ors
> > > can be scraped out by fsync. That would sort of redefine fsync from
> > > being "ensure that my writes are flushed" to "synchronize my cache wi=
th
> > > the current state of the file".
> > >
> > > The problem of course is that applications are not required to do fsy=
nc
> > > at all. At what point do we give up on it, and toss out the pages tha=
t
> > > can't be cleaned?
> > >
> > > We could allow for a tunable that does a kernel panic if writebacks f=
ail
> > > and the errors are never fetched via fsync, and we run out of memory.=
 I
> > > don't think that is something most users would want though.
> > >
> > > Another thought: maybe we could OOM kill any process that has the fil=
e
> > > open and then toss out the page data in that situation?
> > >
> > > I'm wide open to (good) ideas here.
> >
> > As I said above, silently data corruption is dangerous and maybe we rea=
lly
> > should report errors to user space even in desperate cases.
> >
> > One possible approach may be:
> >
> > - When a writeback error occurs, mark the page clean and remember the e=
rror
> > in the inode/address_space of the file.
> > I think that is what the kernel is doing currently.
> >
>
> Yes.
>
> > - If the following read() could be served by a page in memory, just ret=
urns the
> > data. If the following read() could not be served by a page in memory a=
nd the
> > inode/address_space has a writeback error mark, returns EIO.
> > If there is a writeback error on the file, and the request data could
> > not be served
> > by a page in memory, it means we are reading a (partically) corrupted
> > (out-of-data)
> > file. Receiving an EIO is expected.
> >
>
> No, an error on read is not expected there. Consider this:
>
> Suppose the backend filesystem (maybe an NFSv3 export) is really r/o,
> but was mounted r/w. An application queues up a bunch of writes that of
> course can't be written back (they get EROFS or something when they're
> flushed back to the server), but that application never calls fsync.
>
> A completely unrelated application is running as a user that can open
> the file for read, but not r/w. It then goes to open and read the file
> and then gets EIO back or maybe even EROFS.
>
> Why should that application (which did zero writes) have any reason to
> think that the error was due to prior writeback failure by a completely
> separate process? Does EROFS make sense when you're attempting to do a
> read anyway?

Well, since the reader application and the writer application are reading
a same file, they are indeed related. The reader here is expecting
to read the lasted data the writer offers, not any data available. The
reader is surely not expecting to read partially new and partially old data=
.
Right? And, that `read() should return the lasted write()` by POSIX
supports this expectation.

When we cloud provide the lasted data that is expected, we just give
them the data. If we could not, we give back an error. That is much like
we return an error when network condition is bad and only part of lasted
data could be successfully fetched.

No, EROFS makes no sense. EROFS of writeback should be converted
to EIO on read.

>
> Moreover, what is that application's remedy in this case? It just wants
> to read the file, but may not be able to even open it for write to issue
> an fsync to "clear" the error. How do we get things moving again so it
> can do what it wants?

At this point we have lost the lasted data. I don't think use fsync() as
clear_error_flag() is a good idea. The data of the file is now partially
old and partially new. The content of the file is unpredictable. Applicatio=
n
may just want to simply remove it. If the application really want this
corrupted data to restore what it could, adding a new flag to open()
named O_IGNORE_ERROR_IF_POSSIBLE maybe a good idea to
support it. O_DIRECT, O_NOATIME, O_PATH, and O_TMPFILE flags
are all Linux-specific, so, adding this flag seems acceptable.

>
> I think your suggestion would open the floodgates for local DoS attacks.
>

I don't think so. After all, the writer already has write permission. It me=
ans
clearing the file directly should be a better way to attack the reader.

> > - We refuse to evict inodes/address_spaces that is writeback error mark=
ed. If
> > the number of writeback error marked inodes reaches a limit, we shall
> > just refuse
> > to open new files (or refuse to open new files for writing) .
> > That would NOT take as much memory as retaining the pages themselves as
> > it is per file/inode rather than per byte of the file. Limiting the
> > number of writeback
> > error marked inodes is just like limiting the number of open files
> > we're currently
> > doing
> >
>
> This was one of the suggestions at LSF this year.
>
> That said, we can't just refuse to evict those inodes, as we may
> eventually need the memory. We may have to settle for prioritizing
> inodes that can be cleaned for eviction, and only evict the ones that
> can't when we have no other choice.
>
> Denying new opens is also a potentially helpful for someone wanting to
> do a local DoS attack.

Yes, I think so. I have no good idea about how to avoid it, yet. I'll
think about it.
Maybe someone else clever would give us some idea?

>
> > - Finally, after the system reboots, programs could see (partially)
> > corrupted (out-of-data) files. Since user space programs didn't mean to
> > persist these files (didn't call fsync()), that is fairly reasonable.
>
> --
> Jeff Layton <jlayton@redhat.com>
>
