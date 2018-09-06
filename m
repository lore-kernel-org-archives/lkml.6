Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D803C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AACD42077C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2641Bo4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AACD42077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbeIFMC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 08:02:56 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:45175 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbeIFMC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 08:02:56 -0400
Received: by mail-oi0-f66.google.com with SMTP id t68-v6so18650069oie.12;
        Thu, 06 Sep 2018 00:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/Tf/2CGX0blEL51ObeoETGUJTHrZnNYz0QXp0VQyr3w=;
        b=f2641Bo4UzfPnkvsB3fyWfSt0KJ/WpUH284dAEL/OrB5pw4DZBJ6vcYg0Ri+obw6QA
         nhc500vFyqCeZ2dDw17zYLYWZiMqXkBGr6gFytGpHdsELEaE2HOAJiQDAQBHc1ZZtRKP
         U68LTpNjKrPhQn8xtccDADdmZmYj66yeCy5+LwPmKgjvWL2cuQkkf1pIn2nelsgKOTlj
         RSnaE/oeKf+vJYQrttH1CB4/PEgfSJe3yFSPQRonfJokUFE05K+SfHI2vgrNNBx+4o+P
         BV189CgTuB6G2tDA4GCyixGjHdtSB7r6HOvsFEhPt3tyKD9h0EnoT3PH6b7qwLCCMhnH
         +B2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/Tf/2CGX0blEL51ObeoETGUJTHrZnNYz0QXp0VQyr3w=;
        b=sqkYB1LVlsjMeVmnnLE/pdFnwbBMlvXi/gWT1EEiHylMPrtz4ynHEJupOvwAVZWLeh
         dxuu+FYXe+0mb6TCRy/KI7w2z2PhhjeyNGNOZmoruPo7tUbkoj1NUOElCwePkD7jUqIO
         LN8rjtdjUVHctyofc0XEFXRdlDIKlKMjRUMMJk6bpWdViZHNOb0IuPe1+lNMmDOukmeB
         KdFIGDVoyA6AuYbF1UQwLxp6vduXTbYtu31bM+O3naC2Pf90fF+taW3jQ2bZLqphVzCU
         DjgQqRY6U1dQuG9ZOyFXZI9xEYk3qW9ZSS8ZwHzq2tjzmrwu4XyIi9tkGNPpLzPFyWRx
         u+bQ==
X-Gm-Message-State: APzg51DijXORfiewuFwPS/K8a5mnnZDc8OwR3Q9Z4hmU+/lzm8qh8BU4
        qS6kYYSf+Vzf/lN1PMaElUjMSGal2+3ru4wfqip+e8BX070LeJ0v
X-Google-Smtp-Source: ANB0VdbswiG89Ss1FUmEtuN7ckRvZrSC/4j3NiR3tvA8g8MXeNdeqHEyvgzSPb5xxHvVb5pjYJ0jlmbIBVP/+LpH24U=
X-Received: by 2002:aca:51d8:: with SMTP id f207-v6mr1468397oib.59.1536218930879;
 Thu, 06 Sep 2018 00:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAJDTihz-rFb2SGaxZsQnXGnee_2qW_ynhPe=tZ4yzQBSV_KQ1g@mail.gmail.com>
 <20180904075347.GH11854@BitWizard.nl> <CAJDTihzqn3whQ47uUOxGYk4Je4S10ehNEQCtfb=j--iCsdDqgQ@mail.gmail.com>
 <82ffc434137c2ca47a8edefbe7007f5cbecd1cca.camel@redhat.com>
 <CAJDTihw7T8WLme09W8VHCRfiALq4fxg1ZsywcSjn6hXsAw5wRw@mail.gmail.com>
 <cd137e88c9e882200c08c7336aa7b5a1c84a7ba3.camel@redhat.com> <CAJDTihzO0Y0ZE8em2LqT-Ac-Kga7W51Uwwb2uv9oTFhkJ8vKgA@mail.gmail.com>
