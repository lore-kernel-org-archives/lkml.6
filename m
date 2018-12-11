Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0334C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A45252084C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544537718;
	bh=btIkuGMu4oq9KJJipDS2QkItUsZfELjYDWkIDx0tXj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=x/5zTfH2PYdXBjJTfDwVax+ChlG7qTql+H6FKQP51Qcn1LcPW8RpB/vtt4ad6zK3t
	 iRYS6FwUBFHNf1AEER0MX9m8uoMrjIVlB8oen4Xun5Tmy2YUtaKSTkjvbSDnDORDhb
	 EgB+GDIdn8Uipcw/Mm/yPJh+OGhH8QOPAQlbjPHg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A45252084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbeLKOPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:15:17 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43626 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbeLKOPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 09:15:16 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10so14234148wrs.10;
        Tue, 11 Dec 2018 06:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pMf99pyABdRzoJiS5lDTMS1O9Zl2Bxv/+qfzWDHb74s=;
        b=cK2v5ShG2PBWF/v2C9yFy/eWxoJ5j630rJGHlWBE/PM/aI68V8kjCHT/9sTmCx2t1A
         5f7+bypd6Ebni8p25o8pAdhjFMbj2e8tDMvnymImzmJ23k/8+5U7CHbXSf2ouDvpEO7F
         HjUYvfSeaGxxqaw+Io5/PZXASGkC/LrAhdimT7bmJ+8YBM8EaAuHV9Av2BA0QKfmcQaK
         DL8az8CGeNaRJTN/Kgs1rv/dzaGboPUVFGKAvTZbfd3o8pWMDc8tO6PmHuwC66iblU9V
         NdXkGP/DAKDyoBOFRiIsOlRuEuHT28+b4FqqwoO2hQq4MB0hq+GEoTIpFvxCV5J2SOvw
         kEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=pMf99pyABdRzoJiS5lDTMS1O9Zl2Bxv/+qfzWDHb74s=;
        b=l7SUhDTvnD0j0yQAublj2M2hdnN0O/3RC0BzJugjEh2MTuMmHmPtQvcY6Yn7M3zMSP
         zlXLFSf7ctSCzxG+WlbTsICXl94eiU0oZ0rtFwwm0GnxV8wsMOjxTAqzi7wmmcE64NAK
         PuZ2eD0utSklUCakF5xZhBjoUTWI4CxK9bid9MfWpPcBH7Ya7/iGD7J9KocAkpVD2d89
         lJ4JwZlljvBqyns8WKh7y7RFpST3NvS411r2F4NAiR6iCKnNPm8ciO1WyZWN7GVHdIsP
         svcdAiDQ2qgFGv1/RXV5A72CpqapyMWiAw2EelTVO5Qjed/2I0m2HTOSNBhMLZQYLhJT
         N9dA==
X-Gm-Message-State: AA+aEWbAzn6lIZzRSlfjIh498VdHX0QukHGU0ufJz2d3PJYS1nODZySc
        gHqalphL3Q4v0vtJgekwG09XXlbh
X-Google-Smtp-Source: AFSGD/WNnmNyTU2if/F1U14ChQFu6YLUfhMgWGH35q0gJe1urT4GlN4ZYiipVGD2sIVtRWbeH9y0CA==
X-Received: by 2002:a5d:6549:: with SMTP id z9mr12973387wrv.116.1544537714051;
        Tue, 11 Dec 2018 06:15:14 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 133sm168385wme.9.2018.12.11.06.15.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 06:15:12 -0800 (PST)
Date:   Tue, 11 Dec 2018 15:15:09 +0100
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
        currojerez@riseup.net, javi.merino@kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH v10 10/15] sched: Introduce a sysctl for Energy Aware
 Scheduling
Message-ID: <20181211141509.GA32005@gmail.com>
References: <20181203095628.11858-1-quentin.perret@arm.com>
 <20181203095628.11858-11-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203095628.11858-11-quentin.perret@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Quentin Perret <quentin.perret@arm.com> wrote:

> In its current state, Energy Aware Scheduling (EAS) starts automatically
> on asymmetric platforms having an Energy Model (EM). However, there are
> users who want to have an EM (for thermal management for example), but
> don't want EAS with it.

Well, then introduce a new Kconfig variant for EAS, if it's super 
important to allow this to be disabled.

Why do we want to disable it - is it not reliable in some circumstances?

> In order to let users disable EAS explicitly, introduce a new sysctl
> called 'sched_energy_aware'. It is enabled by default so that EAS can
> start automatically on platforms where it makes sense. Flipping it to 0
> rebuilds the scheduling domains and disables EAS.

Yeah, making this a sysctl ABI is asking for trouble - this really should 
be a Kconfig or debug space knob, at most.

Thanks,

	Ingo
