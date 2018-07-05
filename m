Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671FCC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E1E23FCE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:37:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E1E23FCE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754158AbeGEUhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 16:37:17 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34622 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753950AbeGEUhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 16:37:15 -0400
Received: by mail-oi0-f66.google.com with SMTP id 13-v6so19405389ois.1;
        Thu, 05 Jul 2018 13:37:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fvif1klA0QBxw1fpV3aVxT2hIN5tPjxaHzsjQ9QTFr8=;
        b=NNNa5U0UyvYMANGXLK3unJjzapicg3S334VruCuKZjFYgsDGIN8xyqOeVuh/cv9EWB
         RH8AIXKHw9iRbKo85HDxgmaIcv40o218Q/c2UPh7XGPk/uDOnSyzOACPnp1vA7V2LVkl
         snOi+M6q/yXV57tisyOa/c4eUCU7AM8FjuNqzP0OK0eeWaGKg/KjfZspUhVHrWhaOnYo
         k6pu3CYdLT5A6/KY7pBtscVHBEwzFCA2AoFkQH8i06ZY2ka5/TvA4szb7dDgyjcgFlPm
         Vub/h1BmpNUhJkAVv02b/HrHSRmJow1otyYEZMNSCUzqrNHGabj4mRTD6PknrNAEeKyc
         wN9Q==
X-Gm-Message-State: APt69E3bg6QMgskSSpuL6sah8pMpMbR/ouimvEQ9WqGtCudPZ/d4GExA
        VsAKr/bHqHLP6dU7g/7/pA==
X-Google-Smtp-Source: AAOMgpdup7mGIf0jpTQlszS7XSishTkVyJtNCQbeeHcqlNEml8iwMgDXthuJFH2cBRMlCq9+9hAxAw==
X-Received: by 2002:aca:dfc1:: with SMTP id w184-v6mr8718782oig.237.1530823034306;
        Thu, 05 Jul 2018 13:37:14 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id x64-v6sm4168238oig.44.2018.07.05.13.37.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 13:37:13 -0700 (PDT)
Date:   Thu, 5 Jul 2018 14:37:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        smohanad@codeaurora.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 4/6] thermal: tsens: Add support for SDM845
Message-ID: <20180705203712.GA29531@rob-hp-laptop>
References: <cover.1530533998.git.amit.kucheria@linaro.org>
 <43e3ae530334efab3fa0151430879f03731e9daa.1530533998.git.amit.kucheria@linaro.org>
 <20180703162619.GA17238@rob-hp-laptop>
 <CAHLCerNpifvM9nGXiE63-DQ0okP8+1wdxq52qo-K1TWzoYzjtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHLCerNpifvM9nGXiE63-DQ0okP8+1wdxq52qo-K1TWzoYzjtQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 10:56:26PM +0530, Amit Kucheria wrote:
> On Tue, Jul 3, 2018 at 9:56 PM, Rob Herring <robh@kernel.org> wrote:
> > On Mon, Jul 02, 2018 at 06:14:07PM +0530, Amit Kucheria wrote:
> >> SDM845 uses v2.4.0 of the TSENS IP block but the get_temp() function
> >> appears to be identical across v2.x.y in code seen so far. We use the
> >> generic get_temp() function.
> >>
> >> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> >> ---
> >>  Documentation/devicetree/bindings/thermal/qcom-tsens.txt | 2 ++
> >>  drivers/thermal/qcom/tsens-v2.c                          | 6 +++++-
> >>  drivers/thermal/qcom/tsens.c                             | 6 ++++++
> >>  drivers/thermal/qcom/tsens.h                             | 5 ++++-
> >>  4 files changed, 17 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> >> index 06195e8..075182e 100644
> >> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> >> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> >> @@ -5,6 +5,8 @@ Required properties:
> >>   - "qcom,msm8916-tsens" : For 8916 Family of SoCs
> >>   - "qcom,msm8974-tsens" : For 8974 Family of SoCs
> >>   - "qcom,msm8996-tsens" : For 8996 Family of SoCs
> >> + - "qcom,tsens-v2.4.0"  : For SDM845 Family of SoCs
> >> + - "qcom,tsens-v2"      : Generic fallback binding for any Soc using 2.x.y version of the tsens IP
> >
> > You need to show what are valid combinations of compatibles. Does v2
> > apply to 8996? One valid combination per line.
> 
> I've restructured qcom-tsens.txt to look like this:
> 
> -----%<-------
> 
> * QCOM SoC Temperature Sensor (TSENS)
> 
> Required properties:
> - compatible: must be one of the following:
>     - "qcom,msm8916-tsens" (MSM8916)
>     - "qcom,msm8974-tsens" (MSM8974)
>     - "qcom,msm8996-tsens" (MSM8996)
>     - "qcom,tsens-<ip_version>", "qcom,tsens-v2" (TSENS IP version and a
>        generic v2 property as fallback except for MSM8996)
> 
>   Examples with ip_version are:
>     - "qcom,tsens-v2.4.0", "qcom,tsens-v2" (SDM845)
>     - "qcom,tsens-v2.2.1", "qcom,tsens-v2" (MSM8998)
> 
> -----%<-------
> 
> 8996 would end up being something like this if needed, though we're
> stuck with "qcom,msm8996-tsens":
> "qcom,msm8996-tsens", "qcom,tsens-v2.1.0", "qcom,tsens-v2" (MSM8996)

3 versions here for 3 SoCs. I'm not getting that convinced version 
numbers really are better. I would assume that other QCom IP blocks 
have versions too, but pretty much *every* *other* binding uses SoC names. 
Why is this one special? The other problem with versions is the mapping 
of versions to SoCs most likely can't be validated outside of QCom 
unless there's a version register.

So, sorry to go in circles, but can you go back to qcom,<soc>-tsens. You 
can keep qcom,tsens-v2 as a fallback.

Yes, it's annoying to have to update bindings for new SoCs. But it's 
trivial one line patches. Look at Renesas bindings. Maybe adding new 
ones will be scriptable once we move to json-schema binding docs.

Rob
