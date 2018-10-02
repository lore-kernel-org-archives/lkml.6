Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9A2C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 16:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A45822064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 16:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tjader-xyz.20150623.gappssmtp.com header.i=@tjader-xyz.20150623.gappssmtp.com header.b="wyb6dxsJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A45822064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tjader.xyz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbeJBXcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 19:32:03 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36762 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbeJBXcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 19:32:03 -0400
Received: by mail-ot1-f67.google.com with SMTP id c18-v6so2585291otm.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 09:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tjader-xyz.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9O0omtGSjzoyL2jCP/bfMQT09AxOFjStMl9Y8N+0pwM=;
        b=wyb6dxsJcyihIOjbvmMJzcPezz8U6xBuH5Bz+5U2ZWFMFaiVINSNBYTjUhqc/r/YR9
         Ab4wKwB5frgJaCcW9ntAtoRyhcZVltTnti/7Mfg4IsRbNIxOvPGUT9Y5zbbPANNszDrW
         orHVU5RcPnaKiuqYyqHTiHM7H8ZnfA1128EjPRStOoUfBXIByv/j4N9o2gf4J9hAtPBw
         gFY0Gor+d12FansnHsJ0lEH5jFAx9ubZYeUkA7vJA3R32bjYSMN8mtA1JgbIyqAh5WU3
         5nEkfgrJaQuQh/vqqTENxe/kBShmGJrzUyBAbCBj07IJ9ypOOjyhjf6dbE830SwJHT4e
         XAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9O0omtGSjzoyL2jCP/bfMQT09AxOFjStMl9Y8N+0pwM=;
        b=a/3gRmbFci50bNeAG4O25M4c5aiH/NLsycnaiwLmILlpnyLG7Dw7WdJ9QqL0Osh/YH
         0lV0/hEzNNWD0SeoOvh/sxXacFAACiZczJ7n1IabEoDi90nvfniVmxMMWnvGVlJ5onLQ
         qyxza6IacIsoxm3mbguX4JC0anshj9MB7uvUoYguAtXUm6Xf/oSfBgRoLDbrpf4eZvSW
         lYRfhE/bepRVygUB0y1ACkR/zyX+7ciClc8JE/SY+A8k2xiXRBUNJIRXpllwIazHwUdf
         py0P9xKhrx+gYpVSFxtYaobhtrTSHZROrNCL3bWlG8ITmRIESPfSLehCtaGT0/rZoL4X
         lehQ==
X-Gm-Message-State: ABuFfojcETa2EofkARQsBJZpQ0bk4Bx3hpp8HqgRQavOBXgDqKYv2FSt
        qaETDrupOdeuzfHeVzAPqkoYlpGRciBM/GyKcI7UEw==
X-Google-Smtp-Source: ACcGV61/lzitmgsaTs2crm9ku6vA1RHb3j8Neut87LiY7Cw+VMe/kLlI6HwL4V2Mef1ya4H+myEQJHqQjGI1va5F2FM=
X-Received: by 2002:a9d:22a1:: with SMTP id y30-v6mr9223944ota.127.1538498865315;
 Tue, 02 Oct 2018 09:47:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180919141815.18737-1-rodrigo@tjader.xyz> <20180921142811.h5jraemk565alh3i@flea>
 <CAG7TQgE_KU_cK_4E+NG8Qcw-QB2=C6YoqBYR2svmWxywFyySCw@mail.gmail.com>
 <20180925090139.qbu6tqav5oth7zkw@flea> <CAG7TQgFTsR4pf4jAcWMFoOmiP7AXYqjts60RP2kuJGU44AcQJQ@mail.gmail.com>
 <20180927081711.llmwnvpu73loe5iv@flea> <CAG7TQgGMkvBnNE_WEth8gscKxN3qN8a44mNMWz3QP-2+JKfOzg@mail.gmail.com>
 <20180929154754.abz3byvrufvnf4dq@flea> <CAG7TQgGS7DkLpNVYqfCD-9vMZkeY6r+L-5oXKWef3x-OVbqjtw@mail.gmail.com>
 <20181002131312.soqwybsohdifvso3@flea>
In-Reply-To: <20181002131312.soqwybsohdifvso3@flea>
From:   =?UTF-8?Q?Rodrigo_Exterck=C3=B6tter_Tj=C3=A4der?= 
        <rodrigo@tjader.xyz>
Date:   Tue, 2 Oct 2018 13:47:33 -0300
Message-ID: <CAG7TQgHWCJTaM+pFYFq0_8nWg7sA+d0huqu96sjhqZfeHwqbGQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: allwinner: Olimex A64-OLinuXino: enable eMMC.
To:     maxime.ripard@bootlin.com
Cc:     wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 2, 2018 at 10:13 AM Maxime Ripard <maxime.ripard@bootlin.com> w=
rote:
>
> On Sat, Sep 29, 2018 at 01:51:02PM -0300, Rodrigo Exterck=C3=B6tter Tj=C3=
=A4der wrote:
> > On Sat, Sep 29, 2018 at 12:47 PM Maxime Ripard
> > <maxime.ripard@bootlin.com> wrote:
> > > > We can't even remove a node from a device tree? Removing the WiFi n=
ode
> > > > from the current tree would make it correspond to the variant with =
the
> > > > least features.
> > >
> > > Not really. How pissed would you be if you were a user, had wifi
> > > running on your board, you upgrade your kernel, and then it's just
> > > gone? :)
> >
> > That would suck, but what about someone who has the board with no wifi
> > and problems start happening because the wifi is enabled on the device
> > tree?
>
> Did that happen or is it a theoretical issue?

Theoretical. I don't know how likely having a non-existant device
enabled is to cause problems.

> > > > About device tree overlays, I read overlay-notes.txt, but I went
> > > > looking for an example with "git grep /plugin/ arch" and it came
> > > > empty. Is this approach not used for other boards?
> > >
> > > It is, it's simply not stored in the kernel, but through other third
> > > party repos.
> >
> > So that would mean that it's up to every distro to support the boards
> > instead of relying on mainline support?
>
> Distros would have to integrate it either way. One would need to
> detect and / or ask for the board variant in order to load say the BT
> stack, or to know if you want to boot from the eMMC or from the SD
> card.

Yeah, but now if a bug is found in the device tree it has to be fixed
once per distro instead of only on mainline.

> > > > Does the overlay approach make the device available at boot time? T=
hat
> > > > is important for a storage device such as eMMC.
> > > >
> > > > I went with the separate dts approach because that's what I saw was
> > > > done for other similar cases, like Pine64 and Pine64+, OLinuXino-LI=
ME2
> > > > and its variant with eMMC, among others.
> > >
> > > Yeah, but in all these cases, it was done from day one, not after the
> > > facts.
> >
> > For the LIME2 the dts for the emmc variant was commited two years
> > after the base LIME2 dts.
> >
> > What if instead of keeping the current dt for the least featureful
> > model we keep it for the most featureful model and create new dts for
> > the two less featureful models?
>
> This is a different story though. The LIME2 eMMC variant was created
> way after the original LIME2, with a separate name.

What about the idea of keeping the current dt for the most featureful
variant and creating new dts for the other two?

That would make it so that no one's device stops working and would
have mailine support for all three devices.

Also, the current device tree doesn't represent any existing device:
it has wifi on but no emmc. That variation does not exist.
