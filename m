Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E6BC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 02:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A90218E0
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 02:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Y+Q6gOjv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbfAECiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 21:38:55 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:47002 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfAECiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 21:38:55 -0500
Received: by mail-lj1-f193.google.com with SMTP id v15-v6so33906890ljh.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 18:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7NLRTaKXeZBAHE+8yNC6vVh1WEsmDEUpOBA+cgiAy9w=;
        b=Y+Q6gOjvZxT44yW+F9FeJqgHAwoX82ssrj2BJJpusTGzRzEN0VbWOq8N3Mpv+fQ4Oz
         wLv8Hc5QieJYekxvZmH9WwymbSyETIsAYFvxwVI17dsSq8omdpxTHC2IcSlRLfummm6m
         c8+EEtfmE27rctOynQ9huKWtDD+lntjTLxxgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7NLRTaKXeZBAHE+8yNC6vVh1WEsmDEUpOBA+cgiAy9w=;
        b=HPq4ma7E4/aT+YxV2rlN0aYygZUf5gL3dxHKMxaSR7Q20H/1rvdQ7oCvEuWs19JA34
         b7MS70wLKM9NYyJHUffClA0+1o2/jVPzc+SdEgw2mixAv4aHPZeQ/n5sxdczJdusdIoe
         v7GeSMTDrqRhAVbR8xi0shcRwW7EeOqQYFT8uB5Y5F2K6MibZlYN//D3/il5YKVWjpEF
         3yWxuHlwQhk6GFRtmR7/JE4+7WfRD17OEIA71uLdqSOf9kx35XdpuoJ9/c12Z52c3saD
         0LNa8AeYW9BwloPAzArb62u76qkLsOOIkrqrWJHT99NHLzQQ2AqZJFrPYn1pm/mFD3fP
         7csg==
X-Gm-Message-State: AJcUukfMEIgU6iy9MEdK5z31xvem+cr/fkX/TYK2o5GzeN8d4rM87QaI
        d3PJsAaUt0BiSVeBZxGQUMgWuIgann0=
X-Google-Smtp-Source: ALg8bN7cLbWvpE5LnLSdJBcyInSWr1C/3P1U05yOwIUVS4O5XRwDCo+PsoQyfQ0mpDRjSKxMGJKRHg==
X-Received: by 2002:a2e:3e04:: with SMTP id l4-v6mr28820452lja.148.1546655932514;
        Fri, 04 Jan 2019 18:38:52 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id g15sm11376412lfb.1.2019.01.04.18.38.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 18:38:51 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id v5so26637773lfe.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 18:38:50 -0800 (PST)
X-Received: by 2002:a19:3fcf:: with SMTP id m198mr25534359lfa.106.1546655930238;
 Fri, 04 Jan 2019 18:38:50 -0800 (PST)
MIME-Version: 1.0
References: <02bfc577-32a5-66be-64bf-d476b7d447d2@kernel.dk>
 <20181121063609.GA109082@gmail.com> <48e27a3a-2bb2-ff41-3512-8aeb3fd59e57@kernel.dk>
 <26eff539-7de7-784c-0c88-f1d30753299d@redhat.com> <7ea44458b90b4d41a08ba9012818d273@AcuMS.aculab.com>
 <CAHk-=wjLNuNpHRfuVTb6awstC9OOmSb3S8aP51ufep-Th4dXKw@mail.gmail.com>
 <CALCETrW=hMZLUM_nPEEgUW9x9Bmhm2LZ6ZRDiRRguxVT=-_BWA@mail.gmail.com>
 <CAHk-=wiEUVpSU-GxpKDvN9wnH2yDxkJgE7Vqh46A+fmnvhubyw@mail.gmail.com>
 <cd11d9423c8b46ecbf97753f8317c294@AcuMS.aculab.com> <64fd67993af04579b5262c270a7a4694@AcuMS.aculab.com>
 <CAHk-=wj9DA-mH8jahuEPUWxO4EgbCcPRgdOJAQD58DBtCCrHcQ@mail.gmail.com> <a3ebeca68de1493f876467f57575be74@AcuMS.aculab.com>
In-Reply-To: <a3ebeca68de1493f876467f57575be74@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 4 Jan 2019 18:38:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiFoyd-L2f0sdyKDiBQ67b4VHjw9jO34ChYJxwqm1YhCA@mail.gmail.com>
Message-ID: <CAHk-=wiFoyd-L2f0sdyKDiBQ67b4VHjw9jO34ChYJxwqm1YhCA@mail.gmail.com>
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

Coming back to this old thread, because I've spent most of the day
resurrecting some of my old core x86 patches, and one of them was for
the issue David Laight complained about: horrible memcpy_toio()
performance.

Yes, I should have done this before the merge window instead of at the
end of it, but I didn't want to delay things for yet another release
just because it fell through some cracks.

Anyway, it would be lovely to hear whether memcpy_toio() now works
reasonably. I just picked our very old legacy function for this, so it
will do things in 32-bit chunks (even on x86-64), and I'm certainly
open to somebody doing something smarter, but considering that nobody
else seemed to show any interest in this at all, I just went
"whatever, good enough".

I tried to make it easy to improve on things if people want to.

The other ancient patch I resurrected was the old "use asm goto for
put_user" which I've had in a private branch for the last almost three
years.

I've tried to test this (it turns out I had completely screwed up the
32-bit case for put_user, for example), but I only have 64-bit user
space, so the i386 build ended up being just about building and
looking superficially at the code generation in a couple of places.

More testing and comments appreciated.

Now I have no ancient patches in any branches, or any known pending
issue. Except for all the pull requests that are piling up because I
didn't do them today since I was spending time on my own patches.

Oh well. There's always tomorrow.

                    Linus

On Mon, Nov 26, 2018 at 2:26 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Linus Torvalds
> > Sent: 23 November 2018 16:36
> ...
> > End result: we *used* to do this right. For the last eight years our
> > "memcpy_{to,from}io()" has been entirely broken, and apparently even
> > the people who noticed oddities like David, never reported it as
> > breakage but instead just worked around it in drivers.
>
> I've mentioned it several times...
>
> Probably no one else noticed lots of single byte transfers while
> testing a TLP monitor he was writing for an FPGA :-)
> They are far too expensive to buy, and would never be connected
> to the right system at the right time - so we (I) wrote one.
>
> Unfortunately we don't really get to see what happens when the
> link comes up (or rather doesn't come up). We only get the
> LTSSM state transitions.
>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
