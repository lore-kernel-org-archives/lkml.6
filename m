Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9820C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69D1E21757
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SnK8J2Ap"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69D1E21757
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeHGXpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 19:45:47 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38223 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeHGXpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 19:45:47 -0400
Received: by mail-pf1-f195.google.com with SMTP id x17-v6so51751pfh.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 14:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oymKLON2R3fZZMXMf0R/WGj+kimwbWUeo/xpBRqBJh4=;
        b=SnK8J2ApnUJCy0uBMcx/AMdpR/t7HfiR9d6nqDLIl0QzpLm4l8livwWmkg19hwv9t7
         m4v0/yAMQ57I07W3eHSgNckW/D+kYWBYZQ7TX+GL2ojPaCPDo5Ay6MHG/pY2LMKNT8Tr
         2ILWQ2/BwBJGqbq5ND4jIAjPen9iH++nDEtM5AzIuIFirlEn71xfD3oI4T2GpU6c5sjr
         HBIX52A6j2XnHAZnQqIth+ksuoZY5U7nSjxDbgNcNpc33nMsrstq382MSONlQ0INLr4V
         HzNacpf2n3XKLVHk7cdalODIFjgIJ6Ei9G6R8d4HcLezcSjlPDvOHIMxGIFOaexO9jJh
         UkTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oymKLON2R3fZZMXMf0R/WGj+kimwbWUeo/xpBRqBJh4=;
        b=UzlwPUq8dMExcdZbFNs936IF+d/AfxMtO58zhbHOa7HPSO372Emyi1GcLQZa4PFugn
         9ozPDTE+0zMsgEsxaX3peenp9o8m5h0pkOgZYFJCk7h4fH6IHHsdJIu1F+4zERCpWsX4
         Q7u7xUCgd/Ijatu1EViHkEtKOuv8AitZiJlTRIZM+KedKc98wJwtGUhmxS+x65vcUFrU
         OlEKvJaMpeBraG9x/rqZbSbdrbhR7cjou6r+7n1xZXyTdyk8fL3iroepxAHthZqJqgZT
         irkScNVecb3uMilcYFzZaqpRlfzUAcNKFjCCXoeyU3kE9yOyI9iCvQ4YfjbgnzAUfuEe
         qsRQ==
X-Gm-Message-State: AOUpUlF4NgSCRq1WaK1D+W6ZQX3mN3/LrbyGJSpc5X9RPcXraHwYkjMf
        HXHDNVkv3fWriSahOrh7d3qJtkrg1s2yDJ06VHmNuA==
X-Google-Smtp-Source: AA+uWPyHOeuhCbKiqjvg7g88dxbXfULzUh3mH8zcpSrXsa560UtM8DHJb3EkmLyn0UG9kKxOizSS9eqyLAKBsQGztjs=
X-Received: by 2002:a63:9619:: with SMTP id c25-v6mr88285pge.75.1533677365118;
 Tue, 07 Aug 2018 14:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180801182258.17834-1-ndesaulniers@google.com>
 <78c667f9-5c8b-3835-83eb-4b59e27e4f7e@bell.net> <CAKwvOdmdrA+UvAWyqe8sNJt5nxHXHsSwf5Yxih9HYgVL+kovxQ@mail.gmail.com>
 <fe7b57d8-b586-a390-31d2-2274f69db3c0@bell.net> <CAKwvOd=CLBFZRQ4HQb_+VCydDEvsbC2w2gD4hTwvp_jm1zqN9Q@mail.gmail.com>
 <54b2139b-53d2-01c5-f240-93a692cdbc59@bell.net> <CAKwvOdktvrZL8T_5K2VtQtgt_mscS7kzVXYVy0O7CSuGX53Y5A@mail.gmail.com>
 <536ef1b1-cfa2-f66d-4261-fb8405964632@bell.net> <CAKwvOdmwj76aESZNKhzfPmhfzGKvrfDut7oD5KAwA+VR-JukSg@mail.gmail.com>
 <80743c1c-2a8c-7bce-2068-24c63790eba7@bell.net> <CAKwvOdmDwO1U1sk=3-6zXFrVw6by1e_9VBx1WWMCx_rMqYSw-A@mail.gmail.com>
 <81a7e33a-0403-b6d4-fcba-c2168a608ba6@bell.net> <CAKwvOdmXi_EY5=sOO9tRqeoFrHjLsF9L988cGC2yjnFYBxac4w@mail.gmail.com>
 <1d577675-c337-d433-f235-1e46e5d56d4c@gmx.de> <CAKwvOdkABF9cxFxrtYo_mMWAunLL_ifM8+=H0On7WWcFmoN0Og@mail.gmail.com>
 <74f19f24-fc6a-748d-3778-26ee0bfb2d40@gmx.de>
In-Reply-To: <74f19f24-fc6a-748d-3778-26ee0bfb2d40@gmx.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 7 Aug 2018 14:29:13 -0700
Message-ID: <CAKwvOdmav51ye3Bx=hNuroOtXbZ_w1SbE6CEr47DdCF5TcLESQ@mail.gmail.com>
Subject: Re: [PATCH] parisc: prefer _THIS_IP_ and _RET_IP_ statement expressions
To:     deller@gmx.de
Cc:     dave.anglin@bell.net, jejb@parisc-linux.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-parisc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Alistair Strachan <astrachan@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 7, 2018 at 1:30 PM Helge Deller <deller@gmx.de> wrote:
>
> On 07.08.2018 20:11, Nick Desaulniers wrote:
> > On Fri, Aug 3, 2018 at 3:34 PM Helge Deller <deller@gmx.de> wrote:
> >> So, your patch is basically OK and doesn't break anything.
> >> But I agree with Dave and Andrew, that THIS_IP is ugly.
> >
> > I don't disagree, and other maintainers have remarked on _THIS_IP_
> > being ugly, but renaming it en masse is a tree wide change, which I'm
> > trying to avoid at the moment.
>
> Understandable.
>
> > It sounds like we have a working patch? Are there 64b parisc machines
> > to test on, or can this get merged?
>
> Go ahead and merge it.

Thank you, but I was under the impression this would go up through the
parisc tree?
https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git/
right? Or is there a different tree/maintainer I should ask?

> In addition, somehow I'd prefer if there would be a way to add to include/linux/kernel.h:
> +#if !defined(_THIS_IP_)
> #define _THIS_IP_  ({ __label__ __here; __here: (unsigned long)&&__here; })
> +#endif
>
> That way it would somehow be possible to replace that label calulation by the
> preferable inline assembly of current_text_address()...

I'm asserting that there is no need within the entire kernel at the
moment to have inline assembly to get the instruction pointer.  If
there are no call sites of the inline assembly version, there is no
need to define per arch inline assembly versions when C (with GNU
extensions) will suffice.

And if in the future there are, either those call sites can have a
local implementation (as in the second diff I sent in this thread), or
some other change to _THIS_IP_ (as you propose) can be made.  But
until then...

YAGNI: "You Ain't Gonna Need It"

Once this patch and the other 3 outstanding ones are merged, we'll be
sending patches to delete all arch specific assembly implementations
as they will be dead code (no callers, kernel-wide).
-- 
Thanks,
~Nick Desaulniers
