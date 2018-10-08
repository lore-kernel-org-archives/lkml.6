Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846ABC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B7FB2087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t7cph0H5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B7FB2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbeJHPrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 11:47:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40973 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbeJHPrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 11:47:03 -0400
Received: by mail-wr1-f66.google.com with SMTP id x12-v6so19791391wru.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 01:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WRHSl3P5CNNjT0b6NRyW6GiR6E1szdSGBEr+7jUK7gQ=;
        b=t7cph0H5QjwH46Pejkt2LA9jvJ3Bch22u7aFEk/ctKa4bvcWKaGfBIvTs/WDf/9wlk
         McPwJefzh1wg532I/IC31rSc2B7fcX6JzJuQ1i7R0h1KYUkePnOV12kxtZJRTMo5QMPJ
         HCAawmEs7xAlspWF0r7hvhr1wGNs5nTXyhKYl1Oq//j38c89wiKze8Yvn/GKx5gB+A6v
         i+2oF67Qi7RjlkGuAZtyS8Sj1edAis3vsLqGIqwEVU2A0xTjjZDGOeHc9rzDpzoHR6TV
         jfaVCglTttePWB49uyEhdLPecEh0uO/3n2aXaY1rLm8Wt+Ihz9X6APpscP3C/4BHN367
         SZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=WRHSl3P5CNNjT0b6NRyW6GiR6E1szdSGBEr+7jUK7gQ=;
        b=NGPAB4d74mitHBOcEvOXLZjnjHylovo3LyBLhsPcpOXJwHaMh1yT5VXGNRdeNpC/e2
         19YWfw09CjvVAFE9/aN8wAZBzuWUFg7gImIErhUmLufU3W0JySYirlKwXeubggJY8kJt
         m356OOpw91GIlrbtO1k14UFogn6B56LAL3ZDjhrwC7nTmPIbzhYMTtovFvGlOkePaonE
         FzO2C9gBoE0VhnD/uHQSqO0zaKO3xwmth8cyhmNA859RfStbH1qp8KXq3S1il6tBB8W5
         1CMBY3s4ocYqSBmkwWACdwakmlIvhgWRRyZf54I/fsY3Rd9hQ62KrkoDeGcrEP0nvXnr
         7f2Q==
X-Gm-Message-State: ABuFfoilr5BxG8p957mdC8wdICZOEfwWT2dMzun3BgMd1BDWP9rf9CSn
        keSStMG5VYxdcXoGoTgbciw=
X-Google-Smtp-Source: ACcGV60WJ6N1cl/2hsOdIYfSFKPMOJkKTQTq/rS1Pf2Paw1hTWgUVKEdoNe9vsvcaSLsXG1fTaOrGw==
X-Received: by 2002:adf:84e6:: with SMTP id 93-v6mr16610218wrg.144.1538987787350;
        Mon, 08 Oct 2018 01:36:27 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id t194-v6sm13719792wmd.48.2018.10.08.01.36.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 01:36:26 -0700 (PDT)
Date:   Mon, 8 Oct 2018 10:36:24 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 8/8] x86/vdso: Move out the CPU initialization
Message-ID: <20181008083624.GB117675@gmail.com>
References: <1537312139-5580-1-git-send-email-chang.seok.bae@intel.com>
 <1537312139-5580-9-git-send-email-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537312139-5580-9-git-send-email-chang.seok.bae@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Chang S. Bae <chang.seok.bae@intel.com> wrote:

> The CPU and node number will be written, as early enough,
> to the segment limit of per CPU data and TSC_AUX MSR entry.
> The information has been retrieved by vgetcpu in user space
> and will be also loaded from the paranoid entry, when
> FSGSBASE enabled.
>
> The new setup function is named after the getcpu(2) system
> call, and will be called during each CPU initialization
> (before setting up IST). It makes a facility useful to both
> the kernel and userspace unconditionally available much
> sooner.
> 
> The change brings a substantial code removal. The redundant
> setting of the segment in entry/vdso/vma.c and hotplug
> notifier are removed.

The title and the changelog is totally unreadable, full of grammar errors
which makes it actively misleading...

A good changelog should explain not what it does, but _why_ it is
done:

  x86/vdso: Initialize the CPU/node NR segment descriptor earlier

  Currently the CPU/node NR segment descriptor (GDT_ENTRY_CPU_NUMBER) is
  initialized relatively late during CPU init, from the vCPU code, which
  has a number of disadvantages, such as hotplug CPU notifiers and SMP
  cross-calls.

  Instead just initialize it much earlier, directly in cpu_init().

  This reduces complexity and increases robustness.

I've edited the changelog, but please keep this in mind for future submissions.

I also made a number of other cleanups to the code, will push them out
after some testing.

Thanks,

	Ingo
