Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CBEC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 13:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE8421E22
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 13:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUnSRNpr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EE8421E22
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732362AbeHIQL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 12:11:59 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41628 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731198AbeHIQL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 12:11:58 -0400
Received: by mail-ed1-f65.google.com with SMTP id s24-v6so2895193edr.8;
        Thu, 09 Aug 2018 06:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nqbl6Dnw6/j8CyUI6dbIR01IwQQgUkXc+lPoTZ2K6Ig=;
        b=KUnSRNprbYHZh2jogTAa3Pg2tbCROM/q/6uonU6wwmO9FgukRvxwG0DcUDqaLetZVN
         Oxfq4APWBQOT4m30ZIiSeBHn+FUxeaUoKCr2LEh24u0z0pWracaYTSbho3d1yFPfyRSY
         tbWlNrxa9PEbznSxEQUoyIjMxPcQT+K8fk07pDlT1Q14/E/KbDZUuM4SBtBQodxhbNF9
         i6Qu6CPPe+LyKBUYWSP+LN9/1hPqibAwaJ70zCgPQphDQX8qpGrSRvGoO+ogL50mVexP
         6sO24JIbVhfkxv95y2iOQpD5AWgzHLjUaLa1JPU8HMO9C859W0CaZb9tOnbxq8OZiWae
         TQhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nqbl6Dnw6/j8CyUI6dbIR01IwQQgUkXc+lPoTZ2K6Ig=;
        b=Z5PiR6Vj30h3exLb/7SkODzrXjvI8x2DjgHmoyxtWeAg2NySLuWSXCs/I8Kn5J0Nzc
         /xOwxwkVw+GB1FSde046hS9XRA/Ulv7cXCXwTUCmwVpGvdw5etJ73Djm67M080IVo5zv
         QushmwWTGeOQjm2e5/maUK6pwqMEdTRVVKYQ9Qe0i+SFoMne80dZLKru2AsnNxHOGJXT
         n/bL0vyiWrc5HZ5o3N4Qzu3QftxJ7Kj9FYcb5CrLHivBc8A1rX8sx/lqSdzeFS7qBUVn
         LKrYkYowWpJ6RYJhvzgzgeBeftG3pxG4wOpFvpMBLKTVya7roi66THGZM2EHU6yMU0Yz
         6eMw==
X-Gm-Message-State: AOUpUlFh7b35/PqyBhI+NbqPOJII0gczWS57qpWGSpfNLXm4E8xH9IAc
        OSfBMIzQ5X6FaruvqK2CKH8=
X-Google-Smtp-Source: AA+uWPx3yqK6a323N9r406sFupgeorqZfW68URBh65xrsf8iu+xrXeZCmid0Dh4E06Nzh3KKSBZ2GA==
X-Received: by 2002:a50:9b5d:: with SMTP id a29-v6mr3273765edj.167.1533822417129;
        Thu, 09 Aug 2018 06:46:57 -0700 (PDT)
Received: from dimapc.localnet (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id a8-v6sm8034044eda.27.2018.08.09.06.46.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 06:46:56 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Mikko Perttunen <cyndis@kapsi.fi>, Kyle Evans <kvans32@gmail.com>,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] gpu: host1x: Ignore clients initialization failure
Date:   Thu, 09 Aug 2018 16:46:55 +0300
Message-ID: <3195467.1OBRMfmz8N@dimapc>
In-Reply-To: <20180809131035.GZ21639@ulmo>
References: <20180801150807.15926-1-digetx@gmail.com> <1672653.y032a1rHIh@dimapc> <20180809131035.GZ21639@ulmo>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 9 August 2018 16:10:35 MSK Thierry Reding wrote:
> On Thu, Aug 09, 2018 at 03:53:03PM +0300, Dmitry Osipenko wrote:
> > On Thursday, 9 August 2018 13:45:41 MSK Thierry Reding wrote:
> > > On Fri, Aug 03, 2018 at 02:30:47PM +0300, Dmitry Osipenko wrote:
> > > > On Friday, 3 August 2018 13:50:55 MSK Thierry Reding wrote:
> > > > > On Wed, Aug 01, 2018 at 06:08:07PM +0300, Dmitry Osipenko wrote:
> > > > > > From time to time new bugs are popping up, causing some host1x
> > > > > > client
> > > > > > to
> > > > > > fail its initialization. Currently a single clients initialization
> > > > > > failure
> > > > > > causes whole host1x device registration to fail, as a result a
> > > > > > single
> > > > > > DRM
> > > > > > sub-device initialization failure makes whole DRM initialization
> > > > > > to
> > > > > > fail.
> > > > > > Let's ignore clients initialization failure, as a result display
> > > > > > panel
> > > > > > lights up even if some DRM clients (say GR2D or VIC) fail to
> > > > > > initialize.
> > > > > > 
> > > > > > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > > > > > ---
> > > > > > 
> > > > > >  drivers/gpu/host1x/bus.c | 18 +++++++-----------
> > > > > >  1 file changed, 7 insertions(+), 11 deletions(-)
> > > > > 
> > > > > This is actually done on purpose. I can't think of a case where we
> > > > > would
> > > > > actively like to keep a half-broken DRM device operational. The
> > > > > errors
> > > > > that you're talking about should only happen during development,
> > > > 
> > > > [only in a perfect world]
> > > 
> > > gr2d and VIC are fairly deterministic. What are the errors you are
> > > seeing that cause initialization failure?
> > 
> > Right now there are no specific errors. There is only a known trouble with
> > the ARM_DMA_USE_IOMMU, but that causes to fail all of the clients.
> > 
> > > Note that it is possible for
> > > these devices to malfunction even if initialization succeeds. A failure
> > > to initialize can only happen if there's something wrong in the device
> > > tree, firmware is missing (in case of VIC) or a regression was
> > > introduced in some subsystem that causes a failure (maybe deferred probe
> > > or something similar).
> > 
> > A missing firmware is an actual good example. Though can't VIC driver be
> > changed to load firmware at the time of a its first use by userspace? It
> > should be very annoying that kernel driver forces you to churn with
> > initramfs.
> No, that's not really how firmware loading works. There's no technical
> barrier to doing it, but it'd be strange. If a device needs firmware to
> work, it'd be unusual to make it available before you know that it can
> be used.
> 
> What if the firmware can't be loaded at the time of the first use? How
> do you report that back to userspace? -ENOENT because the firmware file
> can't be found? How is userspace to know that this is a problem with
> firmware loading rather than some other error having to do with the VIC
> command stream being broken, for example?

