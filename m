Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9A7C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A6E620849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544537915;
	bh=/sKarZtbYOxybNhvTGXoeTS9+Dg3R3jC+zug2fkhAZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=F52k9m7akxV2gGmcApo9yLtSeJCvphOrb0+td0ORuWA/jzF7L/bnWAAZOcY7Rxl7A
	 HjdHumQzNe/XMiJGYxI4JtYAeDhYT/C45M+ksExBpHbcZiiFkIJB2hCgzdb5mTfFtZ
	 PoA0Bwih9v7RHyaL6VhNrRBR+JGCfxMFj0+m7pZY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A6E620849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbeLKOSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:18:34 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39555 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbeLKOSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 09:18:34 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so14248944wra.6;
        Tue, 11 Dec 2018 06:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1xqiTeUYXRnPvJWWdj4lHOk9RYG/oG0IAWQwB3KaIaE=;
        b=JdhMe1RFv6TBgFPBzvMVSTV8cFU8o00a1815Mb0NK/xQnLtyJiAYyTzERyzE/9Y5Ty
         EpRh65oUuTmPw9QrwPZLPlxbFWO5Ue8ZD6zEEwBom1XrONskmth/BSoQLhqCliguMtYX
         9UbSxnXOTVbn8V1fZF2VY4sem2KJjJ5e8aP5rwxeo4RC/1zF/lnL1IQPPv6EpLOTfcsR
         Bds6TCtMy0ccRqqQ0qyAtGYifIg5b+al338TnjtYA1GZsrNw9ibUJ6pkV4MwC3PIHUgm
         7ZxBE2RPNvGRVj9NjkGrkNyr3GdM+9G/34zHWp+88tYCHhcGgcfs03t4JNgV7OOLSuD0
         HjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=1xqiTeUYXRnPvJWWdj4lHOk9RYG/oG0IAWQwB3KaIaE=;
        b=JEI+VmINVvAH4gqPEs4a7/G70Mle/fLcKV4WQNxZSh3tscByAK59/jHfvZMKdNKNXW
         B0zfrMbY2NQR24JFYl0h6erzj6KVLlYRzEaV7RrvGmL2RPF+ED7EU3VUqco8sx6zV2gW
         E96VtCLRPScfCxAlSJ/V5R7cPJu6Ny11f/zMYv3Acz3GOU8XcMTXpaPni3elAC4Qep9z
         bToYpN9JXJgYomyCacmnoogL/J3eA3NCMDrVp/BL+KzdJ4jlsCpWtNEkZ7Voj/PWKZDM
         /pEpi+YOT85bkoRnuUXjIxHlZS20wWbp9oRZq2DhIC1Met5+3pRqVmCp3ck7bWYpDxed
         BCpg==
X-Gm-Message-State: AA+aEWYh1KTvs35AKH6UfI51x2GASx3etnPwGp6S6jg148TX5I06Sc84
        3W0MINtYbmfy7Ti2+RCsmuA=
X-Google-Smtp-Source: AFSGD/VpuCaRAMpxcR5mJNBdb5IBxK9kwQpsTpp4mBVcmPJl8dcebx/wDOaPh/ETpEHEETmED/hnUA==
X-Received: by 2002:adf:f703:: with SMTP id r3mr13414590wrp.93.1544537911250;
        Tue, 11 Dec 2018 06:18:31 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id l3sm15281429wru.36.2018.12.11.06.18.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 06:18:30 -0800 (PST)
Date:   Tue, 11 Dec 2018 15:18:28 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org,
        tkjos@google.com, joel@joelfernandes.org, smuckle@google.com,
        adharmap@codeaurora.org, skannan@codeaurora.org,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [PATCH v10 04/15] PM / EM: Expose the Energy Model in sysfs
Message-ID: <20181211141827.GA85618@gmail.com>
References: <20181203095628.11858-1-quentin.perret@arm.com>
 <20181203095628.11858-5-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181203095628.11858-5-quentin.perret@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Quentin Perret <quentin.perret@arm.com> wrote:

> Expose the Energy Model (read-only) of all performance domains in sysfs
> for convenience. To do so, add a kobject to the CPU subsystem under the
> umbrella of which a kobject for each performance domain is attached.
> 
> The resulting hierarchy is as follows for a platform with two
> performance domains for example:
> 
>    /sys/devices/system/cpu/energy_model
>    ├── pd0
>    │   ├── cost
>    │   ├── cpus
>    │   ├── frequency
>    │   └── power
>    └── pd4
>        ├── cost
>        ├── cpus
>        ├── frequency
>        └── power
> 
> In this implementation, the kobject abstraction is only used as a
> convenient way of exposing data to sysfs. However, it could also be
> used in the future to allocate and release performance domains in a more
> dynamic way using reference counting.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> ---
>  include/linux/energy_model.h |  2 +
>  kernel/power/energy_model.c  | 90 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 92 insertions(+)

Why is a read-only ABI added for 'convenience'? We really don't do that 
as ABIs are final and they come with responsibilities.

I think if this is for debug purposes it should be declared and put into 
debugfs or so.

If it's for some other purpose that purpose should be declared.

Thanks,

	Ingo
