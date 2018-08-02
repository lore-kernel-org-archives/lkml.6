Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E241EC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 18:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 970CD21566
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 18:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2xUv1Rh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 970CD21566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732494AbeHBULM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 16:11:12 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:52700 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbeHBULL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 16:11:11 -0400
Received: by mail-it0-f67.google.com with SMTP id d9-v6so4889039itf.2;
        Thu, 02 Aug 2018 11:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PQhzsLQokyanw3VY71M9pyBKOUWZ1iBB2Il3h/g6KKQ=;
        b=C2xUv1Rh6qMTXdnUCCVgLhkoLlNw94sno0ahbSCa8HJkDG2pjvDIiIIROeyaqyYm0X
         tl/LjhgWWBC1e9Ln0UbDVKEllZhdJMQ1UMMWt73TTfPEVRlp1UE6PIVfDpP0uJu8YWIl
         uif4WILm5PVjs0gO7We53QL9SzR87Gtfyz2QxPu+iwXPwuwyvjeSv7yqer0+tihXttRm
         YaXZrfbOrk+GW6JyfEDAE/Z2s609OESWzTY7VnPQuy+qZJmhIMY+9K9WnJ/OzWB5qbLE
         OW3OqoGFvXyricV6pKb6kSQ6YDqkqN1x8HEqlVvkJG9soeBzMcjHVDMrKY4+RCOGYLkN
         ijTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PQhzsLQokyanw3VY71M9pyBKOUWZ1iBB2Il3h/g6KKQ=;
        b=JLV5tith0vk5qry5DTzEgBso1gMkDOfkPcb+H1im0tUhgh9RJhfqn7OPACF13N37d8
         wuzkOip127AglM+E93qHW0QX7WGZuXQnZCM/lsPZ8Z1Y++cjrn4aJ/Vw0a4eQnFtyIJQ
         y6CgI0MgnUBP+NpyXDOMzibp11jD+YZ7OlvF+a4gpu4B6yOMjOla/XZfPnpQhx/HiN4I
         ZHGKq8jNGCRYy/kvtmFzkM1v9X+9STeyWIGcny2r93bg7A4mkR8RIhHAiztEjL2458c/
         xte/Qft/lW4HvjXL/3lvyIy4mwyuVqrzSIRnplzhwAsPYWpam9ugpOoSGpAfH9YRx/R1
         50Ug==
X-Gm-Message-State: AOUpUlGw4AuBx9x8SBQr1uWdKfrKXt17Uz9kM7wKPXbrdGN/5v2uxDmf
        Fz6u3jeMehff/UxZyXTvEQ0rlRP2LJG1h/+6Zwk=
X-Google-Smtp-Source: AAOMgpciJyBAFyJ37sPyZ5dV4uTD3aj/LtH20nGMDvazy0z+s52EzsyUvCiu3YbTgwiMA54gmgVVaq+yQh6QEZOX3wo=
X-Received: by 2002:a24:68c2:: with SMTP id v185-v6mr3738815itb.128.1533233936128;
 Thu, 02 Aug 2018 11:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <226835ba-2197-b850-6e5b-8ba14f7fd016@torlan.ru>
 <CAOi1vP_tYG77e71CdDiOcszSSEWrp9Vfi+KB7yFAXVQChkjP5A@mail.gmail.com>
 <93bff248-6897-4867-841b-2dace11597de@torlan.ru> <CA+55aFyAox9BTDpRsqLXiROhHOX60aa45LEZ7Azteaumdu11Fw@mail.gmail.com>
In-Reply-To: <CA+55aFyAox9BTDpRsqLXiROhHOX60aa45LEZ7Azteaumdu11Fw@mail.gmail.com>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Thu, 2 Aug 2018 20:18:44 +0200
Message-ID: <CAOi1vP-SJO4AMK=XD3Lmja++2dQqoiw6Zn8Vgxf8OfvYgnuC6Q@mail.gmail.com>
Subject: Re: LVM snapshot broke between 4.14 and 4.16
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     wgh@torlan.ru, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 2, 2018 at 6:41 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Aug 2, 2018 at 8:16 AM WGH <wgh@torlan.ru> wrote:
> >
> > On 08/02/2018 04:31 PM, Ilya Dryomov wrote:
> > >
> > > From a quick look, --permission r sets DM_READONLY_FLAG, which makes dm
> > > mark the disk read-only with set_disk_ro(dm_disk(md), 1) in do_resume().
> > > A bit later it tries to write to the disk from write_header():
> > >
> > >   return chunk_io(ps, ps->header_area, 0, REQ_OP_WRITE, 0, 1);
> > >
> > > Thanks,
> > >
> > >                 Ilya
> >
> > After further investigation, this was fixed on lvm2 side (userspace) in
> > https://sourceware.org/git/?p=lvm2.git;a=commit;h=a6fdb9d9d70f51c49ad11a87ab4243344e6701a3
> > (snapshot: keep COW writable for read-only volumes).
> >
> > So I guess that's it. Time to poke my distribution package maintainers
> > to bump the package version.
>
> That is *not* how kernel development is supposed to work. If your
> script used to work, it should continue to work.
>
> Why did it use to work despite that read-only flag? And what was it
> that actually broke this?

I think it was my commit 721c7fc701c7 ("block: fail op_is_write()
requests to read-only partitions").  The block layer was previously
allowing non-blkdev_write_iter() writes to read-only disks and
partitions.  dm's chunk_io() boils down to submit_bio(), so in 4.16
it started to fail if the underlying device was marked read-only.

>
> We remain bug-for-bug compatible with older kernel versions when
> people depend on the bugs. Unless the old bugs are security issues,
> and even then we try to make it _look_ like we work the same way.
>
> Or was it a user-space lvm tool that broke in the first place, and the
> kernel release update was a red herring?

Apparently at least some versions of lvm(8) instruct dm to mark the COW
device read-only even though it is always written to.  It comes up only
if the user asks for a read-only snapshot (the default is writable).

One option might be to ignore the supplied DM_READONLY_FLAG for COW
devices.  Marking the COW device (i.e. the exception store) read-only
is probably never sane...

Thanks,

                Ilya
