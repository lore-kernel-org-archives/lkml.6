Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D27C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E99992184B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546539949;
	bh=PoJ0dnKj33jdwURMzFRuZUu1ihZ2k4zHEH0DZSL8UfA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=C92/o5xuZKBXTD9Ope581pdzdESxPHA3pptYG/ch8tlqx/1+tQ+ZInfeWbVjwXIh0
	 f/Sc0YEtY+h7tCqrgjinaE18scbsAgDpbZYnRH0oGCxMWsQctSaz9ZCKkljc/0cZN9
	 XdPGfdJuFvRfYp+96t1G2KVewy7NUMvUVL4x4zrY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731715AbfACSZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 13:25:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:55120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727932AbfACSZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 13:25:47 -0500
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E99DC21871;
        Thu,  3 Jan 2019 18:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546539946;
        bh=PoJ0dnKj33jdwURMzFRuZUu1ihZ2k4zHEH0DZSL8UfA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E6KoCmexVWS8cPtfyo/RfbdA4iPyy4gL2zDMhY8wQs8EEcpOSjgnq/r/y779BBnzc
         v7ZWsPLbXpro7LVNuzNbAnRImv3GsPZZDvcmOqvU3s3LCw5JQADUbfehTh1sSrz6At
         v2rOHVlBGSIkIpHRygar2e8ZEqSOLz/aIHoBSdJ4=
Received: by mail-qk1-f174.google.com with SMTP id 68so20173933qke.9;
        Thu, 03 Jan 2019 10:25:45 -0800 (PST)
X-Gm-Message-State: AJcUukcDxJ2X+7DZ+FyhvKqOgFEIIgEzsDIGVady0sMz3XquzPZIEqko
        gktPY28ylYU2NfHQrD60KpUXyTUcvxN3OIztjA==
X-Google-Smtp-Source: ALg8bN6sJb/CC38IT+vKqJe9FwmTeB1yhwj9N6y6KEzQZGFM4rZifmB+Xf9BtX5VltXrDlJmwuS0fBbz9BrIGYx4qQs=
X-Received: by 2002:a37:7682:: with SMTP id r124mr45419366qkc.79.1546539945110;
 Thu, 03 Jan 2019 10:25:45 -0800 (PST)
MIME-Version: 1.0
References: <1545150569-14897-1-git-send-email-viorel.suman@nxp.com>
 <CAGoOwPQvc5w05NOVsp6Qw-Ee3CJJCcaU2Dtzwbf+7bUe_kFEbA@mail.gmail.com> <1546531006.14398.83.camel@nxp.com>
In-Reply-To: <1546531006.14398.83.camel@nxp.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 3 Jan 2019 12:25:33 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLcBjRBV_zOoMGGB9gFVgk=4LSx80sFam1-9neDVjAYfQ@mail.gmail.com>
Message-ID: <CAL_JsqLcBjRBV_zOoMGGB9gFVgk=4LSx80sFam1-9neDVjAYfQ@mail.gmail.com>
Subject: Re: [RFC PATCH] ASoC: fsl: Add Audio Mixer CPU DAI driver
To:     Viorel Suman <viorel.suman@nxp.com>
Cc:     "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "timur@kernel.org" <timur@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 3, 2019 at 9:59 AM Viorel Suman <viorel.suman@nxp.com> wrote:
>
> Hi Nicolin,
>
> Thank you for your feedback, same here - just back from vacation.
>
> On Jo, 2018-12-27 at 01:24 +0800, Nicolin Chen wrote:
> > Hi Viorel,
> >
> > Sorry for the late response, having been on a long vacation.
> >
> > The code looks pretty clean. Just some small concerns/questions
> > below.
> >
> > On Wed, Dec 19, 2018 at 12:30 AM Viorel Suman <viorel.suman@nxp.com>
> > wrote:
> > >
> > >
> > > This patch implements Audio Mixer CPU DAI driver for NXP iMX8 SOCs.
> > > The Audio Mixer is a on-chip functional module that allows mixing
> > > of
> > > two audio streams into a single audio stream.
> > >
> > > Audio Mixer datasheet is available here:
> > > https://www.nxp.com/docs/en/reference-manual/IMX8DQXPRM.pdf
> > >
> > > Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> > > ---
> > >  .../devicetree/bindings/sound/fsl,amix.txt         |  45 ++
> > >  sound/soc/fsl/Kconfig                              |   7 +
> > >  sound/soc/fsl/Makefile                             |   3 +
> > >  sound/soc/fsl/fsl_amix.c                           | 554
> > > +++++++++++++++++++++
> > >  sound/soc/fsl/fsl_amix.h                           | 101 ++++
> > I aimn't against the naming here, but it seems to be AUDMIX in RM?
> >
> > Would it be better to align with that? It's your decision though.
>
> To me "AUDMIX" sounds more like some RTL high level integration module,
> I would prefer to keep it as it is if there is no strong reason to
> rename it.

At least for compatible string names, matching what's in the RM or RTL
is more appropriate. Where does "AMIX" come from?

Rob
