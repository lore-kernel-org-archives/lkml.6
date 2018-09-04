Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB29C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EBF720645
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xsc7uBLF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EBF720645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbeIDTWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 15:22:24 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:45618 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbeIDTWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 15:22:23 -0400
Received: by mail-oi0-f66.google.com with SMTP id t68-v6so7204774oie.12;
        Tue, 04 Sep 2018 07:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ddi0EIaKQj8+ni8WlVV5qInqds5C2iqV5cQTsmsUFQ4=;
        b=Xsc7uBLF3MlCDeTX0J3FHPht7k1Ksk1H3OmLUYVvcw5n/i8ebECUmrYHNiGLuXElsx
         8zMVPgmU5YQXLvLRlQucWPLE37zAocNK4ULCcfq8/5wPi8CQbr7oMfKs7b6mp2X+d+Hh
         XijdhdZDhIL+0fPTIJgocLzW8lKslfUwfojzZZMMitomDoSc6rMbE3JHwGlKydWFWfJi
         uEBwRk9yg404T9Y3SWxkhga8FGba7LL1K8/tnTtWmNSsoZfw+I9orWToVXnU8UnZzLDe
         XoOp6VmE/LDZ7dxUscsVjy9BiqTDI1OQBCiL9vFyCRfOw1PknriR3o5GeSOfhIfN7yUW
         kKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ddi0EIaKQj8+ni8WlVV5qInqds5C2iqV5cQTsmsUFQ4=;
        b=Ou/r+aJmbChG+WFb+UbWLz9PU2EuMRW/i4ldwIFs9c+3/trwp5q4Olt9TVShI07Rf+
         iRKirha6Ztiz9tdQqIGf+NS8tHSBMK5dVZ8jc7VH1/DtmsPjLeNG0AA0yAqDGuukgG9r
         8XSdChho2SwsTQv7fn4Pc3MfQiPT8izdvY4vRHyfLGeZcpuNeAwAVOTuwZAWK+yCYXWZ
         BIqkr/fEhj4xvvdNFRqOlPF0DaDy//18t8V2Eav0d1BdzXeU5tWWvs69O2oxp7zmcYII
         o+qn1yG7C/B9/x6QSJj8WLDNEFi+S/p8bHWmDlYLAUHb0NoqwWZNMextMKLo8MY4eaRP
         LoxQ==
X-Gm-Message-State: APzg51DR7GULve/tMZr+5QjTIufNjc9IJv8wGwz1a46Ld/+P54gFDIjS
        dyY7Arvp6N9UQUEPRJT22SD7yMwQp0ugTnyQg9Q=
X-Google-Smtp-Source: ANB0VdagmxIRvF2pAQwgUgBYV0hqWaAiHfLLVXdBs626UKmgi9JJcTd0CkGUxj3A97vuwzYZJWu8n8mONYBdme8N2yc=
X-Received: by 2002:aca:5e42:: with SMTP id s63-v6mr23400080oib.134.1536073016403;
 Tue, 04 Sep 2018 07:56:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAJDTihz-rFb2SGaxZsQnXGnee_2qW_ynhPe=tZ4yzQBSV_KQ1g@mail.gmail.com>
 <20180904075347.GH11854@BitWizard.nl> <CAJDTihzqn3whQ47uUOxGYk4Je4S10ehNEQCtfb=j--iCsdDqgQ@mail.gmail.com>
 <82ffc434137c2ca47a8edefbe7007f5cbecd1cca.camel@redhat.com>
In-Reply-To: <82ffc434137c2ca47a8edefbe7007f5cbecd1cca.camel@redhat.com>
From:   =?UTF-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>
Date:   Tue, 4 Sep 2018 22:56:44 +0800
Message-ID: <CAJDTihw7T8WLme09W8VHCRfiALq4fxg1ZsywcSjn6hXsAw5wRw@mail.gmail.com>
Subject: Re: POSIX violation by writeback error
To:     jlayton@redhat.com
Cc:     R.E.Wolff@bitwizard.nl, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 4, 2018 at 7:09 PM Jeff Layton <jlayton@redhat.com> wrote:
>
> On Tue, 2018-09-04 at 16:58 +0800, Trol wrote:
> > On Tue, Sep 4, 2018 at 3:53 PM Rogier Wolff <R.E.Wolff@bitwizard.nl> wrote:
> >
> > ...
> > > >
> > > > Jlayton's patch is simple but wonderful idea towards correct error
> > > > reporting. It seems one crucial thing is still here to be fixed. Does
> > > > anyone have some idea?
> > > >
> > > > The crucial thing may be that a read() after a successful
> > > > open()-write()-close() may return old data.
> > > >
> > > > That may happen where an async writeback error occurs after close()
> > > > and the inode/mapping get evicted before read().
> > >
> > > Suppose I have 1Gb of RAM. Suppose I open a file, write 0.5Gb to it
> > > and then close it. Then I repeat this 9 times.
> > >
> > > Now, when writing those files to storage fails, there is 5Gb of data
> > > to remember and only 1Gb of RAM.
> > >
> > > I can choose any part of that 5Gb and try to read it.
> > >
> > > Please make a suggestion about where we should store that data?
> >
> > That is certainly not possible to be done. But at least, shall we report
> > error on read()? Silently returning wrong data may cause further damage,
> > such as removing wrong files since it was marked as garbage in the old file.
> >
>
> Is the data wrong though? You tried to write and then that failed.
> Eventually we want to be able to get at the data that's actually in the
> file -- what is that point?

