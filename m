Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id qb3eFtTvGFu/CAAAmS7hNA
	; Thu, 07 Jun 2018 08:43:04 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A9150607DC; Thu,  7 Jun 2018 08:43:04 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zih4WSeW"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 34D5A602FC;
	Thu,  7 Jun 2018 08:43:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 34D5A602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932746AbeFGInB (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:43:01 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44918 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753480AbeFGImy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:42:54 -0400
Received: by mail-pl0-f68.google.com with SMTP id z9-v6so5672948plk.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 01:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=owR9MIRm/vT+/AACYyDHAQ+Gug1zAEJ17yzB4qBkKk4=;
        b=Zih4WSeWqUbSkc1qU0Dvv/W0VHMDNNnJxOlFxtnKRSwPlS4GFuW85++7uDiO4wWEkO
         U7FwGRFYRuOc8gWA3F4SqvKfW+x0uedVOG1GRLKbZm3EIEOzLPa2+F4T68EMSJ8e4DF2
         BUIV2BlKN5EWb/YzD37DbWAmIRJHbX/ulqdUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=owR9MIRm/vT+/AACYyDHAQ+Gug1zAEJ17yzB4qBkKk4=;
        b=DrTNZ6vUJ+0ohyK0SNrJlrS5eiwgivNElVaqESINFx/ObUJhVi9BhgV9IA+teXI4Fa
         YWS05p701GdDkXVe5ADEU2pgebXm4m6D/Mq82Ff2rgAmIHfV3W8o0NqtMvgaieZa2Fj5
         iO5L1c8QALKheD8siE0XhHaW0W9GkPJuyvlcVdatyqYboLDTXWJ7kPLHowB3EegvQ9NJ
         87DN32DZR3y23L7eXE3Jt2FkCcdOwrJtHkdCahYAO6tthBmKYUTuaZhjZPXAgHzWcQ8a
         krA/u4jnCnw1Qp3/N2JB3w5SywTs3Z8RqxKcyE7YMX9L/MT4CKYC/vsoKF/bjvAubgWX
         dsGw==
X-Gm-Message-State: APt69E0FMOHcFh6NoOCqcMz25uu0k02m3lfuwQ2XUcemLRpJ8xsDSEwm
        L2d+9sAYjlgP1xtjz7uU5i5f0g==
X-Google-Smtp-Source: ADUXVKIQzkyu/0Mf4T4iSARLcqYTRedUbkgHVEJ6yezLJ3R15YkyfgsU6ShvHR+DLCGkBqFUviud3w==
X-Received: by 2002:a17:902:6b09:: with SMTP id o9-v6mr1107309plk.256.1528360974138;
        Thu, 07 Jun 2018 01:42:54 -0700 (PDT)
Received: from localhost ([122.172.167.207])
        by smtp.gmail.com with ESMTPSA id v26-v6sm31170188pfe.13.2018.06.07.01.42.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 01:42:53 -0700 (PDT)
Date: Thu, 7 Jun 2018 14:12:51 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, rjw@rjwysocki.net,
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
Message-ID: <20180607084251.rv2tg3kgz4aohlpd@vireshk-i7>
References: <1528190208-22915-1-git-send-email-daniel.lezcano@linaro.org>
 <20180606122357.GN12258@hirez.programming.kicks-ass.net>
 <22f5cf0b-049e-7938-55f6-4b4b154f8389@linaro.org>
 <20180606150203.GE12180@hirez.programming.kicks-ass.net>
 <ea347237-7cef-095a-5ddb-19c181d10c23@linaro.org>
 <20180607083229.GJ12198@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607083229.GJ12198@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-06-18, 10:32, Peter Zijlstra wrote:
> On Thu, Jun 07, 2018 at 10:18:27AM +0200, Daniel Lezcano wrote:
> > So IIUC, neither atomic or WRITE|READ_ONCE are necessary in this code
> > because of the wake_up_process() barrier is enough, right ?
> 
> I didn't look hard enough; if there ever is a time where the loads and
> stores happen concurrently, you need READ/WRITE_ONCE(). If there is no
> concurrency on the variables, you don't need anything.
> 
> Neither atomic_read/set() nor REAd/WRITE_ONCE() will help with ordering,
> which is what the wake_up_process() would provide here, different things
> entirely.

Right and you still need the READ/WRITE_ONCE() thing as
idle_injection_set_duration() may run in parallel with the idle_injection_fn()
thread.

And I don't think the purpose of atomic_read/write was ever to take care of the
ordering issues in this code, it was always about parallel loads/stores.

-- 
viresh