In-Reply-To: <CAJDTihzO0Y0ZE8em2LqT-Ac-Kga7W51Uwwb2uv9oTFhkJ8vKgA@mail.gmail.com>
From:   =?UTF-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>
Date:   Thu, 6 Sep 2018 15:28:39 +0800
Message-ID: <CAJDTihwMGj11x+M=LPV-zSV1rKUh0UAOKAk-YN0DcSCatQiC0Q@mail.gmail.com>
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

On Wed, Sep 5, 2018 at 4:09 PM =E7=84=A6=E6=99=93=E5=86=AC <milestonejxd@gm=
ail.com> wrote:
>
> On Tue, Sep 4, 2018 at 11:44 PM Jeff Layton <jlayton@redhat.com> wrote:
> >
> > On Tue, 2018-09-04 at 22:56 +0800, =E7=84=A6=E6=99=93=E5=86=AC wrote:
> > > On Tue, Sep 4, 2018 at 7:09 PM Jeff Layton <jlayton@redhat.com> wrote=
:
> > > >
> > > > On Tue, 2018-09-04 at 16:58 +0800, Trol wrote:
> > > > > On Tue, Sep 4, 2018 at 3:53 PM Rogier Wolff <R.E.Wolff@bitwizard.=
nl> wrote:
> > > > >
> > > > > ...
> > > > > > >
> > > > > > > Jlayton's patch is simple but wonderful idea towards correct =
error
> > > > > > > reporting. It seems one crucial thing is still here to be fix=
ed. Does
> > > > > > > anyone have some idea?
> > > > > > >
> > > > > > > The crucial thing may be that a read() after a successful
> > > > > > > open()-write()-close() may return old data.
> > > > > > >
> > > > > > > That may happen where an async writeback error occurs after c=
lose()
> > > > > > > and the inode/mapping get evicted before read().
> > > > > >
> > > > > > Suppose I have 1Gb of RAM. Suppose I open a file, write 0.5Gb t=
o it
> > > > > > and then close it. Then I repeat this 9 times.
> > > > > >
> > > > > > Now, when writing those files to storage fails, there is 5Gb of=
 data
> > > > > > to remember and only 1Gb of RAM.
> > > > > >
> > > > > > I can choose any part of that 5Gb and try to read it.
> > > > > >
> > > > > > Please make a suggestion about where we should store that data?
> > > > >
> > > > > That is certainly not possible to be done. But at least, shall we=
 report
> > > > > error on read()? Silently returning wrong data may cause further =
damage,
> > > > > such as removing wrong files since it was marked as garbage in th=
e old file.
> > > > >
> > > >
> > > > Is the data wrong though? You tried to write and then that failed.
> > > > Eventually we want to be able to get at the data that's actually in=
 the
> > > > file -- what is that point?
> > >
> > > The point is silently data corruption is dangerous. I would prefer ge=
tting an
> > > error back to receive wrong data.
> > >
> >
> > Well, _you_ might like that, but there are whole piles of applications
> > that may fall over completely in this situation. Legacy usage matters
> > here.
> >
> > > A practical and concrete example may be,
> > > A disk cleaner program that first searches for garbage files that won=
't be used
> > > anymore and save the list in a file (open()-write()-close()) and wait=
 for the
> > > user to confirm the list of files to be removed.  A writeback error o=
ccurs
> > > and the related page/inode/address_space gets evicted while the user =
is
> > > taking a long thought about it. Finally, the user hits enter and the
> > > cleaner begin
> > > to open() read() the list again. But what gets removed is the old lis=
t
> > > of files that
> > > was generated several months ago...
> > >
> > > Another example may be,
> > > An email editor and a busy mail sender. A well written mail to my bos=
s is
> > > composed by this email editor and is saved in a file (open()-write()-=
close()).
> > > The mail sender gets notified with the path of the mail file to queue=
 it and
> > > send it later. A writeback error occurs and the related
> > > page/inode/address_space gets evicted while the mail is still waiting=
 in the
