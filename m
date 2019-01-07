Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8587EC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB1B2173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HngzpRyJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbfAGRoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 12:44:03 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:47018 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfAGRoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 12:44:03 -0500
Received: by mail-lj1-f195.google.com with SMTP id v15-v6so1032315ljh.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 09:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xpV81iF96YzjLIFdv4Rq46XvKaIDPwBh72AbacI+WrQ=;
        b=HngzpRyJeVlYc9Vj3lxkJCN3EwUgHf5SbmAeRV+B26CVpPwnpSBBemKsPwHl6GyEG1
         o2Boaj4ykiM0hddsEzDlpB+OGE0RlFD5eeW6UOLABlNn0sXw8szSGhSvpaNlrmEUKRnP
         CNb4q6jGIMbLTAgLMQgKDy2++bBlFr0YYVsNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xpV81iF96YzjLIFdv4Rq46XvKaIDPwBh72AbacI+WrQ=;
        b=YXHdnL6kqUYWrbXsKMLUT/VJA967W52KCy+7cybnhRqiNfUIIg5AT7XJcMe1MLx7ws
         4Ek0hWUXd6uIVdOZ1xdTDOugqlE97Uf4ZCZC/kDsjfehkISj0+8k6i4KFFjcWYq/VRkk
         kzvcOGg6XRUSbILP1ARpdiExUEADRkV6LNl4edyltYlwViVBibrqJVAxlwQO2mn/A1qH
         RvaoaFqrb+pmv4GDPjpkLJnlAfBbdF9jyYk8HyLje/Q7kCL1fUh/URvDhU9KbDvpVU/9
         Kw4vd59nXX7VHaQz+tu9j3B8rQ1FmFu4RCRz+HDSSMNLKdiRXUO2sIWqJzqgaT04d78P
         rNyw==
X-Gm-Message-State: AA+aEWYbDRqnIE3hXI9veNiHZk2fCS08pKWOOKzdmegkIK17NQg4q8J5
        0Hcg0TGu2rNY+MoidzyID5CDi+NGIko=
X-Google-Smtp-Source: ALg8bN5CgHedYBcvUc2YSCuhxNWNvHV2F24cbfnmWBAD7Me7CUu5mTTj6MB9Okc9gmaQGoZtwsTZuA==
X-Received: by 2002:a2e:974a:: with SMTP id f10-v6mr38759907ljj.61.1546883040731;
        Mon, 07 Jan 2019 09:44:00 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id c203sm12757172lfe.95.2019.01.07.09.43.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 09:43:58 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id v1-v6so1094267ljd.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 09:43:57 -0800 (PST)
X-Received: by 2002:a2e:2416:: with SMTP id k22-v6mr11850036ljk.80.1546883037292;
 Mon, 07 Jan 2019 09:43:57 -0800 (PST)
MIME-Version: 1.0
References: <02bfc577-32a5-66be-64bf-d476b7d447d2@kernel.dk>
 <20181121063609.GA109082@gmail.com> <48e27a3a-2bb2-ff41-3512-8aeb3fd59e57@kernel.dk>
 <26eff539-7de7-784c-0c88-f1d30753299d@redhat.com> <7ea44458b90b4d41a08ba9012818d273@AcuMS.aculab.com>
 <CAHk-=wjLNuNpHRfuVTb6awstC9OOmSb3S8aP51ufep-Th4dXKw@mail.gmail.com>
 <CALCETrW=hMZLUM_nPEEgUW9x9Bmhm2LZ6ZRDiRRguxVT=-_BWA@mail.gmail.com>
 <CAHk-=wiEUVpSU-GxpKDvN9wnH2yDxkJgE7Vqh46A+fmnvhubyw@mail.gmail.com>
 <cd11d9423c8b46ecbf97753f8317c294@AcuMS.aculab.com> <64fd67993af04579b5262c270a7a4694@AcuMS.aculab.com>
 <CAHk-=wj9DA-mH8jahuEPUWxO4EgbCcPRgdOJAQD58DBtCCrHcQ@mail.gmail.com>
 <a3ebeca68de1493f876467f57575be74@AcuMS.aculab.com> <CAHk-=wiFoyd-L2f0sdyKDiBQ67b4VHjw9jO34ChYJxwqm1YhCA@mail.gmail.com>
 <dbb32dfaebee4bcb8ec3372bc7a27032@AcuMS.aculab.com>
In-Reply-To: <dbb32dfaebee4bcb8ec3372bc7a27032@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 7 Jan 2019 09:43:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg02_--Xbf9HQw0g5-0k_uY+ksbxfBHK45BKDnPjz9OXw@mail.gmail.com>
Message-ID: <CAHk-=wg02_--Xbf9HQw0g5-0k_uY+ksbxfBHK45BKDnPjz9OXw@mail.gmail.com>
Subject: Re: [PATCH] x86: only use ERMS for user copies for larger sizes
To:     David Laight <David.Laight@aculab.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        "dvlasenk@redhat.com" <dvlasenk@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
        Peter Anvin <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        "brgerst@gmail.com" <brgerst@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 7, 2019 at 1:55 AM David Laight <David.Laight@aculab.com> wrote:
>
> I needed to open-code one part because it wants to do copy_to_user()
> from a PCIe address buffer (which has to work).

It will never work for memcpy_fromio(). Any driver that thinks it will
copy from io space to user space absolutely *has* to do it by hand. No
questions, and no exceptions. Some loop like

   for (..)
      put_user(readl(iomem++), uaddr++);

because neither copy_to_user() nor memcpy_fromio() will *ever* handle
that correctly.

They might randomly happen to work on x86, but absolutely nowhere else.

               Linus
