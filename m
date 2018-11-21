Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B557C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B3421479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="SeAPMLpb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41B3421479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732816AbeKVEeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 23:34:07 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43713 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731412AbeKVEeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 23:34:07 -0500
Received: by mail-qk1-f196.google.com with SMTP id r71so5367602qkr.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 09:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PPXYopDM0Bj3FgWCzKyop9CZtXJofPPZ6H3F3Sq4K/g=;
        b=SeAPMLpbx3ACQD+BNpkm07YoCNSE/0dvZPAyb6mvye0nFaePNY4gcRqxl1H1kvK1Ia
         2INcDfbXvneW3K3i6CCEcLw32kwAx7qMOR2fKWdMAqCTg9AV5QANSUdQ92rgKCFiGcg5
         6PdJFT3ecPmldlZNBcA0VFTVcOQ6PPNk0la8et7wO++P629O6pvEdObFR/BHPi9r8946
         ovRsnzfNmOAS1uH/P3lrh3emw7uAV+asC3FAJ8dD3C3NNc1NcR6m1LqWpNu+w+CyuXdQ
         7L5urhqch4peapcNKqUWxmsQgQTg0OC3a4R7AYskxdZILc0QPHIc4DD4SlDkpWrwgVO1
         DxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PPXYopDM0Bj3FgWCzKyop9CZtXJofPPZ6H3F3Sq4K/g=;
        b=S/YvAmEYgTUDsdj8C4Vo/ddGvzNSAXtkQAr44A3cE866lB3JvG9dcsCJfuOf0FIlO1
         FghfbMrPc+0vASqkU4/FJs5qbHa9ExL7Zf2qaWeW95Jmmght8RbCN9PS6lf9CxuyOJV/
         tLBw1TacYIpaZ4/E+M775TXp//Ju1INgFreepvrKqj7PqoV+t/9kiPZlJpOow/p/Uwyj
         I1UbEd26MYJE3JWieUgifoFJWT4cHZYILM8B2R5ZumoPuOlLn+/8I5B9ZQFqkY+D37mT
         NGEomDfaSmF8ckAfxwiCPe5TNkL+Wcri/xyCNi6IdqvxQUU5mRiB0dFjOl4UsH+cW2x0
         K2UQ==
X-Gm-Message-State: AA+aEWZSaz6POyKP3Sp3tmbku5cSBmwHLtfxfZkqwQdVOKt1QIUHoaT+
        a1RdpCcYoLHFZrrkvwFqdiHTLmtsxp8=
X-Google-Smtp-Source: AFSGD/WWkKJKhibNSDOx+PhBUiyACvaQCoDQoXceBdBlWyo7URiG0iz+6n5dLW7IoqN9NDLIqVT6fw==
X-Received: by 2002:a37:d204:: with SMTP id f4mr6554982qkj.311.1542823124207;
        Wed, 21 Nov 2018 09:58:44 -0800 (PST)
Received: from soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net ([40.117.208.181])
        by smtp.gmail.com with ESMTPSA id a90sm26031942qka.30.2018.11.21.09.58.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 09:58:43 -0800 (PST)
Date:   Wed, 21 Nov 2018 17:58:41 +0000
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     catalin.marinas@arm.com, akpm@linux-foundation.org,
        rppt@linux.vnet.ibm.com, mhocko@suse.com,
        ard.biesheuvel@linaro.org, andrew.murray@arm.com,
        james.morse@arm.com, marc.zyngier@arm.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] arm64: Early boot time stamps
Message-ID: <20181121175841.if3vyumzvw3yoovi@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
References: <20181120144340.30201-1-pasha.tatashin@soleen.com>
 <20181120144340.30201-2-pasha.tatashin@soleen.com>
 <20181121174706.GC9801@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121174706.GC9801@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-11-21 17:47:07, Will Deacon wrote:
> > +	/*
> > +	 * The arm64 boot protocol mandates that CNTFRQ_EL0 reflects
> > +	 * the timer frequency. To avoid breakage on misconfigured
> > +	 * systems, do not register the early sched_clock if the
> > +	 * programmed value if zero. Other random values will just
> > +	 * result in random output.
> > +	 */
> > +	if (!freq)
> > +		return;
> > +
> > +	arch_timer_read_counter = arch_counter_get_cntvct;
> 
> Why do you need to assign this here?
> 
> > +	sched_clock_register(arch_timer_read_counter, ARCH_TIMER_NBITS, freq);
> 
> arch_timer_read_counter can be reassigned once the arm_arch_timer driver
> has probed; what stops this from being unused as the sched_clock after that
> has happened? I worry that toggling the function pointer could lead to
> sched_clock() going backwards.

No reason, I will revert it back to use a local variable. I agree, time
can go backward for a period of time while we switch to permanent clock later,
if that clock is different. 

> 
> > +}
> > +
> >  void __init setup_arch(char **cmdline_p)
> >  {
> > +	sched_clock_early_init();
> > +
> >  	init_mm.start_code = (unsigned long) _text;
> >  	init_mm.end_code   = (unsigned long) _etext;
> >  	init_mm.end_data   = (unsigned long) _edata;
> 
> The patch from this point onwards just looks like a refactoring to me which
> should be independent of adding early printk timestamps. Also, it doesn't
> update the vdso logic, which hardwires a 56-bit mask for the counter values.

OK, I will split the patch, and will also address the hard coded value
here:

https://soleen.com/source/xref/linux/arch/arm64/kernel/vdso/gettimeofday.S?r=c80ed088#73

Are there more that you know of?

Thank you,
Pasha
