Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEDFC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F1B20657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:49:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26F1B20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbeKASvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 14:51:44 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43072 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbeKASvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 14:51:44 -0400
Received: by mail-ed1-f68.google.com with SMTP id y20-v6so16037066eds.10;
        Thu, 01 Nov 2018 02:49:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KiqBjlSGPMyfU1H0z+omrZoqjZ+XM4hWGmuVQ9zNxbw=;
        b=HwZGlRPhhID3/WQOVRnKdPuSypiiG/xv8G6IN/mu4lJFjbQXwp3md4uvN7Kgu4QJh0
         mqEnWLU5felhjP2LHahRQZEML0XzbdKfFLIZxKU5iMYxdX07SwWh9JfZGv+w900xMpbV
         SRozDCynqnWgRNCtiu+Dg20VStoxEsDQgdVgQRK/st74zIu2OZFkOij+Godm59wWlUiJ
         //9Y4RCbvsyJed8pcUhi80JtdrahEeouupcO6yJeXwaQBYM9qK5FRtJrjuD0lvZGP3K6
         kMNCOiXFr0Q0X+K579L8wicOOGB0vmxDCYe67MNXXa+w6JYJcKzE9kL9eYxrT8FoINsN
         x7JA==
X-Gm-Message-State: AGRZ1gLaZNcNJuaifb9Wq/N4JgEFUoLNsq69fRyonNrnUYuoIHz61Zqz
        bi2QNyslgZNx99b8iwnFBFRb009Z9qc=
X-Google-Smtp-Source: AJdET5dgq4Jo48kgqY35wLn7RPIgvCnU/aF0yzzSA4wiSprMxxjfyyL7JEH9WPTelubUJsz2QibfEw==
X-Received: by 2002:a50:cd88:: with SMTP id p8-v6mr4817372edi.151.1541065766545;
        Thu, 01 Nov 2018 02:49:26 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id z7-v6sm5331591ejp.49.2018.11.01.02.49.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 02:49:26 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id f1-v6so1417444wmg.1;
        Thu, 01 Nov 2018 02:49:25 -0700 (PDT)
X-Received: by 2002:a1c:13d2:: with SMTP id 201-v6mr4878438wmt.58.1541065765425;
 Thu, 01 Nov 2018 02:49:25 -0700 (PDT)
MIME-Version: 1.0
References: <20181031183634.29640-1-jagan@amarulasolutions.com>
 <20181031183634.29640-7-jagan@amarulasolutions.com> <CAMty3ZCeZzXYy4XRwTeQjYfpB6KKjEVRWyhjoca9Os4foLYL4g@mail.gmail.com>
 <CAGb2v67xCnH20Hga2P2Ekk3vhhOWUSgtOmRVAte+HDuodjsjkw@mail.gmail.com> <CAMty3ZBNdg43nL-HviyHufwQtTbC4wv20JVYBBT8LDpWiV0wTQ@mail.gmail.com>
In-Reply-To: <CAMty3ZBNdg43nL-HviyHufwQtTbC4wv20JVYBBT8LDpWiV0wTQ@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 1 Nov 2018 17:49:12 +0800
X-Gmail-Original-Message-ID: <CAGb2v66MohJC9fBYhwJgaf+HP_AZb-c5B9CZr1GaAABc+Qj0vA@mail.gmail.com>
Message-ID: <CAGb2v66MohJC9fBYhwJgaf+HP_AZb-c5B9CZr1GaAABc+Qj0vA@mail.gmail.com>
Subject: Re: [RFC PATCH 7/7] arm64: allwinner: h6: orangepi-liet2: Enable
 AP6356S WiFi support
To:     Jagan Teki <jagan@amarulasolutions.com>
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

On Thu, Nov 1, 2018 at 5:08 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> On Thu, Nov 1, 2018 at 1:28 PM Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > On Thu, Nov 1, 2018 at 3:35 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > >
> > > On Thu, Nov 1, 2018 at 12:07 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > > >
> > > > From: Jagan Teki <jagan@openedev.com>
> > > >
> > > > Enable AP6356S WiFi/BT combo chip on Orangepi Lite2 board:
> > > > - WiFi SDIO interface is connected to MMC1
> > > > - WiFi WL-PMU-EN pin connected to gpio PM3: attach to mmc-pwrseq
> > > > - WiFi WL-WAKE-AP pin connected to gpio PM0
> > > > - 32kHz external oscillator gate clock from RTC
> >
> > You never specified a clock rate for it, so it might actually be wrong.
> > The default clock rate would be something "around" 32 kHz, but not very
> > accurate. Meanwhile the WiFi module would have very specific requirements
> > on frequency and accuracy of this clock. The WiFi part doesn't seem to
> > care that much, but the Bluetooth part cares very much. It doesn't work
> > or it would seem to work but you don't get anything off the radio if the
> > frequency is off (as in off-frequency).
>
> True, but why it's not 32K which is stated in manual and schematics do
> we need to measure the actual rate with oscilloscope?

I suppose it's just shorthand. The datasheet describes the actual requirements
for both oscillators, where it clearly states the 32K one should be 32768 Hz.
A scope shouldn't be needed as we expect the board design to at least conform
to constraints outlined in datasheets.

On the side, the LOSC be _around_ 32kHz if you clocked it from the internal
RC oscillator, which is not very stable. This is actually the hardware default.
But the WiFi module (and also the RTC) needs 32.768K, a slight difference,
but enough to throw off calculations for other clocks. When the RTC module
isn't clocked from the external crystal, the RTC clock will drift. This has
been reported and is why we have

    /* Switch to the external, more precise, oscillator */
    writel(SUN6I_LOSC_CTRL_KEY | SUN6I_LOSC_CTRL_EXT_OSC,
           rtc->base + SUN6I_LOSC_CTRL);

in the RTC driver's clock probe function. See these two patches:

    fb61bb82cb46 rtc: sun6i: Switch to the external oscillator
    3855c2c3e546 rtc: sun6i: Expose the 32kHz oscillator

Note the commit message for the second patch is incorrect. We actually force
the RTC module to use the external crystal regardless of the "clocks" property.

I actually forgot about this. So even without assigning clock rates your patch
would work fine. Hope this doesn't confuse you more than it already has.

ChenYu

> > > > Signed-off-by: Jagan Teki <jagan@openedev.com>
> > > > ---
> > > > Note:
> > > > - chip detected, but failed to connect
> > > > [  129.084504] brcmfmac: brcmf_sdio_hostmail: mailbox indicates firmware halted
> > > > [  135.906409] brcmfmac: brcmf_sdio_bus_rxctl: resumed on timeout
> > >
> > > This got fixed. Will send next version.
> >
> > Could you wait until I get my RTC changes out? I also have some Bluetooth
> > patches for AP621x, which is what started all this RTC work, which you might
> > find interesting.
>
> Yes, my intention is the same.
