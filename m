Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2424FC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 16:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D01E620989
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 16:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WnZAr9Db"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D01E620989
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbeKSDJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 22:09:45 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:35977 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbeKSDJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 22:09:44 -0500
Received: by mail-vk1-f196.google.com with SMTP id u62so6278229vkb.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 08:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pTu895Wo8lMil32ounV+sWiZjfzqscr+hO3y++jVKzI=;
        b=WnZAr9DbGU6RlWeOQspnEElQBUx19YoKv1HPVTWzfEKxuTulVY3N+521UjyJd2AmcH
         wpCrvdWSRXUqT9GRzXES8WZKiarzDft4BQS/2TcgaIdp5itKae6chVrAHUYJkf3XTv/d
         swZLLJeKHx5ac+Egwx6jaIa60Mjhg33KYbdnC4DExpis0+i5aMg0HxCMg+KN6WbcAGHg
         Hj7HYGlRTCTgQG3nLN37gZmB7BS1HxjxlWajJfBKduGFKykQYQghgUd3g4nKliUF4UiQ
         p8BoJgXb3/bhfko8P73lhglI9QdWSjqq1VTPsuCGMad6FJ+QAWW1q4pCozm3sOctZUCO
         Lymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pTu895Wo8lMil32ounV+sWiZjfzqscr+hO3y++jVKzI=;
        b=CP79km4PoTR/NdEs8c4Zk6/ggvSkP3jzROkdwWc6SRqUNU0s1pqS1/Mvx2QMoALVpK
         TiUHExJ00RLYMHQOPCWSzjIVG07TNPE6yFDcsrryV5kUj55S6xR1bviogwYCaYCwjaJZ
         Aac2PJ3zQCuGAw4GdUolkjyTst36qAbrQzNk3+gZj5eguDzlE8fAdGxFBoqh9mMqdxFp
         58B0fqGxCN3Q2lS4YYrrb4W2WGftZwFlPTYGzWAz0r1NHkMRv4U87aUdNqjZK92QgFeS
         +NVe38IqT+hmG4L/frf08XsE35m4hCj5zaXaRl8hVEDzIw8TI7VsButGpVerfiQFjf/n
         WwNQ==
X-Gm-Message-State: AA+aEWZslEh9BueqIDZFGNpNfFZhpEl3alIeUWauCigsihLWUJZuAUUf
        8ppQxuw7oDonp9TwAPiGYVr2UfWrTpxGOmzwu4vxrg==
X-Google-Smtp-Source: AFSGD/X4ET5a9pGyaMnBDgnGHtlcfwSQn03Ni/VrJe4hP1oidCjGYoqR256n35qIGmr9ICr8l/hgd+zhf4UZMI1614Y=
X-Received: by 2002:a1f:c4d:: with SMTP id 74mr2619490vkm.50.1542559738617;
 Sun, 18 Nov 2018 08:48:58 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Sun, 18 Nov 2018 08:48:58
 -0800 (PST)
In-Reply-To: <a7f50692-667c-4efe-a2d0-fa324eebb90b@infradead.org>
References: <20181118111751.6142-1-christian@brauner.io> <CAKOZuet3s0WxxPgrtrNkq8YiOWhYAiK6yEio6PKVV9J_H4_TSA@mail.gmail.com>
 <CALCETrUd2Y2MmO8Qx8aUvQDOTNiyj35Y7bctPBZe0p2i1EUiLw@mail.gmail.com>
 <CAKOZuev1JUGFWuwsKqS6rXcFMqpCHT1VAG2kwB4O=FHo6DAFiQ@mail.gmail.com>
 <CALCETrVLP_mudJTW6EQpRr5GZ7kfuGci+QCT1uPrOVDTWcod-A@mail.gmail.com> <a7f50692-667c-4efe-a2d0-fa324eebb90b@infradead.org>
From:   Daniel Colascione <dancol@google.com>
Date:   Sun, 18 Nov 2018 08:48:58 -0800
Message-ID: <CAKOZueutLc8d0Fe+7dNWiZKnALhTSST8+kCnOrL+OmB6coUmtA@mail.gmail.com>
Subject: Re: [PATCH] proc: allow killing processes via file descriptors
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian@brauner.io>,
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
        Kees Cook <keescook@chromium.org>,
        Jan Engelhardt <jengelh@inai.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 8:33 AM, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 11/18/18 8:17 AM, Andy Lutomirski wrote:
>> On Sun, Nov 18, 2018 at 7:53 AM Daniel Colascione <dancol@google.com> wrote:
>>>
>>> On Sun, Nov 18, 2018 at 7:38 AM, Andy Lutomirski <luto@kernel.org> wrote:
>>>> I fully agree that a more comprehensive, less expensive API for
>>>> managing processes would be nice.  But I also think that this patch
>>>> (using the directory fd and ioctl) is better from a security
>>>> perspective than using a new file in /proc.
>>>
>>> That's an assertion, not an argument. And I'm not opposed to an
>>> operation on the directory FD, now that it's clear Linus has banned
>>> "write(2)-as-a-command" APIs. I just insist that we implement the API
>>> with a system call instead of a less-reliable ioctl due to the
>>> inherent namespace collision issues in ioctl command names.
>>
>> Linus banned it because of bugs iike the ones in the patch.
>>
>>>
>>>> I have an old patch to make proc directory fds pollable:
>>>>
>>>> https://lore.kernel.org/patchwork/patch/345098/
>>>>
>>>> That patch plus the one in this thread might make a nice addition to
>>>> the kernel even if we expect something much better to come along
>>>> later.
>>>
>>> I've always commented on that patch. You never addressed my technical
>>> objections. Why are you bringing up this patch again as if that
>>> discussion had never happened? To review, that patch has various race
>>> conditions
>>
>> I don't think I ever saw that review.
>>
>>> and even if it were technically correct, it'd be an abuse
>>> of directory objects (in what other circumstance do we poll
>>> directories?) and not logically generalizable to a model in which we
>>> expose process exit status via the exit-monitoring API.
>>
>> I agree it's weird.  It might be better to have /proc/PID/exit_status
>> and make *that* pollable.
>>
>
> If there is a new exit_status file, it could even be more than
> 8 bits of exit status:
>
> See https://lore.kernel.org/lkml/alpine.LSU.2.20.1507091257010.9602@nerf40.vanv.qr/T/#u
> and http://austingroupbugs.net/view.php?id=594#c1317

First of all, as I discussed in [1], we need to first figure out *who*
should have access to the process exit information. FreeBSD appears to
make it public without disaster, and if we make exit status public, a
lot of problems just disappear.

[1] https://lore.kernel.org/lkml/CAKOZueussVwABQaC+O9fW+MZayccvttKQZfWg0hh-cZ+1ykXig@mail.gmail.com/

Providing more than eight bits of status information is a separate
discussion. I don't think it's necessary, since it breaks assumptions
people make today without really adding much in the way of new
capabilities. If we want to let processes die while leaving behind
more information, let's let them leave behind an arbitrary-sized
string or something instead of repeating the mistake of an integral
exit status, but with more bits.
