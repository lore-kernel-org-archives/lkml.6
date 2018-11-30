Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F5EC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A90921479
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbTuuiTV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A90921479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbeLABWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 20:22:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:56418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726932AbeLABWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 20:22:44 -0500
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A6F72147C;
        Fri, 30 Nov 2018 14:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543587197;
        bh=WvSinIe5ZWcLOB2fnNVs8jgHQ286i28Hn6pp4Ukwwgo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nbTuuiTVGGWQ1N560yghJgaaUKzJ0ojo38WQcIAJilfsFj3mYsEejf3xiihIi8LQC
         6zbwVURGmq6Lr6nZ3MW4F+hnGfc288KNPjxu9mnn2GFSTGr/GIiFBn5MO72cNyxQga
         TV8mWUvvKMYaKNhtNoLbWWaOQFn+Tnu5dMnc71YA=
Received: by mail-qk1-f170.google.com with SMTP id m5so3196990qka.9;
        Fri, 30 Nov 2018 06:13:17 -0800 (PST)
X-Gm-Message-State: AA+aEWbsF/szPhwyNdJc75Er0vftNMSgnRBa/MmBm6BCHQiloKjcTnYu
        jXu8Ls0DDyEfIZedhOoQ5arfbzV+zQtIEVe4gg==
X-Google-Smtp-Source: AFSGD/X+oXyFJUIEETNO1rc6/HUpDjQrmGjCBme8HlZZehr+H0At82pqVdbLQMirsYoxxCepDB0ypVa+HdJy8Tlsbd8=
X-Received: by 2002:a37:5686:: with SMTP id k128mr5071276qkb.29.1543587196293;
 Fri, 30 Nov 2018 06:13:16 -0800 (PST)
MIME-Version: 1.0
References: <20181124141703.29232-1-masneyb@onstation.org> <20181127105642.uu56phxjfl7bjl2p@holly.lan>
 <20181130135927.GA27500@basecamp>
In-Reply-To: <20181130135927.GA27500@basecamp>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 30 Nov 2018 08:13:04 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+-AZFf==911Pmf_ObUk+3VQgC+2+BvQ9q8LyQ_v=FdOA@mail.gmail.com>
Message-ID: <CAL_Jsq+-AZFf==911Pmf_ObUk+3VQgC+2+BvQ9q8LyQ_v=FdOA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: trivial: add ti,lm3630a binding
To:     Brian Masney <masneyb@onstation.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Craig Tatlor <ctatlor97@gmail.com>, Dan Murphy <dmurphy@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Dan M

On Fri, Nov 30, 2018 at 7:59 AM Brian Masney <masneyb@onstation.org> wrote:
>
> On Tue, Nov 27, 2018 at 10:56:42AM +0000, Daniel Thompson wrote:
> > On Sat, Nov 24, 2018 at 09:17:02AM -0500, Brian Masney wrote:
> > > Add a trivial binding for the Texas Instruments LM3630A Backlight Chip.

How does this chip relate to ones Dan has been working on?

> >
> > It's quite unusual for a backlight device to have a trivial binding.
> >
> > The driver supports fairly extensive parametrization via struct
> > lm3530a_platform_data. It is really the case that none of these
> > properties should ever be set via DT?
>
> Hi Daniel,
>
> I initially assumed that we would let user space configure these values
> once the system has booted, but you are right that these should be
> available in device tree.
>
> The driver has two different LED banks that can be configured
> independently.

That is usually represented with child nodes which makes this anything
but trivial. Plus, given that we have bindings for LEDs/backlights, no
LED/backlight controller is a trivial device.

> How do you feel about having a single property in
> device tree populate the initial values for both banks? I propose that
> we could use the property default-brightness-level for leda_init_brt
> and ledb_init_brt in struct lm3630a_platform_data. The max-brightness
> property can populate leda_max_brt and ledb_max_brt.
>
> I need to look at other bindings this weekend to see if there are any
> standard properties that I can use for leda_ctrl/ledb_ctrl, pwm_ctrl,
> and pwm_period.
>
> Brian
>
