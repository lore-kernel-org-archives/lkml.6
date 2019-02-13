Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2B8C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E59E6222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550045698;
	bh=78GJy8Tg1F64jYVb0AJkJB4DOwttt/1qeDzr/jWVkIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dKxrUmf0ZgNfk70Aq2/B32AAyZYEzoZYLrNCQ3Tfy14UUdSaMZ82qi56Cp/DmkHqs
	 eFwI1LJAWhUKWUFG06wGR79CGVIW+bdBemHT9ot4dEWeCKl7qzwnIlwjymGITgykzH
	 rwRiH0UDxOHp0an2/OHphvK54i/jZZbM2QBjidbQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390561AbfBMIO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 03:14:56 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35281 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732965AbfBMIOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 03:14:55 -0500
Received: by mail-wm1-f67.google.com with SMTP id t200so1365909wmt.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 00:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kO01Peai4Zhkttf54vbKyKWh//kopmg+FT7VueRNA48=;
        b=D/NtXw0bAktPtELsX4vPG+wmdFzw+Tl/a4/JuLFH4McQZp7/qXizppAE4vSvomW1hB
         s82P5lqhBRDzkmuBuw6j6IBNkw1prfOA92dP6eVtk5pBfcc4tMiWMW8nf4xKMmF7d1tJ
         QTToSsG9f2izkv0pGImQaEHdeBqicjhLpUil38o3CXRk7jkOsH+qft0NjyQHzcU7EMT0
         6hW1VWN8oB91DKOIvmg9Pn/SvGhyfvGEbZZE8bGVsV4kj9R3VlInPMLvWlx2LaBQiTKU
         AZsyGqzVLsG9uvirCaRxiyKBSNZeJJhcQUhmVmM/RZ2Gz+dvFN3U6OunfE/qytPWeImn
         RdQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kO01Peai4Zhkttf54vbKyKWh//kopmg+FT7VueRNA48=;
        b=Izqsrhf6zi9xlgijMlkFI2iZ5HgYnrCAX4FKkXrnoOmYLrzbqZTloh6n+L+U68E7na
         rNy4ryDoDn+4+N5l3nCPyGnZgzj2YqEdlYcbzr/dk52ezb2KTGXPsufLT1/O5YemuLGs
         XZ79/9vzxysbfq6qD83psdr8sk6hXWdqzLR3kmFjE8gAaq0y10xH6AjhQjkI+PiFt0rW
         V0SVV0a+K1XbS0LhVuZHV4XnhNGGVr01TEfULeD58RpCPXQy47hS+FpOeaW0lu/X30us
         dFY0YXSeSZiuYUVmOYP1YD96O4Ub0UbSJGsA33mer4Z3ocGf5LCF2O6KE8XwAgcAIAnH
         K6uA==
X-Gm-Message-State: AHQUAuaDKLp93dn2Zwl7BRb95Hyb3GYrAL23RZQCwlSkW6ixaGs9QIEc
        SrGeBpUsvzWjlBP3i1dk0oU=
X-Google-Smtp-Source: AHgI3IaT04QNFRcpjXyorTooM2FV8BPF3gxDAcsJEbmHYS0RfEdTiqGt7V0x2jm3rVZdcAgoGcDOBw==
X-Received: by 2002:a7b:c08a:: with SMTP id r10mr2180019wmh.112.1550045693575;
        Wed, 13 Feb 2019 00:14:53 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id n3sm6548548wmf.46.2019.02.13.00.14.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 00:14:52 -0800 (PST)
Date:   Wed, 13 Feb 2019 09:14:50 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Chan <michael.chan@broadcom.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v3 10/10] x86/split_lock: Handle #AC exception for split
 lock
Message-ID: <20190213081450.GA53242@gmail.com>
References: <1549084491-57808-1-git-send-email-fenghua.yu@intel.com>
 <1549084491-57808-11-git-send-email-fenghua.yu@intel.com>
 <20190211105339.GA40840@gmail.com>
 <20190211181013.GA103371@romley-ivt3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211181013.GA103371@romley-ivt3.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Fenghua Yu <fenghua.yu@intel.com> wrote:

> On Mon, Feb 11, 2019 at 11:53:39AM +0100, Ingo Molnar wrote:
> > > +		do_trap(trapnr, signr, str, regs, error_code, BUS_ADRALN, NULL);
> > > +	}
> > > +}
> > 
> > Is there any experience with how frequently this signal is killing 
> > user-space processes on a modern distro? Any expectation of how frequent 
> > such SIGBUS task terminations are going to be in the field?
> 
> We did pretty intensive testing internally (zero day tests, many engineers
> and testers use the patches in their dailly work, etc). So far I'm not
> aware of any user space process hiting split lock issue. I guess GCC or
> other compilers takes care of the issue already. Inline assembly code may
> hit the issue if code is not right, but there are fewer inline assembly
> code in user space.
> 
> So far we only find two kernel split lock issues and fix them in the first
> two patches in this patch set. We also find one BIOS split lock issue
> internally which has been fixed in production BIOS.
> 
> Thanks.

Ok, still, for binary compatibility's sake, could you please add a sysctl 
knob (root-only, etc.) and a kernel boot parameter that disables this 
check?

Looks good otherwise.

Thanks,

	Ingo
