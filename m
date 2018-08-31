Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1047CC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 978242083B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MDrjqwWY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 978242083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbeHaMUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:20:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43811 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbeHaMUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:20:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id k5-v6so10353644wre.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 01:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fxBiUiQ6elJyWLDNpe2Ez+FoZn9ZnQnyofVOTaZqb30=;
        b=MDrjqwWYwIeFMTzWBfKuizVfku2BVcpVVY0ieGd3u0KxwhKTD32Z+C1cpSIfoEzOmj
         HW09a6XEtUB5L0cgU/ZVnhFWxcA8VJooaoHy+eW0fpSeLFfUSQ99jX6hfW12KERwFHI0
         t8SWUr95Gf7LMJMBu/pKVzLdPvYeOVSJJ/9N0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fxBiUiQ6elJyWLDNpe2Ez+FoZn9ZnQnyofVOTaZqb30=;
        b=aaY/qo7VQZRn8Hb/UFfgwUg6BnQdOZnJs0glDTTRj6ZX+tkuVfj7j6Kh09bVQjiN6U
         HmFJrJUydkLwic8U4AoFPlLrjQrCahiAZF0D3pJmEMWh8vC0Ih6U7xmLsUa5xV+IgxXK
         s9v2N1IscjL1JGGfjKMewM08DIcYj1GbbE/N1fPD3tXG9tsvvQmiCDiKhHfMomOdqm8y
         97hz0FsoSLlTHP3/oe0PITWqUaoYrfrucjSMK/Rz1dfYmgsJiDDEgYspsrw6/gBeBSwM
         JQevKVMnp7CmhO3oZBquGuI/POKiASFgwcrV0Jw/TtX1mU5Gy+lMjwq3EKzJH9JYGDWQ
         nKMw==
X-Gm-Message-State: APzg51DymWv7i/CnjPyQNpw15T9oM0B/BeDsu31lPgVSzK12/b/nYWkX
        Ybpp48MkjPxkumyPa3u1qtXYPg==
X-Google-Smtp-Source: ANB0Vdanf0BpQMSVSZL6eJzojEAg7OTt7jv57usmtuuRoYpSa46CWIRfoVNzn4MZ9GgLcU/3QwbrsQ==
X-Received: by 2002:adf:ce06:: with SMTP id p6-v6mr10524597wrn.118.1535703262970;
        Fri, 31 Aug 2018 01:14:22 -0700 (PDT)
Received: from [192.168.0.15] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id r66-v6sm8221995wmb.37.2018.08.31.01.14.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 01:14:22 -0700 (PDT)
Subject: Re: [PATCH v1 02/10] dt-bindings: thermal: Fix a typo in
 documentation
To:     Eduardo Valentin <edubezval@gmail.com>,
        Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <cover.1533815718.git.amit.kucheria@linaro.org>
 <08b528ddc26adcb57539b1ac9d352850d7d80bfb.1533815718.git.amit.kucheria@linaro.org>
 <20180824232423.GD25163@localhost.localdomain>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <b8083ad2-f98d-9d66-212e-25bd34c9cec7@linaro.org>
Date:   Fri, 31 Aug 2018 10:14:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180824232423.GD25163@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/08/2018 01:24, Eduardo Valentin wrote:
> On Thu, Aug 09, 2018 at 06:02:34PM +0530, Amit Kucheria wrote:
>> c(1) + x(1) was actually meant to be c(1) * x(1).
>>
>> While we're at it, add some brackets to make it nicer to read.
>>
>> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/thermal/thermal.txt | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
>> index cc553f0952c5..751104213d08 100644
>> --- a/Documentation/devicetree/bindings/thermal/thermal.txt
>> +++ b/Documentation/devicetree/bindings/thermal/thermal.txt
>> @@ -152,7 +152,7 @@ Optional property:
>>    Elem size: one cell	the sensors listed in the thermal-sensors property.
>>    Elem type: signed	Coefficients defaults to 1, in case this property
>>  			is not specified. A simple linear polynomial is used:
>> -			Z = c0 * x0 + c1 + x1 + ... + c(n-1) * x(n-1) + cn.
>> +			Z = (c0 * x0) + (c1 * x1) + ... + (c(n-1) * x(n-1)) + cn.
> 
> To be honest, I would prefer if this looks like:
> +			Z = c0 * x0 + c1 * x1 + ... + c(n-1) * x(n-1) + cn.
> 
> The extra bracketing seams unnecessary confusion

I agree, the brackets don't change the computation ordering, they are
pointless.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