The point is silently data corruption is dangerous. I would prefer getting an
error back to receive wrong data.

A practical and concrete example may be,
A disk cleaner program that first searches for garbage files that won't be used
anymore and save the list in a file (open()-write()-close()) and wait for the
user to confirm the list of files to be removed.  A writeback error occurs
and the related page/inode/address_space gets evicted while the user is
taking a long thought about it. Finally, the user hits enter and the
cleaner begin
to open() read() the list again. But what gets removed is the old list
of files that
was generated several months ago...

Another example may be,
An email editor and a busy mail sender. A well written mail to my boss is
composed by this email editor and is saved in a file (open()-write()-close()).
The mail sender gets notified with the path of the mail file to queue it and
send it later. A writeback error occurs and the related
page/inode/address_space gets evicted while the mail is still waiting in the
queue of the mail sender. Finally, the mail file is open() read() by the sender,
but what is sent is the mail to my girlfriend that was composed yesterday...

In both cases, the files are not meant to be persisted onto the disk.
So, fsync()
is not likely to be called.

>
> If I get an error back on a read, why should I think that it has
> anything at all to do with writes that previously failed? It may even
> have been written by a completely separate process that I had nothing at
> all to do with.
>
> > As I can see, that is all about error reporting.
> >
> > As for suggestion, maybe the error flag of inode/mapping, or the entire inode
> > should not be evicted if there was an error. That hopefully won't take much
> > memory. On extreme conditions, where too much error inode requires staying
> > in memory, maybe we should panic rather then spread the error.
> >
> > >
> > > In the easy case, where the data easily fits in RAM, you COULD write a
> > > solution. But when the hardware fails, the SYSTEM will not be able to
> > > follow the posix rules.
> >
> > Nope, we are able to follow the rules. The above is one way that follows the
> > POSIX rules.
> >
>
> This is something we discussed at LSF this year.
>
> We could attempt to keep dirty data around for a little while, at least
> long enough to ensure that reads reflect earlier writes until the errors
> can be scraped out by fsync. That would sort of redefine fsync from
> being "ensure that my writes are flushed" to "synchronize my cache with
> the current state of the file".
>
> The problem of course is that applications are not required to do fsync
> at all. At what point do we give up on it, and toss out the pages that
> can't be cleaned?
>
> We could allow for a tunable that does a kernel panic if writebacks fail
> and the errors are never fetched via fsync, and we run out of memory. I
> don't think that is something most users would want though.
>
> Another thought: maybe we could OOM kill any process that has the file
> open and then toss out the page data in that situation?
>
> I'm wide open to (good) ideas here.

As I said above, silently data corruption is dangerous and maybe we really
should report errors to user space even in desperate cases.

One possible approach may be:

- When a writeback error occurs, mark the page clean and remember the error
in the inode/address_space of the file.
I think that is what the kernel is doing currently.

- If the following read() could be served by a page in memory, just returns the
data. If the following read() could not be served by a page in memory and the
inode/address_space has a writeback error mark, returns EIO.
If there is a writeback error on the file, and the request data could
not be served
by a page in memory, it means we are reading a (partically) corrupted
(out-of-data)
file. Receiving an EIO is expected.

- We refuse to evict inodes/address_spaces that is writeback error marked. If
the number of writeback error marked inodes reaches a limit, we shall
just refuse
to open new files (or refuse to open new files for writing) .
That would NOT take as much memory as retaining the pages themselves as
it is per file/inode rather than per byte of the file. Limiting the
number of writeback
error marked inodes is just like limiting the number of open files
we're currently
doing

- Finally, after the system reboots, programs could see (partially)
corrupted (out-of-data) files. Since user space programs didn't mean to
persist these files (didn't call fsync()), that is fairly reasonable.


> --
> Jeff Layton <jlayton@redhat.com>
>
