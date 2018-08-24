Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AB0C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B8F421477
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWuXDRBo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B8F421477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbeHYCk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 22:40:29 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41455 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbeHYCk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 22:40:28 -0400
Received: by mail-pg1-f195.google.com with SMTP id s15-v6so4911873pgv.8;
        Fri, 24 Aug 2018 16:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8kNRto0U3F9tEF2srXYarmJ8ZbgeNyQbA3FiJ41WqF4=;
        b=WWuXDRBou0cXdvG3pTGCX4OVf+YjbsV6oSo6h6n9GofFnIVttaEPOsyoct+rHaNs4v
         bV1jdnaAir11R1slkX1l5Nog01wPjxlFwut9b1PXjcgR/XXyWg5jCDECc3XVTIl2kyUs
         Zo89Mh54xjXnfonyVYyEmj5pDilzHAmNlnb3KMjL6fuMxX45RLcISTBy43c1f67rUTiX
         lGinCr8jXIgyUBCHYHvxwNrGtJ0wXoJwZOtq20b9LuxdQtCPYrJj7ickCw7VQpdWZfhf
         CCkHLCl7Bc9sQbJ66uRoJYDO2VC77BqveCnlvdSIbWc+biJl/9f70PrHZYWyC5TKeCv8
         Lm0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8kNRto0U3F9tEF2srXYarmJ8ZbgeNyQbA3FiJ41WqF4=;
        b=Mip/Ap3c+dJczZTKo3vOKfsa3+hmythWWxcKFUt3dWeH/1OEyazB1LoTFrlduixcTD
         wG4QqH91G/v7Qh/YTj2RQ10hNYpKWsmoi+lVkVEBTeyT1ESZOW5uKoHOEVT+1SuQw8p4
         iqXKFvkWiw/ah6fbXRxexO9MfQFOadmVjB5U4tEVkg6wsOqb7nrOpJ0ftD9Fel8ui1xc
         h2w1l9BED+lJ2MkBZvK9CFk6GnS4uKsvYev0PSKe5rixq5VqLasbI2OpUz86O9RK3ooz
         eYsto8cb3u5+J4x8yDi1qjPykYwVNlAxXq0sHSR1tnuRIw3SEZ1WTo9BCnoXKhk/OAgv
         OLCg==
X-Gm-Message-State: APzg51AQB1ZbAnoxCCywV/FzWlgUZyJKriRArFRmqOHx6XibJI2SpN9Q
        H7LYx+3hVyCdZjhoWVapxE4=
X-Google-Smtp-Source: ANB0Vda3oO1aVAzYGBUHZq8QwV9s7Wi/BwiblR0z5TF9EwaTxyATIbWNWThsoA76C3cMzF2U8CSh8Q==
X-Received: by 2002:a63:2d05:: with SMTP id t5-v6mr3428867pgt.403.1535151828348;
        Fri, 24 Aug 2018 16:03:48 -0700 (PDT)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id r130-v6sm11033550pgr.8.2018.08.24.16.03.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 16:03:47 -0700 (PDT)
Date:   Fri, 24 Aug 2018 16:03:40 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Emmanuel Vadot <manu@bidouilliste.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Emmanuel Vadot <manu@freebsd.org>,
        Chen-Yu Tsai <wens@csie.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Zhang Rui <rui.zhang@intel.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/7] dt-bindings: Add DT bindings documentation for
 Allwinner Thermal Sensor Controller
Message-ID: <20180824230338.GA19399@localhost.localdomain>
References: <20180804070355.14857-1-manu@freebsd.org>
 <20180820111755.rzg7l2lznmbpuf2e@flea>
 <CAL_JsqLVQDRH1esAXghfQdxmp+iorWVCArM2qTwjbgmQzmhzQw@mail.gmail.com>
 <20180820140737.xmqhu5ndqzehvkql@flea>
 <20180820162715.49e6d8a469ece983f3c1d288@bidouilliste.com>
 <20180824145840.isdcg3fr6mw4ntzg@flea>
 <20180824215921.59d060b54eb3a1e7d1552bde@bidouilliste.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20180824215921.59d060b54eb3a1e7d1552bde@bidouilliste.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 09:59:21PM +0200, Emmanuel Vadot wrote:
