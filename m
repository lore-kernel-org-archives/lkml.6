Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570CFC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 19:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1ED12150F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 19:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bidouilliste.com header.i=@bidouilliste.com header.b="fjAxzQLi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1ED12150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bidouilliste.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbeHXXf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 19:35:28 -0400
Received: from mail.blih.net ([212.83.177.182]:50426 "EHLO mail.blih.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbeHXXf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 19:35:28 -0400
Received: from mail.blih.net (mail.blih.net [212.83.177.182])
        by mail.blih.net (OpenSMTPD) with ESMTP id cf1c8e7b;
        Fri, 24 Aug 2018 21:59:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=bidouilliste.com; h=date
        :from:to:cc:subject:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=mail;
         bh=OendLtYs339simp9MYyk/w/oSig=; b=fjAxzQLiFkq5aVic4m/+x+QePJP4
        WgGG5kMMaJ9ZS96Ec8ayrquZ23OOwv/J6uhToGwrniKT2D5qLG/Bcj/v6eqvkv6n
        B5FYxE558xTfIgKnN/pSOHJeBZSj3zxILZ8jxUM1HnsBC7B5HDes2dqKVX1qumrq
        GdAoFtKWdrNCsYM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=bidouilliste.com; h=date
        :from:to:cc:subject:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; q=dns; s=
        mail; b=eRe79pifQwYQy50PSAV+GbtFG/uSieNiLsCJHX1XmbTW2Bs5WKbXzlZY
        9dX8w3Jp1tBKmTyADRivqdQUezm8oXZs3ieVhVrHZA692ByVNK3wmBw7OaHCfhtv
        XHHoLKiiUusugfZ9m0DiXHp/POWGZZC6PX7CtMq4aybY1kf5QNw=
Received: from skull.home.blih.net (ip-9.net-89-3-105.rev.numericable.fr [89.3.105.9])
        by mail.blih.net (OpenSMTPD) with ESMTPSA id b00b65ab
        TLS version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO;
        Fri, 24 Aug 2018 21:59:21 +0200 (CEST)
Date:   Fri, 24 Aug 2018 21:59:21 +0200
From:   Emmanuel Vadot <manu@bidouilliste.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eduardo Valentin <edubezval@gmail.com>,
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
Message-Id: <20180824215921.59d060b54eb3a1e7d1552bde@bidouilliste.com>
In-Reply-To: <20180824145840.isdcg3fr6mw4ntzg@flea>
References: <20180804070355.14857-1-manu@freebsd.org>
        <20180820111755.rzg7l2lznmbpuf2e@flea>
        <CAL_JsqLVQDRH1esAXghfQdxmp+iorWVCArM2qTwjbgmQzmhzQw@mail.gmail.com>
        <20180820140737.xmqhu5ndqzehvkql@flea>
        <20180820162715.49e6d8a469ece983f3c1d288@bidouilliste.com>
        <20180824145840.isdcg3fr6mw4ntzg@flea>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; amd64-portbld-freebsd12.0)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi,

On Fri, 24 Aug 2018 16:58:40 +0200
Maxime Ripard <maxime.ripard@bootlin.com> wrote:

> Hi,
> 
> On Mon, Aug 20, 2018 at 04:27:15PM +0200, Emmanuel Vadot wrote:
> > On Mon, 20 Aug 2018 16:07:37 +0200
> > Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > 
> > > On Mon, Aug 20, 2018 at 07:41:22AM -0600, Rob Herring wrote:
> > > > On Mon, Aug 20, 2018 at 5:17 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > > >
> > > > > On Sat, Aug 04, 2018 at 09:03:49AM +0200, Emmanuel Vadot wrote:
> > > > > > This patch adds documentation for Device-Tree bindings for the Allwinner
> > > > > > Thermal Sensor Controller found on the H3, H5 and A64 SoCs
> > > > > >
> > > > > > Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
> > > > >
> > > > > I'm not going to merge a binding for a device that doesn't have any
> > > > > driver implemented at the moment in Linux.
> > > > 
> > > > I'll take it then. Linux is not the only DT client.
> > > 
> > > Then don't complain if we ever have to break the ABI. We never tested
> > > that hardware, never had any code running on it, and it *will* cause
> > > some issues. For example, the calibration data have never been used
> > > and how they should be represented have never been described, since no
> > > one ever actually tried to use it.
> > > 
> > > And sure, Linux is not the only DT client. Just like FreeBSD isn't.
> > 
> >  What kind of data would you need for me to make things better ?
> >  We have the driver in FreeBSD for almost two years now, whne I started
> > to see how to upstream it I noticed a lot of problems and spent 4 or 5
> > days to try on all the SoCs mentionned in the serie, the only SoC I
> > didn't include it the A83T as for some reason I couldn't make the
> > driver work.
> 
> Do you have a link to that driver? 

 https://github.com/freebsd/freebsd/blob/master/sys/arm/allwinner/aw_thermal.c

> How and how much did you test it?

 Using a cheap IR thermometer as it's all I can afford.
 Then running multiples cpufreq-a53 process and comparing the result.
 Did the same without using the calibration data, result where closer
when I used them.

> Are you using the calibration data stored in the SID?

 Yes, which is why the serie contain the nvmem cell for the SID.

> 
> > I just hope that you understand that we cannot wait for Linux to
> > have a driver to have some bindings.
> 
> Just like I'm sure you can understand that just merging the DT bits
> without testing anything caused some troubles in the past, and I don't
> want to discover it in a year from now.

 I do, I don't like wrong DT info as much as you do I think. I had
the unfortunate event to find that the sun4i-a10-timer compatible used
in every soc is plain wrong for !A10 and !A13, patches comming soon.
 I want those bits merged but I also want that they reflect reality,
this is not a hard driver to do, NetBSD also have one I think, maybe
OpenBSD do to.

> Maxime
> 
> -- 
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com


-- 
Emmanuel Vadot <manu@bidouilliste.com> <manu@freebsd.org>
