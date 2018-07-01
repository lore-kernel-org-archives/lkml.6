Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56D8C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC77249E4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwnYH8oq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CC77249E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031469AbeGAR0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:26:41 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33697 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753681AbeGAR0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 13:26:34 -0400
Received: by mail-wr0-f196.google.com with SMTP id k7-v6so9764809wrq.0;
        Sun, 01 Jul 2018 10:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=qH1mzUZxYkVEWiQ9bM5H21uchY9FtqVqjdg7ld+ifMg=;
        b=ZwnYH8oqdrF7dnmlngbO4wstmW+niwVSzMMNIGzb6yvXopnGR1RExGWyKCMZ8egJNK
         53j/cV4lbd4ZFZdUhHQWMQ6Uw+a12aOu/d5y6qhzITdx56dN+ln8g3jtU35Hjngfe/Eo
         ITrmLyRKoioLt7MXnPLDlH/u54ewO2HQ1Q/gYbZSY/rblXwOA3KXifUlLur1ChQIiaHc
         sWk37cRPYqc3iIVK57xByAS5I/AclhF8h+qUd5zcHok9/kx+DWg6ZS8kBlpCpnw2Xj7e
         yRLx0UTA3BD+7fbc22hgh6Shy4dls3pAPNSZaSdvRMnAojFGoNLFpk/gBviP/Maieptd
         Ku1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=qH1mzUZxYkVEWiQ9bM5H21uchY9FtqVqjdg7ld+ifMg=;
        b=KHOXJKbhEwNxiQT63zkPdOwn9VooyszR+Mr/HTJtxWks0Tf7N/O8FFDbz/+85xj2Pg
         5IUoyhgFhhnNsXbOGjh+GYhVfRMvIZfoMkpFGi/sSQnL1kpy3SnCipJP25RBxP1NrUD9
         BR1HiWcRRq81zluQP/4Ls/IOvEx5tl8lzLf8WkyvRYktsHLArCA0Z4O1G51dChT73Hy8
         U7PWpSbPosbggddm7cN7foHsRlWHEDoSeA3sYA5vuM5yqrrpJUh+wF9kkb5FlA1AQ/CQ
         EXURQZyatDdmJp1tWl8/OWacO1w1MpPy3JqijCD/G2fHAa8zkftNsqsUV3BOdWfwyAzk
         37Vw==
X-Gm-Message-State: APt69E0ZWE42bzHLQ+tj5SPROEgIsYwVMOfnzacgkivaB0nyCPXI4wl5
        0Gn/qlVLxRNSoDOd/+76vpxbH/2ADNU=
X-Google-Smtp-Source: AAOMgpdmrgm+wr4ryh/YIHN8Y1rR3xkWdfEFqGs9lA7s4LRgRLSqUaudZ/rP7WlTjyqhW66Irns8DQ==
X-Received: by 2002:adf:e405:: with SMTP id g5-v6mr2430818wrm.96.1530465992437;
        Sun, 01 Jul 2018 10:26:32 -0700 (PDT)
Received: from [192.168.0.103] (p5B3F6705.dip0.t-ipconnect.de. [91.63.103.5])
        by smtp.gmail.com with ESMTPSA id h7-v6sm4623777wmb.48.2018.07.01.10.26.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Jul 2018 10:26:31 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] dt-bindings: clock: Modify Actions Soc clock
 bindings
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     afaerber@suse.de, sboyd@kernel.org, pn@denx.de,
        linux-arm-kernel@lists.infradead.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, devicetree@vger.kernel.org
References: <20180626192820.28237-3-sravanhome@gmail.com>
 <20180628191805.3722-1-sravanhome@gmail.com>
 <20180628191805.3722-4-sravanhome@gmail.com>
 <20180630093202.GB7320@Mani-XPS-13-9360>
From:   Saravanan Sekar <sravanhome@gmail.com>
Message-ID: <15070ea0-aebf-2b7d-89f0-b21e729c927e@gmail.com>
Date:   Sun, 1 Jul 2018 19:26:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180630093202.GB7320@Mani-XPS-13-9360>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mani


On 06/30/18 11:32, Manivannan Sadhasivam wrote:
> Hi Saravanan,
>
> I agree with modifying the existing binding to accomodate other
> SoC's of the same family. But the binding should be
> "actions,owl-cmu.txt" since it reflects the family name.

Agree, will modify the name

> Andreas, what do you think?
>
> On Thu, Jun 28, 2018 at 09:18:05PM +0200, Saravanan Sekar wrote:
>> Modify clock bindings common Actions Semi Soc family S700/S900.
>>
>> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
>> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
>> ---
>>   ...tions,s900-cmu.txt => actions,sx00-cmu.txt} | 18 ++++++++++--------
>>   1 file changed, 10 insertions(+), 8 deletions(-)
>>   rename Documentation/devicetree/bindings/clock/{actions,s900-cmu.txt => actions,sx00-cmu.txt} (71%)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/actions,s900-cmu.txt b/Documentation/devicetree/bindings/clock/actions,sx00-cmu.txt
>> similarity index 71%
>> rename from Documentation/devicetree/bindings/clock/actions,s900-cmu.txt
>> rename to Documentation/devicetree/bindings/clock/actions,sx00-cmu.txt
>> index 93e4fb827cd6..8dc7edb4d198 100644
>> --- a/Documentation/devicetree/bindings/clock/actions,s900-cmu.txt
>> +++ b/Documentation/devicetree/bindings/clock/actions,sx00-cmu.txt
>> @@ -1,12 +1,14 @@
>> -* Actions S900 Clock Management Unit (CMU)
>> +* Actions S900/S700 Clock Management Unit (CMU)
>>   
> Same as above. Should be Actions OWL SoC's Clock Management Unit (CMU).

sure

>> -The Actions S900 clock management unit generates and supplies clock to various
>> -controllers within the SoC. The clock binding described here is applicable to
>> -S900 SoC.
>> +The Actions S900/S700 clock management unit generates and supplies clock to
>> +various controllers within the SoC. The clock binding described here is
>> +applicable to S900/S700 SoC.
>>   
>>   Required Properties:
>>   
>> -- compatible: should be "actions,s900-cmu"
>> +- compatible: should be one of this
> Change to: compatible: should be one of the following:

sure

> Thanks,
> Mani
>
>> +	"actions,s900-cmu"
>> +	"actions,s700-cmu"
>>   - reg: physical base address of the controller and length of memory mapped
>>     region.
>>   - clocks: Reference to the parent clocks ("hosc", "losc")
>> @@ -15,9 +17,9 @@ Required Properties:
>>   Each clock is assigned an identifier, and client nodes can use this identifier
>>   to specify the clock which they consume.
>>   
>> -All available clocks are defined as preprocessor macros in
>> -dt-bindings/clock/actions,s900-cmu.h header and can be used in device
>> -tree sources.
>> +All available clocks are defined as preprocessor macros in corresponding
>> +dt-bindings/clock/actions,s900-cmu.h or s700-cmu.h header and can be used in
>> +device tree sources.
>>   
>>   External clocks:
>>   
>> -- 
>> 2.18.0
>>

Thanks,
Saravanan
