Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB158C2F42E
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EEEE2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548084220;
	bh=pXlDdFTKiVEnXoJSyGsOaxNG/NYdvCPYkNqoMMSTNLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aqrNeJT8yvQzWxKRFMDy6Eo3XcX1K52X8iar3j90PQ+xDqEX4RXM/nqklZB1VURr2
	 8U/UWvJ8HDv5MBYvU8NzetHeBaG3ezna9mrODo/3tJdS6pmNRE2QFB3W8nNg6a0D9z
	 9cpQ/oqoxoOVE04naia0B0NOYJM2bDU4yukDD55I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730126AbfAUPXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:23:39 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45834 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730080AbfAUPXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:23:37 -0500
Received: by mail-ot1-f66.google.com with SMTP id 32so20784805ota.12;
        Mon, 21 Jan 2019 07:23:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BTprJiQSSd9oFHbZyZXiPAZoKdv8sPvXoKx1czOhrmU=;
        b=SF2/88uvEYmkjXxscUcv7ZE7xQ1gTC4jzQpsVTfZlk4ssZ2LOaC9LaAf+NJ47jfLY6
         HC2nmtu9Oz6fFCbGJjzOF15qTIwe5qEuJi1WcrdzhRMWvWQBWUrXQL4um5QpQI78yoPI
         E8NYfU5cSwR33V/rgOMUS+4Stre8QoNp3MT13u64sKR27ojcZY0oVBOtAtr+6z25sSq9
         GGXtPQJqgfln/YfIeKuRKvSy1vOKASJbphQbiZVeJSda3fxpXr4Kx5TtqYbiialevev8
         HdgBiP0Agt4PcAd50fVYzfDfY8En6/alSkoQvrNCOOmXfiFOd4MOlOfjjOKotk8F7u4k
         CWjQ==
X-Gm-Message-State: AJcUukfpZcJYBl/7WHdZXD7t/Dx9NF0f5MEPIfBHoz/PXzxftPzfv7DR
        LxEsPHVf+9OjjdFlZ1mB+kl3Q4c=
X-Google-Smtp-Source: ALg8bN6xc+jSfPAKy2Jra85r9CopBZTNymVHnRS/reb5iZw0WoCBIEeYC1EJ5mp4BFF+u1O3X6KY4g==
X-Received: by 2002:a05:6830:1453:: with SMTP id w19mr14226713otp.213.1548084216296;
        Mon, 21 Jan 2019 07:23:36 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i7sm5256034oth.57.2019.01.21.07.23.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 07:23:35 -0800 (PST)
Date:   Mon, 21 Jan 2019 09:23:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Viorel Suman <viorel.suman@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Cosmin Samoila <cosmin.samoila@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "timur@kernel.org" <timur@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "viorel.suman@gmail.com" <viorel.suman@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v3 0/4] Add NXP AUDMIX device and machine drivers
Message-ID: <20190121152335.GA12284@bogus>
References: <1547729177-14317-1-git-send-email-viorel.suman@nxp.com>
 <20190117161804.GA5760@bogus>
 <1547817384.11482.33.camel@nxp.com>
 <20190118194642.GA11798@Asurada-Nvidia.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190118194642.GA11798@Asurada-Nvidia.nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 11:46:42AM -0800, Nicolin Chen wrote:
> On Fri, Jan 18, 2019 at 01:16:24PM +0000, Viorel Suman wrote:
> > > > 1. Moved "dais" node from machine driver DTS node to device driver
> > > > DTS node
> > > >   as suggested by Rob.
> > > That was not what I suggested. You still have a virtual node which
> > > looks to me to be unnecessary.
> > 
> > To me removing virtual node implies that AUDMIX machine driver (imx-
> > audmix.c + virtual node) shall be removed and machine driver code
> > merged into device driver (fsl_audmix.c + device node) - please let me
> > know if my understanding is wrong.
> 
> We could use a non-DT configuration right? From the driver logic,
> DT just registers a device corresponding to the machine driver so
> that it can probe(). We could register one in fsl_audmix instead.
> Please refer to how fsl_ssi registers the sound card device. The
> machine driver can get audmix_np from the parent device pointer,
> and I think that's all you need.

Yes.

> Or maybe someone else would provide a better way. But it'd work.

Or the machine driver could create the audmix device. That probably 
makes less sense, but either way there doesn't have to be a 1-1 
correspondence of DT nodes and (platform) devices.

I'm not an ASoC expert, but why can't the machine driver just control 
the audmix directly (with DAIs as separate drivers)? Is the audmix ever 
going to a be a component for a different machine driver?

Rob

