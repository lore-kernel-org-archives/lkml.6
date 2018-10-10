Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5FAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E06C42085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E06C42085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbeJKC1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 22:27:50 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:35938 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbeJKC1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 22:27:50 -0400
Received: by mail-vs1-f66.google.com with SMTP id c205so6129991vsd.3;
        Wed, 10 Oct 2018 12:04:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3jy6qMnuwuirOWOT6FOVcP2kJeSdyFW6HdqAE7F8Nmk=;
        b=GhHtVDfrIbvVd8lr/8JUgFCh7S7F71cxsnDPQwqn+scqtSlkodz1R3fPdg8Omz9TtO
         2h24JEYXiQQca647flsiRl6MuUSkoy95sd/BltJIWrXBZm7uQHI5dmxUG9HH2/0ilikt
         KcoQMioujSTufvVtPSaL4fBBVIjhsyS57bWQkgEKfq1YY2bCWaSHXE19gYFcKwWMDZje
         v8gk6JXqHZUbEv2qsv1kOHO+ptiJ0nI4DSCuhnu/6KNVyv+KCkfA0SARo7ZoDHsU8uiI
         KjgRwPk1dnoA0NVXx2scJNpZslc9wJCqlWCKadykmqUtQshw5QZTU3rAmGU7YzNdmn4C
         hA6g==
X-Gm-Message-State: ABuFfohCpBeZ5s556Ez9S6yLCCoFdH0G1jWL8kEBDtSvLKDnNTNfkQnL
        57BndgzpFnChkar3I+yFjp6MvLsTj8ZRQ+83pZE=
X-Google-Smtp-Source: ACcGV62hovQb0n+k6srdSZba1mq/DUztqR7r1nhJF4KmbdHec7r3B9H6FU93epaljJg0kDdnZScva9FrtvqMmvMBlbg=
X-Received: by 2002:ab0:47ed:: with SMTP id w45mr12670069uac.78.1539198260653;
 Wed, 10 Oct 2018 12:04:20 -0700 (PDT)
MIME-Version: 1.0
References: <20181008152523.70705-1-sashal@kernel.org> <20181008152523.70705-24-sashal@kernel.org>
 <CAKdAkRSoq_U1rkO+6gbautYpS1fFn3icLY3Dtx0geXNC7MwvbA@mail.gmail.com>
 <bec357b5-09d0-5014-d2a3-0ade83499d15@gmail.com> <CAKdAkRSuuv_8BOz2m=DSgnV7a2MNY+6ZPera3ROfV3osMUTStQ@mail.gmail.com>
 <20181010142958.GF32006@sasha-vm> <20181010170219.GA47260@dtor-ws>
In-Reply-To: <20181010170219.GA47260@dtor-ws>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 10 Oct 2018 21:04:08 +0200
Message-ID: <CAMuHMdXypH2mKoGoY2=_L2_C3YV_v=9OLNCOHE5+u1QaWhHz_A@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.18 24/58] Input: atakbd - fix Atari CapsLock behaviour
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        stable <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Wed, Oct 10, 2018 at 7:03 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Same goes for patches that deal with error handling in probe() functions
> that your AUTOSEL scripts like to pick. Yes, they are fixing bugs. But
> show me actually users affected by them? You encounter these issues with
> probe when you do initial device bringup, but once device is stabilized
> probes are expected to succeed. There won't be duplicate sysfs
> attributes, memory will be allocated, and so on. Fixes to remove() might
> be worthwhile if it is a hot-pluggable bus, but otherwise - no. Yes, the
> box may OOPS if someone manually unbind device through sysfs, but the
> solution is no to patch stable kernels, but simply tell user "dont to
> that [yet]".

In modern days with -EPROBE_DEFER, bugs in probe() are much more likely
to cause damage than before.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
