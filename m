Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5ECC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 16:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B5B8223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 16:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B5B8223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388572AbeKPC4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 21:56:14 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:57710 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387833AbeKPC4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 21:56:14 -0500
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 5B4091860B;
        Thu, 15 Nov 2018 17:47:37 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id UrI6uJO0-asU; Thu, 15 Nov 2018 17:47:34 +0100 (CET)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
        by bastet.se.axis.com (Postfix) with ESMTPS id 44BA0185F5;
        Thu, 15 Nov 2018 17:47:34 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F98F1A08A;
        Thu, 15 Nov 2018 17:47:34 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 03AB61A077;
        Thu, 15 Nov 2018 17:47:34 +0100 (CET)
Received: from seth.se.axis.com (unknown [10.0.2.172])
        by boulder02.se.axis.com (Postfix) with ESMTP;
        Thu, 15 Nov 2018 17:47:33 +0100 (CET)
Received: from XBOX03.axis.com (xbox03.axis.com [10.0.5.17])
        by seth.se.axis.com (Postfix) with ESMTP id EB64031E;
        Thu, 15 Nov 2018 17:47:33 +0100 (CET)
Received: from lnxricardw1.se.axis.com (10.0.5.60) by XBOX03.axis.com
 (10.0.5.17) with Microsoft SMTP Server (TLS) id 15.0.1365.1; Thu, 15 Nov 2018
 17:47:33 +0100
Date:   Thu, 15 Nov 2018 17:47:28 +0100
From:   Ricard Wanderlof <ricard.wanderlof@axis.com>
X-X-Sender: ricardw@lnxricardw1.se.axis.com
To:     =?ISO-8859-15?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
CC:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <alsa-devel@alsa-project.org>,
        Adrien Charruel <adrien.charruel@devialet.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [alsa-devel] [PATCH v2 1/2] ASoC: ak4118: Add support for AK4118
 S/PDIF transceiver
In-Reply-To: <CAJiuCcd_LAhODGGu=EBj4WBvx2PufcVbw=tO1+Mm+1Hj0k6BRw@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1811151742510.20252@lnxricardw1.se.axis.com>
References: <20181114121642.1404-1-peron.clem@gmail.com> <alpine.DEB.2.20.1811141602590.20252@lnxricardw1.se.axis.com> <CAJiuCcd_LAhODGGu=EBj4WBvx2PufcVbw=tO1+Mm+1Hj0k6BRw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: XBOX03.axis.com (10.0.5.17) To XBOX03.axis.com (10.0.5.17)
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 14 Nov 2018, Clément Péron wrote:

> > > The AK4118A is a digital audio transceiver supporting 8 input channels
> > > at 192kHz and with 24bits resolution.
> > > It converts the S/PDIF signal to I2S format and is configurable over I2C.
> > >
> > > This driver introduce a minimal support of the AK4118, like selecting the
> > > input channel, reading input frequency and detecting some errors.
> >
> > I'm curious, from what it seems, there is no checking that the input
> > sample rate actually matches the configured sample rate? It's perfectly
> > understandable for a driver which has 'minimal support', but it's
> > something a user must be aware of; for instance if someone does
> >
> > arecord -r 48000 output.wav
> >
> > when the input data actually has a rate of 44100 Hz then the file will be
> > written with a header specifying 44100 Hz but the data will actually be
> > 48000 Hz.
> >
> > It's not an objection on my part, just an observation. I don't know how
> > ALSA could enforce this in any way; ideally (barring automatic sample rate
> > conversion) one would want an error message that the sample rate specified
> > when opening the stream does not match the sample rate of the S/PDIF input
> > data.
> 
> I'm quite new with linux audio driver but adding in ak4118_hw_params a
> check like if params_rate(params) == ak4118_rate should do the job no

It will if the SPDIF stream is already running when the driver is started 
up, but if for some reason the sample rate changes or the SPDIF source is 
not transmitting anything when the stream is started it won't work to do 
it hw_params. A changing sample rate might be an unusual usecase, but one
could imagine having an SPDIF source which is silent (e.g. not even 
plugged in) when the stream is set up.

Like I said, it might not be a problem in many applications. And I'm not 
really sure how to solve it. Perhaps someone else knows. ALSA likes to be 
in control of parameters such as the sample rate, but it can't with an 
external device controlling the sample rate of the SPDIF receiver.

/Ricard
-- 
Ricard Wolf Wanderlof                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
