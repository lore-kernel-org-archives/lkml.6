Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA34FC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 10:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73734214E0
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 10:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRYwZKUL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73734214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbeKKUmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 15:42:13 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:32870 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbeKKUmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 15:42:13 -0500
Received: by mail-wm1-f66.google.com with SMTP id f19-v6so6811991wmb.0;
        Sun, 11 Nov 2018 02:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HWUNH/MqxAP5HbUo/QpN1R6G6mfVls8zZ2HHTBQLKYI=;
        b=KRYwZKULaOgjJeo9lg926+pfbqdCydm3Vn+OXNs1a0ekEx5bAhmpiZnXoJXU6kk6O6
         lvMULzynscFJgPq2RyfRys8PnRsFUENLWFJUhc0TnvH+qKCdbvD61QGhRoLHocOL0PhD
         2H4AjvaWEJamavyjzauf64RNnTQwWZZY53cfumzE9oIQTC2Ekvleh9/D7LRg8Mk/h5zY
         jL4jBQLahGU028qIogtBAe2VI0AM7JKvMBVvJ8GfkOI1Xo8QBHUMn7PpC0HNAAfCKG/g
         k3jTMbvUQGEQTKikiI7n0AyajeHne5wFH417gGL1otHP0f2qTbNULLJGTrSqHo8Rqbmk
         x6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HWUNH/MqxAP5HbUo/QpN1R6G6mfVls8zZ2HHTBQLKYI=;
        b=O/ILsF64r0GXc9gFqwKZGW1Xe1m0bZVipLYOaSgCPU6AlmOdYOJqCucLcQqi8Jdpua
         Yt1Z9gD77bWvjBL0eIN5iQJ8JEmunxLw5luv/J3S9UpkIVyQINwOdlgiY/NED/vCcKoO
         NEXcZH28FVldSOmPn0b043Zk1wmWL4PPcEc+LvGNzp8/qOGGIqLVeeggOdTpAMAA+vYj
         Eorky0tjjAtc774JrbbcZDm6K8RneYCDsCOG4ny1+RX0nzSPIS9NxZKribNKGwrWR/Ea
         25OZUy5OyQmHew5nMEMLrjvXqUqSvzjuvH2+/Yv2lLMgeMzt0G8NH1zMifWkOfoLGv/4
         Vp5g==
X-Gm-Message-State: AGRZ1gLt0xI3Fa/MHNMONUGJR2GcRafQrlbHB3WUA2YkvCYznLE5KZw3
        Lv4rW7Xi09Ese2PNdGwsFYk=
X-Google-Smtp-Source: AJdET5dsbR5T5DNBgXFguyghnB8z0/50CaCEcNQAIi316m1+3VzLsGsYGOePJuNRhSLtSsfVzO0sEQ==
X-Received: by 2002:a1c:f614:: with SMTP id w20-v6mr1740997wmc.136.1541933636760;
        Sun, 11 Nov 2018 02:53:56 -0800 (PST)
Received: from [10.0.20.223] (mail.jambit.com. [95.157.63.22])
        by smtp.gmail.com with ESMTPSA id x142-v6sm20542710wmd.20.2018.11.11.02.53.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Nov 2018 02:53:56 -0800 (PST)
Cc:     mtk.manpages@gmail.com, Daniel Colascione <dancol@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Florian Weimer <fweimer@redhat.com>,
        Carlos O'Donell <carlos@redhat.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>
Subject: Re: Official Linux system wrapper library?
To:     Willy Tarreau <w@1wt.eu>
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
 <bbc12da5-830e-99a7-95e3-d9da42947dc9@gmail.com>
 <20181111081725.GA30248@1wt.eu>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <3664a508-ca74-4ff0-39a6-34543194a24e@gmail.com>
Date:   Sun, 11 Nov 2018 11:53:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181111081725.GA30248@1wt.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/18 9:17 AM, Willy Tarreau wrote:
> On Sun, Nov 11, 2018 at 07:55:30AM +0100, Michael Kerrisk (man-pages) wrote:
>> [1] https://sourceware.org/bugzilla/show_bug.cgi?id=6399 is a
>>     longstanding example.
> 
> This one was a sad read and shows that applications will continue to
> suffer from glibc's prehistorical view on operating systems and will
> continue to have to define their own syscall wrappers to exploit the
> full potential of the modern operating systems they execute on. This
> reminds me when one had to write their own spinlocks and atomics many
> years ago. Seeing comments suggesting an application should open
> /proc/$PID makes me really wonder if people actually want to use slow
> and insecure applications designed this way. Bah, after all, this
> wipes quite a bit of the shame I feel every time I do something to
> bypass it :-/
> 
> The sad thing is that the energy wasted arguing in the bug above could
> have been better spent designing and implementing a generic solution
> to expose syscalls without depending on glibc's politics anymore.

I'm not sure I'd view the glibc position quite so harshly (although 
it is disappointing to me that bug 6399 remains open). I think they
are simply short of people to work on this task. There was a lengthy
period where no syscall wrappers were being added (pretty much from
2.16 to 2.24, as far as I can tell), but that has changed.

And there is an expectation in some cases from the kernel side
that glibc will provide wrappers that build on (rather than just
wrap) some syscalls. And sometimes those wrappers are non-trivial.

A converse question that one could ask is: why did a culture
evolve whereby kernel developers don't take responsibility for
working with the major libc to ensure that wrappers are added as
part of the job of adding each new system call? Yes, I know, there
are some historical reasons (and even today, IMO, they do 
themselves no favors by requiring a CLA), but glibc really is 
a different place today, compared to where it was a few years 
ago.

Cheers,

Micahel

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
