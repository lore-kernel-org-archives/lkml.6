Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F33AC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1B020658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kink44Va"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD1B020658
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbeH3Twk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:52:40 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:50643 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbeH3Twk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:52:40 -0400
Received: by mail-it0-f65.google.com with SMTP id j81-v6so3237124ite.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 08:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PlzLOqrBAIn0ZzDf9bDS9S5Pof2gIH/fkTuJ2GMRdkQ=;
        b=Kink44VaEN0WpM1tJZk5KYkoFX30KpwtyWVpdFTZyccvw5MOJhW7miuL+lNjFGtZnQ
         FhXg668+LO1J7h4snm6FY4nxFzVLPEcjo/6EqlwfmiNTbkS7GDbexgaJz1ZxcukrcxZB
         iCucsdigcC1l3Nkurst4T5+8oIPy1e172bkyYG1ChyD/mu8WP2fp5+Vl7T7XGkJUsl8g
         KHkWDxSQioSw9CukDfFNQ5Lo64xjFqzFECjThyRgap45Tfe2YalI/3J8njzQwOHop4W1
         tS11jeqlHM/FtBUS9OUdLmKHox2gqSod2hGoccXnWVKzCoCPpoZL2iNjD+eNJiOVkupu
         9kMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PlzLOqrBAIn0ZzDf9bDS9S5Pof2gIH/fkTuJ2GMRdkQ=;
        b=C2UX2A5HwIkFsQDDLJPMDiZ4/loFj2hqU05SIZPZjcVrchYIWMrNUqJ4vVNRpA+nDQ
         akgOXQmZRXDh8ildbouLVDzgAVwc6OujO/BUI51JBJvU7b6ucmRNPfXLuhL99V+r9/FL
         4JreKHA4FEfklun44vTXIq6QEdxC7fZGh70zcgny9zEuxanS//2JZPDi/oEyEI5Muf/C
         PC9fPcfHsWEtpmze20mm4mRpbXFRveAZFTb09c1VNluoXx74VMyAKj3r8yHl5QQzfUkm
         RLRJnfRjkcW3AoWphJ3P/n/hnyqpto2u+X6cmayg4vQpVcnbIb+NtZuIhkYxYWHKylYz
         /ACg==
X-Gm-Message-State: APzg51Df9EqO2PvonM7wah+A/rnCyxlmn2qSdSYskbQ/UhblS2X+gBaZ
        fUo2ogkxJlEGcjGKrA3goL1ukNvO89KMn+9gRAiBXQ==
X-Google-Smtp-Source: ANB0Vda4vcpEwmg6XQlQlc9x8R+vlF9Ot6N2pLbaUmqj0qE8YyMFwpDujJ2TsKnFBATfciRS6aJt91gXROTxGatovE4=
X-Received: by 2002:a24:dd88:: with SMTP id t130-v6mr2602962itf.129.1535644192353;
 Thu, 30 Aug 2018 08:49:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180828160005.90796-1-tkjos@google.com> <20180829070036.GA13718@infradead.org>
In-Reply-To: <20180829070036.GA13718@infradead.org>
From:   Todd Kjos <tkjos@google.com>
Date:   Thu, 30 Aug 2018 08:49:40 -0700
Message-ID: <CAHRSSExgXbKOYR9HU=+WDaQjHBYB3=YCYXgnAOGwJ0Y3Q3qshw@mail.gmail.com>
Subject: Re: [PATCH] binder: use standard functions to allocate fds
To:     hch@infradead.org
Cc:     Todd Kjos <tkjos@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@google.com>,
        Christian Brauner <christian.brauner@canonical.com>,
        ben@decadent.org.uk, torvalds@linux-foundation.org,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 12:00 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> >  config ANDROID_BINDER_IPC
> >       bool "Android Binder IPC Driver"
> > -     depends on MMU
> > +     depends on MMU && !CPU_CACHE_VIVT
>
> Thats is a purely arm specific symbol which should not be
> used in common code.  Nevermind that there generally should
> be no good reason for it.

It is true that the current design (10+ years old) has this flaw. VIVT
cache support was the rationale for using the non-standard functions
to allocate file descriptors from the sender context. There are no
known cases of recent android releases running on a device with
a VIVT cache architecture, but I did want to call this out.

We're working on refactoring to eliminate this issue.

>
> > +     fixup->offset = (uintptr_t)fdp - (uintptr_t)t->buffer->data;
>
> This looks completely broken.  Why would you care at what exact
> place the fd is placed?  Oh, because you share an array with fds
> with userspace, which is a hell of a bad idea, and then maninpulate
> that buffer mapped to userspace from kernel threads.

Well, android apps rely on this behavior (and have for 10+ years) so
there is no way to avoid the need to manipulate the buffer from
the kernel. We are working to refactor the driver to do this
using standard mechanisms instead of relying on low-level internal
functions.

>
> I think we just need to rm -rf drivers/android/binder*.c and be done
> with it, as this piece of crap should never have been merged to start
> with.