> > > queue of the mail sender. Finally, the mail file is open() read() by =
the sender,
> > > but what is sent is the mail to my girlfriend that was composed yeste=
rday...
> > >
> > > In both cases, the files are not meant to be persisted onto the disk.
> > > So, fsync()
> > > is not likely to be called.
> > >
> >
> > So at what point are you going to give up on keeping the data? The
> > fundamental problem here is an open-ended commitment. We (justifiably)
> > avoid those in kernel development because it might leave the system
> > without a way out of a resource crunch.
> >
> > > >
> > > > If I get an error back on a read, why should I think that it has
> > > > anything at all to do with writes that previously failed? It may ev=
en
> > > > have been written by a completely separate process that I had nothi=
ng at
> > > > all to do with.
> > > >
> > > > > As I can see, that is all about error reporting.
> > > > >
> > > > > As for suggestion, maybe the error flag of inode/mapping, or the =
entire inode
> > > > > should not be evicted if there was an error. That hopefully won't=
 take much
> > > > > memory. On extreme conditions, where too much error inode require=
s staying
> > > > > in memory, maybe we should panic rather then spread the error.
> > > > >
> > > > > >
> > > > > > In the easy case, where the data easily fits in RAM, you COULD =
write a
> > > > > > solution. But when the hardware fails, the SYSTEM will not be a=
ble to
> > > > > > follow the posix rules.
> > > > >
> > > > > Nope, we are able to follow the rules. The above is one way that =
follows the
> > > > > POSIX rules.
> > > > >
> > > >
> > > > This is something we discussed at LSF this year.
> > > >
> > > > We could attempt to keep dirty data around for a little while, at l=
east
> > > > long enough to ensure that reads reflect earlier writes until the e=
rrors
> > > > can be scraped out by fsync. That would sort of redefine fsync from
> > > > being "ensure that my writes are flushed" to "synchronize my cache =
with
> > > > the current state of the file".
> > > >
> > > > The problem of course is that applications are not required to do f=
sync
> > > > at all. At what point do we give up on it, and toss out the pages t=
hat
> > > > can't be cleaned?
> > > >
> > > > We could allow for a tunable that does a kernel panic if writebacks=
 fail
> > > > and the errors are never fetched via fsync, and we run out of memor=
y. I
> > > > don't think that is something most users would want though.
> > > >
> > > > Another thought: maybe we could OOM kill any process that has the f=
ile
> > > > open and then toss out the page data in that situation?
> > > >
> > > > I'm wide open to (good) ideas here.
> > >
> > > As I said above, silently data corruption is dangerous and maybe we r=
eally
> > > should report errors to user space even in desperate cases.
> > >
> > > One possible approach may be:
> > >
> > > - When a writeback error occurs, mark the page clean and remember the=
 error
> > > in the inode/address_space of the file.
> > > I think that is what the kernel is doing currently.
> > >
> >
> > Yes.
> >
> > > - If the following read() could be served by a page in memory, just r=
eturns the
> > > data. If the following read() could not be served by a page in memory=
 and the
