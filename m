Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0696C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9612320850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="AJblSxBh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9612320850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbeLEQCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:02:05 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44817 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbeLEQCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:02:04 -0500
Received: by mail-qk1-f194.google.com with SMTP id n12so12128792qkh.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 08:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q63NP6HHv8MmLXxuAIzKXrKWfuE1xKbiTqkCNXb9RGw=;
        b=AJblSxBh6qa0ivGrrvlx7jfgkSEqUZpnF5+m/gHsll81N+WTkvBL/+26tQ2C+MHKfG
         4TUfaRVpRRYK/OqnoQ+PmgCKzdqg+iX7IEEs8QQMsd4X2zYBJ4Mcs+Mw+BhS7fk/L4Mu
         I4bSjcxrFt7QofF1LhXElnIu3svO/RWDxm0Zfm8EDOri/0lavK5IqrheFyNrnHjGvwgh
         Mh5pxXS4yPM8jCp2tYR2vXmsNwJuUNvV/GvYrTV0EKwIm4bi6nVieDZRcURis8SFu0kX
         T2NGgFjzsFHi9eLTKm0dCID/XGv+xCPRCh4WOOtthnATSL+hgrSurmkG3f9j0f8357Jl
         Njug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q63NP6HHv8MmLXxuAIzKXrKWfuE1xKbiTqkCNXb9RGw=;
        b=LNoP70Nr/ZoP/T0wFNjo6GJfVcPo6Hr8y3IQPpRffEwrqH+8YPzsvmLPM+nfGQjlwc
         +DYd0SiJ7Oi0ZPTT4y7diOva1HifCm274dRK/pq+v/t0f+jqtHyaP6UDmQil/7JBKVcz
         gKJCFlVW72cxLMf+w661DsqdmOFuryjYgZcvs+l713dX/49+snkjwxwWeZggDx9yrgOH
         j3++4pcpOVXw70n+5qhO4h8p4NKjWKtNrSo9AGlnlNHK3XiTTCRl9ClyEBHLsM/jfg1y
         MXLVE0SDPzYHyjNMfmZIPxR8w9PoeQCQPAjAyJMuy/hb67sFy+XAXBrKp4a5ioCiy+Pf
         jmng==
X-Gm-Message-State: AA+aEWZhCffhhyrQpAOZTRvqkCPmF1MqxH1Fq/uPQrwv/AJ5VaBkm3py
        AcBBu5Zf1++Zt/GV4/E1mGhiXw==
X-Google-Smtp-Source: AFSGD/WXASXlWCPCtfJgJzLkQJFNd+29a5HpSHF2hcpSNlm5NwF5/SumXGrVcWxucHB1Gx46wRG+pw==
X-Received: by 2002:a37:9181:: with SMTP id t123mr22081025qkd.187.1544025722700;
        Wed, 05 Dec 2018 08:02:02 -0800 (PST)
Received: from soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net ([40.117.208.181])
        by smtp.gmail.com with ESMTPSA id p47sm14181745qta.36.2018.12.05.08.02.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 08:02:01 -0800 (PST)
Date:   Wed, 5 Dec 2018 16:01:59 +0000
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>, catalin.marinas@arm.com,
        akpm@linux-foundation.org, rppt@linux.vnet.ibm.com,
        mhocko@suse.com, ard.biesheuvel@linaro.org, andrew.murray@arm.com,
        james.morse@arm.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] arm64: Early boot time stamps
Message-ID: <20181205160159.qetplipng3bhrgnb@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
References: <20181120144340.30201-1-pasha.tatashin@soleen.com>
 <20181120144340.30201-2-pasha.tatashin@soleen.com>
 <20181121174706.GC9801@arm.com>
 <20181121175841.if3vyumzvw3yoovi@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
 <86lg5lrygq.wl-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86lg5lrygq.wl-marc.zyngier@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-11-22 14:14:29, Marc Zyngier wrote:
> On Wed, 21 Nov 2018 17:58:41 +0000,
> Pavel Tatashin <pasha.tatashin@soleen.com> wrote:
> > 
> > On 18-11-21 17:47:07, Will Deacon wrote:
> > > > +	/*
> > > > +	 * The arm64 boot protocol mandates that CNTFRQ_EL0 reflects
> > > > +	 * the timer frequency. To avoid breakage on misconfigured
> > > > +	 * systems, do not register the early sched_clock if the
> > > > +	 * programmed value if zero. Other random values will just
> > > > +	 * result in random output.
> > > > +	 */
> > > > +	if (!freq)
> > > > +		return;
> > > > +
> > > > +	arch_timer_read_counter = arch_counter_get_cntvct;
> > > 
> > > Why do you need to assign this here?
> > > 
> > > > +	sched_clock_register(arch_timer_read_counter, ARCH_TIMER_NBITS, freq);
> > > 
> > > arch_timer_read_counter can be reassigned once the arm_arch_timer driver
> > > has probed; what stops this from being unused as the sched_clock after that
> > > has happened? I worry that toggling the function pointer could lead to
> > > sched_clock() going backwards.
> > 
> > No reason, I will revert it back to use a local variable.
> 
> I think the issue is that you are doing an assignment for something
> that the kernel has already statically initialized.
> 
> > I agree, time can go backward for a period of time while we switch
> > to permanent clock later, if that clock is different.
> 
> It is worse than that. You're setting up sched_clock with an
> unreliable clock source which can go backward at any point, not just
> at handover time.
> 
> I'd rather we have the timestamping code be able to use another souce
> than sched_clock, and eventually switch to it once sched_clock is
> registered (and properly corrected.

Hi Marc,

The early sched clock is implemented the same way on SPARC and x86: it
uses the sched_clock() interface to get timestamps. In addition it can
be used be engineers to precisely measure and debug early boot problems
by directly inserting cheap sched_clock() calls into code. Ftrace might
also be extended in future to support early boot.

I am not sure it is a good idea to invent a different interface that
would be used by printk() only for timestamping early in boot.

During the hang over from unstable to stable the sched_clock_register()
does the right thing and calculates the offset where the last clock
ended and new started.

In unlikely even if on some broken chips time goes backward, it will
happen during early boot only. Do you know if there are arm64 chips
exist where time may go backward? We can either don't do early boot
clock on those chips, or modify sched_clock() to check for the last
return value, and make sure that it is always smaller than the new
return value.

Thank you,
Pasha
