Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263D3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 05:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E75BB2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 05:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aeb4beq1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725915AbfBSFQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 00:16:08 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46372 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfBSFQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 00:16:07 -0500
Received: by mail-pf1-f193.google.com with SMTP id g6so9617706pfh.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 21:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GHaiFJohMk/q3KHj6Y6LVP0NZOY6zkpU7SEBNWmbwK0=;
        b=aeb4beq1JnNJVu8udZqV9C+B5pJw7DBN24bv3ie1CrTX084LkPZRrsNfsfw7Ik8jSq
         XvnsqTHhRL6a2c+oEakYX+3ArjXpGiJW/6NXqUUMMHvXEqwtnsbijis3uAekqKzDZ0P3
         iDev2S/sHgwhk16JPOLIqbFGxFTQsDzAPjryb1gnLZVNaNlmIeO0L1BlWcRL47R9DTUD
         1wQxU3WFQF1DQmQZOzsGawrTmknoQo9Zt7nVnzEaiXXmW19/SIPkUwgrvM3x5bixJ991
         ZYr9sXikBWLLN+BtmOvBdJr1M0IDE4PDeXl4+8b+icjR1Q6wF7FHjCuxZvYZ1j5KeI7x
         Qn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GHaiFJohMk/q3KHj6Y6LVP0NZOY6zkpU7SEBNWmbwK0=;
        b=VTrS8OCNTVHrUN2Q1pvyDm/bQ9hWgI2hnuKe7x1XtHYeTBxN8A68NiLXghgA8/mNuG
         vDjcFHICBiZU9R/1mZIYUDWbVaw8DKbl8tZRv21M0LFUrJsATiwGB0gM9Z8Vsql/gnuI
         plQR1H6t1/nXQdedUADejvuxlVr9vd7/7Ff+t14fLu2E1WeX0Te+VmGhme0qz18SYbc2
         d9e406aS+/n0z3IYhRy9C3ruq3k2xW+wd12DIfbfbzHePwOsJU1qWSowcVNeNNZBeA/v
         +dNyRETurGaEM23M5sJO5JrETQFRJaZvsTWKk7k4PQkINjt8ruZ69CQ62x9x0BOcbfwF
         8XWw==
X-Gm-Message-State: AHQUAuaCY/KfMBrJ60zFAS6eEKP/mYWWpTXp5JnzIjfNoI1Ml2sB1ZOR
        av1rin1QGLPNL9ToXKKFDozO8w==
X-Google-Smtp-Source: AHgI3IbAcdxv/aecIuiSM9oKQdp2ioc72RpAdcjYuYAdRxJVumxI809S3uT7BMIugM45nW2OCnz5pg==
X-Received: by 2002:a63:2a96:: with SMTP id q144mr21902063pgq.338.1550553366276;
        Mon, 18 Feb 2019 21:16:06 -0800 (PST)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id p29sm20403435pgm.78.2019.02.18.21.16.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 21:16:05 -0800 (PST)
Date:   Mon, 18 Feb 2019 21:16:03 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Khasim Syed Mohammed <khasim.mohammed@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Don't deassert reset GPIO during probe
Message-ID: <20190219051602.GB13018@tuxbook-pro>
References: <20190125232616.25714-1-bjorn.andersson@linaro.org>
 <20190213152352.GB417@e107981-ln.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213152352.GB417@e107981-ln.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 13 Feb 07:23 PST 2019, Lorenzo Pieralisi wrote:

> On Fri, Jan 25, 2019 at 03:26:16PM -0800, Bjorn Andersson wrote:
> > Acquiring the reset GPIO low means that reset is being deasserted, this
> > is followed almost immediately with qcom_pcie_host_init() asserting it,
> > initializing it and then finally deasserting it again, for the link to
> > come up.
> > 
> > Some PCIe devices requires a minimum time between the initial deassert
> > and subsequent reset cycles. In a platform that boots with the reset
> > GPIO asserted this requirement is being violated by this deassert/assert
> > pulse.
> > 
> > Acquiring the reset GPIO high will prevent this by matching the state to
> > the subsequent asserted state.
> > 
> > Cc: stable@vger.kernel.org
> 
> Missing Fixes: tag, please provide me one so that I can proceed.
> 

This applies to the original commit introducing this driver, so:

Fixes: 82a823833f4e ("PCI: qcom: Add Qualcomm PCIe controller driver")

Regards,
Bjorn
