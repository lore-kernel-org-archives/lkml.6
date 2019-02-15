Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAACC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 21:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F3621924
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 21:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="It8F+c8O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391943AbfBOVPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 16:15:14 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34033 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387600AbfBOVPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 16:15:14 -0500
Received: by mail-wr1-f68.google.com with SMTP id f14so11805305wrg.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 13:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VADwBkT847c4aOiIkdkR9YLvQNw66R551EDkGw96awk=;
        b=It8F+c8OyP4FK+4MuoQpsanlzZ3WZTFldM914Xab6exkiKDCu9GknyvQIsVd0HGJ08
         HEN4FHfsL4LcOYhNSIU1GIKUrOW04LqSQdhxK/lFEUWmcEFYl+eSG7Bn6+iPVTrjvxht
         vx3QaNze8o7IfV0+ucXZ+rjxH8//eSEIwFUVrrmin6O1tCI4FtVsIzasTmu+hwfoGGBo
         IZzxwOaLtzAgowwm1xLPaUP3hQB4b96OZad4i4FxozYunbQevU/4GClxAMNkALNMT1jW
         6YMxLyRb+E42aIrTBh+AI3KxQ/6XeZi0Cu0z/3taFa/blovZGnHmp/TvyGSnhwH0Yz1y
         Cgsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VADwBkT847c4aOiIkdkR9YLvQNw66R551EDkGw96awk=;
        b=pMnFNr1/oXlVe/hRMf7bW+P/f4gzmFIXyBNHDArh99w4AIEiOMucyUVsfnXDvvB913
         ZISuSJAmozLD4/nBNbuTdzn7auEMsGbe4bZ5/gFsP46fJyg231Aptm1JFRPAegmStZu6
         26M5Seh8+PLAcabMittyiPckBO8L76wNnUt34QCEYs/tXUHbWq+y3Jac4+5sJdDWoxRc
         XnvGex4m7rDLIRmc/a68onk37e2nJNmhdRQ1T9+ymmYUfEqYLXa0C8k2Sg7BJ4zWa/MR
         8vSRtVi0uWeuJKLikdQPhke3GLNCjJ2eFzqckawh4XUoJKRAkYiAOUIL3Xk2hBIjpfYo
         Umbg==
X-Gm-Message-State: AHQUAubo105ezKv47MoOdN3vvoQXPTrNMd35qyhEVksUfpA4gGpyTcno
        1gaCkRqQs+8GV8JvjkZEOZyRHdHxIIaalkr4ZKnZ2A==
X-Google-Smtp-Source: AHgI3IZOdHmSmMjg4PexSRpR5bh5vsKdCyPn7i+o78RY3ci6TP6v/Vp+MECM81V6G2afaHRsr7UChmU6/o6/iKGTT58=
X-Received: by 2002:adf:fa51:: with SMTP id y17mr8606129wrr.233.1550265311833;
 Fri, 15 Feb 2019 13:15:11 -0800 (PST)
MIME-Version: 1.0
References: <20190128214408.25442-1-afd@ti.com> <CALAqxLXb53nsBJtb958sMzpr-fnXxqFE0s2B6YJzoGcswv50wg@mail.gmail.com>
 <20190215105057.jujgm4k77rhkvmo7@DESKTOP-E1NTVVP.localdomain>
 <CALAqxLU=L3Y7KJEo9c-Nu1rS3EquofGf1UGWBWqAO+Qke72Ekw@mail.gmail.com>
 <0cc81357-034b-9c74-8172-2a7a26e77804@ti.com> <CALAqxLXe8KHvx_ce10_W_0uxBsLBsyWw+B9J-fzZU5vTY8VC+Q@mail.gmail.com>
 <bbfb51f3-c703-7bb7-db83-311945ef2be9@ti.com>
In-Reply-To: <bbfb51f3-c703-7bb7-db83-311945ef2be9@ti.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 15 Feb 2019 13:15:00 -0800
Message-ID: <CALAqxLXUU7U2WksEOH342Nt6V9_LT9RHnZufHyPeQJUi7okHig@mail.gmail.com>
Subject: Re: [PATCH v2] staging: android: ion: Allocate from heap ID directly
 without mask
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Brian Starkey <Brian.Starkey@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Christoph Hellwig <hch@infradead.org>,
        Liam Mark <lmark@codeaurora.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>, nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 12:52 PM Andrew F. Davis <afd@ti.com> wrote:
> On 2/15/19 1:58 PM, John Stultz wrote:
> > So yea, I don't think we should tie our hands in reworking the
> > interfaces, but it would be nice to avoid having subtle ABI changes
> > that don't have clear ways for userland to detect which interface
> > version its using.
> >
>
> Let me preference this by pointing out I've dealt with the same pain
> internally with our Android and soon to also in AOSP for the Beagle x15
> boards[0].. But my stance matches Christoph's in the other ION thread:
>
> https://lkml.org/lkml/2019/1/19/53
>
> The more freely we can make ABI changes here in staging the quicker we
> can get this out of staging where the ABI can be locked down.
> ION_IOC_VERSION should solve this anyway.

If there is real momentum to destaging and locking the ABI down,
that's great! I just want to avoid lots of little incompatible changes
that don't get us fully out of staging and cause tons of pain for
folks trying to make it work (because at that point, its easier for
folks to stick to their own out of tree solutions).

> > So my initial thought is we simply use a /dev/ion_heaps/ dir which has
> > a list of heap devicenodes. /dev/ion goes away.
> >
> > Currently ION_IOC_HEAP_QUERY returns:
> >   char name[MAX_HEAP_NAME];
> >   __u32 type;
> >   __u32 heap_id;
> >
> > The names are discoverable via "ls /dev/ion_heaps/"
> >
> > The heap_id is really only useful as a handle, and after opening the
> > heap device, we'll have the fd to use.
> >
>
> So why have heap_id at all then?
>

Good question!  I'm hoping we can yank them, though internally I
didn't quite get there with my first patchset. :)

> > But to match the use case you describe:
> > 1) ls /dev/ion_heaps/ for a list of heaps
>
> Yuk, dirent.h and friends :(

Yea, its not super fun, but its a standard interface, and the ugly
bits can be done once in the helper library.


> > Does that sound reasonable?  And I don't really mean to dismiss the
> > dynamic picking of the best heap part, and having something like a
> > opaque constraints bitfield that each device and each heap export so
> > userland can match things up would be great.  But since we don't have
> > any real solutions there yet(still!), it seems like most gralloc
> > implementations are likely to be fully knowing which heap they want at
> > allocation time.
> >
>
> I think you already touched on my main issue with this, the dynamic
> picking not supported. Well, like you said it doesn't really exist now
> either. And this doesn't look to stop one from adding it as some ioctl
> extensions..
>
> Okay, looks like you posted an RFC, lets move the discussion over to
> that thread.

Sounds good. I look forward to your input!

thanks
-john
