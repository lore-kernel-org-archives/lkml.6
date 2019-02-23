Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48821C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 18:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14CBE206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 18:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ish/Whc1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfBWSM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 13:12:59 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40151 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfBWSM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 13:12:59 -0500
Received: by mail-pf1-f195.google.com with SMTP id h1so2565251pfo.7
        for <linux-kernel@vger.kernel.org>; Sat, 23 Feb 2019 10:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sP2935QBF/NPe/dZl0b3jMUepOEvY0BXuyW5CtqjJYY=;
        b=ish/Whc1Uksx8dBz3VqzoVh2s+wScJoP6At1+b4uZ8YmHcmeTzmX/q4wrooejlZgCS
         crkDydtgaUhe7IqU7JRSXSvP/6IfLD0HqyJFSYu3Gwg7lN+fGEQLZo9El0nOBgKLX/qf
         D6yRQB8j6oVdc6rgQFHiSpnF95/Ai1K/NjPCPJFgq838E0h16Xg08MMa97VlXzSx4gbR
         dknAVFmaJ4vxaQQhUAP+uc6gyLBl3p/+Idy4YCKBgNCsFAKXPJ5QdlDFLKDsumvX6EDp
         aMUiC329UwJkhgmIe8R04lda4FRblRNoNxVBF64NhZJN3vHRZpjqJiD28J7BoIaMovXx
         jEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sP2935QBF/NPe/dZl0b3jMUepOEvY0BXuyW5CtqjJYY=;
        b=CQUEAz6NfTgjImNEZQUF+jTVeeRRG4GIR0t3oIVp6/8Pd11KAAjxEoOh5VO6+KzkZm
         zmDfYGJxzcsTmrWUc7p0Ps/Ee+3g2y43FqFlCDssAziejH7OaN6J3feKLHqBvPrfnc35
         5svSDVOcWAexp60eB+v3Giixwx0bFEjFtNs+UZt0XzgkXKQ8l9fNtdNrN3zsSB4SfYoD
         dSC+fYhCLn5Foq5QVf6RvafR7B6mqyVF0ajicxAADZF0ujSCwIAF2Fom75NE0X33H7C1
         BBf7DIrAfm8QkT/lBoVKAEq24htxjmGghDGdjKSBkNN0I8L1Eqe0yRfB8v5lzaegrSC7
         z68g==
X-Gm-Message-State: AHQUAuYVhqV3q7JemINsKEqwRsGBTCCZWiuYx8Ae0qh5zLYlZ2mwjzmM
        wClFV9McJQ1Ep26LLJD+lFCs1g==
X-Google-Smtp-Source: AHgI3IbAS/S9+F0oHH7L73VSDLX0ekSAgY9OlDLt7Ph74abIEtyLbB6C/dCo1voZOkzoWQpEK5/BCA==
X-Received: by 2002:a62:1854:: with SMTP id 81mr8061925pfy.223.1550945578134;
        Sat, 23 Feb 2019 10:12:58 -0800 (PST)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y133sm7417361pfb.107.2019.02.23.10.12.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Feb 2019 10:12:56 -0800 (PST)
Date:   Sat, 23 Feb 2019 10:12:54 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Jens Axboe <axboe@kernel.dk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64/io: Don't use WZR in writel
Message-ID: <20190223181254.GC572@tuxbook-pro>
References: <68b71c15f32341468a868f6418e4fcb375bc49ba.camel@gmail.com>
 <20190211105755.GB30880@fuggles.cambridge.arm.com>
 <38d8965a-cd41-17cf-1b95-8dd58c079be4@arm.com>
 <874c702b8af760aa8fae38d478c79e3ecba00515.camel@gmail.com>
 <235d20ef-3054-69d9-975d-25aebf32aad3@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <235d20ef-3054-69d9-975d-25aebf32aad3@arm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 11 Feb 06:59 PST 2019, Marc Zyngier wrote:

> On 11/02/2019 14:29, AngeloGioacchino Del Regno wrote:
> 
> [...]
> 
> > Also, just one more thing: yes this thing is going ARM64-wide and
> > - from my findings - it's targeting certain Qualcomm SoCs, but...
> > I'm not sure that only QC is affected by that, others may as well
> > have the same stupid bug.
> > 
> 
> At the moment, only QC SoCs seem to be affected, probably because
> everyone else has debugged their hypervisor (or most likely doesn't
> bother with shipping one).
> 
> In all honesty, we need some information from QC here: which SoCs are
> affected, what is the exact nature of the bug, can it be triggered from
> EL0. Randomly papering over symptoms is not something I really like
> doing, and is likely to generate problems on unaffected systems.
> 

The bug at hand is that the XZR is not deemed a valid source in the
virtualization of the SMMU registers. It was identified and fixed for
all platforms that are shipping kernels based on v4.9 or later.

As such Angelo's list of affected platforms covers the high-profile
ones. In particular MSM8996 and MSM8998 is getting pretty good support
upstream, if we can figure out a way around this issue.

Regards,
Bjorn
