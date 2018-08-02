Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A5DC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 18:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B265421564
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 18:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MwJe+2C8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B265421564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387874AbeHBUZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 16:25:25 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:35549 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387512AbeHBUZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 16:25:24 -0400
Received: by mail-it0-f44.google.com with SMTP id q20-v6so4882111ith.0;
        Thu, 02 Aug 2018 11:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qpMOWRt7le5biLh1CHAb4XmKD2c1UF2xEbHu3Kryc0o=;
        b=MwJe+2C8SptE6g48pPjg/faV3cum+Wqbggs4vox3Y7/MZcTWx/XPR69P7VzhWleL6Y
         HsQqPsMDEZeZAiGJ2Y3iMv7Q7YApNEp9NCtoxptrotwnfCnaUtjuGLEUxo9aADcYOBDJ
         +P/5HqGq9cj9ilXjdCsLOlFpqmXaY6ZeaLdpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qpMOWRt7le5biLh1CHAb4XmKD2c1UF2xEbHu3Kryc0o=;
        b=sAcla8G+/zhpf9HiYodionQCnrKbR6Kr4ccoXWwxZpNGOkqbExR90mrhsP9rAJEPo0
         Iqb5512ejjDkfeWv1r6MxnzvfgJZmPx5uGbCHmkKlGxwOyJxBsJ4YUWqufrXsLT4oHox
         BwLTmAI6YM04BcHOIphIjUe2MTHPpfd386wiAH3Z9gvRyDlFj+hklXZQRO5LbbbOyX84
         mdZ9Fo2L4hhkgEjUW+/sOUDqOCzjYow5/3T7OynpKb02TIw6IR2VE9YUWrApnZfqE4oL
         N32MCGKtWTB7ZC/Jtt58eEKSPUWosrqQDIMMGZPg5wk2ZXPtxEb3X9unVLsiHsrdr5Tq
         tIkQ==
X-Gm-Message-State: AOUpUlHeheuSbrz+fRlwpBaTAQ0KUf8C17oImdD1Rsfp5AJ/1346JUTw
        8ETL83s7M+/xgOMsNnTW6tm9AdF6Gv5+LA6nUSM=
X-Google-Smtp-Source: AAOMgpdrFYuU8IOqy9ZCS3XLVL74RdY7iuTBG3Wt7UbvKlIaqkx/KElkBTZgijol7KFEiHCXuo6C5vViP+N83Tf17k0=
X-Received: by 2002:a24:94f:: with SMTP id 76-v6mr3619805itm.113.1533234785792;
 Thu, 02 Aug 2018 11:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <226835ba-2197-b850-6e5b-8ba14f7fd016@torlan.ru>
 <CAOi1vP_tYG77e71CdDiOcszSSEWrp9Vfi+KB7yFAXVQChkjP5A@mail.gmail.com>
 <93bff248-6897-4867-841b-2dace11597de@torlan.ru> <CA+55aFyAox9BTDpRsqLXiROhHOX60aa45LEZ7Azteaumdu11Fw@mail.gmail.com>
 <CAOi1vP-SJO4AMK=XD3Lmja++2dQqoiw6Zn8Vgxf8OfvYgnuC6Q@mail.gmail.com>
In-Reply-To: <CAOi1vP-SJO4AMK=XD3Lmja++2dQqoiw6Zn8Vgxf8OfvYgnuC6Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Aug 2018 11:32:54 -0700
Message-ID: <CA+55aFy2DR9fxHhmGq+azSjX9D71YtLsuFKmoEuYW3uTAUYtJg@mail.gmail.com>
Subject: Re: LVM snapshot broke between 4.14 and 4.16
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     wgh@torlan.ru, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 2, 2018 at 11:18 AM Ilya Dryomov <idryomov@gmail.com> wrote:
>
> I think it was my commit 721c7fc701c7 ("block: fail op_is_write()
> requests to read-only partitions").  The block layer was previously
> allowing non-blkdev_write_iter() writes to read-only disks and
> partitions.  dm's chunk_io() boils down to submit_bio(), so in 4.16
> it started to fail if the underlying device was marked read-only.

Ugh. That commit does look like the obviously right thing to do, and
our old behavior was obviously wrong.

At the same time, we really really shouldn't break user flow, even if
that flow was due to an obvious bug.

Dang.

> Apparently at least some versions of lvm(8) instruct dm to mark the COW
> device read-only even though it is always written to.  It comes up only
> if the user asks for a read-only snapshot (the default is writable).
>
> One option might be to ignore the supplied DM_READONLY_FLAG for COW
> devices.  Marking the COW device (i.e. the exception store) read-only
> is probably never sane...

That sounds like possibly the sanest fixlet for this - perhaps
together with a warning message saying "ignoring DM_READONLY_FLAG for
COW device" so that people see that they are doing insane things.

But some of our internal DM_READONLY_FLAG use obviously comes from
other sources that we have to honor (ie some grepping shows me code
like

                if (get_disk_ro(disk))
                        param->flags |= DM_READONLY_FLAG;

where we obviously can *not* override the get_disk_ro() state. So it
depends a lot on how this all happened. But it looks like in this
particular case, it all came from one inconsistent lvmcreate command.

Or - if there really is only _one_ user that noticed this, and a new
lvm2 release fixes his problem, maybe we can say "we broke it, but the
only person who reported it can work around it".

WGH (sorry, no idea what your real name is) - what's the source of the
script that broke? Was it some system script you got from outside and
likely to affect others too?

Or was it just some local thing you wrote yourself and was
unintentionally buggy and nobody else is likely to hit this?

Because if the latter, if you can work around it and you're the only
user this hits, we might just be able to ignore it.

                   Linus