>=20
>  Hi,
>=20
> On Fri, 24 Aug 2018 16:58:40 +0200
> Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>=20
> > Hi,
> >=20
> > On Mon, Aug 20, 2018 at 04:27:15PM +0200, Emmanuel Vadot wrote:
> > > On Mon, 20 Aug 2018 16:07:37 +0200
> > > Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >=20
> > > > On Mon, Aug 20, 2018 at 07:41:22AM -0600, Rob Herring wrote:
> > > > > On Mon, Aug 20, 2018 at 5:17 AM Maxime Ripard <maxime.ripard@boot=
lin.com> wrote:
> > > > > >
> > > > > > On Sat, Aug 04, 2018 at 09:03:49AM +0200, Emmanuel Vadot wrote:
> > > > > > > This patch adds documentation for Device-Tree bindings for th=
e Allwinner
> > > > > > > Thermal Sensor Controller found on the H3, H5 and A64 SoCs
> > > > > > >
> > > > > > > Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
> > > > > >
> > > > > > I'm not going to merge a binding for a device that doesn't have=
 any
> > > > > > driver implemented at the moment in Linux.
> > > > >=20
> > > > > I'll take it then. Linux is not the only DT client.
> > > >=20
> > > > Then don't complain if we ever have to break the ABI. We never test=
ed
> > > > that hardware, never had any code running on it, and it *will* cause
> > > > some issues. For example, the calibration data have never been used
> > > > and how they should be represented have never been described, since=
 no
> > > > one ever actually tried to use it.
> > > >=20
> > > > And sure, Linux is not the only DT client. Just like FreeBSD isn't.
> > >=20
> > >  What kind of data would you need for me to make things better ?
> > >  We have the driver in FreeBSD for almost two years now, whne I start=
ed
> > > to see how to upstream it I noticed a lot of problems and spent 4 or 5
> > > days to try on all the SoCs mentionned in the serie, the only SoC I
> > > didn't include it the A83T as for some reason I couldn't make the
> > > driver work.
> >=20
> > Do you have a link to that driver?=20
>=20
>  https://github.com/freebsd/freebsd/blob/master/sys/arm/allwinner/aw_ther=
mal.c
>=20
> > How and how much did you test it?
>=20
>  Using a cheap IR thermometer as it's all I can afford.
>  Then running multiples cpufreq-a53 process and comparing the result.
>  Did the same without using the calibration data, result where closer
> when I used them.
>=20
> > Are you using the calibration data stored in the SID?
>=20
>  Yes, which is why the serie contain the nvmem cell for the SID.
>=20
> >=20
> > > I just hope that you understand that we cannot wait for Linux to
> > > have a driver to have some bindings.
> >=20
> > Just like I'm sure you can understand that just merging the DT bits
> > without testing anything caused some troubles in the past, and I don't
> > want to discover it in a year from now.
>=20
>  I do, I don't like wrong DT info as much as you do I think. I had
> the unfortunate event to find that the sun4i-a10-timer compatible used
> in every soc is plain wrong for !A10 and !A13, patches comming soon.
>  I want those bits merged but I also want that they reflect reality,
> this is not a hard driver to do, NetBSD also have one I think, maybe
> OpenBSD do to.


I would prefer to see a series of DT bindings + driver. Can you send
your next iteration with the driver so we can review both together?

>=20
> > Maxime
> >=20
> > --=20
> > Maxime Ripard, Bootlin
> > Embedded Linux and Kernel engineering
> > https://bootlin.com
>=20
>=20
> --=20
> Emmanuel Vadot <manu@bidouilliste.com> <manu@freebsd.org>
