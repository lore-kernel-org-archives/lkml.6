Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFEEC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75A3620871
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QyPhG6rL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75A3620871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754002AbeFTEeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 00:34:24 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37378 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbeFTEeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 00:34:20 -0400
Received: by mail-pl0-f68.google.com with SMTP id 31-v6so1032430plc.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 21:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sBzOSAn37SgM3Weui7zzBs6ql41HzBk9vUUVMhfnN8A=;
        b=QyPhG6rLosqaEfO+B11gLoWN1RM7kbqvZYkgj0iSvI6lvFSdxTR7jwAOnlSEHXz9EN
         h9iuegBdz1QNq64nSRbVwqimHqU8MPQmLFUzQYObR1lcIM6jJK4FkM2wbpm2ra0lH2ST
         SGojlTAT8tjsBbao2BV9YJm0M1jEN++AECVTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sBzOSAn37SgM3Weui7zzBs6ql41HzBk9vUUVMhfnN8A=;
        b=s6ZnuJ3p2UoHX8cEjMixrR0DVIp//x/jKvdc7uOkOXSj4l9MP3jdx6b8X1SX3cQKG8
         mxv9ybjnBcboNkrVlVpnvlwB9zGoPlWHnj3ub7Ag2eVynJ7khlcO5PCJe0tbQyaWrEMi
         /nvxcpvcxcGbe0EAaOM40Q3pOFjgZumaA/Pbk0e7/319FdrGOGLS8q0kcA82DJJ4RDvd
         TpxBO0oCLgZKTPWXC/07RMY+bHnxkzhAOctno/rG0o6Xs4nv0Ru2XNEx0pv6GZEz9fBW
         nLVyQZohrLvtEoetsaU4Eh9v5fXUsVgIszuZW1Bh8ULY9Xpp6rdnDRr8xzSc6a2vb5Xp
         hlTQ==
X-Gm-Message-State: APt69E2g9Oq26SfnADoMSpSMNRrcATE/ZcBiHcHDtGB5AYhyvJuhL/jT
        xPUNVWYGaWAA4MUUeBsuhyhEDw==
X-Google-Smtp-Source: ADUXVKK9GCDkBSAUFWLuB1YxaRhB8CZFNcc2Lkg9BdEj32E/ye1bfUDgNKoOxgJVGi8+prcX5S3b8w==
X-Received: by 2002:a17:902:788e:: with SMTP id q14-v6mr21637255pll.234.1529469258763;
        Tue, 19 Jun 2018 21:34:18 -0700 (PDT)
Received: from localhost ([122.171.103.96])
        by smtp.gmail.com with ESMTPSA id 76-v6sm1868525pfr.172.2018.06.19.21.34.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 21:34:17 -0700 (PDT)
Date:   Wed, 20 Jun 2018 10:04:15 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH V9] powercap/drivers/idle_injection: Add an idle
 injection framework
Message-ID: <20180620043415.57yvgzlye4l7wdqy@vireshk-i7>
References: <1529414627-5638-1-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529414627-5638-1-git-send-email-daniel.lezcano@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-06-18, 15:23, Daniel Lezcano wrote:
> Initially, the cpu_cooling device for ARM was changed by adding a new
> policy inserting idle cycles. The intel_powerclamp driver does a
> similar action.
> 
> Instead of implementing idle injections privately in the cpu_cooling
> device, move the idle injection code in a dedicated framework and give
> the opportunity to other frameworks to make use of it.
> 
> The framework relies on the smpboot kthreads which handles via its
> main loop the common code for hotplugging and [un]parking.
> 
> This code was previously tested with the cpu cooling device and went
> through several iterations. It results now in split code and API
> exported in the header file. It was tested with the cpu cooling device
> with success.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Javi Merino <javi.merino@kernel.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Kevin Wangtao <kevin.wangtao@linaro.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Rui Zhang <rui.zhang@intel.com>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
> ---
> 
> V9:
>    - Unconditionnally reset the should_run flag for all kthreads
>      belonging to the cpumask and remove the park() callback (Viresh Kumar)
>    - Fix up the typos in the comments (Viresh Kumar)

Looks great now. Can't think of any more races :)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
