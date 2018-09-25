Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6464AC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 23:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F302420867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 23:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WKBuGz3l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F302420867
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbeIZFQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 01:16:28 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34626 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbeIZFQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 01:16:28 -0400
Received: by mail-lf1-f68.google.com with SMTP id y10-v6so7325092lfj.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 16:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=twBci8YtfyGwp966pwPGqC7Dq+p8hkwRhs4LcMYacxI=;
        b=WKBuGz3l8q9UUfyWgjOMocFuhwSJxhUdNvcyfxyxFzBERJhtjq/mZnZXkN6gFZdO/d
         KeJHGcRdSh7a7hgDeR1pQO1dGEDn44QmzdfSQyp36tRS2ymREohCyzcEhd/n/6fM2w0v
         3864klAzJJpEfaRDMXpqPWsl9grcejuIKredgIe9wCp/c7V4p6KxijH6g0ohfcdag04I
         lkhj2mscd+XdJAnn+gnMYMQF0TF2euXCUQ0JMRtKgDxNweSHiTa8JHLAfwwe9uDj86VT
         /yKyOja5Gb/dxM7lXNFk1eMRhFxt02Rd8yZBkrGh2SpqHdoUuUEBP8X8qdp3A6WM0eve
         8g6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=twBci8YtfyGwp966pwPGqC7Dq+p8hkwRhs4LcMYacxI=;
        b=ZxrVfM3BlN30i4T52DiXGvqdbO+JXg/keRtcxgQPdZOVm7tJucs/830u0SY9FCuPZC
         yk6EiPZC1uZ6BCdVsELtMSJ0stTP9bxE5MqfAI+nmgIPbqU1yT0OK7LElBSF66mIZyBl
         Sfcp2AYfrXcD8f7kyoq5oL+Su4RX9kA5/ipHSs7n6vHGhNq1TOcxFKIg5/Jrai+l9uII
         0w5Em6lpwXHa+H32lcv5Blle30Un96MXODOikrW6g6rlcbKOFy+rIX9/kTmr+YbFvWR8
         liwUdgoU+s+2Lp7h3tL86f5BM/DM0z3ijmmWNKU3mdKrhJLuiHv+6LG9dvu7IdhOOOHq
         OlYQ==
X-Gm-Message-State: ABuFfohgDSHoG0DujImrEeTW2biXS2f2fXT7FeR/h4J3eZZkKLOJ7Nx0
        rlUsUVMM+/hMHcvIx1TQxxfkNk2FyD6kXmNNj0VkvQ==
X-Google-Smtp-Source: ACcGV61ZtThyZ5m0skWm6jqkodDRkI3SIonSjmxJW4s+R75tNCFavhYGU379DCW0NUOBhPivt9k06j4uWhXqNiivcMw=
X-Received: by 2002:a19:c650:: with SMTP id w77-v6mr2401294lff.108.1537916795041;
 Tue, 25 Sep 2018 16:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180914175122.21036-1-rkir@google.com> <20180914175122.21036-6-rkir@google.com>
 <20180925183138.GB21572@kroah.com>
In-Reply-To: <20180925183138.GB21572@kroah.com>
From:   Roman Kiryanov <rkir@google.com>
Date:   Tue, 25 Sep 2018 16:06:23 -0700
Message-ID: <CAOGAQeovsK6HDV0_t4EoHhWU-XKyNF8tR0xAx8ff50xpjsRAdA@mail.gmail.com>
Subject: Re: [PATCH 06/21] platform: goldfish: pipe: Add DMA support to
 goldfish pipe
To:     gregkh@linuxfoundation.org, Lingfeng Yang <lfy@google.com>
Cc:     Todd Kjos <tkjos@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, thank you for looking into my patches.

> A whole new api needs some others to review it becides just me.  Please
> get some more signed off by on this.

Yes, I will find more people.

> If you have a spdx line, you don't need the gpl boiler-plate text
> either.

Agree.

> But, this is a uapi file, so gpl2 is not probably the license you want
> here, right?  That should be fixed before you end up doing something
> foolish with a userspace program that includes this :)

I will confirm which license works for us.

> Don't we have a dma userspace api?  What does virtio use?  What about
> uio?  Why can't one of the existing interfaces work for you?

Yes, I learned we have other tools to do the same as our driver does,
but we already have
userland using DMA through out driver. Maybe I will retire this driver
completely.

> > + * 'G'       00-3F   drivers/misc/sgi-gru/grulib.h   conflict!
> > + * 'G'       00-0F   linux/gigaset_dev.h     conflict!
>
> Causing known conflicts is not wise.

Goldfish devices are used only in Android emulator. We can pick other
numbers to avoid conflicts,
but this breaks our userland. We are ok with conflicts with drivers we
don't expect to be used.
