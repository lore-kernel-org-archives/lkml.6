Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3362ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7685D2064D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7685D2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731138AbeGRQYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:24:40 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39083 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730902AbeGRQYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:24:40 -0400
Received: by mail-oi0-f66.google.com with SMTP id d189-v6so9656987oib.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 08:46:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GsJHLZekyrntxYLjb7/YYa4VwCpNbm3lWXvPUyMUO8U=;
        b=U2JmgtFagxnsvS7P7SWQgFb63RVFuXdq+m2b0dpo3JBq4+yn4rIY1il8+Tkt1tiWy3
         cXWuizb+vdgdxpcxzUbXRJtQ0uFKTqWooFB2Ic+HtX1hBGfsuDOwPbBAV43+LMk/fJ5F
         GW7SgtdC90y82MQrtRtSpg2z0vYfDd8s8l8iN7CmhReqaTA5zXLzlnnXdHVA+HiwXIqB
         OAoEXnhs6VZ0PbFdhAPo7rqcw56+4iocG1irO5cbSRdI6J6Bf33eiiYr+r/UvMOdO/tf
         qBrAuJJYpgKjOCU+sl+GeJs+GQE8tyZ107JNc4uJsGRb+ilnmg6vz1IYYqJRqE74uxlp
         8+WA==
X-Gm-Message-State: AOUpUlFc8k1KpyuwzQZgudfqd5CPBEJTX67/YdQv558RCgzsD4BAxWQQ
        8tIaMuSiZUy0TMdJTITIbikvz6p/+f0WHkc8G5Gx5w==
X-Google-Smtp-Source: AAOMgpdJwU7sbqiRkVHKkBvPNb82WUas6+edNLMbVEBE8ImUUB3mGajm4U916GsaURHmt2/BY1nXwwvMjgoBdPKNKW0=
X-Received: by 2002:aca:e8c9:: with SMTP id f192-v6mr7037979oih.87.1531928769582;
 Wed, 18 Jul 2018 08:46:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3407:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 08:46:09
 -0700 (PDT)
In-Reply-To: <20180718124340.GS30522@ZenIV.linux.org.uk>
References: <CA+55aFxc7M9g+jqVnMHAsK350Ty1tQ9AghuJhBug+FPA6=XQrw@mail.gmail.com>
 <20180711152555.GR30522@ZenIV.linux.org.uk> <20180711161540.GS30522@ZenIV.linux.org.uk>
 <20180712124326.GA19272@ZenIV.linux.org.uk> <CA+55aFwyOHvwV4qkmM1kRYQ+4brWbLSHaXE8GPV41u5Sj-AG4Q@mail.gmail.com>
 <20180712155337.GU30522@ZenIV.linux.org.uk> <20180718025636.GA26175@ZenIV.linux.org.uk>
 <20180718132955.2bf185b7@canb.auug.org.au> <CAOssrKf60FHqgG6pB5zOP7iV-qdHdDUODdG7SVpoNh3Pipo=6w@mail.gmail.com>
 <CAOssrKdqnsPSipweUCers6d2AgJX2aVGQUs1pd7cB79GoSJH1Q@mail.gmail.com> <20180718124340.GS30522@ZenIV.linux.org.uk>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Wed, 18 Jul 2018 17:46:09 +0200
Message-ID: <CAOssrKcS+kwK+S1aojhbW_4p8FJLPaafBDqDu89d=F14wT-0rw@mail.gmail.com>
Subject: Re: vfs / overlayfs conflict resolution for linux-next
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 2:43 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Wed, Jul 18, 2018 at 02:10:32PM +0200, Miklos Szeredi wrote:
>> On Wed, Jul 18, 2018 at 9:25 AM, Miklos Szeredi <mszeredi@redhat.com> wrote:
>> > On Wed, Jul 18, 2018 at 5:29 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>> >> Hi Al,
>> >>
>> >> On Wed, 18 Jul 2018 03:56:37 +0100 Al Viro <viro@ZenIV.linux.org.uk> wrote:
>> >>>
>> >>> ... and now it even builds.  Said that, I would really like to hear something
>> >>> from you - I can duplicate the entire overlayfs-next and merge it into
>> >>> my #for-next and ask Steven to use that instead of your tree, but I very
>> >>> much dislike going over your head like that.
>> >>>
>> >>> I realize that you'd been away for a while and probably are digging yourself
>> >>> from under the piles of mail, but it's getting late in the cycle and I want
>> >>> to get #for-next into reasonably sane shape.  Please, look through that
>> >>> thing and respond.

Pushed updated series based on your vfs.git#for-ovl branch to the
overlayfs-next tree.  There's the additional patch dealing with
nr_files accounting (will post for review shortly).  That one has a
trivial conflict with the mount series, otherwise merges cleanly with
viro/vfs.git#for-next.

I like the call_with_creds() idea.  I didn't realize that
override_creds()/revert_creds() can be quite heavyweight due to doing
(unnecessary in this case) refcounting.   Could use call_with_creds()
in overlayfs too, since we hold ref on ofs->creator_cred for the
lifetime of the filesystem.

Thanks,
Miklos
