Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644AFC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 06:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BAC321855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 06:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YRiwcIx7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfAXGpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 01:45:21 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43515 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfAXGpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 01:45:21 -0500
Received: by mail-pf1-f195.google.com with SMTP id w73so2506970pfk.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 22:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B2AQ3GYZz1T9fdTcYNRKe7NNBbjnRj+gpP4X+qZGAx8=;
        b=YRiwcIx7Ae7v/Bo/sSApSyUNGixUkTs/cO6uF2zOkme8nUSbdeYfu37PQmDJM1eACy
         xTeiKfvmR6bGSADqU3TI2t8/wjb+oGYLSPtOpzU7aBqQchajtikBz+SucOmjCMkSLAB0
         3TK92lI/YEy86kgBzcVDrLtKbMoiLrtK9odDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B2AQ3GYZz1T9fdTcYNRKe7NNBbjnRj+gpP4X+qZGAx8=;
        b=Hd3s5hIT4O7bIFIzy+KH3kKESwrS3G3XYp2oBMU2c4wBt343e7msN5Pl38TqHQTXAV
         zPtpX19XQu3PnIzQ8eFSl2RDzk5VVrIySUHzF+X3yPUxXmCci4UBeQt1jq3EhHQjAMba
         LEYkK2b0KV3Ml9eWtb/SN6tMPkMVXdQZiNZviowSqvhf7lH2pM8/2w6FUnFfsygbVFqH
         BguilIL23Q8eThstIrkQ+fLW38R7tZn+ZL64ijbJ7Kudd4sPXuTUN/eueXFMG/V+VYYx
         63OFQ325dAnlh8bLrQhtgE1W4P+dSWbmNuHYLxQUSXoUCZ7DcLCXlAG/EbZi6wkd6sIS
         i+ew==
X-Gm-Message-State: AJcUukdY4ZnV9MkX/ZEmz149akkxTk09ese8f03cSstuPE9vlUxRHMwg
        Bcj+0RaywGXdax7oJUNR3moaUA==
X-Google-Smtp-Source: ALg8bN5H/2NeoGQaSXcmSzhY8Ja8mXJeUkFv/acD2GQD7rTMv2TfriJxX8ivH0jXPnw4wqkmtBVZsw==
X-Received: by 2002:a63:2507:: with SMTP id l7mr4676378pgl.22.1548312320132;
        Wed, 23 Jan 2019 22:45:20 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id y29sm33550064pga.59.2019.01.23.22.45.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 22:45:18 -0800 (PST)
Date:   Thu, 24 Jan 2019 12:15:15 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] soc: qcom: update config dependencies for QCOM_RPMPD
Message-ID: <20190124064515.yimgprg5hzsfghc6@vireshk-i7>
References: <20190118044801.7312-1-rnayak@codeaurora.org>
 <154783318835.169631.6614930101893188915@swboyd.mtv.corp.google.com>
 <df735d42-d208-62c7-ddbc-87ea314c36d1@codeaurora.org>
 <25f46403-e78e-271b-c4d0-13b4623846b3@roeck-us.net>
 <864348fb-3d06-7b4b-cc82-17c96b7ce219@codeaurora.org>
 <20190122100854.nuepsz5ddbt4jda4@vireshk-i7>
 <57f73ea8-3be4-470c-1ef8-d870af605347@codeaurora.org>
 <20190123111630.s33rzxn7o3mr6kks@vireshk-i7>
 <b2ab31ef-6c95-186f-62b3-f1b04d2de945@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2ab31ef-6c95-186f-62b3-f1b04d2de945@roeck-us.net>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-19, 06:22, Guenter Roeck wrote:
> See Documentation/kobject.txt.
> 
> "One important point cannot be overstated: every kobject must have a
> release() method, and the kobject must persist (in a consistent state)
> until that method is called. If these constraints are not met, the code is
> flawed. Note that the kernel will warn you if you forget to provide a
> release() method.  Do not try to get rid of this warning by providing an
> "empty" release function.
> 
> If all your cleanup function needs to do is call kfree(), then you must
> create a wrapper function which uses container_of() to upcast to the correct
> type (as shown in the example above) and then calls kfree() on the overall
> structure."

Guenter, you are of course correct but I am not sure what else we can
do here. In the most common case device & kobject are allocated along
with the real entity, like struct genpd here, and we free those from
the release routine (i.e. kfree(genpd)). But in our case most of the
times the genpd is created statically by platform drivers and not by
the genpd core, and so we can't free it from release().

Over that the genpd->dev is only used by the OPP core currently and
the device isn't even registered with the device core.

-- 
viresh
