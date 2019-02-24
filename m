Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8E8C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 03:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1ECC20663
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 03:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o8uRTkxY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbfBXDyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 22:54:01 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36837 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbfBXDyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 22:54:01 -0500
Received: by mail-pg1-f195.google.com with SMTP id r124so2926609pgr.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Feb 2019 19:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vEFJj8f8aJJKNog+h5E3CItg2WjBd6JxcRZBrrmKL3Q=;
        b=o8uRTkxYYxNxx9gCDsBgGLu9asQE2kEcKC3WWxLciu1WMLFHflUHM9FP2KUuoEntpq
         kJW/FLFZIkm2eVjHb+pjjn9pCd8piQXJWbi5UcrgITrUcjjKN07iTL4/yT7r1DLcYyFd
         uFIsoC1uEc351KV3I/AeT3itvL6Z1HLdee9KlG8SP6V/mm/u+fdgDPGcNV16ksuw9IQL
         Pwn/X1gFSRxFfSfoEwfasMjoiQ+fQf4+ankGV4W/AyuM6HPUskcFCs8bUqTljbjWd2u3
         6xuTrnG7gZE3dz7b/4ZpHsf1MOrWu9KP6TPQIrj6bSWawk378ffbkJlCM5QNkRuehCYG
         Tc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vEFJj8f8aJJKNog+h5E3CItg2WjBd6JxcRZBrrmKL3Q=;
        b=o0Aql7+wLZoVVP04LB9AwHlMuiAVLPodytlbDgOXzwHaLUXxdDcVojmOJKpfxqk8Lc
         FoW2/Y1DSRzEbGambRduEXYx5xgN4+XYSYmrzxp6qYIgmbetX/jyzUspsYWoggiVVk7Q
         dyXLQxdbMiaVHnqFKWMY/3CjWD+r95Chd/J7EkVeRC7lsOOqXvbwHO/8H2uBeZ+/SfBo
         EDfVz84KQp+0WBr6FQ8v+PwO4/wj2dmkvXqkPZeHq8QUt6eDHndz6nIF2rgHUVoFKZxO
         qTvIORIFCGCG22jKHEmj7IVJOxyYb75IuGtMCt9FRuoxxMdtFApi3eNnJTWiNnr4IDgy
         dTJQ==
X-Gm-Message-State: AHQUAubnq4CO75tOahE3f3H29puACB00Vu4LQBuD91oNj3UwGebqvxwy
        g4FJ065s+ZDgvhCO8SRnQWonng==
X-Google-Smtp-Source: AHgI3IbWcnfQyp5986NEkTynM+WgioIIX4ib7mtuHujZZp12UDUzhPBeTDUDcitVhs3hkSB3ci0VJw==
X-Received: by 2002:a62:e204:: with SMTP id a4mr11200228pfi.225.1550980439873;
        Sat, 23 Feb 2019 19:53:59 -0800 (PST)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v26sm7362953pgn.46.2019.02.23.19.53.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Feb 2019 19:53:58 -0800 (PST)
Date:   Sat, 23 Feb 2019 19:53:56 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Jens Axboe <axboe@kernel.dk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] arm64/io: Don't use WZR in writel
Message-ID: <20190224035356.GD572@tuxbook-pro>
References: <68b71c15f32341468a868f6418e4fcb375bc49ba.camel@gmail.com>
 <20190211105755.GB30880@fuggles.cambridge.arm.com>
 <38d8965a-cd41-17cf-1b95-8dd58c079be4@arm.com>
 <874c702b8af760aa8fae38d478c79e3ecba00515.camel@gmail.com>
 <235d20ef-3054-69d9-975d-25aebf32aad3@arm.com>
 <20190223181254.GC572@tuxbook-pro>
 <86zhqm8i6d.wl-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86zhqm8i6d.wl-marc.zyngier@arm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 23 Feb 10:37 PST 2019, Marc Zyngier wrote:

> On Sat, 23 Feb 2019 18:12:54 +0000,
> Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
> > 
> > On Mon 11 Feb 06:59 PST 2019, Marc Zyngier wrote:
> > 
> > > On 11/02/2019 14:29, AngeloGioacchino Del Regno wrote:
> > > 
> > > [...]
> > > 
> > > > Also, just one more thing: yes this thing is going ARM64-wide and
> > > > - from my findings - it's targeting certain Qualcomm SoCs, but...
> > > > I'm not sure that only QC is affected by that, others may as well
> > > > have the same stupid bug.
> > > > 
> > > 
> > > At the moment, only QC SoCs seem to be affected, probably because
> > > everyone else has debugged their hypervisor (or most likely doesn't
> > > bother with shipping one).
> > > 
> > > In all honesty, we need some information from QC here: which SoCs are
> > > affected, what is the exact nature of the bug, can it be triggered from
> > > EL0. Randomly papering over symptoms is not something I really like
> > > doing, and is likely to generate problems on unaffected systems.
> > > 
> > 
> > The bug at hand is that the XZR is not deemed a valid source in the
> > virtualization of the SMMU registers. It was identified and fixed for
> > all platforms that are shipping kernels based on v4.9 or later.
> 
> When you say "fixed": Do you mean fixed in the firmware? Or by adding
> a workaround in the shipped kernel?

I mean that it's fixed in the firmware.

> If the former, is this part of an official QC statement, with an
> associated erratum number?

I don't know, will get back to you on this one.

> Is this really limited to the SMMU accesses?
> 

Yes.

> > As such Angelo's list of affected platforms covers the high-profile
> > ones. In particular MSM8996 and MSM8998 is getting pretty good support
> > upstream, if we can figure out a way around this issue.
> 
> We'd need an exhaustive list of the affected SoCs, and work out if we
> can limit the hack to the SMMU driver (cc'ing Robin, who's the one
> who'd know about it).
> 

I will try to compose a list.

Regards,
Bjorn
