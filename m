Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568B2C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F034E20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jclsSJyk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F034E20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387409AbeHBAFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 20:05:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:53964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731900AbeHBAFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 20:05:55 -0400
Received: from mail-qk0-f180.google.com (mail-qk0-f180.google.com [209.85.220.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8E5020862;
        Wed,  1 Aug 2018 22:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533161877;
        bh=uq7haUAlCFnMCstFWY2hjS5vXumhBkmjDeRgJFxSk+0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jclsSJyk7seyWCiU035PVbn+Mk9/k3aRbgDEXwLs9NomzGa8hoHBrZcdFbBBG+MGl
         L19ItscN/XHxtcWvXDLqqiKHims4uG6P2ObwqYSJakRgOhJFr1ugWVp0iVVl1e2Zfw
         MLFSxF/rfzREgQY4g27odx78pyeDE2myE2KWGGwo=
Received: by mail-qk0-f180.google.com with SMTP id v17-v6so154395qkb.11;
        Wed, 01 Aug 2018 15:17:57 -0700 (PDT)
X-Gm-Message-State: AOUpUlH+QViT2eLqsVjzsZAXQHv0cLC2wtMhLk0b1SIYewjb7WlaK006
        3Bn/UsGVwIUn4V8cSxv5EDG2AHbDRuR9Ap3lJw==
X-Google-Smtp-Source: AAOMgpfUC2hOwzmyiQZ0TsM+W8SmOuJnj/4URO/o3DpVna+9t4wmFwh99aaukJpajRkQINVSVihVfbHn2NAJ71adxUQ=
X-Received: by 2002:a37:1a69:: with SMTP id a102-v6mr195349qka.43.1533161876982;
 Wed, 01 Aug 2018 15:17:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
 <20180727121806.18209-4-srinivas.kandagatla@linaro.org> <20180731204536.GA7241@rob-hp-laptop>
 <d31d8f54-18b0-118f-eb25-7b92d5bf9842@linaro.org>
In-Reply-To: <d31d8f54-18b0-118f-eb25-7b92d5bf9842@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 1 Aug 2018 16:17:45 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJqCvWBqCfiS7dQMSzJ_FZDtAMJ8OQZvdGSJhsX0eYr6w@mail.gmail.com>
Message-ID: <CAL_JsqJqCvWBqCfiS7dQMSzJ_FZDtAMJ8OQZvdGSJhsX0eYr6w@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] mfd: wcd9335: add wcd irq support
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vinod <vkoul@kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 2:57 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> Thanks for the review,
>
> On 31/07/18 21:45, Rob Herring wrote:
> > On Fri, Jul 27, 2018 at 01:17:59PM +0100, Srinivas Kandagatla wrote:
> >> WCD9335 supports two lines of irqs INTR1 and INTR2.
> >> Multiple interrupts are muxed via these lines.
> >> INTR1 consists of all possible interrupt sources like:
> >> Ear OCP, HPH OCP, MBHC, MAD, VBAT, and SVA
> >> INTR2 is a subset of first interrupt sources like MAD, VBAT, and SVA
> >>
> >> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> >> ---
> >>   drivers/mfd/Makefile                |   2 +-
> >>   drivers/mfd/wcd9335-core.c          |   9 ++
> >>   drivers/mfd/wcd9335-irq.c           | 172 ++++++++++++++++++++++++++++++++++++
> >>   include/dt-bindings/mfd/wcd9335.h   |  43 +++++++++
> >
> > I'm confused why these are defined here. The binding for the wc9335 is
> > not an interrupt-controller.
>
> I can move this defines to include/linux/mfd/wcd9335/wcd9335.h as there
> are no active users for this, but I  was hoping that these can be used
> in DT in future.
>
> WCD9335 is an interrupt controller too. It muxes multiple interrupts via
> a gpio line interrupt.
>
> I did mention this in the bindings.

Then the header belongs in the binding patch.

I don't recall child nodes being defined though and you don't need to
be a interrupt-controller (in DT) without them.

Rob
