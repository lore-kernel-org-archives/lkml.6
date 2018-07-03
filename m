Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61116C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11484249E1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11484249E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933774AbeGCQ02 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 12:26:28 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:35934 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932520AbeGCQ0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 12:26:23 -0400
Received: by mail-yw0-f193.google.com with SMTP id t198-v6so908981ywc.3;
        Tue, 03 Jul 2018 09:26:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q4M6HV9jwcX5rnPqB/xtwIhfrXd8jYfA6mbvkblnLbE=;
        b=PCwX8mS+eKs2vndinpzDgBaLRKKeJTKtMI6O+VgQwHG94z+GJ2y0XEFgDtaePHUyqt
         I/wV5/mgwMk9MmvISq+Pb89c3j8CLJP9148yf1bvl7cBdqNSr1s1KfFHTJaogxdvCqi3
         wbIttcEB6IbaY5sC9EazcZBNTUXm2euiGO95VuS1fjhAweN9Sd186Gq/cIkoRm12n6ER
         t0Y93Qct6LwLiaDtuSRHm4tLR4eH1YD0lFAvbdKsMHjvZYLfSb91B44tziQa3uOgIkNk
         WAljxnhxKfGpEWDILKB1apLjWMO3qAiSk46ibFe+PFWFj5kErEUpk8yvCFlhfSkwQYeW
         Kf+A==
X-Gm-Message-State: APt69E1cPjguFCR4HGE3QDBI+LTXsD5hVjXlDtWP9wFhwSxQq7uNMF2h
        LSYlVSxp+aM9TuyVmkPL6Q==
X-Google-Smtp-Source: AAOMgpccXf19B1ylxp/qjrfuwX55mWQhIAFl3ecunFbG5pj4akiS7aziNsBhlLXnTQBs6h15W30Bdw==
X-Received: by 2002:a81:a443:: with SMTP id b64-v6mr14898982ywh.137.1530635182049;
        Tue, 03 Jul 2018 09:26:22 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id l3-v6sm470406ywm.103.2018.07.03.09.26.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 09:26:21 -0700 (PDT)
Date:   Tue, 3 Jul 2018 10:26:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        edubezval@gmail.com, smohanad@codeaurora.org,
        vivek.gautam@codeaurora.org, andy.gross@linaro.org,
        Zhang Rui <rui.zhang@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 4/6] thermal: tsens: Add support for SDM845
Message-ID: <20180703162619.GA17238@rob-hp-laptop>
References: <cover.1530533998.git.amit.kucheria@linaro.org>
 <43e3ae530334efab3fa0151430879f03731e9daa.1530533998.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43e3ae530334efab3fa0151430879f03731e9daa.1530533998.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 06:14:07PM +0530, Amit Kucheria wrote:
> SDM845 uses v2.4.0 of the TSENS IP block but the get_temp() function
> appears to be identical across v2.x.y in code seen so far. We use the
> generic get_temp() function.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.txt | 2 ++
>  drivers/thermal/qcom/tsens-v2.c                          | 6 +++++-
>  drivers/thermal/qcom/tsens.c                             | 6 ++++++
>  drivers/thermal/qcom/tsens.h                             | 5 ++++-
>  4 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> index 06195e8..075182e 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> @@ -5,6 +5,8 @@ Required properties:
>   - "qcom,msm8916-tsens" : For 8916 Family of SoCs
>   - "qcom,msm8974-tsens" : For 8974 Family of SoCs
>   - "qcom,msm8996-tsens" : For 8996 Family of SoCs
> + - "qcom,tsens-v2.4.0"  : For SDM845 Family of SoCs
> + - "qcom,tsens-v2"      : Generic fallback binding for any Soc using 2.x.y version of the tsens IP

You need to show what are valid combinations of compatibles. Does v2 
apply to 8996? One valid combination per line.

Rob
