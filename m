Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E2EC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B387120841
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qn4gZnzQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B387120841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbeJHRvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 13:51:16 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46791 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbeJHRvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 13:51:16 -0400
Received: by mail-pg1-f193.google.com with SMTP id a5-v6so7622877pgv.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 03:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MAG/ZKixf4/se1DNfu8zlPD0BSftdGEs0Ds2rW8SqOw=;
        b=Qn4gZnzQ8xO+VenS7XS+KTSjru4MdWPf4HuXYQRRMKBGk5/M3e1u/Ivr1q9C5ubIaP
         ZTAZtXYLTzXmwXBjfZSR4o2WddeJh2Fkh5+utSXNr+xoIzWv+QprRsisPQ8Ge7ZvYC6u
         FNRqRcxOYiPaXO3sw5BJ5aPC/d4gznuh13Ijg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MAG/ZKixf4/se1DNfu8zlPD0BSftdGEs0Ds2rW8SqOw=;
        b=qes+r9U0vcPyXilHLcf0FueSzXEFafvAic86GKKIkh19lbnIa6tDA51ZgPxoY+86Sc
         NL848IaWZQPL38BtgH6/B3ilZaPsVqTMaUFzt5g6hwZZ3uRxRlnAyVVq8qh+4ZjO2J6O
         GYz+ztvCKA/oRn4mTMeNERH7gGkqmt6npbpEzC7fVD8dMUzIj9fe39mUT0TmQvedpeum
         dbWhfNC8BbyMop/YA/kAw41e49wABJjFYBMaaOgRSmjOlXt0v7qrkrIeu+t54uHGCVB6
         rTFonlpS4CD95yU2oap66PxJ7Kpbigb8zqlzOLDAD1DdeMm+PrymjZ7b2HShkqOP1zyL
         AAKA==
X-Gm-Message-State: ABuFfoj02/i3Bfu4ciSvnQyTyqYhLmqwsHRSZwFwpKiCFJUVWZ83PY+U
        TcRFNGL8etDwz4JKYhEX1U25kw==
X-Google-Smtp-Source: ACcGV62inntRlS45/wc2Pc7hTDrH/LlesQnpb4iXQz8nOY8x4mjDh6jHNmt+lqjdPShFEo5jmShtsw==
X-Received: by 2002:a62:2fc1:: with SMTP id v184-v6mr24564516pfv.115.1538995212261;
        Mon, 08 Oct 2018 03:40:12 -0700 (PDT)
Received: from localhost ([122.172.112.137])
        by smtp.gmail.com with ESMTPSA id i186-v6sm31944891pge.80.2018.10.08.03.40.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 03:40:11 -0700 (PDT)
Date:   Mon, 8 Oct 2018 16:10:09 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Taniya Das <tdas@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        amit.kucheria@linaro.org, evgreen@google.com
Subject: Re: [PATCH v8 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW
 driver
Message-ID: <20181008104009.2x6s7shxfhl3hzkr@vireshk-i7>
References: <1537698793-15285-1-git-send-email-tdas@codeaurora.org>
 <1537698793-15285-3-git-send-email-tdas@codeaurora.org>
 <20181008084012.GA23693@centauri.lan>
 <20181008095952.gl7di2tnuv3jwew6@vireshk-i7>
 <20181008103856.GA10890@centauri.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008103856.GA10890@centauri.lan>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-10-18, 12:38, Niklas Cassel wrote:
> On Mon, Oct 08, 2018 at 03:29:52PM +0530, Viresh Kumar wrote:
> > On 08-10-18, 10:40, Niklas Cassel wrote:
> > > > +		ret = of_parse_phandle_with_args(cpu_np, "qcom,freq-domain",
> > > > +				"#freq-domain-cells", 0, &args);
> > > 
> > > Hello Taniya,
> > > 
> > > in your DT binding, you use
> > > 
> > > #freq-domains-cells = <1>
> > > 
> > > Yet here you parse for "#freq-domain-cells".
> > 
> > And what is the problem with that ? Or are you suggesting her to call
> > of_parse_phandle_with_fixed_args() ?
> 
> Hello Viresh,
> 
> #freq-domain-cells != #freq-domains-cells
> 
> The code should parse for the exact same property name as stated in the
> DT binding.

Oh, I missed that both the names are different here. It makes sense
now :)

-- 
viresh
