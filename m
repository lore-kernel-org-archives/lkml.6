Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1692BC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C00D2204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ZuHyxirq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C00D2204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbeKASKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 14:10:42 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:32803 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbeKASKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 14:10:42 -0400
Received: by mail-io1-f65.google.com with SMTP id f12-v6so8456930iog.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 02:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m5h20GUykvwxNqrxE/u//qTABB49PVKmBLpCXGRhzYA=;
        b=ZuHyxirqXtRgbpnsoCyI/5bL3YvPNUoT9jwMCJ3XvEhbs+fGd8m0tRw6N4Ms2R+1vU
         H0RyV50fY39DA23Yn8bc8rC80Hj7qc5dIXPTMqyzRQjL5czbosmpzIVdzWKwp35i04Y2
         FWZhA5PHxk5Ar4NaUk5dQcqU6yUhoB6c3nRds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m5h20GUykvwxNqrxE/u//qTABB49PVKmBLpCXGRhzYA=;
        b=UFqFE13QoKXVto4aChyg4XSFf7PEMqmOgRKrE7Gvfz/quPTOp7pdLnR32l46V4TrrG
         MjfyiYvUAhJ4W+8AteJiC+Bgh8ioxnK8Le1kAzaLmS+vbzFh0eHRUmGG6ZkHQ5XLOV0+
         4mhWkgmfbnJFysNEJ7JG/M90udJ4dt9UM/cgm0743iRiqEAfmVwF0wluaoJATTGC6FBA
         4uDKEVBqNEqxXruayKQFQsGrFzTgT+Cp9S/yV2ZalHgvqAvOoUIPITACvvSLs6pu7mmu
         CaoLFPyqdqCoiAMYEtTV22GX1z8aCHaRIGY45l2MmYLDl7MS8toQft3w+hicjRA+tCLC
         Ebog==
X-Gm-Message-State: AGRZ1gL5352ZgeWN8kBynuEpGj37AZKUlSm2sytXz22wuNVgsvfOUTha
        S/wP9O23ICub8h/ar0wYs/VHmAFrpKZFSHqvQ0WEIw==
X-Google-Smtp-Source: AJdET5cyf4mxLH2L2LsjILd+HUMr6cnYQWIkWN7jrqu/BESgs/fat6IMzc/rIrDZ0Z4Oe5htl7BXPsEQdf2guaisgm4=
X-Received: by 2002:a6b:918b:: with SMTP id t133-v6mr4673021iod.267.1541063313839;
 Thu, 01 Nov 2018 02:08:33 -0700 (PDT)
MIME-Version: 1.0
References: <20181031183634.29640-1-jagan@amarulasolutions.com>
 <20181031183634.29640-7-jagan@amarulasolutions.com> <CAMty3ZCeZzXYy4XRwTeQjYfpB6KKjEVRWyhjoca9Os4foLYL4g@mail.gmail.com>
 <CAGb2v67xCnH20Hga2P2Ekk3vhhOWUSgtOmRVAte+HDuodjsjkw@mail.gmail.com>
In-Reply-To: <CAGb2v67xCnH20Hga2P2Ekk3vhhOWUSgtOmRVAte+HDuodjsjkw@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 1 Nov 2018 14:38:21 +0530
Message-ID: <CAMty3ZBNdg43nL-HviyHufwQtTbC4wv20JVYBBT8LDpWiV0wTQ@mail.gmail.com>
Subject: Re: [RFC PATCH 7/7] arm64: allwinner: h6: orangepi-liet2: Enable
 AP6356S WiFi support
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com, Jagan Teki <jagan@openedev.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 1:28 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Thu, Nov 1, 2018 at 3:35 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > On Thu, Nov 1, 2018 at 12:07 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > >
> > > From: Jagan Teki <jagan@openedev.com>
> > >
> > > Enable AP6356S WiFi/BT combo chip on Orangepi Lite2 board:
> > > - WiFi SDIO interface is connected to MMC1
> > > - WiFi WL-PMU-EN pin connected to gpio PM3: attach to mmc-pwrseq
> > > - WiFi WL-WAKE-AP pin connected to gpio PM0
> > > - 32kHz external oscillator gate clock from RTC
>
> You never specified a clock rate for it, so it might actually be wrong.
> The default clock rate would be something "around" 32 kHz, but not very
> accurate. Meanwhile the WiFi module would have very specific requirements
> on frequency and accuracy of this clock. The WiFi part doesn't seem to
> care that much, but the Bluetooth part cares very much. It doesn't work
> or it would seem to work but you don't get anything off the radio if the
> frequency is off (as in off-frequency).

True, but why it's not 32K which is stated in manual and schematics do
we need to measure the actual rate with oscilloscope?

>
> > >
> > > Signed-off-by: Jagan Teki <jagan@openedev.com>
> > > ---
> > > Note:
> > > - chip detected, but failed to connect
> > > [  129.084504] brcmfmac: brcmf_sdio_hostmail: mailbox indicates firmware halted
> > > [  135.906409] brcmfmac: brcmf_sdio_bus_rxctl: resumed on timeout
> >
> > This got fixed. Will send next version.
>
> Could you wait until I get my RTC changes out? I also have some Bluetooth
> patches for AP621x, which is what started all this RTC work, which you might
> find interesting.

Yes, my intention is the same.
