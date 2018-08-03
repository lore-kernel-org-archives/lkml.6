Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED3AC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 19:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C3782178F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 19:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NzC/e3oq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C3782178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731741AbeHCVeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 17:34:07 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:35358 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbeHCVeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 17:34:07 -0400
Received: by mail-it0-f42.google.com with SMTP id 139-v6so3122401itf.0;
        Fri, 03 Aug 2018 12:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BYEY9r7UTzwTSXxFpUn7q8RMOrNrHfB/+LSj6jg6e6U=;
        b=NzC/e3oqTFZpS8/awDIwqyYJdx9uOhHO7UyEx5mMF4zOwUDTeB4qPVdk0+WmT/dW4o
         cRKPp3G4mx1JaaS3oRgnUpVkeZkH7SPOVfatUgYiFAAD2fJX8wsyGyzjpS9oeiJGy7BC
         HK2/nTbOVjWSzGTpdbR+yiAtBrjnpJB1wBrEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BYEY9r7UTzwTSXxFpUn7q8RMOrNrHfB/+LSj6jg6e6U=;
        b=tEXa+7FlCg9IWrNRTmYTPr1oD8WQ9NHRipAJZ/5CJc0TOnN1WszLQ1hyMD+CtMit5Q
         CCpP82wF0K6F6CdPIPJky5MrNmIwMUNAi5eIZAtgEA0vGQgIPuEL/IeIVJ/dZrNX9G9b
         16cQdPRWFfuGaS/Y1vZ+jFZWtmiBikmrjnrRU/blV2AXriOrJlpkU1VaeaSusE0E1627
         CbxvXG5S4IhjsuGoGrgMyiSIiltu+D0H9L4nYkWrThAfk6F9qIuxGLwrXbnv/3Xiv/PW
         9A4rXdm9kCjh8MUMCPv8Psm8jQHWIyYtHzEm1hPlvjTXn2TsBqrgBHkCnlp/RvN+SkUD
         ksJg==
X-Gm-Message-State: AOUpUlGesrh81fGKq14iUQsTecUTmEjSV9KXItloFB55mCMhNdItniyU
        7jxsrCh70R6OSuJIZTlyvWUhNxgHjivTBHgkwXk=
X-Google-Smtp-Source: AAOMgpeNAyYc6xrsv2DxPgLkA8II9SJmTtEjsH0Jb9TVGtAQdQRkYr0vJXiDMNw2ssDqQKDb9BJRQHaP1XwNp/6FiSc=
X-Received: by 2002:a02:2b12:: with SMTP id h18-v6mr4725114jaa.10.1533324987015;
 Fri, 03 Aug 2018 12:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <CA+55aFyAox9BTDpRsqLXiROhHOX60aa45LEZ7Azteaumdu11Fw@mail.gmail.com>
 <CAOi1vP-SJO4AMK=XD3Lmja++2dQqoiw6Zn8Vgxf8OfvYgnuC6Q@mail.gmail.com>
 <CA+55aFy2DR9fxHhmGq+azSjX9D71YtLsuFKmoEuYW3uTAUYtJg@mail.gmail.com>
 <d76415de-2056-c7d6-cc88-b896deaa8ead@torlan.ru> <1ec0a220-d5b0-1c27-e63b-c4d3f4ce9d77@torlan.ru>
 <CA+55aFyPVQ5-gA93irsaxPC9BNQxnGWrDDHPMUYai2kxKiaKWQ@mail.gmail.com>
 <b2bbd8ec-ac5b-fa8a-d3f7-8615d87f73c3@redhat.com> <CA+55aFwWZX=CXmWDTkDGb36kf12XmTehmQjbiMPCqCRG2hi9kw@mail.gmail.com>
 <20180803185431.GB3258@redhat.com> <CA+55aFwDEY7B6OMh5xL2wc8BRj1KkzBHggNowAjbsWfma6H5Zg@mail.gmail.com>
 <20180803193037.GA4581@redhat.com>
In-Reply-To: <20180803193037.GA4581@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Aug 2018 12:36:15 -0700
Message-ID: <CA+55aFzPDchiWn0sxPjO-ha1o4nYuHnE0YD+rG9LoSe4+Lt1OA@mail.gmail.com>
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

On Fri, Aug 3, 2018 at 12:30 PM Mike Snitzer <snitzer@redhat.com> wrote:
>
> I was trying to give context for the "best to update lvm2 anyway"
> disclaimer that was used.  Yeah, it was specious.

So I'll apologize for the strong words, and I'll just say - not
excuse, but explanation - that this is the *ONE* thing that continues
to drive me absolutely bat-shit insane.

It's the *ONE* thing I will refuse to even discuss. Pretty much any
technical thing, I'll happily discuss, and I'll admit when I was
completely wrong and a f*cking moron.

Hey, it happens.

But the "no regressions" thing is _so_ important to me, and _so_
frustrating when I get the feeling that people ignore it, that I just
go ballistic.

I'm sorry for going ballistic, but there it is. It keeps happening
every once in a while. I thought we'd gotten mostly over it.

                Linus
