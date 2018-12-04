Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6277CC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27C8220851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aM+3zahY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27C8220851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbeLDJ3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:29:24 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35172 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbeLDJ3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 04:29:23 -0500
Received: by mail-pl1-f195.google.com with SMTP id p8so8017188plo.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 01:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s3POJJRFWiYBGAT/8H2YYt1pNBZPIe3ZJEh71RTPSfA=;
        b=aM+3zahYG9K+QFRvNpDe1vKB6n6yRYmri+If4lRfYajfGVG+9v1UMFL+7WZqTC9GSD
         8klD8EsP32UasAxjin6z3ymMU7ak/7tgEg7EBXG9qiHEPFpbPAoKn07AY6K31zvuSRE4
         cVYovJspfmFyg5+P6uwCjjYZCB4Up4JlAb5xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s3POJJRFWiYBGAT/8H2YYt1pNBZPIe3ZJEh71RTPSfA=;
        b=ha5K41kpSLmTIVHenm3TdIkQixkkE3CtezBQG22CD7zjdQoMKgmg9gW5q8ezrG+y/M
         39rRYkMcSBgBdL2H4J0HQmEDBxargIMa+dO8CXP5PFF/mOfd5kYX+YE2a+71OzthA+of
         fM3NVXo/9X0S4eE7cgt/E5Z0+NP4Ctonj+GDGZKPQ5gfTBGO6RYTR65xNtysjGG30ti8
         7YZ5LFikoBVZDKNpLcGlkaaawk9bK6+uTPR2iRiN370/69Joa804BY/nejCSc2vbABlZ
         OIqUUZQyYDlWJW57vykWPEZ5Jzk3UpLloVNNB21pfKuoz5Sqy+eKpZZr4T3Z6vXsJMID
         z05Q==
X-Gm-Message-State: AA+aEWZLmqbCTFMeg4NVbGrfb30q6d56l0xtp4XzvttgULMb1R1ehe33
        H6P1s5Wt8jQ+kWacK8fHm010/g==
X-Google-Smtp-Source: AFSGD/Ug7vD9gYnQgKS29iHuxIA8zA8RdEDIA1V0vo1llL5X29wPOESGGWGDYmWtEAmO7P7L+6+jDQ==
X-Received: by 2002:a17:902:161:: with SMTP id 88mr19820625plb.306.1543915762770;
        Tue, 04 Dec 2018 01:29:22 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id w136sm22474801pfd.169.2018.12.04.01.29.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 01:29:22 -0800 (PST)
Date:   Tue, 4 Dec 2018 14:59:19 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        evgreen@google.com, Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v11 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq
 HW driver
Message-ID: <20181204092919.t326z6etfvdrjyge@vireshk-i7>
References: <1543722903-10989-1-git-send-email-tdas@codeaurora.org>
 <1543722903-10989-3-git-send-email-tdas@codeaurora.org>
 <20181204051231.mm5ixli7ckpfzvd4@vireshk-i7>
 <99d25f02-e595-d4e8-25c4-3c4c206f79a6@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99d25f02-e595-d4e8-25c4-3c4c206f79a6@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-12-18, 14:57, Taniya Das wrote:
> Hello Viresh,
> 
> On 12/4/2018 10:42 AM, Viresh Kumar wrote:
> > Hi Taniya,
> > 
> > Sorry that I haven't been reviewing it much from last few iterations as I was
> > letting others get this into a better shape. Thanks for your efforts..
> > 
> > On 02-12-18, 09:25, Taniya Das wrote:
> > > +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> > 
> > > +struct cpufreq_qcom {
> > > +	struct cpufreq_frequency_table *table;
> > > +	void __iomem *perf_state_reg;
> > > +	cpumask_t related_cpus;
> > > +};
> > > +
> > > +static struct cpufreq_qcom *qcom_freq_domain_map[NR_CPUS];
> > 
> > Now that the code is much more simplified, I am not sure if you need this
> > per-cpu structure at all. The only place where you are using it is in
> > qcom_cpufreq_hw_cpu_init() and probe(). Why not merge qcom_cpu_resources_init()
> > completely into qcom_cpufreq_hw_cpu_init() and get rid of this structure
> > entirely ?
> > 
> 
> Yes, we still would require the per-cpu.

An explanation on why do you feel so would have been nice :)

I am sure I am missing something obvious here.

-- 
viresh
