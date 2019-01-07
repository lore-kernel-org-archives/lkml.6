Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8E0C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8606C2089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="at7MnrtC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfAGI4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 03:56:37 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34158 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbfAGI4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 03:56:37 -0500
Received: by mail-ed1-f66.google.com with SMTP id b3so118718ede.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 00:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3QJDlXU6jEsWi1B5HJNrdK28a8zG30jKkE66cy0wHdI=;
        b=at7MnrtC9Fz8B0Il1KsSr2ChLxsnR71uG4379X3xdeg5R2w8xysF07IwbwmpguIi6n
         PjMMlS97qpA53gWp+tjcNHZt61G83+wRHEpALQrZ7G5XLdIQeQaZAJA9T1jXsGdrL77S
         75fZmNkwNCqOKWFx+JqDdtDj4PkUsHGEe8m18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3QJDlXU6jEsWi1B5HJNrdK28a8zG30jKkE66cy0wHdI=;
        b=T5otQy/U1+hnvQhk32gkazh1x4SZdpy7PSewMvPrpaSk85FLPb+vkv8z2mzgjrCUdY
         Q+7sARMux2fNti2VMtpoVRw9TvS61Sm0c2NO9SX0sXXXQrRuqqoUGT50gBOkbFKes0K4
         QU9EttWjC82Er1X3BFbvXhK6T8AtMtnVDHJZxQxguGU5NwuZgfZT43DHymFB/CGJQT/q
         qMp79NW/K2fK61jL3V9Y0q7iBTK+SA8Ph46LPcKd4AF8BJBCos0KHknxXUCdtdualPd1
         UeTUr4WYZ68WLtKt2mnU6GC0Y/vwUDSj91YU+AsEtUzmUB9WlExKkngvyDeyO4Te7bt+
         297A==
X-Gm-Message-State: AA+aEWbzZu/KLcsuzZ6AXLVokdEbRKpzSXe5/RfyC7cTRKewMuUixOvp
        Y5ndYlhLbl39V6clQfsZqYFagQ==
X-Google-Smtp-Source: AFSGD/X/n+YINqJ9uTCHdgCAaL/iERW/gcv4ZJahWtD5xnlatwDxdXIu/mvBlqfSJi5PYLUz1A3L3Q==
X-Received: by 2002:a17:906:5d10:: with SMTP id g16-v6mr46408293ejt.212.1546851394320;
        Mon, 07 Jan 2019 00:56:34 -0800 (PST)
Received: from [192.168.0.40] (29.139.135.77.rev.sfr.net. [77.135.139.29])
        by smtp.googlemail.com with ESMTPSA id v12-v6sm20117631ejk.58.2019.01.07.00.56.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 00:56:33 -0800 (PST)
Subject: Re: [PATCH v2 1/4] dt-bindings: Correct RISC-V's timebase-frequency
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     atish.patra@wdc.com, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, aou@eecs.berkeley.edu,
        devicetree@vger.kernel.org, dmitriy@oss-tech.org,
        linux-riscv@lists.infradead.org, mark.rutland@arm.com,
        robh+dt@kernel.org, tglx@linutronix.de, anup@brainfault.org,
        Damien.LeMoal@wdc.com, Christoph Hellwig <hch@infradead.org>
References: <mhng-9767f556-9f5a-4366-931f-131222d3253b@palmer-si-x1c4>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <a3e05488-053d-ae3e-b342-0799e60b1abd@linaro.org>
Date:   Mon, 7 Jan 2019 09:56:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <mhng-9767f556-9f5a-4366-931f-131222d3253b@palmer-si-x1c4>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/01/2019 01:36, Palmer Dabbelt wrote:
> On Fri, 14 Dec 2018 01:17:24 PST (-0800), daniel.lezcano@linaro.org wrote:
>> On 14/12/2018 00:14, Atish Patra wrote:
>>> From: Palmer Dabbelt <palmer@sifive.com>
>>>
>>> In RISC-V systems, timebase-frequency is per cpu instead of one
>>> instance for entire SOC as there is a individual timer per each CPU.
>>> Fix the DT binding accordingly.
>>
>> Why not use a fixed-clock instead of this timebase property which forces
>> to declare a global variable to be exported from arch/riscv to
>> drivers/clocksource ?
> 
> That makes sense to me.  I've always disliked this global variable and a
> big part of why my original version got delayed forever is that I'd
> hoped to get rid of it.
> 
> Given that this is all a mess anyway I'm OK breaking backwards
> compatibility here.
> 
> Is there an example of how to do this?


Can you give some hardware details? Is the timebase frequency constant?
If it is the case, a fixed-clock shared for each cpu can be used, no?

    myclock: myclock {
        compatible = "fixed-clock";
        #clock-cells = <0>;
        clock-frequency  = <1000000>;
        clock-output-names = "mytimer";
    };

Alternatively, may be different output can be specified with the clock,
one for each CPUs.

Or if the timebase frequency is resulting from a clock divisor, it can
be defined as:

        clock {
                compatible = "fixed-factor-clock";
                clocks = <&parentclk>;
                #clock-cells = <0>;
                clock-div = <2>;
                clock-mult = <1>;
        };

hardware details can help to narrow down the right description.


>> In addition, please add the 'Fixes' tag
>>
>>> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>> [Atish: Update the commit text]
>>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>> ---
>>>  Documentation/devicetree/bindings/riscv/cpus.txt | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/riscv/cpus.txt
>>> b/Documentation/devicetree/bindings/riscv/cpus.txt
>>> index adf7b7af..b0b038d6 100644
>>> --- a/Documentation/devicetree/bindings/riscv/cpus.txt
>>> +++ b/Documentation/devicetree/bindings/riscv/cpus.txt
>>> @@ -93,9 +93,9 @@ Linux is allowed to run on.
>>>          cpus {
>>>                  #address-cells = <1>;
>>>                  #size-cells = <0>;
>>> -                timebase-frequency = <1000000>;
>>>                  cpu@0 {
>>>                          clock-frequency = <1600000000>;
>>> +                        timebase-frequency = <1000000>;
>>>                          compatible = "sifive,rocket0", "riscv";
>>>                          device_type = "cpu";
>>>                          i-cache-block-size = <64>;
>>> @@ -113,6 +113,7 @@ Linux is allowed to run on.
>>>                  };
>>>                  cpu@1 {
>>>                          clock-frequency = <1600000000>;
>>> +                        timebase-frequency = <1000000>;
>>>                          compatible = "sifive,rocket0", "riscv";
>>>                          d-cache-block-size = <64>;
>>>                          d-cache-sets = <64>;
>>> @@ -145,6 +146,7 @@ Example: Spike ISA Simulator with 1 Hart
>>>  This device tree matches the Spike ISA golden model as run with
>>> `spike -p1`.
>>>
>>>          cpus {
>>> +                timebase-frequency = <1000000>;
>>>                  cpu@0 {
>>>                          device_type = "cpu";
>>>                          reg = <0x00000000>;


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

