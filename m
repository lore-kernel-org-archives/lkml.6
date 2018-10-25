Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C81C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 12:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 140802075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 12:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UvhLwIRU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 140802075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbeJYUgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 16:36:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37196 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbeJYUgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 16:36:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id g9-v6so9027976wrq.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 05:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mKn2D5i0TxJkj8npIqd0YMUVnGSny9gkvHnjxYiePm4=;
        b=UvhLwIRUFZkZnzL9jqMbSSCB6U8nWf6lhjrVMa6Jxckkof3w2xeLeyEoXAjzc+5d3R
         lPGBo/yoB4YQQciZu3tVxG4+YIUqWZsdny/ZdkCEGB7U6F2OiL3Oxk9ZhEqI+odL0rp0
         N985Twts4ZRdqIdiNt2rvREmBgimEgjD7qTY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mKn2D5i0TxJkj8npIqd0YMUVnGSny9gkvHnjxYiePm4=;
        b=EBSyh4v04ZJW20SVmE8VIyGrsDlpqWRypc30ShkOU0ARMDpS1kvjxYxMeEejEqE2DP
         deTkM97Bb3eD44Ta+mRfttYdVIYGFHVcxSWAJ79/xU879vJv8nd9qjG0oEwsIV0OnDTP
         +udb9xNDd3KUmlDN1nKRLMAooAwfYwXX8q89ANAjER5SKTOcpTKmPoJ2A7d8UlZl7Rur
         3lFns79DXMm1VlHIiGTZlDeCBJOHRKKD3eZ0hnmHMGXBGXVuEunnv2fUwrzOV/n1PPf+
         89e3YGv1Tta2pab8yUDrYBmX97SR0FlHWqgy/1pm3BCEkju0y8fcBZZGQ4V6b9BnxGLw
         GhxQ==
X-Gm-Message-State: AGRZ1gIrLY/PIVQn164rvkqkmdpIuOBWVahcW9asSuXppSkywn+FYqeC
        N/uUjZ+lD5U0WsilQxC2VkYfm6wue8c=
X-Google-Smtp-Source: AJdET5fB8jRYN30oWo5TWNJHCIUHswQ7dG7+oF40rubNhfKl6y5j5KMNV91ybOG5kbRxRWUaVB5uJg==
X-Received: by 2002:a5d:40ca:: with SMTP id b10-v6mr1619257wrq.288.1540469054995;
        Thu, 25 Oct 2018 05:04:14 -0700 (PDT)
Received: from [192.168.0.40] (84.215.136.77.rev.sfr.net. [77.136.215.84])
        by smtp.googlemail.com with ESMTPSA id e21-v6sm1612201wma.8.2018.10.25.05.04.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 05:04:14 -0700 (PDT)
Subject: Re: [PATCH] dt-bindings: arm: Fix cpu capacity mismatch in example
To:     Viresh Kumar <viresh.kumar@linaro.org>, catalin.marinas@arm.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <138600f5d504b41202a29a1e130a7aa4e51f1925.1540451976.git.viresh.kumar@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <80206cb7-b550-1cf6-abf4-e4b17de4cdb5@linaro.org>
Date:   Thu, 25 Oct 2018 14:04:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <138600f5d504b41202a29a1e130a7aa4e51f1925.1540451976.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2018 10:27, Viresh Kumar wrote:
> The example text says the capacity value should be 446, while the
> example have it set to 578 instead. Fix the mismatch.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/cpu-capacity.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/cpu-capacity.txt b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
> index 9b5685a1d15d..7a0d6b429c8d 100644
> --- a/Documentation/devicetree/bindings/arm/cpu-capacity.txt
> +++ b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
> @@ -61,7 +61,7 @@ mhz values (normalized w.r.t. the highest value found while parsing the DT).
>  Example 1 (ARM 64-bit, 6-cpu system, two clusters):
>  capacities-dmips-mhz are scaled w.r.t. 1024 (cpu@0 and cpu@1)
>  supposing cluster0@max-freq=1100 and custer1@max-freq=850,
> -final capacities are 1024 for cluster0 and 446 for cluster1
> +final capacities are 1024 for cluster0 and 578 for cluster1
>  
>  cpus {
>  	#address-cells = <2>;

I think it is actually correct. The example is confusing on what the
numbers are. IIUC, it is:

(after normalizing)

dhrystone result on big CPU is 1024 at 1100MHz
dhrystone result on little CPU is 446 at 850MHz

We have to scale the result of the little for 1100MHz in order to compare.

1100/850 = 1.294

dhrystone result on little CPU is 446 * 1.294 = 577 at 1100MHz

So we put the normalized values 1024 and 577. The arch_topology will
scale 577 back to 446 as it will compute the max capacity based on the
max freq which is 850MHz.

The *final* capacities are 1024 for cluster0 and 446 for cluster1 (read
the cpu max capacity, the ones showed in the sysfs).

Did I miss something ?


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

