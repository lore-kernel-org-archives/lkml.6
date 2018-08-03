Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F72C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 19:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B339A21782
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 19:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PT2vxOxn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B339A21782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731978AbeHCVHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 17:07:42 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:36576 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728246AbeHCVHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 17:07:42 -0400
Received: by mail-io0-f195.google.com with SMTP id r15-v6so5880835ioa.3;
        Fri, 03 Aug 2018 12:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nvL5FiU5YXCXcfxUfO20a3zDdWcrcNDrj4X8rTCzbZs=;
        b=PT2vxOxnkAA0cke3iM8WrP0cCya7HflOTUJwFHzUf67Cs/11M5bGPBOwCFysyVmU3B
         d7P8mXeZwHvjo6nkPyKsTKb8zcgDOZAw3RcGCVC1yRQqbhbQuFbTgDXjecSo4BJBCHZm
         ThajIF2NDRy1MR+F7JTFj5IN+eMsNr7KWgLEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nvL5FiU5YXCXcfxUfO20a3zDdWcrcNDrj4X8rTCzbZs=;
        b=GwMYJP0bvrYKo3ro3thPj+NYzOzik9rp7oM877GL35X7rZZfndq3N9boFef2K3bSXF
         9R5nWC0rAmwnGZRxyonhRx2DatpfWv5XGlYeJDJLkaaTPhaJaoYIwNPWi367x/jQSxKy
         POtk8VNPrdCqf9RWXnk/p6KYuoc1FuATjAot2pBvzOzBsmZmUY+KUOZLLs5Iki2K5xil
         mVI4NqkSCmEfkJ2gsTbF7m34fjQzv0rElCbp5Nn7cWcEPAZouGwaXSVNasgTP6VEKxng
         Ct6jZ43638FQFhW/yDeWjBBeGSfjt2UxxBz2QzKXsXpkFzo3Hel1gbnyXYEuFHx6reDE
         7+SQ==
X-Gm-Message-State: AOUpUlH8DcY3nxWFu5bDQAKHGpybKAps3kHdsyCeLIyVJNcVY/njOKnR
        Y87sCnC30p304sX9khdudOOHqO80hCEfkYcjMRw=
X-Google-Smtp-Source: AAOMgpfY5goloJYOgYbYK93LL+KAeD6moehbL+9AJQdfwd1bCp//6H0iPk2HfRgk10RAeSb+AgcFmtSvrKXkYHHNxbU=
X-Received: by 2002:a6b:fc0c:: with SMTP id r12-v6mr7580454ioh.203.1533323407671;
 Fri, 03 Aug 2018 12:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAOi1vP_tYG77e71CdDiOcszSSEWrp9Vfi+KB7yFAXVQChkjP5A@mail.gmail.com>
 <93bff248-6897-4867-841b-2dace11597de@torlan.ru> <CA+55aFyAox9BTDpRsqLXiROhHOX60aa45LEZ7Azteaumdu11Fw@mail.gmail.com>
 <CAOi1vP-SJO4AMK=XD3Lmja++2dQqoiw6Zn8Vgxf8OfvYgnuC6Q@mail.gmail.com>
 <CA+55aFy2DR9fxHhmGq+azSjX9D71YtLsuFKmoEuYW3uTAUYtJg@mail.gmail.com>
 <d76415de-2056-c7d6-cc88-b896deaa8ead@torlan.ru> <1ec0a220-d5b0-1c27-e63b-c4d3f4ce9d77@torlan.ru>
 <CA+55aFyPVQ5-gA93irsaxPC9BNQxnGWrDDHPMUYai2kxKiaKWQ@mail.gmail.com>
 <b2bbd8ec-ac5b-fa8a-d3f7-8615d87f73c3@redhat.com> <CA+55aFwWZX=CXmWDTkDGb36kf12XmTehmQjbiMPCqCRG2hi9kw@mail.gmail.com>
 <20180803185431.GB3258@redhat.com>
In-Reply-To: <20180803185431.GB3258@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Aug 2018 12:09:56 -0700
Message-ID: <CA+55aFwDEY7B6OMh5xL2wc8BRj1KkzBHggNowAjbsWfma6H5Zg@mail.gmail.com>
Subject: Re: LVM snapshot broke between 4.14 and 4.16
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Zdenek Kabelac <zkabelac@redhat.com>, wgh@torlan.ru,
        Ilya Dryomov <idryomov@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, dm-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 3, 2018 at 11:54 AM Mike Snitzer <snitzer@redhat.com> wrote:
>
>
> As I explained to Ted in my previous reply to this thread: using an lvm2
> that is of the same vintage of the kernel is generally going to provide
> a more robust user experience

You said that yes.

And it is completely irrelevant.

The fact is, if you use an older lvm2, then a newer kernel still needs
to work.  Your "more robust experience" argument has nothing
what-so-ever to do with that.

Will you get new features from newer user land tools? Sure, usually.
And entirely immaterial to a kernel regression.

Will newer user land tools hopefully fix other issues? You'd hope so,
but again - immaterial.

So why are you bringing up a complete red herring? It's entirely
immaterial to the actual issue at hand.

I would _hope_ that other projects hjave the same "no regressions"
rule that the kernel has, but I know many don't. But whatever other
projects are out there, and whatever other rules _they_ have for their
development is also entirely immaterial to the kernel.

The kernel has a simple rule: no user regressions.

Yes, we've had to break that rule very occasionally - when the
semantics are a huge honking security issue and cannot possibly be
hidden any other way, then we obviously have to break them.

So it has happened. It's happily quite rare.

But in this case, the issue is that the block layer now enforces the
read-only protection more. And it seems to be the case that the lvm
tools set the read-only flag even when they then depended on being
able to write to them, because we didn't use to.

So just judging from that description, I do suspect that "we can't
depend on the lvm read-only flag", so a patch like

 "let's not turn DM_READONLY_FLAG into actually set_disk_ro(dm_disk(md), 1)"

makes sense.

Obviously, if we can limit that more, that would be lovely.

But dammit, NOBODY gets to say "oh, you should just update user land tools".

Because when they do, I will explode. And I'm 1000% serious that I
will refuse to work with people who continue to say that or continue
to make excuses.

And user land developers should damn well know about this. The fact
that they are apparently not clued in about kernel rules is what
allowed this bug to go undiscovered and unreported for much too long.
Apparently the lvm2 user land developers *did* notice the breakage,
but instead of reporting it as a kernel bug, they worked around it.

So user land developers should actually know that if the kernel stops
working for them, they should *not* work around it. Sure, fix your
program, but let the kernel people know.

And kernel people should know that "oh, the user land people already
changed their behavior" is *not* a "I don't need to care about it".
Unless the user land fix was so long ago that nobody cares any more.

                   Linus
