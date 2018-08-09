Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD898C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B47921BC9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0dtwzQ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B47921BC9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732120AbeHIPRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 11:17:53 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33687 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbeHIPRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 11:17:53 -0400
Received: by mail-ed1-f65.google.com with SMTP id x5-v6so2842371edr.0;
        Thu, 09 Aug 2018 05:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MxH6c6JJKZrd0iG2UqFIBuHn0Ii0F/la4VWA2YMICNU=;
        b=A0dtwzQ8qpkVEVePPT+RXqY8ZgJ7o6uBwvJXvGkm/DHHFO7IZExDosCb7qB5tI3aZr
         xuaIEWrssKJA9IpRqWl9jCaQ8kDhP2iQuytwKtjY2lHmMuj78j2fpJgxNSLYmX09uS6k
         pIu2k7hEiCNNGQMXyo/PntHxCgGi6fyWJkSxqsZSCJZE2qy0NSmXdx+MBq12IC9k9hih
         2lNfcdzQPap8traVSyjRVr/T2c2iNcbMbItMQw9WsKpd2HXTDAxZ84BOefPRtNEKB5d1
         FnqqfyTW9OO3G4W1BTE6UtgJbumlESbQBWmT6l0wcyBeV8qJ93mXo7CC+ERGyXF3xg+w
         8lPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MxH6c6JJKZrd0iG2UqFIBuHn0Ii0F/la4VWA2YMICNU=;
        b=n6YiZLU93p2HVkTw6/AC+xEBAUVZYFVJuAP6CyoeDhlQ50sQ/q03376i0snd7rOG4Q
         7bZXkV+vHBGpnE+8CpVspW+hqvnO4D6CKAcWzaH4VRN5pjTNVrM0NxfPRVnydKlWxna0
         jCHS4DrcQeAHS0Uc9s7+DTKbO81W3UpifxZIbiDThda+bvKyuhaKE/Lpc48dLVAIJqZU
         lJOsUYAbrXwBlbKCfa1W0n+M8o85+ZwzZ/vBYzzyNto+kosSa0WA4hyRY+PLdUF6JrS0
         vjRxB0RmcN01WquyzORNRxDQ/uphqzSPxAWlHFCsMctsu08l3qf0oj0yABenIVcgU8Bf
         54jw==
X-Gm-Message-State: AOUpUlH/rMSGeaxYFD/6OSHdcR4OGGzWK92hOcaJ3sj/L48dRLyFo3XZ
        iMwdAxtj8cIXOG87388+kNQ=
X-Google-Smtp-Source: AA+uWPxWkETBL7oPEmS6CkHHsCY2h90faCtUtvcSnjLgnqChqkWlfxiodBryCpqpkoaA+0BEH3I0lQ==
X-Received: by 2002:a50:97fc:: with SMTP id f57-v6mr3024170edb.21.1533819185276;
        Thu, 09 Aug 2018 05:53:05 -0700 (PDT)
Received: from dimapc.localnet (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id a8-v6sm7874890eda.27.2018.08.09.05.53.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 05:53:04 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Mikko Perttunen <cyndis@kapsi.fi>, Kyle Evans <kvans32@gmail.com>,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] gpu: host1x: Ignore clients initialization failure
Date:   Thu, 09 Aug 2018 15:53:03 +0300
Message-ID: <1672653.y032a1rHIh@dimapc>
In-Reply-To: <20180809104541.GC21639@ulmo>
References: <20180801150807.15926-1-digetx@gmail.com> <4457259.6qKMIOUXSS@dimapc> <20180809104541.GC21639@ulmo>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 9 August 2018 13:45:41 MSK Thierry Reding wrote:
> On Fri, Aug 03, 2018 at 02:30:47PM +0300, Dmitry Osipenko wrote:
> > On Friday, 3 August 2018 13:50:55 MSK Thierry Reding wrote:
> > > On Wed, Aug 01, 2018 at 06:08:07PM +0300, Dmitry Osipenko wrote:
> > > > From time to time new bugs are popping up, causing some host1x client
> > > > to
> > > > fail its initialization. Currently a single clients initialization
> > > > failure
> > > > causes whole host1x device registration to fail, as a result a single
> > > > DRM
> > > > sub-device initialization failure makes whole DRM initialization to
> > > > fail.
> > > > Let's ignore clients initialization failure, as a result display panel
> > > > lights up even if some DRM clients (say GR2D or VIC) fail to
> > > > initialize.
> > > > 
> > > > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > > > ---
> > > > 
> > > >  drivers/gpu/host1x/bus.c | 18 +++++++-----------
> > > >  1 file changed, 7 insertions(+), 11 deletions(-)
> > > 
> > > This is actually done on purpose. I can't think of a case where we would
> > > actively like to keep a half-broken DRM device operational. The errors
> > > that you're talking about should only happen during development,
> > 
> > [only in a perfect world]
> 
> gr2d and VIC are fairly deterministic. What are the errors you are
> seeing that cause initialization failure?

