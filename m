Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F94C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 16:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 548DE2075B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 16:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TIKpueHc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 548DE2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbeKSCuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 21:50:08 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:46611 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbeKSCuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 21:50:08 -0500
Received: by mail-ua1-f65.google.com with SMTP id v24so9874815uap.13
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 08:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8BTlG+U6crX6f99a8da9qr+s5BE0MjwGdyEN+HrRM2Q=;
        b=TIKpueHc3aLoiE715+/ixJZT81uEdDOrTeL4BR2RTvve7Hm3F7uUN1JHSvyVt1lg2q
         u76LAm7zJnwuOELWHHC95rg0C9eJ7Qe4nihiOAlEO0dWTfeJihHRky3PF8+cMsZmLMJT
         /s6sG2aU9mC5spf+QaC+sg8PsyUswlLp2k5R+CRXa/FSLbPQlkd4TZzpHDDs+6OTP3vD
         e0Y4e01I8mV409oyBH819sPKvVAbBcP/vWUCJgRME1t9KeO4oK4YfD/TBZNGzhpf76KP
         1mPnnCLChrL5GXpuFTpTRu3HYGuB+EUh8ezf1UCvZIAuZxvyw1aE0AZURHtCdksJsxlw
         DW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8BTlG+U6crX6f99a8da9qr+s5BE0MjwGdyEN+HrRM2Q=;
        b=jsPCgVFMeneNrE4vjAPKznSebWHiLzNCYb6HGis4RrQg1q5IF8r+7+Z8VIBT7usNRp
         PU+tdnmqH1sPRwXGPQeA1KaoddvhnSpwVaeRUrQAc/8jzJweAt7Uvq2uymlFkKGisADB
         p+mN2QsYil6Eoe1Zl3B0fZW3J70qTSv+SssZF8Mif8ectgeWl+uGOnCYfPhHF80/dDny
         VAND5jFT6k2HSm9RVtDpg5Iarb8aKaBrdoPG3/kUrwh79wCm5IscXHoyFvCNuzGZj8k4
         m00Xn53bpVLhPp8JJpZnRoCDwksYzU9QGebo9DBLvWrJcrl9Vrffo1XlncWI8nU341aO
         wLoA==
X-Gm-Message-State: AGRZ1gLiEjRN/12fFTaejsq0cdhKPQ1rzhcCHAJvQ9kf3cUB4+4x77kH
        Gw9ht62fTNCwcHtfCW0AtJtZzP0VGHGpEbp7gqqaC6c09i5OjA==
X-Google-Smtp-Source: AJdET5eXDLBkc3w9EU4ni0uWSjlMJrWrxklRts45cnzVoVgCbg8Vvg3Zv3EckYMGEDmbkMymBHekIFy722CFPPN6N1k=
X-Received: by 2002:ab0:225a:: with SMTP id z26mr8563954uan.100.1542558564775;
 Sun, 18 Nov 2018 08:29:24 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Sun, 18 Nov 2018 08:29:24
 -0800 (PST)
In-Reply-To: <CALCETrVLP_mudJTW6EQpRr5GZ7kfuGci+QCT1uPrOVDTWcod-A@mail.gmail.com>
References: <20181118111751.6142-1-christian@brauner.io> <CAKOZuet3s0WxxPgrtrNkq8YiOWhYAiK6yEio6PKVV9J_H4_TSA@mail.gmail.com>
 <CALCETrUd2Y2MmO8Qx8aUvQDOTNiyj35Y7bctPBZe0p2i1EUiLw@mail.gmail.com>
 <CAKOZuev1JUGFWuwsKqS6rXcFMqpCHT1VAG2kwB4O=FHo6DAFiQ@mail.gmail.com> <CALCETrVLP_mudJTW6EQpRr5GZ7kfuGci+QCT1uPrOVDTWcod-A@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Sun, 18 Nov 2018 08:29:24 -0800
Message-ID: <CAKOZuetuuxW+yFnyaqS5kW6gkVMstLa8D-7SgYtrLBUQB+sgDg@mail.gmail.com>
Subject: Re: [PATCH] proc: allow killing processes via file descriptors
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Christian Brauner <christian@brauner.io>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 8:17 AM, Andy Lutomirski <luto@kernel.org> wrote:
> On Sun, Nov 18, 2018 at 7:53 AM Daniel Colascione <dancol@google.com> wrote:
>>
>> On Sun, Nov 18, 2018 at 7:38 AM, Andy Lutomirski <luto@kernel.org> wrote:
>> > I fully agree that a more comprehensive, less expensive API for
>> > managing processes would be nice.  But I also think that this patch
>> > (using the directory fd and ioctl) is better from a security
>> > perspective than using a new file in /proc.
>>
>> That's an assertion, not an argument. And I'm not opposed to an
>> operation on the directory FD, now that it's clear Linus has banned
>> "write(2)-as-a-command" APIs. I just insist that we implement the API
>> with a system call instead of a less-reliable ioctl due to the
>> inherent namespace collision issues in ioctl command names.
>
> Linus banned it because of bugs iike the ones in the patch.

Maybe: he didn't provide a reason. What's your point?

>> > I have an old patch to make proc directory fds pollable:
>> >
>> > https://lore.kernel.org/patchwork/patch/345098/
>> >
>> > That patch plus the one in this thread might make a nice addition to
>> > the kernel even if we expect something much better to come along
>> > later.
>>
>> I've always commented on that patch. You never addressed my technical
>> objections. Why are you bringing up this patch again as if that
>> discussion had never happened? To review, that patch has various race
>> conditions
>
> I don't think I ever saw that review.

https://lore.kernel.org/lkml/CAKOZuevXXqwJepmLNUtrU=f8jtdgdKAzUAnAA2+KVcWoMxMyFg@mail.gmail.com/

>> and even if it were technically correct, it'd be an abuse
>> of directory objects (in what other circumstance do we poll
>> directories?) and not logically generalizable to a model in which we
>> expose process exit status via the exit-monitoring API.
>
> I agree it's weird.  It might be better to have /proc/PID/exit_status
> and make *that* pollable.

That's exactly what my patch provides. I feel like we're rehashing the
previous discussion.
