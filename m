Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEDCC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 233D92086C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="a1U1+0eo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390853AbfBMS1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:27:31 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33644 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733194AbfBMS1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:27:31 -0500
Received: by mail-lf1-f65.google.com with SMTP id q12so2582099lfm.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 10:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Y+X7wTSpO2Pty7S0uson3SJIbmPRN3fq7tyVVDbT5M=;
        b=a1U1+0eotV43sDZkDq3OiOMvX/sqgVC2wI/h3dpFRCO4wSFwee6pL3nLht1Cy6uJ9M
         ZR2qZobLtqHaTnRrx495d69SocPFCzyWr2F1AuxY0QjuzYqKN3CP7CIHSSk8hqDuMjhc
         9WuQPM2GMZ896CD4CNrZ+u+X/x1xRX9d/ssZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Y+X7wTSpO2Pty7S0uson3SJIbmPRN3fq7tyVVDbT5M=;
        b=rzxUKXtbgkEJ5qqxQCa0jCvXptCYU+1/I5N7G3yHtLKYhjLA5/5FJTjkgoEDMbjfeT
         9mMhxoRAffOxxHOsPKAMkIsiLbUxmtIV7G035rz5AZhrdPWC8lKwf63PHWkoeD+2X+/7
         hxUfMQRqgK1xGontY79jotznwqzDDYx7/4NQ8lBMmz8X9hxbFK5kkRbQFMAn9DqhGnED
         K+s3SkNOmhZOxgPsssviVarA2dSxLM79cf0NG5/Cg5eA9FDYpB860ztegxg3voV9uEu5
         K7P9Tr38quGW8PsmfnPfZuLkPkjhvIJDG94or7dnkZ8NzuQ9heVtP283fXPbkBWdaLBb
         R11A==
X-Gm-Message-State: AHQUAuaSDKeFLIG8Ok5Kl9ABQbVQCKcUoazT4H1DngPKW74Qat3LBkfL
        g/kdfRpdW8cNbzTeK8z155iw51ky9/8=
X-Google-Smtp-Source: AHgI3IYjdpMzMMINRkD59j/mnLeXe3fJT3SiRh6oqfeFjuA7FPqtfD+emDhCTSupCMai5muhlfY3fA==
X-Received: by 2002:ac2:4243:: with SMTP id m3mr1119086lfl.5.1550082448729;
        Wed, 13 Feb 2019 10:27:28 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id i127-v6sm3574315lji.67.2019.02.13.10.27.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 10:27:27 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id g2so2524500lfh.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 10:27:26 -0800 (PST)
X-Received: by 2002:a19:ae0a:: with SMTP id f10mr1110009lfc.1.1550082446110;
 Wed, 13 Feb 2019 10:27:26 -0800 (PST)
MIME-Version: 1.0
References: <20190211172948.3322-1-will.deacon@arm.com> <CAHk-=wiP42aqBApAUJbLAB43u5ips9ArgLxXn5L1r74bowxdow@mail.gmail.com>
 <20190213172047.GH6346@brain-police>
In-Reply-To: <20190213172047.GH6346@brain-police>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 Feb 2019 10:27:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wigYDMPnoFRC9eBystt0gi6n1yQtAyuEqVg6x+5znOk6A@mail.gmail.com>
Message-ID: <CAHk-=wigYDMPnoFRC9eBystt0gi6n1yQtAyuEqVg6x+5znOk6A@mail.gmail.com>
Subject: Re: [RFC PATCH] docs/memory-barriers.txt: Rewrite "KERNEL I/O BARRIER
 EFFECTS" section
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 9:20 AM Will Deacon <will.deacon@arm.com> wrote:
>
> On Mon, Feb 11, 2019 at 02:34:31PM -0800, Linus Torvalds wrote:
> >
> > IOW, we should seriously just consider making the rule be that locking
> > will order mmio too. Because that's practically the rule anyway.
>
> I would /love/ to get rid of mmiowb() because I think it's both extremely
> difficult to use and also pretty much never needed. It reminds me a lot of
> smp_read_barrier_depends(), which we finally pushed into READ_ONCE for
> Alpha.

Right. Make as much of this implicit as we can.

At least as long as it's _reasonably_ cheap on all architectures that matter.

How expensive would it be on ARM? Does the normal acquire/release
already mean the IO in between is serialized?

> > Powerpc already does it. IO within a locked region will serialize with the
> > lock.
>
> I thought ia64 was the hold out here? Did they actually have machines that
> needed this in practice?

Note that even if mmiowb() is expensive (and I don't think that's
actually even the case on ia64), you can - and probably should - do
what PowerPC does.

Doing an IO barrier on PowerPC is insanely expensive, but they solve
that simply track the whole "have I done any IO" manually. It's not
even that expensive, it just uses a percpu flag.

(Admittedly, PowerPC makes it less obvious that it's a percpu variable
because it's actually in the special "paca" region that is like a
hyper-local percpu area).

> If so, I think we can either:
>
>   (a) Add an mmiowb() to their spin_unlock() code, or
>   (b) Remove ia64 altogether if nobody complains
>
> I know that Peter has been in favour of (b) for a while...

I don't think we're quite ready for (b), but see above: I don't think
adding mmiowb() to the ia64 spin unlock code is even all that
expensive.

Yeah, yeah, there's the SGI "SN" platform that apparently has a bug,
so because of that platform problem maybe it needs the more complex
"use a flag" model.  But even the complex model isn't _hugely_
complex.

But we *could* first just do the mmiowb() unconditionally in the ia64
unlocking code, and then see if anybody notices?

Tony, comments? Are there any SGI SN machines around any more?

                      Linus
