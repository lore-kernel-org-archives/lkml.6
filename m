Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7717BC070C3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 00:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C7B920659
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 00:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQFw+XPx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C7B920659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbeJOIjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 04:39:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:40228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbeJOIjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 04:39:24 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B33A20890;
        Mon, 15 Oct 2018 00:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539564989;
        bh=EBd2uKWsVOvQ2Lnz5TJfkhJ7bntO2B4pon8qGdgZCgs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vQFw+XPxfDkYwC2zMpFRayqkTflASgJwLXtA7sjBFi2c/bQFugAr0WJf1QW4e1nq7
         ZuHq47EexVeC2KzmOXiFGLVdwJOUkPKKuBJ8iG1IFRvDHSCxF5xkem3aY7NBOF8Im3
         PFNx6Hm4kVFtqZGuzooYUlRsuKZpONpd0Bkwf9hU=
Received: by mail-qk1-f174.google.com with SMTP id v68-v6so10910433qka.2;
        Sun, 14 Oct 2018 17:56:29 -0700 (PDT)
X-Gm-Message-State: ABuFfohmHzuJ4LnuNrfSJrWycGZliCsRpU1Z1rt8WPGDICawssVmr+vb
        G6B5B1pxIX2AFlwL5kN6MK+oFgoIbOEtiNjjNQ==
X-Google-Smtp-Source: ACcGV616xO0bosyogGjVU/51byCl+UJyaqYPEom9K9uRm3hV93j2XyXW6xTSTMI7vzb5+KiHA3qsTaBvvlotO2PNRSY=
X-Received: by 2002:a37:6904:: with SMTP id e4-v6mr14254642qkc.79.1539564988431;
 Sun, 14 Oct 2018 17:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <20181011165123.32198-1-dmurphy@ti.com> <20181011165123.32198-3-dmurphy@ti.com>
 <20181011182734.GA7973@amd> <4fcb91c7-b2b2-798d-8a41-fa1b475086e0@ti.com>
 <8c1559e1-b703-4c98-8bd9-7c9993bd59f5@gmail.com> <20181012162619.GA28573@bogus>
 <20181012180312.GB5565@amd> <60cc9238-aba2-aa6a-64a4-2b5e20835549@gmail.com>
In-Reply-To: <60cc9238-aba2-aa6a-64a4-2b5e20835549@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Sun, 14 Oct 2018 19:56:16 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+Yspr_iNP1eYanvtmiuMf-xNEZ0suDH3tQayV=V5r5=g@mail.gmail.com>
Message-ID: <CAL_Jsq+Yspr_iNP1eYanvtmiuMf-xNEZ0suDH3tQayV=V5r5=g@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] dt-bindings: ti-lmu: Remove LM3697
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Lee Jones <lee.jones@linaro.org>,
        Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2018 at 1:46 PM Jacek Anaszewski
<jacek.anaszewski@gmail.com> wrote:
>
> On 10/12/2018 08:03 PM, Pavel Machek wrote:
> > Hi!
> >
> >>>>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> >>>>>
> >>>>> NAK.
> >>>>
> >>>> Thanks for the NAK.
> >>>>
> >>>> This NAK was NAK'd by other maintainer in the V2 RFC patchset
> >>>>
> >>>> https://lore.kernel.org/patchwork/patch/993171/
> >>>
> >>> I confirm. LM3697 is a standalone device and not a cell of any
> >>> MFD device.
> >>>
> >>> Waiting for DT maintainer's ack.
> >>
> >> You all sort out what you want... I can't follow it all, and I'm not
> >> going to spend the time trying to figure out what is going on here.
> >
> > This is what I want:
> >
> >> As this is worded, changing the driver is a Linux problem and irrelevant
> >> to the binding. Now if you want to move documentation to a location that
> >> makes more sense, then fine. But structure patches that way and make it
> >> clear that from an binding ABI perspective, nothing is changing.
> >
> > ...but apparently I did not have enough authority to get it.
> >
> > (I'm ok with move, and it is possible that binding does need some
> > fixups besides the move; still it should be done as fixup not as a new
> > binding).
>
> There is a fundamental question - should the bindings be considered
> an ABI, even though there is no mainline "*.dts" implementation basing
> on these bindings?

In theory there could be out of tree users. Having a dts file using it
in tree shouldn't be a requirement to maintain the ABI IMO. However, a
lack of dts is one piece of determining whether this is in use or not.

> This patch fixes the issues of bindings in a way that would change
> the ABI, if only it existed. But it apparently doesn't exist in
> mainline. Unless a DT documentation itself constitutes an ABI.
>
> I'd like to have it clarified at this occasion, and that's why
> I kindly ask for DT maintainer's ack or NACK for this modification
> of bindings.
>
> For a reference we have a nice summary of the MFD driver and related
> bindings' flaws in [0] and [1].
>
> [0] https://lkml.org/lkml/2018/9/7/774
> [1] https://lkml.org/lkml/2018/9/11/984

Given this one seems to have not really been finished, it's probably
okay to make changes in this case. Still, it would be good to see
patches structured so that it's obvious we're breaking things. But how
the patches are structured doesn't matter until there's some agreement
on the end result.

Rob
