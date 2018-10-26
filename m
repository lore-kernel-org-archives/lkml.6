Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57122C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 089D12084D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NDrvs/jp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 089D12084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbeJZRGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 13:06:44 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53285 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbeJZRGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 13:06:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id l26-v6so610323wmh.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 01:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MtgC7Jd3JHHvHAWNyYKiDYJNoW+57OqI3hkRlBi0I7A=;
        b=NDrvs/jpKi/Zf1AYMgBW6t+xd1vR7gCAdVlJRrj5xT4ueumBr6IYwwL9DlZAKmhzPZ
         XYr7F04IIrQcCNdx6amT/UeEiqWeprV9uR2x+nplhX2oYSmAabtqiTvT5QMs1mUiHtrM
         ujzJBl3P7JTIVwlu3U2otOlhE6awWzVFbbTjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MtgC7Jd3JHHvHAWNyYKiDYJNoW+57OqI3hkRlBi0I7A=;
        b=paD/EDr9G6dIwVSpamSmtubYpp72ddmLWxDN5Nu/ZLI0EyS5WsJoCRkGOiOjzCE2vI
         7OAwl+Dga1aTBbAbEtuCmLDeNsyVXXZaGjrBXDR7dVz/wLjlbBuWdmQF/TT9WLs1aPQL
         93lf6dsbRdafJcYhB6fSHEexKEClbBDWzsZsIOxTWIf8z0jKxIIhA2XtbKY3rDe+jd6V
         fxmBR6Zs9zB9t4+89edfuvrMRhZR4IZI7z0dfkJM0+Joq1rfdiOf/hJ4GFQR+QwSntdS
         NMQ+lPVjBBamGZjYUpGwY0WOZldEuBD54m+CD05xhd861sEiJtdFbK6lfbj4Z7n7PYCb
         6Nvg==
X-Gm-Message-State: AGRZ1gKDleOW8UJuZKPXhDdEZUAvc4slUzlf+WbQQBscpnmKfNeJhl7L
        X8unK7dxNlKLDl7O6thuuHISEpZvr1Y=
X-Google-Smtp-Source: AJdET5c8vI//+f8y0mHqKy4f7mrwG+pruwyhdSOZzbWbQuTg3lqHDWR0CgG6idXylxQJbQ52bM+/uA==
X-Received: by 2002:a1c:85d0:: with SMTP id h199-v6mr4564139wmd.127.1540542635138;
        Fri, 26 Oct 2018 01:30:35 -0700 (PDT)
Received: from [192.168.0.40] (247.65.136.77.rev.sfr.net. [77.136.65.247])
        by smtp.googlemail.com with ESMTPSA id v1-v6sm15707178wrd.24.2018.10.26.01.30.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 01:30:34 -0700 (PDT)
Subject: Re: [PATCH] dt-bindings: arm: Fix cpu capacity mismatch in example
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     catalin.marinas@arm.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <138600f5d504b41202a29a1e130a7aa4e51f1925.1540451976.git.viresh.kumar@linaro.org>
 <80206cb7-b550-1cf6-abf4-e4b17de4cdb5@linaro.org>
 <20181026041107.4hofhlcubbo5claq@vireshk-i7>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d4d6af05-61f1-4123-c2dc-4ee0946f79e8@linaro.org>
Date:   Fri, 26 Oct 2018 10:30:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181026041107.4hofhlcubbo5claq@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/2018 06:11, Viresh Kumar wrote:
> On 25-10-18, 14:04, Daniel Lezcano wrote:
>> I think it is actually correct. The example is confusing on what the
>> numbers are. IIUC, it is:
>>
>> (after normalizing)
>>
>> dhrystone result on big CPU is 1024 at 1100MHz
>> dhrystone result on little CPU is 446 at 850MHz
>>
>> We have to scale the result of the little for 1100MHz in order to compare.
>>
>> 1100/850 = 1.294
>>
>> dhrystone result on little CPU is 446 * 1.294 = 577 at 1100MHz
>>
>> So we put the normalized values 1024 and 577. The arch_topology will
>> scale 577 back to 446 as it will compute the max capacity based on the
>> max freq which is 850MHz.
>>
>> The *final* capacities are 1024 for cluster0 and 446 for cluster1 (read
>> the cpu max capacity, the ones showed in the sysfs).
>>
>> Did I miss something ?
> 
> No. What about making it more clear in the example to save the next idiot (like
> me) from wasting time :)
> 
> diff --git a/Documentation/devicetree/bindings/arm/cpu-capacity.txt b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
> index 9b5685a1d15d..d061e6575bde 100644
> --- a/Documentation/devicetree/bindings/arm/cpu-capacity.txt
> +++ b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
> @@ -61,7 +61,10 @@ mhz values (normalized w.r.t. the highest value found while parsing the DT).
>  Example 1 (ARM 64-bit, 6-cpu system, two clusters):
>  capacities-dmips-mhz are scaled w.r.t. 1024 (cpu@0 and cpu@1)
>  supposing cluster0@max-freq=1100 and custer1@max-freq=850,
> -final capacities are 1024 for cluster0 and 446 for cluster1
> +final capacities are 1024 for cluster0 and 446 for cluster1.
> +Note that the values mentioned below in the example (1024 and 578)
> +aren't normalized based on max frequency of each cluster and that is
> +left for the operating system to do.

Yes, it will help but if you want to make things even more clear, I
suggest to elaborate the text a bit and give the numbers above to
explain (1100/850=1.294, 446 * 1.294 = 577, ...)


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

