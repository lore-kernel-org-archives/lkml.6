Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E491C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A3E220659
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:03:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A3E220659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440474AbeKXCsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 21:48:03 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45897 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436604AbeKXCsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 21:48:03 -0500
Received: by mail-ed1-f68.google.com with SMTP id d39so10605755edb.12;
        Fri, 23 Nov 2018 08:03:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6SnfM2u1VaB93hc95fAYkUFoAXf1GhMo4+6x2q/JGGw=;
        b=WEVVI1NQ7/cOW44Mx0biju/Bdz93V1nO3OWLVF5oIezNlCSjpNzHp5pD+jX5forncD
         USrQgi/BTKtCYa9/GbwoeJdCLlkiKgyH8ltJcSMad2pdcsrF7/efxvHGpbLjFBGJfIFF
         fU47yJMshKg9GPf+6TvJp43JufU9159poi9C2lY2oPIbqKLPWRKrDLZXkdO19FbBSk6G
         KtpgsqcLE6KB8cKi+CnmnfeRVN+EMgE1aKTR8kNQlxEyD1n2BYNC1tLSCJvsASKy3LBS
         fsx5YJoCzrof+3vCvpanx8OvHeAc+pqBbBAo7PqMaRb2n6DbdGKUcSBy4VDe8YXJi1z5
         2rCw==
X-Gm-Message-State: AA+aEWaodtiy27KPjzOK6XuqOrNYdSv7RPsKpDioBU9giVIjpPjBnXHu
        zep9dbM3Qm9R09ekGhIGw22sT4Lg6Cw=
X-Google-Smtp-Source: AFSGD/X0Mw6ss64H36EjEgG6YF8F8Pak/1iIGDFInrDNOuEp5np03ovOVb6GZW4J115OcZ7IS36uSg==
X-Received: by 2002:a50:af26:: with SMTP id g35-v6mr7419233edd.192.1542988994509;
        Fri, 23 Nov 2018 08:03:14 -0800 (PST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id b11-v6sm4133104ejd.16.2018.11.23.08.03.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 08:03:13 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id l9so12800880wrt.13;
        Fri, 23 Nov 2018 08:03:12 -0800 (PST)
X-Received: by 2002:adf:891a:: with SMTP id s26mr14372986wrs.44.1542988992220;
 Fri, 23 Nov 2018 08:03:12 -0800 (PST)
MIME-Version: 1.0
References: <20181122102325.29495-1-wens@csie.org> <2007258.VzpTJLJblp@anarsoul-thinkpad>
 <CAGb2v67J6ptnr_uPW0+H=WvCdAVzZ1Sw1wTUQrr6KrNsc_mXKQ@mail.gmail.com>
In-Reply-To: <CAGb2v67J6ptnr_uPW0+H=WvCdAVzZ1Sw1wTUQrr6KrNsc_mXKQ@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sat, 24 Nov 2018 00:03:01 +0800
X-Gmail-Original-Message-ID: <CAGb2v66e7KmCLDgj8XFAbNhfg5txBnxE5svP30Zm0=p30mBF2w@mail.gmail.com>
Message-ID: <CAGb2v66e7KmCLDgj8XFAbNhfg5txBnxE5svP30Zm0=p30mBF2w@mail.gmail.com>
Subject: Re: [PATCH v9 0/8] Add support for audiocodec in Allwinner A64
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com,
        Vasily Khoruzhick <anarsoul@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 12:37 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Fri, Nov 23, 2018 at 12:26 PM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> >
> > On Thursday, November 22, 2018 2:23:17 AM PST Chen-Yu Tsai wrote:
> > > Hi everyone,
> > >
> > > This is v9 of the A64 audio codec series, originally started by Vasily.
> > > These are the last changes to make the A64 audio codec work correctly,
> > > and be accurately represented in the device tree and in software.
> > >
> > > Notably, the new driver changes cover regulator supplies for the simple
> > > audio amplifier, which is used in the Pinebook for the internal
> > > speakers, and the audio codec's internal headphone amp. There's also an
> > > extra patch that enables SDM fractional clock support for the audio PLL
> > > on the A64, which gives us accurate audio playback.
> > >
> > > Patch 1 & 2 add the cpvdd regulator supply to the sun50i-codec-analog
> > > dt bindings & driver.
> > >
> > > Patch 3 & 4 add a regulator supply to the simple-audio-amplifier dt
> > > bindings & driver.
> > >
> > > Patch 5 adds SDM fractional clock support for the audio PLL on the A64.
> > >
> > > Patch 6 ~ 8 add the device tree bits and enables audio on several
> > > boards.
> > >
> > > I have one extra patch for the Bananapi M64 that's not included here,
> > > as I'm waiting for an accessory to test the microphone bias. I'll send
> > > that one out once it's tested.
> > >
> > > As always, we'll take the clock and dts patches after Mark has merged
> > > the ASoC ones.
> > >
> > > And a big thanks to Vasily for having worked on this for so long.
> >
> > Thank you for picking it up!
> >
> > Just a minor note: hpvcc-supply should be a property of codec_analog in
> > sun50i-a64-pinebook.dts
>
> Thanks. I'll fix that up when applying.

Merged the remaining 4 patches with the misplaced regulator supply property
in the last patch fixed.

ChenYu

> > Otherwise looks fine, tested on Pinebook and Pine64-LTS.
> >
> > Tested-by: Vasily Khoruzhick <anarsoul@gmail.com>
>
> Great!
>
> ChenYu
