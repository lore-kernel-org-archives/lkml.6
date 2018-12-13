Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94182C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E2520851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="J6SKUws1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60E2520851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbeLMR4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 12:56:50 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41883 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbeLMR4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 12:56:50 -0500
Received: by mail-wr1-f65.google.com with SMTP id x10so2926436wrs.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 09:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Gu4DkuQehAOmMCscMrWmcXJAwhG+cQlBZwKNNOnsljY=;
        b=J6SKUws1pfjczpujp2olCYxNwVxFAU9HkJ6LmjBIPGEOJJEwAEsXlNTzYLZ4bPk+jw
         MdXZsDtVz9+sffde3VWxmHI+KdZX+DqAIShPGZ5igHTqzfhFlu4anojgh2RTo9XddZMy
         UtxWRC8WX2YTDALaK7FCh4zGdwlmxTsjmLpAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Gu4DkuQehAOmMCscMrWmcXJAwhG+cQlBZwKNNOnsljY=;
        b=WIEH2H+wjNcvzB8HeU5GzGXpJ7Rnc3njz8/IE9nqfdHWG2i05JX+yWzycsC85TJ/ay
         Un/0u0hBwUn1YbYn9ms1v84V4l9+s/VKi4F9DU5fod9xyliM7oCNTdkudbTGeYMg1/ZE
         IWBZ2qZ74xQgOiSjwvV6KAktDFAhs2kXjLAKwJbSIzCwPl013d7GWyt2zi4Ho/pwo5Zj
         0kkRRZPn8pBqPFJtB8SjTBqNzycbLruKckxzw+ORUk6GRmt29Z/5IiRgz3y9vek+TI/V
         FYh2A8In3iTz7bJ60f1gFH5W4438RgYn8fiZl5zT4E7xQEaIHQtbvMb+q4hZlbFGVkiW
         /h0A==
X-Gm-Message-State: AA+aEWaP7ypzFs1gB6Lu4ENdO29ZtnW/OZCaC3DylaMfjuuZEz9CsNGi
        kpCPa4Ed3BLPrwPbqRW/r/usTA==
X-Google-Smtp-Source: AFSGD/XKGt2aSeUWgUYhc7ts1A1ygwh7T5LbQn0YYNkwoNZ3PZxhqZ2QcK3+94hFPpM5X6S+hg4uoQ==
X-Received: by 2002:adf:db51:: with SMTP id f17mr20746202wrj.90.1544723808290;
        Thu, 13 Dec 2018 09:56:48 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id w6sm3629446wme.46.2018.12.13.09.56.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 09:56:47 -0800 (PST)
Subject: Re: [PATCH v5 4/4] arm64: dts: add msm8996 compatible to gicv3
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     sudeep.holla@arm.com, tglx@linutronix.de, jason@lakedaemon.net,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, nicolas.dechesne@linaro.org,
        ctatlor97@gmail.com, vkoul@kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
References: <20181210135633.30283-1-srinivas.kandagatla@linaro.org>
 <20181210135633.30283-5-srinivas.kandagatla@linaro.org>
 <86tvjhbao7.wl-marc.zyngier@arm.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <9380f9e8-bab0-6e5a-fa64-faaa1730a3db@linaro.org>
Date:   Thu, 13 Dec 2018 17:56:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <86tvjhbao7.wl-marc.zyngier@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/12/2018 17:26, Marc Zyngier wrote:
> I've applied the first 3 patches to irqchip/next. Please route this
> one via arm-soc.

Thanks, I will request Andy to take in his next pull request!

--srini	
> 
> Thanks,
> 
> 	M.