Right now there are no specific errors. There is only a known trouble with the 
ARM_DMA_USE_IOMMU, but that causes to fail all of the clients.

> Note that it is possible for
> these devices to malfunction even if initialization succeeds. A failure
> to initialize can only happen if there's something wrong in the device
> tree, firmware is missing (in case of VIC) or a regression was
> introduced in some subsystem that causes a failure (maybe deferred probe
> or something similar).

A missing firmware is an actual good example. Though can't VIC driver be 
changed to load firmware at the time of a its first use by userspace? It 
should be very annoying that kernel driver forces you to churn with initramfs.

> > > and the
> > > device not showing up is a pretty good indicator that something is wrong
> > > as opposed to everything booting normally and then getting some cryptic
> > > error at runtime because one of the clients didn't initialize.
> > 
> > If machine doesn't have a serial port and it doesn't have ssh server
> > running or network doesn't come up, you'll end up with a completely
> > dysfunctional piece of hardware. Hence there is no chance for you to even
> > check what is wrong. The argument about a cryptic error doesn't make much
> > sense, you have to improve your runtime as well (and you'll get a error
> > message in the kernels log).
> 
> You make a good point here. I'm not aware of any devices we support in
> the kernel that don't have a serial console, but that doesn't mean the
> kernel could be used on an "unsupported" device  that doesn't have one.

AFAIK, enabling serial on AC100 require soldering iron.

> > > From my perspective, all clients should always be operational in
> > > whatever baseline version you use. If it isn't that's a bug that should
> > > be fixed. Ideally those bugs should get fixed before making it into a
> > > baseline version (mainline, linux-next, ...), so that this never impacts
> > > even developers, unless they break it themselves, in which case refusing
> > > to register the DRM device is a pretty good incentive to fix it.
> > 
> > Sounds like you're assuming that only kernel developers are supposed to
> > use
> > Tegra, though at least (for now) for upstream it is kinda true. Of course
> > that could be changed ;-)
> 
> That's not at all what I'm saying. What I am saying is that we should
> make it difficult for developers to break the kernel in a way that would
> put users into a position that is difficult to get themselves out of. If
> we refuse to register the complete DRM device in case some subdevice
> fails to initialize we increase the chances of developers noticing and
> fixing it.
> 
> If all we do on failure is output an error message, it's very likely to
> go unnoticed. Developers are likely to check specifically the
> functionality that they're working on and ignore failures that they may
> have caused in other parts of the code as a side-effect of their current
> work.

I can try to help with improving of your automated testing suite, if you'll 
make it accessible to the public.

> Perhaps a good middle ground would be to turn initialization failures
> into WARN_ON() to increase the chances of them getting notified and then
> continue on a best effort basis in the hopes of having enough
> initialized to get a message to users.

Good to me, I'll make v2.

> Another alternative would be to
> mark essential subdevices (such as the display controller) so that only
> they will cause failure to register the whole DRM device.

I don't think that making some subdevice more valuable than the others is a 
feasible approach, how you are going to differentiate what of the two display 
controllers is more important than the other.



