Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACA0C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E46E20989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WbkQr0Kp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730611AbfA3KRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 05:17:21 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35449 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfA3KRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 05:17:21 -0500
Received: by mail-pl1-f193.google.com with SMTP id p8so10851341plo.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 02:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qtqFBfcBpvpDSs7hW0mzxMLq7yUG6Ahbo+VkJvD38cc=;
        b=WbkQr0KpBVamQsPJnuV4Q60cgeFnnSFMWEpBLNO4BdSer+fvP3I58cLUHT3yV0kthv
         G0LrXs8LUMdPbR6SSt83G4rsQcnQh4ayWNMZXqSVDbQRNOYq8JmvqWxwqz4cX054YNJq
         Ku8KZdtOueYzAbykjyvkFsVFsCadn8WIayL0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qtqFBfcBpvpDSs7hW0mzxMLq7yUG6Ahbo+VkJvD38cc=;
        b=H+PtWKDGcOqd2USBIeNoPGCzaoBJzKY+jkaBdcMw+XsMlGevHbqZB9NMHb7PRzNW+c
         iJnPU6n/jnDFu+X9IboGiSxGw7RAQ523HmZQN5J1g3hvt3KbdOxOrqbRCxoySlO3y7zx
         9MJZtFeOV7lBD1TRnpNLgpBR8TqEMOtbl0RSxkPS2KlJVuVYtOkSJA3SbXt9Pj7Jb36h
         nk42D8camFJnJLoN/gjjpdhOqIsq8NcTJnMOukGD0rD+YFir+BTTUYqc+ZNLlXEzjNua
         jN4zOeb4Q2C/mz8vX7wFf6oDP+euvRY/4968jLd4pV3EKdpFt6qVVZ6D9rAN2sCaaTxZ
         p4LA==
X-Gm-Message-State: AJcUukeJbgoSei7n0NM1uhjV2D5MBB0v2eAe9Q3Exy3PyI5u0Vymm4Na
        yElc1zR3ph8JzOkh33JiKjpB0w==
X-Google-Smtp-Source: ALg8bN5ZP+pqxSK3+axrtFel8s0idJS1nrrba4mwyQA9QsMSf7ul+5tOWzvQUh00Y2lV4S3+QJfVvA==
X-Received: by 2002:a17:902:780a:: with SMTP id p10mr30442782pll.54.1548843440166;
        Wed, 30 Jan 2019 02:17:20 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id x28sm2871896pge.66.2019.01.30.02.17.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 02:17:18 -0800 (PST)
Date:   Wed, 30 Jan 2019 15:47:15 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>, rjw@rjwysocki.net,
        sudeep.holla@arm.com, liviu.dudau@arm.com,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        mark.rutland@arm.com, nm@ti.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH 2/7] cpufreq: dt: Register an Energy Model
Message-ID: <20190130101715.nz2bpqnust7gv4at@vireshk-i7>
References: <20190128165522.31749-1-quentin.perret@arm.com>
 <20190128165522.31749-3-quentin.perret@arm.com>
 <20190128193656.GI81583@google.com>
 <20190129052144.plicqu4vozh3l3ss@vireshk-i7>
 <20190129091546.tfh3lo4w4sosfuba@queper01-lin>
 <20190130051806.fdsos27jaekkwgbs@vireshk-i7>
 <20190130091055.zjj2jrjvi2n3ht66@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130091055.zjj2jrjvi2n3ht66@queper01-lin>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-01-19, 09:12, Quentin Perret wrote:
> What I had in mind is something as simple as:
> 
> 	void of_dev_pm_opp_register_em(struct cpumask *cpus)
> 	{
> 		/* Bail out if an EM is there */
> 		if (em_cpu_get(cpumask_first(cpus)))
> 			return;
> 
> 		/* Check prerequisites: dpc coeff in DT, ... */
> 		...
> 
> 		em_register_perf_domain(...);
> 	}
> 
> IIUC, Matthias' point was that if the EM is already registered, there is
> no good reason to call em_register_perf_domain() again. Now, that should
> in fact be harmless because em_register_perf_domain() already does that
> check. It's just cleaner and easier to understand from a conceptual
> standpoint to not call that function several times for no reason I
> assume.

If there is no good reason to call em_register_perf_domain() several
times, then the same applies to of_dev_pm_opp_register_em() as well,
isn't it ?

This is init code anyway isn't going to run a lot, so I wouldn't
suggest adding any such (duplicate) checks in
of_dev_pm_opp_register_em().

-- 
viresh
