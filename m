Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90D2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74FBA21924
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hGuDUh3J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390864AbfBMXif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 18:38:35 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36870 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728875AbfBMXie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 18:38:34 -0500
Received: by mail-pl1-f195.google.com with SMTP id b5so2009653plr.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 15:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZPIj4EbTVOz6N/Q3YiGw9SLQBQnUYSsyTYltaROd0Ao=;
        b=hGuDUh3JCW2v5hchNn5o0XSDnt1ylStAkY9CzQXtGk/7CGLqpAKlYAXvF2apzUWoWj
         lyVHA/Nljh/KOhEIirh4umYJduo72d3t5x1FRIpdjnIN2Cgg9ySeEqmk6wCnYmUmTBlE
         /YL2bkQ+TKFq/ahQJp8GAo+hTbVi/0Rg4OStjuw7zxNqc8GTuPve5td3dolkdlzYWn9F
         +LFrqiCb0OMvMGwYHRG1LT957m1OvRagGvoOCuzg0ldkmn5DA8PksxKfc+E7qpYF7fU+
         XuJoH7UwdDY30zJ7p/UX9n/nWDxgtgEkN5ClQ4RIuKNYvAn5JmrZb4pREAK97Pm+A6Kr
         sckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZPIj4EbTVOz6N/Q3YiGw9SLQBQnUYSsyTYltaROd0Ao=;
        b=E0u5GFBLpThkEJOJa0K9RCwpMRRSnEl3O32cXPxK5xBgechtrWFKEnVMG2ct9YIQtu
         1TLFkDZbseX7IMynv7wlChdBZLEuHYf5XMyqLq2iLO/HM5tdBg6Jb1pCW3LKFXSpQyry
         oApZmgKfJQr7kfRC/rVaF+vx75+agQSRTWGKzjgffJ3wMlI6xpoMbd7PUrIhKfjeGXWM
         qCNVV9al88warnDy0iBoqXD4Wu9KfXE772qYBrUWb2sBG9uP4+KjKfQnc1fxvzUJ93+L
         BSsOo+PrWhm5owmfq9mCirVP/9mZemj1cS0isW0eWhjWxHW76NhOVutDNl8NkTs6iLpO
         VoNQ==
X-Gm-Message-State: AHQUAuZpl38e1jOlJu1l4NVEEIA4BORFbM/Gbw/V53ZZgurnftNGaL/M
        TLNy9bClM5qBe6CNdRe9CpDwCg==
X-Google-Smtp-Source: AHgI3Ib7Et8IvS4uSSxmEgbq8gGxA/Ze9PB7rScOUbZfBf3M1sJCnzgbYgoTB7QX9beK90yRfNbbDA==
X-Received: by 2002:a17:902:8d8d:: with SMTP id v13mr792927plo.121.1550101113885;
        Wed, 13 Feb 2019 15:38:33 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li221-181.members.linode.com. [173.255.211.181])
        by smtp.gmail.com with ESMTPSA id l22sm530646pfj.179.2019.02.13.15.38.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 15:38:32 -0800 (PST)
Date:   Thu, 14 Feb 2019 07:38:27 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, julien.thierry@arm.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [v5.0-rc6 regression] "perf/core: Don't WARN() for impossible
 ring-buffer sizes"
Message-ID: <20190213233827.GA9483@leoy-ThinkPad-X240s>
References: <CANLsYkynsuO7mQxnfSrctOtUtjeokgMX5f9hqG0muufJsKfdbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkynsuO7mQxnfSrctOtUtjeokgMX5f9hqG0muufJsKfdbA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu, Mark,

On Wed, Feb 13, 2019 at 02:26:25PM -0700, Mathieu Poirier wrote:
> Hi Mark,
> 
> CoreSight trace collection is broken on v5.0-rc6 due to this commit:
> 
> 9dff0aa95a32 perf/core: Don't WARN() for impossible ring-buffer sizes
> 
> Before:
> root@juno:/home/linaro# perf record -e cs_etm/@20070000.etr/u
> --per-thread  uname
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.036 MB perf.data ]
> root@juno:/home/linaro#
> 
> After:
> root@juno:/home/linaro# perf record -e cs_etm/@20070000.etr/u
> --per-thread  uname
> failed to mmap with 12 (Cannot allocate memory)
> root@juno:/home/linaro#
> 
> The problem is related to the order_base_2() [1] test with a size of
> 1264, stemming from nr_pages equal to 128.  The combination yields an
> order of 11, something leading directly to the error path.
> 
> The results are the same with linux-next 20190213.  This was tested on
> a Juno R0 and R1 with a 4K page configuration.  I haven't tried but
> I'm pretty sure it breaks IntelPT as well.

I noticed in another thread [1] Peter gave out the fixing for this
issue; applied this fixing on my local code and it fixes CoreSight
tracing issue.

Thanks,
Leo Yan

[1] https://lkml.org/lkml/2019/2/12/452