> > > inode/address_space has a writeback error mark, returns EIO.
> > > If there is a writeback error on the file, and the request data could
> > > not be served
> > > by a page in memory, it means we are reading a (partically) corrupted
> > > (out-of-data)
> > > file. Receiving an EIO is expected.
> > >
> >
> > No, an error on read is not expected there. Consider this:
> >
> > Suppose the backend filesystem (maybe an NFSv3 export) is really r/o,
> > but was mounted r/w. An application queues up a bunch of writes that of
> > course can't be written back (they get EROFS or something when they're
> > flushed back to the server), but that application never calls fsync.
> >
> > A completely unrelated application is running as a user that can open
> > the file for read, but not r/w. It then goes to open and read the file
> > and then gets EIO back or maybe even EROFS.
> >
> > Why should that application (which did zero writes) have any reason to
> > think that the error was due to prior writeback failure by a completely
> > separate process? Does EROFS make sense when you're attempting to do a
> > read anyway?
>
> Well, since the reader application and the writer application are reading
> a same file, they are indeed related. The reader here is expecting
> to read the lasted data the writer offers, not any data available. The
> reader is surely not expecting to read partially new and partially old da=
ta.
> Right? And, that `read() should return the lasted write()` by POSIX
> supports this expectation.
>
> When we cloud provide the lasted data that is expected, we just give
> them the data. If we could not, we give back an error. That is much like
> we return an error when network condition is bad and only part of lasted
> data could be successfully fetched.
>
> No, EROFS makes no sense. EROFS of writeback should be converted
> to EIO on read.
>
> >
> > Moreover, what is that application's remedy in this case? It just wants
> > to read the file, but may not be able to even open it for write to issu=
e
> > an fsync to "clear" the error. How do we get things moving again so it
> > can do what it wants?
>
> At this point we have lost the lasted data. I don't think use fsync() as
> clear_error_flag() is a good idea. The data of the file is now partially
> old and partially new. The content of the file is unpredictable. Applicat=
ion
> may just want to simply remove it. If the application really want this
> corrupted data to restore what it could, adding a new flag to open()
> named O_IGNORE_ERROR_IF_POSSIBLE maybe a good idea to
> support it. O_DIRECT, O_NOATIME, O_PATH, and O_TMPFILE flags
> are all Linux-specific, so, adding this flag seems acceptable.
>
> >
> > I think your suggestion would open the floodgates for local DoS attacks=
.
> >
>
> I don't think so. After all, the writer already has write permission. It =
means
> clearing the file directly should be a better way to attack the reader.
>
> > > - We refuse to evict inodes/address_spaces that is writeback error ma=
rked. If
> > > the number of writeback error marked inodes reaches a limit, we shall
> > > just refuse
> > > to open new files (or refuse to open new files for writing) .
> > > That would NOT take as much memory as retaining the pages themselves =
as
> > > it is per file/inode rather than per byte of the file. Limiting the
> > > number of writeback
> > > error marked inodes is just like limiting the number of open files
> > > we're currently
> > > doing
> > >
> >
> > This was one of the suggestions at LSF this year.
> >
> > That said, we can't just refuse to evict those inodes, as we may
> > eventually need the memory. We may have to settle for prioritizing
> > inodes that can be cleaned for eviction, and only evict the ones that
> > can't when we have no other choice.
> >
> > Denying new opens is also a potentially helpful for someone wanting to
> > do a local DoS attack.
>
> Yes, I think so. I have no good idea about how to avoid it, yet. I'll
> think about it.
> Maybe someone else clever would give us some idea?

Well, think about how filesystems deal with file metadata. Modern journal
filesystems cache meta modifications in memory firstly. And then write the
journal of modification operations to disk. After all these tasks successfu=
lly
complete, it starts to perform real modifications to file metadata on disk.
Finally, it removes the journal. If power failure happens,  it starts again=
 from
the first operation in the journal. Thus, metadata is always consistent eve=
n
after power failure.

If EIO happens during writing the cached meta modification operations to di=
sk,
what will the journal filesystem do? It certainly couldn't drop the
cached opration
that failed to be written and go on or the filesystem will be
inconsistent, eg., an
already allocated block may be allocated again in the future.

The meta operation cache is limited in memory space, just as the
dentry/inode/address_space/error_flag cache is limited in memory space.
So, the way journal filesystems deal with EIO and limited memory space of m=
eta
operation cache applies to us dealing with EIO and limited memory space of
dentry/inode/address_space/error_flag cache with no further potential DoS
backdoor kicking in.

>
> >
> > > - Finally, after the system reboots, programs could see (partially)
> > > corrupted (out-of-data) files. Since user space programs didn't mean =
to
> > > persist these files (didn't call fsync()), that is fairly reasonable.
> >
> > --
> > Jeff Layton <jlayton@redhat.com>
> >