You'll have to check kernels log if there is some kernel-related failure in 
any case for the detailed information.

> Modifying the initramfs is only necessary if you have the module built-
> in or the module in the initramfs. If the module is in a root
> filesystem, simply put the firmware there as well and you should be
> good. This is all very standard Linux behaviour, nothing new or exotic
> there.

Having display driver built-in usually more preferable, it's not fun if kernel 
can't get to FS mount stage.

> > > > > and the
> > > > > device not showing up is a pretty good indicator that something is
> > > > > wrong
> > > > > as opposed to everything booting normally and then getting some
> > > > > cryptic
> > > > > error at runtime because one of the clients didn't initialize.
> > > > 
> > > > If machine doesn't have a serial port and it doesn't have ssh server
> > > > running or network doesn't come up, you'll end up with a completely
> > > > dysfunctional piece of hardware. Hence there is no chance for you to
> > > > even
> > > > check what is wrong. The argument about a cryptic error doesn't make
> > > > much
> > > > sense, you have to improve your runtime as well (and you'll get a
> > > > error
> > > > message in the kernels log).
> > > 
> > > You make a good point here. I'm not aware of any devices we support in
> > > the kernel that don't have a serial console, but that doesn't mean the
> > > kernel could be used on an "unsupported" device  that doesn't have one.
> > 
> > AFAIK, enabling serial on AC100 require soldering iron.
> > 
> > > > > From my perspective, all clients should always be operational in
> > > > > whatever baseline version you use. If it isn't that's a bug that
> > > > > should
> > > > > be fixed. Ideally those bugs should get fixed before making it into
> > > > > a
> > > > > baseline version (mainline, linux-next, ...), so that this never
> > > > > impacts
> > > > > even developers, unless they break it themselves, in which case
> > > > > refusing
> > > > > to register the DRM device is a pretty good incentive to fix it.
> > > > 
> > > > Sounds like you're assuming that only kernel developers are supposed
> > > > to
> > > > use
> > > > Tegra, though at least (for now) for upstream it is kinda true. Of
> > > > course
> > > > that could be changed ;-)
> > > 
> > > That's not at all what I'm saying. What I am saying is that we should
> > > make it difficult for developers to break the kernel in a way that would
> > > put users into a position that is difficult to get themselves out of. If
> > > we refuse to register the complete DRM device in case some subdevice
> > > fails to initialize we increase the chances of developers noticing and
> > > fixing it.
> > > 
> > > If all we do on failure is output an error message, it's very likely to
> > > go unnoticed. Developers are likely to check specifically the
> > > functionality that they're working on and ignore failures that they may
> > > have caused in other parts of the code as a side-effect of their current
> > > work.
> > 
> > I can try to help with improving of your automated testing suite, if
> > you'll
> > make it accessible to the public.
> 
> This has nothing to do with automated test suites. The problem with test
> suites is that you can't force everyone to run them, so it's likely that
> people would still miss it.
> 
> The whole point of failing the whole thing is to force people to do the
> right thing irrespective of any test suite or log or whatever. So if I
> work on display and accidentally break VIC initialization, I'm now
> forced to fix VIC initialization if I want to be able to test display.
> 
> > > Perhaps a good middle ground would be to turn initialization failures
> > > into WARN_ON() to increase the chances of them getting notified and then
> > > continue on a best effort basis in the hopes of having enough
> > > initialized to get a message to users.
> > 
> > Good to me, I'll make v2.
> > 
> > > Another alternative would be to
> > > mark essential subdevices (such as the display controller) so that only
> > > they will cause failure to register the whole DRM device.
> > 
> > I don't think that making some subdevice more valuable than the others is
> > a
> > feasible approach, how you are going to differentiate what of the two
> > display controllers is more important than the other.
> 
> I wasn't talking about one display controller vs. another, but rather
> about "optional" subdevices. For example, I'd consider gr2d, gr3d and
> VIC as optional in that they aren't needed to get something on the
> screen. Anything display related would be considered required to make
> sure people get at least a working display, even if all optional sub-
> devices fail.

Well, from a users perspective, likely that display panel is more important 
than HDMI port. It doesn't sound good that display panel won't work because of 
an unrelated HDMI issue (and vice versa).



