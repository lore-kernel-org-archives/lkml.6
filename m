Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F40C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F9AE2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddfIird1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F9AE2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbeJRPuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 11:50:23 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36961 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbeJRPuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 11:50:23 -0400
Received: by mail-wm1-f67.google.com with SMTP id 185-v6so4716979wmt.2;
        Thu, 18 Oct 2018 00:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tdpOlQlgeOnx0N7HYdMQh9qtWEjQ6MMPQ6nLyhZaHpM=;
        b=ddfIird1wxXlNPsOuwHtlHDWvP5wmSbiUVQq/XCu7eA0VgPn3XW4V2DJn0ahu/rrLu
         Z++6WTAz2PPfopuJeqF/+lVEFNx56Qc1LchP/2+BPfrO6OYTyFGzVx7al97Auyy2spA5
         aCy36LA85fvD6e0NyxmpalPpgJmp6ZOtcdkzp9MoRBVVSMtrMoBryR8lC0rApMi+NxU9
         3kDNZp2SepnhMtX5t3NAaIyeceTSm82I6cHCp72Ld9E1llAKBKQNqvIVLqURp61inwjN
         0ikaTNs2hzxzqM4t+6mDNk2S6ESLjnr67J1hcCgd501TTru0mFdHKeP5iaezHdeAA6N7
         IKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tdpOlQlgeOnx0N7HYdMQh9qtWEjQ6MMPQ6nLyhZaHpM=;
        b=iHzZS3UfQs3acIvEG/BwZU4n7BhIgCE3pcYJUDmaC8mDGoPRohw5QMhKMQoPFwDsvm
         G5Dzt+C/zMTY3cyJ7omW6aFIaKEQuzy85dHN7HK2QzsXkmNGNuCK4xEjsobxUTu3J9HQ
         HAEnTLFYthDlvKnc8pR3dq97Vsqp1gTZ60LXn/iD1hpZDRax4SzXNJO3pdjMpN3VefS1
         uNFkmOw/EUdJEQn6y89g5rLhdt9rKm+Ijz0pj7IuKH3yLKIPKuYJ6AYKwAG5FM16+2Fn
         6Oh0tG+iO9qVtgot67eD6pofLfs+BEnc+/8HRxYeuko+3Uly8b1ki0DM0b/WtC3h4FUD
         KMcQ==
X-Gm-Message-State: ABuFfogqPQadhqbNDUdwFhKWVvmPYjhk2b2m1TNcJShTfL3uQpUgb/F+
        IZV6zl1Jy0ZHGw9KqMbn6pbukIiG
X-Google-Smtp-Source: ACcGV60fU65c5yiWptYO1IMfJ/Dij5/EnWdw2uKjBpgSPhg5TnLE/TdzDXAFZJAEEGeVYeWYVhAZmg==
X-Received: by 2002:a1c:c683:: with SMTP id w125-v6mr6153589wmf.117.1539849036748;
        Thu, 18 Oct 2018 00:50:36 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id a84-v6sm4148164wmf.46.2018.10.18.00.50.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 00:50:36 -0700 (PDT)
Date:   Thu, 18 Oct 2018 09:50:33 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Quentin Perret <quentin.perret@arm.com>,
        ionela.voinescu@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
Message-ID: <20181018075033.GA58819@gmail.com>
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
 <20181010061751.GA37224@gmail.com>
 <5BBE1E1F.3030308@linaro.org>
 <20181016073305.GA64994@gmail.com>
 <5BC76181.90105@linaro.org>
 <20181018064849.GA42813@gmail.com>
 <CAJZ5v0g=CnAv6HC6H68ub0KbO8Z8Fx4BtW=mjfEshNsnNX407w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g=CnAv6HC6H68ub0KbO8Z8Fx4BtW=mjfEshNsnNX407w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Rafael J. Wysocki <rafael@kernel.org> wrote:

> > The only long term maintainable solution is to move all high level
> > cpufreq logic and policy handling code into kernel/sched/cpufreq*.c,
> > which has been done to a fair degree already in the past ~2 years - but
> > it's unclear to me to what extent this is true for thermal throttling
> > policy currently: there might be more governor surgery and code
> > reshuffling required?
> 
> It doesn't cover thermal management directly ATM.
> 
> The EAS work kind of hopes to make a connection in there by adding a
> common energy model to underlie both the performance scaling and
> thermal management, but it doesn't change the thermal decision making
> part AFAICS.
> 
> So it is fair to say that additional governor surgery and code
> reshuffling will be required IMO.

BTW., when factoring out high level thermal management code it might make 
sense to increase the prominence of the cpufreq code within the scheduler 
and organize it a bit better, by introducing its own 
kernel/sched/cpufreq/ directory and renaming things the following way:

  kernel/sched/cpufreq.c		=> kernel/sched/cpufreq/core.c
  kernel/sched/cpufreq_schedutil.c	=> kernel/sched/cpufreq/metrics.c
  kernel/sched/thermal.c		=> kernel/sched/cpufreq/thermal.c

... or so?

With no change to functionality, this is just a re-organization and 
expansion/preparation for the bright future. =B-)

Thanks,

	Ingo
