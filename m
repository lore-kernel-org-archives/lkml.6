Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF87FC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 08:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6548221894
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 08:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QF++/AMr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6548221894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbeHQLg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 07:36:28 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:40502 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbeHQLg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 07:36:28 -0400
Received: by mail-wm0-f54.google.com with SMTP id y9-v6so6688501wma.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 01:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wovn9MBxuOUBfVTb6YKy7wBqfRENNLLOE/mwW6Xl3ts=;
        b=QF++/AMrUFZNB+4a/o52IHB1F8lrctVwZcXjJv9leFlTTUEWrZujblhoT4762YCgj8
         DvUM96+hDbwB/9w2Ho21Dhv8jPy5ZVrCj3ZslroMfzri6j7d70rooWcFZ7MJf3rt7Vv3
         ixc2ToftuTgGDO8X+onfJj/OSSMnwHArKs2xbqG6AZx1LZeI1KdadHzCnqXUKgDBogS7
         iP1lfqmislFQoKVJ4HnHnpgIt5KGJm15pbX9k6bIWvOZnygQY0Sz9wl5hOVkWqt4cr2c
         Ywb7gjWTbPAu8+JYw9J//1+ONe3NdVkLslXwYolshhf4BdjZ6fToki/eJtPpGfF3XN5s
         p4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wovn9MBxuOUBfVTb6YKy7wBqfRENNLLOE/mwW6Xl3ts=;
        b=FyZou/yCTK92t6iyXQRfy+zwQpu2G/tqLSuqP1AloCDhLfeNlsiu96M5l0uycTZ33L
         ai3yKH84hXwqewr/b4FOjUepC4J9x1EdH/9z8RThdN+j5axO9OI3eFMLn5yHrfBAjX5h
         3k/9DTsb/9aTCLlTW0wrcERo01eNzB1z7djMlTvyC2jiJvRLFl3b//w4Ie4FJZxIAavG
         9xoRQ8pv10RQEW2fWdAPjzLedLdC2XeA/8ropkSm0iPWnWr9T5dnVm++vhviZzvS38o0
         9hMoZ619sfJ8JCSDUSFuHsmH7Ou93+jgsGOwe8gYkC+9cfs4HASqg92M1aKlaZaC74kX
         MCdA==
X-Gm-Message-State: AOUpUlGLMNfeYdSUfL6Mq+pchM5VVHwckBJjabKv4ee9n/G/HsLUYg55
        fDsNtMYHopXcyzehc50/wNGpF24hTWRdiTZXwMI=
X-Google-Smtp-Source: AA+uWPz9gcF4hCMaScX6Q41xCqk5Z4y1pDnQl3wUjFmYtYHYcEvHltNKx9A5PkXpSCYpy9HdvXnNRhrWAoD2iSR79wY=
X-Received: by 2002:a1c:d702:: with SMTP id o2-v6mr17964938wmg.115.1534494837019;
 Fri, 17 Aug 2018 01:33:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:4302:0:0:0:0:0 with HTTP; Fri, 17 Aug 2018 01:33:55
 -0700 (PDT)
In-Reply-To: <CAFLxGvxhUyqs3_esJwBjHrTY0Ba=bPB=425hWr0rz-BySTjzoA@mail.gmail.com>
References: <CA+icZUW9Cg0G41ZSwjUBaJ+F9qCc23GGMp8aCgfNQejstKJmmQ@mail.gmail.com>
 <CAFLxGvxhUyqs3_esJwBjHrTY0Ba=bPB=425hWr0rz-BySTjzoA@mail.gmail.com>
From:   Vegard Nossum <vegard.nossum@gmail.com>
Date:   Fri, 17 Aug 2018 10:33:55 +0200
Message-ID: <CAOMGZ=G-MU7qTSeA4VFK+-nx2jFAM2fGL8WpQ6eBRvovEhaneQ@mail.gmail.com>
Subject: Re: Merge branch 'l1tf-final' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     sedat.dilek@gmail.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        x86 maintainers <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 August 2018 at 17:42, Richard Weinberger
<richard.weinberger@gmail.com> wrote:
> On Thu, Aug 16, 2018 at 2:58 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>>
>> Hi Linus,
>>
>> I am here on Linux v4.18 and tried first to merge the l1tf-final Git-branch.
>> Unfortunately, this is no more available in the tip Git-tree.
>>
>> Then I saw Linux v4.18.1 which includes all the above stuff.
>>
>> I tried to 'git cherry-pick -m 1 958f338e96f874a0d29442396d6adf9c1e17aa2d'.
>> I know the commit-id is the hash of a merge.
>> Luckily, I could get the "diff" and applied it.
>> But the history misses.
>>
>> How can I get the history and subjects of all commits in your tree to
>> cherry-pick the single commits?
>>
>> Do you happen to know another solution to get easily all L1TF commits
>> with any other tricks?
>
> That should help:
> git log --oneline
> 958f338e96f874a0d29442396d6adf9c1e17aa2d^..958f338e96f874a0d29442396d6adf9c1e17aa2d

Hey,

As a shorthand for this, you can also use just:

git log --oneline 958f338e96f87^-

The syntax was made especially so that you can see all the commits
that arrived via a merge commit without having to write the rev of the
merge twice but is otherwise exactly equivalent to "rev^..rev".

It should work from git v2.13. Just a tip :-)


Vegard
