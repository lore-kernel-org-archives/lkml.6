Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95F3C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD19B20659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544113629;
	bh=KRyjkGHdbrnpBRAVuH6C/FGKJA6A1MqSDPXmNaEmIek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hQBSfE8Jpa9IYlJa+4WZTXCAdjsjHzOF6MRItvYU12XPoHFMNg3Irl4RdN7VZcpZ9
	 zT3in6XW7mGZ1OfGNZ/kZa+L/v3ZD17ZZ9LuRtcrsAddwU16lSMDlD+6JEBtEV0+Co
	 FTHiJ09jJuy4J5hF7X5T5beVNZWvEE1BCHtmybp4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD19B20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbeLFQ1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:27:08 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35819 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbeLFQ1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 11:27:08 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so1123101wrb.2;
        Thu, 06 Dec 2018 08:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kJgAfFVAcud5Bh1AnJz2yFShvgQWi7xtD0iUdUlRMVg=;
        b=COjGvbcfYXtTlmf/4gIOjEzZm1R1Hd1GNFmrh0cQ6OGCs1hD/cv9bAAO+3aseh2QMQ
         wGGESaePlopaOM0/fodjWhPeMLyKU879NUbYmIggalHgUoJbSgxbeV93d5nj8//WXTgv
         SGq8qOSXyPfH8rfyG5+KSsu010P+XpAd41Td9RZF2VaxigP/hVlJ9OuFkyzFS1U8Ckx3
         s0pSzFcSK1GXm/X6nbEmu2w3eOxLdtFWvYEuN9JKxsl2KFpXEassmloo9UCkXaFNM2WR
         QZ7HdGBXNWuZT9is8PzWXrIQ5floyp2Cv+HPu4++Yjoloq25K847isMRe83WNm7H1TGx
         rGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kJgAfFVAcud5Bh1AnJz2yFShvgQWi7xtD0iUdUlRMVg=;
        b=seXz5+Pp4ONsSeFIwqLxG7d7vr9YRQJg7AjpM6wgPLsg+5uqkDhfGcZmVyi12UF0Xz
         QYgetOAEfU+aaRMiyQn+Nq2ZIUw0O7arrUcew4JZCPuU6hq6D7pYEXOeifNkkJ9yZVw6
         MniJGgWmYV4KJ5uMjaddM8Y/crRZYNmZdVldW8vKu7CdXrpJi6qSHaFmFh8qJrJYeTsV
         CHv7dpnDAv8rkVOgh4YCF4+YFPhSLiqU0iHV7bdt+ia6QB2edsxWTvXGYXGgFfRxTRtu
         PCGwmySRbTTkx23IAw72g95zhdXcn2DAa+GFhq0i4Jw/EX5yhnB5BEgiv5mLMlxcyvA5
         jc1w==
X-Gm-Message-State: AA+aEWay4nhRGp4d/2sI885vMwUK8bJzyexdo2TExfT/1MPoh+eD2b8O
        49GTSWKXT+MS7zTZgWg+CcDHUy16
X-Google-Smtp-Source: AFSGD/U+fXUvqoV0My0+4VukFkVM3me53V0AzPlEuOXMWsqroFC3eefjsIAla+rLABBjut+HPGL4rg==
X-Received: by 2002:a5d:4512:: with SMTP id s18mr27353419wrq.182.1544113626200;
        Thu, 06 Dec 2018 08:27:06 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id s16sm478788wrt.77.2018.12.06.08.27.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 08:27:05 -0800 (PST)
Date:   Thu, 6 Dec 2018 17:27:03 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>, X86 ML <x86@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>
Subject: Re: [PATCH] x86/mce: Streamline MCE subsystem's naming
Message-ID: <20181206162703.GA119163@gmail.com>
References: <20181205141323.14995-1-bp@alien8.de>
 <20181205163037.GC109259@gmail.com>
 <20181205170006.GK29510@zn.tnic>
 <20181205180158.GA64770@gmail.com>
 <20181205190355.GP29510@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205190355.GP29510@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Borislav Petkov <bp@alien8.de> wrote:

> On Wed, Dec 05, 2018 at 07:01:58PM +0100, Ingo Molnar wrote:
> > Oh - I thought we'd have arch/x86/mce/ or so?
> > 
> > There's machine check events that are not tied to any particular CPU, 
> > correct? So this would be the right conceptual level - and it would also 
> > remove the somewhat redundant 'kernel' part.
> 
> Well, all the MCE events reported are some way or the other tied to the
> CPU and they're reported in the CPU's MCA banks so I think we want
> 
> 	arch/x86/cpu/mce/

Well, *everything* the kernel does is in some way connected to a CPU, 
because we always execute the kernel on a CPU, still we have things like 
discrete PMUs and abstractions for other pieces of hardware that are not 
per CPU.

So the real question is, is there a signifcant class of MCE events that 
are not tied to the reporting channel which is per CPU (-ish ...) MCA 
banks?

Thanks,

	Ingo
