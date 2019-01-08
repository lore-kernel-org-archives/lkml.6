Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E644C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6734A2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbfAHIxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 03:53:35 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34096 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfAHIxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 03:53:35 -0500
Received: by mail-qt1-f194.google.com with SMTP id r14so3556974qtp.1;
        Tue, 08 Jan 2019 00:53:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fDVwSAD8qDmeIv3fPvAqbbZcOdV92dALFTvIveYIqG8=;
        b=qHHV/1xhlQaF/73Eyll92xfOSAQvzeN0jnJNKpm+X6p01t0RP1eSqV2s1XQz/mwjPh
         WHm8dJMWYUcsds4cfOoSz+ICoSMJQIhlMFxkAAyoSRxqzYiysYxVkhxvylVsstDtPIoG
         DrZDz3y8MiPaRTUo0ORZrkdrJz8JoAVagjHa4SdkvrWMe1MV5KmgJ1fCxBWnqkiFuxDV
         ocejl32p5NWMQ+tn2apw0VK7C5NnQj7/gXm0NYv05zshqOcaH1y7YTCE0TAkYWkEs1EY
         QtMjLvc7ztyjcNuPxflJdqlVoGBBI+qB+5jijn/+wWBLqak0L7W0ofIqJCiuMkPPNBFB
         Dqqw==
X-Gm-Message-State: AJcUukco3eX8j8R88AvqDSOGMatYtxI/NkUq6Sd+SdA2UlVQu0vrkLqG
        v4AYSrmlCj0glS/W9AC6KP83/fqGN6XaXeoE7kQqM5VM4Kw=
X-Google-Smtp-Source: ALg8bN7YKtLtiEkKKnQmQ3h0mUr+6IwVvDRRcJjv2gpaJUMX+g3cezyMspONmmiMbmmUjZ5laGuxoFdQd6yQ7jIJvMI=
X-Received: by 2002:ac8:7451:: with SMTP id h17mr776706qtr.319.1546937613697;
 Tue, 08 Jan 2019 00:53:33 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNARQggM3aKEPRKJqa4tunFAfmfErMZuS-rrnRv6UB1VpPQ@mail.gmail.com>
 <CAHk-=wiLt3rgeyM3BWAd5VJrKcnxxuHybwoQiDGMgyspo6oXDg@mail.gmail.com>
 <CAK7LNASpO86yNe4BWBYnfd+r82=d_ofxYybLi_aM+4+dgf46+A@mail.gmail.com> <20190108004255.tq2fffkbxffrzsv3@mail.google.com>
In-Reply-To: <20190108004255.tq2fffkbxffrzsv3@mail.google.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 8 Jan 2019 09:53:17 +0100
Message-ID: <CAK8P3a38jvLjEY5Wx=wx5Ou-sPF_-0rdguAXK9eOkyyDqx=kzQ@mail.gmail.com>
Subject: Re: [GIT PULL 2/4] Kbuild updates for v4.21 part2
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 1:43 AM Changbin Du <changbin.du@gmail.com> wrote:
>
> On Mon, Jan 07, 2019 at 01:32:56PM +0900, Masahiro Yamada wrote:
> > (+CC Changbin Du, Arnd Bergmann)
> >
> >
> >
> [...]
> > > This branch already added a couple of extra inline markers just to
> > > make code work reasonably. How many tens (or hundreds) got missed just
> > > because the build still works, but the lack of inlining means that we
> > > generate completely garbage code?
> >
> >
> > I do not have the exact number, but
> > my impression was "not so many".
> >
> > Changbin and Arnd might have better insight.
> > They were trying to eliminate potential problems beforehand.
> >
> > For example,
> > 7e17916b
> > 412dd15c
> > 08813e0e
> >
> Yes, the case is not so many. At the beginning, I also thought this could
> require incredible change. But after trying, just found it is not so bad. I have
> a couple of patches to fix the remaing warnings which adds 'inline' or '_init'
> markers for related functions.
>
> I promise that all warnings get fixed with new version. And since I only have
> coressponding setup to fully test x86 and ARM platform, I think we could make
> this new option depend on x86 or arm temparaly so untested platforms will
> not complain anymore.
>
> Linus, is this good for you? Thank you for revewing.

I actually never followed up on this in November, as I was busy trying to
get more of the y2038 work done. In my randconfig tree, I have a number
patches that fix individual drivers after your patches so I can get back to a
warning-free randconfig build overall, but I haven't had a chance to separate
out everything that is needed here from other randconfig fixes (e.g. gcc-9
and clang stuff).

I tried to get most changes into a single patch that only marks functions
inline, see diffstat below. If we want to go ahead with
CONFIG_NO_AUTO_INLINE, I can try to get that into a shape that
can be submitted with a proper changelog etc.

      Arnd

commit 6985383a091f4be1a2695b0d20108998237651fa
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Sat Nov 3 22:13:15 2018 +0100

    make more functions inline

    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

 arch/x86/entry/vsyscall/vsyscall_64.c           |  2 +-
 arch/x86/kernel/cpu/microcode/intel.c           |  2 +-
 arch/x86/kernel/ftrace.c                        |  2 +-
 arch/x86/kernel/hw_breakpoint.c                 |  6 +++---
 arch/x86/kernel/quirks.c                        |  2 +-
 drivers/clocksource/timer-nps.c                 |  6 +++---
 drivers/dma/stm32-mdma.c                        | 20 ++++++++++----------
 drivers/gpio/gpio-aspeed.c                      |  2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c    |  2 +-
 drivers/infiniband/hw/mlx5/cq.c                 |  6 +++---
 drivers/media/cec/cec-pin.c                     | 55
+++++++++++++++++++++++++++++++------------------------
 drivers/mmc/host/sdhci-pci-core.c               |  6 +++---
 drivers/net/ethernet/broadcom/cnic.c            | 18 +++++++++++++-----
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c   |  5 +++--
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c | 16 ++++++++++++----
 drivers/net/wireless/ti/wlcore/sdio.c           |  2 +-
 drivers/pci/controller/pci-xgene.c              |  2 +-
 drivers/phy/socionext/phy-uniphier-usb3hs.c     |  6 +++---
 drivers/scsi/ufs/ufs-qcom.c                     |  2 +-
 drivers/soc/qcom/wcnss_ctrl.c                   |  2 +-
 drivers/staging/axis-fifo/axis-fifo.c           |  4 ++--
 drivers/staging/comedi/drivers/pcl816.c         |  2 +-
 drivers/staging/comedi/drivers/pcl818.c         |  2 +-
 drivers/thermal/tegra/soctherm.c                |  2 +-
 drivers/thermal/tegra/tegra-bpmp-thermal.c      |  4 ++--
 drivers/tty/serial/sh-sci.c                     |  4 ++--
 drivers/video/fbdev/i740fb.c                    |  2 +-
 net/vmw_vsock/vmci_transport.c                  |  2 +-
 28 files changed, 105 insertions(+), 81 deletions(-)
