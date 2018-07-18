Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5E9ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 19:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E9E2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 19:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWfGvo+k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74E9E2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbeGRUad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 16:30:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:36228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726992AbeGRUad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 16:30:33 -0400
Received: from mail-it0-f44.google.com (mail-it0-f44.google.com [209.85.214.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1993920856;
        Wed, 18 Jul 2018 19:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531943468;
        bh=oCPoTpXsK5RGCIs8IjRid6UXfiCYh9HhBvUvlDSZ1/A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hWfGvo+kiSDbktLAOA3M5OSk7r7jQM6GfPonqlKG235/dclGdTdksfNLgj8CGkPr0
         RIJufi6r3FJhPDJ5rq7LkYZzdLuj3iNKiRztv509A329ItwXN2u2GZSY0oLc8VFlY9
         7vSUWqTRdDP1XP7bYidd7KPpVXfLFFhUSuR5kfd4=
Received: by mail-it0-f44.google.com with SMTP id q20-v6so6062523ith.0;
        Wed, 18 Jul 2018 12:51:08 -0700 (PDT)
X-Gm-Message-State: AOUpUlE2UZ3EiqkLP65p1nKqlA5tQ+a04etajTcHAtDr8mdtfpwilFXA
        ql2gzZJbTFSNzMYWL/Irj+NLadDEKiKxGUMSlw==
X-Google-Smtp-Source: AAOMgpekTo7Za2sfYJO/ydPQIlFTgvE4WFL1g9QFxeI0NhKtSo//6oNFhP0brQ+Ej/Ugxm6DjI8DaswbYeaBY3pA++s=
X-Received: by 2002:a02:9936:: with SMTP id r51-v6mr6839717jaj.46.1531943467490;
 Wed, 18 Jul 2018 12:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180711053122.30773-1-andrew@aj.id.au> <20180711053122.30773-2-andrew@aj.id.au>
 <20180711200450.GB17291@rob-hp-laptop> <1531356830.3551458.1437853280.551CA8C5@webmail.messagingengine.com>
 <CAL_JsqKpXxR4t_-3BOy-0mFePXkaSck_4PfHRD=OZQ-_-T5P=w@mail.gmail.com>
 <b6ced4cad4d7ff78330181b2c893855c23103953.camel@kernel.crashing.org>
 <1531463489.747186.1439263128.075AECE1@webmail.messagingengine.com>
 <CAL_JsqLZo-=7UkuvvUFYdCR4asBBiWyC=Q1ryH=-HLU6vzf9tA@mail.gmail.com> <ece91112ecfdc7218184c4c4519e455cf9397e11.camel@kernel.crashing.org>
In-Reply-To: <ece91112ecfdc7218184c4c4519e455cf9397e11.camel@kernel.crashing.org>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 18 Jul 2018 13:50:56 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL_bMXLAA0091-g8PmhXR5g5Pf2y2=ey7Ss5ofHm46sWw@mail.gmail.com>
Message-ID: <CAL_JsqL_bMXLAA0091-g8PmhXR5g5Pf2y2=ey7Ss5ofHm46sWw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/4] dt-bindings: misc: Add bindings for misc. BMC
 control fields
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eugene.Cho@dell.com, a.amelkin@yadro.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>, stewart@linux.ibm.com,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 10:56 PM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> On Mon, 2018-07-16 at 07:55 -0600, Rob Herring wrote:
> > If that data is one set per SoC, then i'm not that concerned having
> > platform-specific data in the driver. That doesn't mean the driver is
> > not "generic". It's still not clear to me in this thread, how much of
> > this is board specific, but given that you've placed all the data in
> > an SoC dtsi file it seems to be all per SoC.
>
> So Rob, I think that's precisely where the disconnect is.
>
> I think we all (well hopefully) agree that those few tunables don't fit
> in any existing subystem and aren't likely to ever do (famous last
> words...).
>
> Where we disagree is we want to make this parametrized via the DT, and
> you want us to hard wire the list in some kind of SoC driver for a
> given SoC family/version.
>
> The reason I think hard wiring the list in the driver is not a great
> solution is that that list in itself is prone to variations, possibly
> fairly often, between boards, vendors, versions of boards, etc...

Can we separate the list of what's enabled from the details of the
registers?  Even if we put all this into DT, we may still want to have
some separation for dts file structure. Some portion of this has to be
SoC specific because you are simply exposing SoC registers.

> We can't know for sure every SoC tunable (out of the gazillions in
> those chips) are going to be needed for a given system. We know which
> ones we do use for ours, and that's a couple of handfuls, but it could
> be that Dell need a slightly different set, and so might Yadro, or so
> might our next board revision for that matter.

That's very hand wavy. Do you have some concrete examples (i.e. dts
files) showing the differences.

One problem I'm having with this is you are still going to need per
board specifics in userspace. You may be moving some of details out,
but moving to DT is not going to completely eliminate that. I agree
that not using /dev/mem is a good thing, but there are several ways
you could do that independent of any DT binding.

> Now, updating the device-tree in the board flash with whatever vendor
> specific information is needed is a LOT easier than getting the kernel
> driver constantly updated. The device-tree after all is there to
> reflect among other things system specific ways in which the SoC is
> wired and configured. This is rather close...

Sadly, updating my kernel is easier than updating my PC firmware
(though packaged firmware on my current laptop changes that). I can
assure you that ARM boards are generally much worse in that regard.
BTW, you may want to pay attention to EBBR[1][2]. Not sure how much
you care for BMCs, but there may be some interest.

Rob

[1] https://github.com/ARM-software/ebbr
[2] https://lists.linaro.org/pipermail/boot-architecture/
