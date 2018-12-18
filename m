Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71601C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359A920869
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mKLLt89y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbeLRXxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 18:53:41 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:44338 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbeLRXxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 18:53:40 -0500
Received: by mail-ua1-f65.google.com with SMTP id d19so6350102uaq.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 15:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=37HWCbnI2MU0qAbJuSSQoCmbVAJ47eC3I7oXShAc6IY=;
        b=mKLLt89yoHP6NX335/tntXE/RR9FKZJwvt2U+dqidBYhoHKpvcjeMmBNzXzb6+rSYq
         1FWBNtEx9QxgS8PTux2sL1Clk4hIo6XPO8CWGG1/qmQoTmH4lzLiD8kPppfUC7FHpqbn
         FvBxYUvxOPuRjK4c1VHM6eFgtSv2Zs5pFGC6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=37HWCbnI2MU0qAbJuSSQoCmbVAJ47eC3I7oXShAc6IY=;
        b=DwmTefeXvWtjht0lzGpcN4noKOmqOdwZmB6vbw8Wb3nAHrzn0GeQSiFZFo+Mn3PmBs
         oWbK/XrYVI0uTc1Su/aVk/eyvpswswd33SKp40u0fnaJRewwwKkI2WkTcFpMphYnh74L
         mqKPj6o9Kog4/VT+vSq8V05CfW4r6850rmMW3HnCnz6xPnBVxx0TMB6iAQLQYXVUQPz8
         boqOT9WKMe6rrnEiIuuXe5nfdHZJNXZnphrU5DO2n624Y3FYptduHLh40/FPJPH2BLOR
         75gxY0CVwuej8ewDvxMMx4XQNzudp9z5KdDX4UF4u8YIaiCxtPUbMFGd7ydA0FlzSe0h
         ltTg==
X-Gm-Message-State: AA+aEWbk34e6m3Mpqr0JnulMuI86D2ZEzfZ4b0MUz/VhkWbIhrfoL/8H
        IYN7yYutXqwqB/r0R6cnYcuHeNd/jEg=
X-Google-Smtp-Source: AFSGD/X4KXyQ0qohQwMJZnVz1cE1tqvattYkRFcI6BGpSptPH9QKxXYAdBkwUT1EyXPpbBbrONX1ug==
X-Received: by 2002:ab0:210e:: with SMTP id d14mr9198526ual.20.1545177219213;
        Tue, 18 Dec 2018 15:53:39 -0800 (PST)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id l13sm18011605vka.16.2018.12.18.15.53.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 15:53:38 -0800 (PST)
Received: by mail-vk1-f182.google.com with SMTP id w72so4108263vkd.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 15:53:38 -0800 (PST)
X-Received: by 2002:a1f:ab17:: with SMTP id u23mr8517993vke.73.1545177217957;
 Tue, 18 Dec 2018 15:53:37 -0800 (PST)
MIME-Version: 1.0
References: <20181210023649.229271-1-dianders@chromium.org> <20181218170510.GA28994@wychelm.lan>
In-Reply-To: <20181218170510.GA28994@wychelm.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 18 Dec 2018 15:53:26 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U5eQWh40vru1H8tfd37e8kZiwsd9zSVWy-ikk9b3PCKA@mail.gmail.com>
Message-ID: <CAD=FV=U5eQWh40vru1H8tfd37e8kZiwsd9zSVWy-ikk9b3PCKA@mail.gmail.com>
Subject: Re: [PATCH] debug: Allow forcing entering debug mode on panic/exception
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Brian Norris <briannorris@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 18, 2018 at 9:05 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Sun, Dec 09, 2018 at 06:36:49PM -0800, Douglas Anderson wrote:
> > Ever since commit 5516fd7b92a7 ("debug: prevent entering debug mode on
> > panic/exception.") (yes, years ago) my kgdb workflow has been broken.
> > On Chrome OS we have 'kernel.panic = -1' in
> > '/etc/sysctl.d/00-sysctl.conf'.  That means that when userspace starts
> > up it will tell the kernel "please reboot on panic".  ...and so when I
> > get a panic then the system reboots instead of letting me debug it.
> >
> > While I could go in an change the 'sysctl.conf' and I could go in and
> > hack the kernel myself, these things are inconvenient.  I either need
> > to keep a private kernel patch or or remember to edit a file every
> > time I install an updated version of Chrome OS.  What is convenient
> > (for me) is to have a CONFIG option that makes kgdb override the panic
> > request.  This is because the Chrome OS build system makes it very
> > easy for me to add some extra CONFIG "fragments" to my debug kernels.
> >
> > Hopefully having this extra config option is OK and useful to others
> > who would also prefer to make sure that kgdb is always entered on a
> > panic no matter what userspace might request.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> Sorry to be late with this review. I forgot to search for "debug:" when
> I was checking for missed patches earlier.
>
> Mind you... one of the reasons I deferred review when you first sent it
> in was that my gut reaction was "I don't like it" so I decided to wait
> until I could offer a head reaction instead.
>
> Ultimately I'm not sure this should be solved within kgdb. Perhaps best
> phrased as: is the problem that kgdb *misinterprets* panic_timeout or is
> the problem that Doug wants to *override* panic_timeout?
>
> I think the answer to this question is the later meaning I'm interested
> in what happens if you introduce a CONFIG_PANIC_TIMEOUT_FORCE (c.f.
> CONFIG_CMDLINE_FORCE) to prevent the userspace changing the
> panic_timeout (either by avoiding registering the panic sysctl or, if
> that is a huge ABI problem attaching it to a different variable).
>
> TBH I'm not sure if such a patch would be accepted but I think it makes
> more semantic sense!
>
> (there is a small review comment below but the above is more important)

Thanks for the review.  Yeah, it definitely was a bit of a
questionable patch but I figured I'd throw it out there to see what
folks thought.  I think we should just drop it.  I talked with Brian
about this offline and we agree that it actually should be OK to just
drop the setting from '00-sysctl.conf'.  I have my patch at
crrev.com/c/1382879 and it looks like folks are happy with it.  :-)


-Doug
