Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D826C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 02:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC1221480
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 02:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GstQsTkL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC1221480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbeIZJDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 05:03:48 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33854 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbeIZJDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 05:03:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id k19-v6so12580581pfi.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 19:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Wminz0EzTH1jInvRsoX9C8RhecCOV4esJ2yXhMEfIQk=;
        b=GstQsTkLYXCLzOAcmZjqM1DPvp7LG2cWUnzycLDoDQHXUUDa9om0wHB10MYg+5pfDv
         bfeKUcFIoapK1q0G6uGe5Qt4K0Obu9Aly1DHatesddOHIH8BV+VVdghPsIP1ZdoM3I0D
         qfUCCs99HREtiD4fNHlQ7AmI/lYNU+xtuFcZKAV4zM6p6IkO2qo0eujP6MxdH7yg9mDJ
         ZSC1tVBSHjfyRZP+vnLbNtcxlzVT0ko6gcqJu+vDe0S9ZihwNRWGeHPARuhFWyNKaZjT
         K1dxy1VgH8cQ0vhftZNvym9G0qUXZWMzMbGlNaGgfBoU7ou7DdYMAMe1d3RcGgPeeyNL
         L2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wminz0EzTH1jInvRsoX9C8RhecCOV4esJ2yXhMEfIQk=;
        b=Dl4mVVRWNuimY9s7ygwKSCS3Fl0C7yZSOcUozIIeoO/GjpWkuZJ/eGv2Uzn5JO3u7r
         24F8IBMM25imKStZfoalpvzzL5ZzdFQtryHYnP+006HdD036jbxDdEnc5EWIg8KYty5M
         gikz1tB5xJD5+EsEjclZZGSc1YOMKkdFoCj8ohHfsWzbT4DMJMmFEIW3ygLl2egjzY/4
         Q8vEnfFQpD4/wRZDY6ZHwh+xzdV+MNjSo+aq5FLIBgsg72Sb4Pys9mvnkBRCtI/rVPSb
         V4M/Pl9Qwo7n6LgsCp+3PmjeLbKJ7VTL58r+uPqoyyjEdmFfr+Ht1jQ1l6L6OJVxYlAH
         zT6w==
X-Gm-Message-State: ABuFfogb+JrBmquuzkObGgEza+kEyTMR45F0gWD9TR89o7TiZClzvLs0
        xhcU3UZtqKQ/5g8wkjmhPbwdqEXz
X-Google-Smtp-Source: ACcGV63UHsGd9cH5AaiqJeeD+pBMDtZKsumrgqNsw1qdSpTBTb6F1xUJfonRedipYFT4yRHLSTCYLA==
X-Received: by 2002:a17:902:758f:: with SMTP id j15-v6mr3908872pll.160.1537930388571;
        Tue, 25 Sep 2018 19:53:08 -0700 (PDT)
Received: from [192.168.1.3] (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id k71-v6sm5582068pge.44.2018.09.25.19.53.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 19:53:07 -0700 (PDT)
Subject: Re: [PATCH 3/4] MIPS: BMIPS: Remove special handling of
 CONFIG_MIPS_ELF_APPENDED_DTB=y
To:     Yasha Cherikovsky <yasha.che3@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Kevin Cernekee <cernekee@gmail.com>, linux-kernel@vger.kernel.org,
        Jonas Gorski <jonas.gorski@gmail.com>
References: <20180925180825.24659-1-yasha.che3@gmail.com>
 <20180925180825.24659-4-yasha.che3@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <27cf7925-71a1-42f1-db52-7598663edd65@gmail.com>
Date:   Tue, 25 Sep 2018 19:52:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180925180825.24659-4-yasha.che3@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/25/2018 11:08 AM, Yasha Cherikovsky wrote:
> The ELF appended dtb can be accessed now via 'fw_passed_dtb'.
> 
> Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

> Cc: Kevin Cernekee <cernekee@gmail.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: linux-mips@linux-mips.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   arch/mips/bmips/setup.c | 9 +--------
>   1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
> index 3b6f687f177c..b71b6eaaf7ed 100644
> --- a/arch/mips/bmips/setup.c
> +++ b/arch/mips/bmips/setup.c
> @@ -153,8 +153,6 @@ void __init plat_time_init(void)
>   	mips_hpt_frequency = freq;
>   }
>   
> -extern const char __appended_dtb;
> -
>   void __init plat_mem_setup(void)
>   {
>   	void *dtb;
> @@ -164,15 +162,10 @@ void __init plat_mem_setup(void)
>   	ioport_resource.start = 0;
>   	ioport_resource.end = ~0;
>   
> -#ifdef CONFIG_MIPS_ELF_APPENDED_DTB
> -	if (!fdt_check_header(&__appended_dtb))
> -		dtb = (void *)&__appended_dtb;
> -	else
> -#endif
>   	/* intended to somewhat resemble ARM; see Documentation/arm/Booting */
>   	if (fw_arg0 == 0 && fw_arg1 == 0xffffffff)
>   		dtb = phys_to_virt(fw_arg2);
> -	else if (fw_passed_dtb) /* UHI interface */
> +	else if (fw_passed_dtb) /* UHI interface or appended dtb */
>   		dtb = (void *)fw_passed_dtb;
>   	else if (__dtb_start != __dtb_end)
>   		dtb = (void *)__dtb_start;
> 

-- 
Florian
