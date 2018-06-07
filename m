Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id V2rQCNbwGFt9EwAAmS7hNA
	; Thu, 07 Jun 2018 08:49:29 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id ADDD0608B8; Thu,  7 Jun 2018 08:49:29 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pqyr5n1W"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3D758607DC;
	Thu,  7 Jun 2018 08:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3D758607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932696AbeFGIt1 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:49:27 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:37937 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932550AbeFGItY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:49:24 -0400
Received: by mail-pg0-f66.google.com with SMTP id c9-v6so4425980pgf.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 01:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CghJsvp2s6j1fXfMuhENnUTS1OrRgPOuN6UC+h4COxk=;
        b=Pqyr5n1WwlG3cGpAXomQNBFVuDl662SWFWYwnKM7VVRh3qtJB+DijqSyPs86MGmP6n
         YJdXelkWQ80V3i+xRPhK4fCdTsI0TDyDD0QxqEn5wtPR2rrfaIYB5fu8VPvuTffSYfWX
         QxYs/yS8eoFvNm4/AsKyM2dC6ZKfmoXzvWp2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CghJsvp2s6j1fXfMuhENnUTS1OrRgPOuN6UC+h4COxk=;
        b=cC/ntmoPOWEdEdSWdWqro6yv4dnIM4B0a/JBpmrCx0qERLCW6kfK077NBXrmqBxBjG
         XfzulBLmEAkIoPDxmJKJPFp3Fu2GCER7fyYKwX3DbLiXmha+NoVA30yUdVOr1WoajWDL
         d87B09TuuzUe8EY562UHEGh8c8ZsaQZnnOpo0An65ItclYCTcD1GF6ndqwsO+EZOAlFm
         zldL9MF+4cbYKgPIfZSxWc2SDHPjN9j8siafXIxSycqyuRQxTyl44qsEUsw+9iQsFuOo
         f1Jklbifh2IuDqs1yWJZby8j8a3XSH6kAJZjt8YO2Qkx5LHIZGYPkspyH9C/8+1PNFtr
         xyrg==
X-Gm-Message-State: APt69E33HXcimdSbgUZIt1I44eKpXH1SqDxvn7Zms7HJi+PMR/pzlFtO
        HWvMQECMexrfYB2ZvK4wPGAQxw==
X-Google-Smtp-Source: ADUXVKK14QJXEJ7NMEy8r4Dqs5da883Z89sIVJWrINs5vIxbV4knEfxYdgQNsUvKs6uV3ILk2v0Rtw==
X-Received: by 2002:aa7:8345:: with SMTP id z5-v6mr949469pfm.251.1528361364438;
        Thu, 07 Jun 2018 01:49:24 -0700 (PDT)
Received: from localhost ([122.172.167.207])
        by smtp.gmail.com with ESMTPSA id q9-v6sm19544132pgv.84.2018.06.07.01.49.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 01:49:23 -0700 (PDT)
Date: Thu, 7 Jun 2018 14:19:21 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH V5] powercap/drivers/idle_injection: Add an idle
 injection framework
Message-ID: <20180607084921.toctrooftl6y7kkx@vireshk-i7>
References: <1528190208-22915-1-git-send-email-daniel.lezcano@linaro.org>
 <20180606122357.GN12258@hirez.programming.kicks-ass.net>
 <22f5cf0b-049e-7938-55f6-4b4b154f8389@linaro.org>
 <20180606150203.GE12180@hirez.programming.kicks-ass.net>
 <ea347237-7cef-095a-5ddb-19c181d10c23@linaro.org>
 <20180607083229.GJ12198@hirez.programming.kicks-ass.net>
 <20180607084251.rv2tg3kgz4aohlpd@vireshk-i7>
 <9996fb40-c7aa-db61-5445-52c146f44d85@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9996fb40-c7aa-db61-5445-52c146f44d85@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-06-18, 10:46, Daniel Lezcano wrote:
> Yes, correct.
> 
> But if we don't care about who wins to store to value, is there a risk
> of scramble variable if we just assign a value ?

Normally no, as the compiler wouldn't screw it up badly. But there is no rule
which stops the compiler from doing this:

idle_duration_ms = 5;
idle_duration_ms = -5;
idle_duration_ms = 0;
idle_duration_ms = <real-value-we-want-to-write>;

So we *must* use READ/WRITE_ONCE() to make sure garbage values aren't seen by
readers.

-- 
viresh
