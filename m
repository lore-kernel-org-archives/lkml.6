Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090B5C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 19:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B859521782
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 19:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B859521782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731969AbeHCVDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 17:03:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54680 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727953AbeHCVDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 17:03:55 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DF88C4021CC2;
        Fri,  3 Aug 2018 19:06:20 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F677100725C;
        Fri,  3 Aug 2018 19:06:18 +0000 (UTC)
Date:   Fri, 3 Aug 2018 15:06:17 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, dm-devel@redhat.com,
        Ilya Dryomov <idryomov@gmail.com>, wgh@torlan.ru,
        Zdenek Kabelac <zkabelac@redhat.com>
Subject: Re: LVM snapshot broke between 4.14 and 4.16
Message-ID: <20180803190617.GA4498@redhat.com>
References: <CA+55aFyAox9BTDpRsqLXiROhHOX60aa45LEZ7Azteaumdu11Fw@mail.gmail.com>
 <CAOi1vP-SJO4AMK=XD3Lmja++2dQqoiw6Zn8Vgxf8OfvYgnuC6Q@mail.gmail.com>
 <CA+55aFy2DR9fxHhmGq+azSjX9D71YtLsuFKmoEuYW3uTAUYtJg@mail.gmail.com>
 <d76415de-2056-c7d6-cc88-b896deaa8ead@torlan.ru>
 <1ec0a220-d5b0-1c27-e63b-c4d3f4ce9d77@torlan.ru>
 <CA+55aFyPVQ5-gA93irsaxPC9BNQxnGWrDDHPMUYai2kxKiaKWQ@mail.gmail.com>
 <20180803133102.GA3092@redhat.com>
 <20180803152034.GD32066@thunk.org>
 <20180803183932.GA3258@redhat.com>
 <CA+55aFwGGjs_imFFkEPJ4g99Kseam=4Qppv4G6Q=ZfZXdzF7Vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwGGjs_imFFkEPJ4g99Kseam=4Qppv4G6Q=ZfZXdzF7Vw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 03 Aug 2018 19:06:20 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 03 Aug 2018 19:06:20 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'msnitzer@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03 2018 at  2:57pm -0400,
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, Aug 3, 2018 at 11:39 AM Mike Snitzer <snitzer@redhat.com> wrote:
> >
> > Please stop with the overreaction and making this something it isn't.
> 
> It's not an overreaction when people get their scripts broken, and
> some developers then argue "that's not a serious bug".
> 
> Guys, this needs to be fixed.  With all the stupid and fundamentyally
> incorrect excuses, I am now no longer even willing to maintain any
> other course of action.
> 
> If you develop for the Linux kernel, you need to realize that
> "breaking user space" is simply not acceptable. And if you cannot live
> with that, then you should stop working on the kernel. Because I will
> refuse to continue to pull from you as a developer.

WTF!?

> At worst, I'll just revert the original commit entirely. I was hoping
> we'd be able to avoid that, partly because the commit looks fine, but
> partly because it also doesn't revert cleanly.
> 
> Or I'll just do something like this, since it seems like it's the lvm
> people who have the hardest time with understanding the simple rules:

I'll be your whipping boy all you like.

But you're making Zdenek's response into mine and threathening to no
longer pull from me.

Over what?

A block regression that an lvm2 developer papered over.

> diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
> index b810ea77e6b1..fcfab812e025 100644
> --- a/drivers/md/dm-ioctl.c
> +++ b/drivers/md/dm-ioctl.c
> @@ -1049,7 +1049,12 @@ static int do_resume(struct dm_ioctl *param)
>                         return PTR_ERR(old_map);
>                 }
> 
> -               if (dm_table_get_mode(new_map) & FMODE_WRITE)
> +               /*
> +                * This used to do
> +                *    dm_table_get_mode(new_map) & FMODE_WRITE
> +                * but the lvm tools got this wrong, and will
> +                * continue to write to "read-only" volumes.
> +               if (0)
>                         set_disk_ro(dm_disk(md), 0);
>                 else
>                         set_disk_ro(dm_disk(md), 1);
> 
> which seems to target the actual problem more directly.

How does that pass for a fix to this issue?

That'll unilaterally mark all dm device's readonly.
