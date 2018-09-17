Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5617CECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 02:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9DA4214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 02:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+WGFkfI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9DA4214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbeIQILb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:11:31 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33924 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbeIQILb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:11:31 -0400
Received: by mail-pg1-f194.google.com with SMTP id d19-v6so6933476pgv.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Sep 2018 19:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=b+W2KgD1+35cPMUuyiWExE3u77Z/RdE9Diza4aKRjG0=;
        b=S+WGFkfINlD50Arb5w+b6lUk/3bBRN0btXbCul2BMriZSrqxh0nsMjSXCwyCXldsxT
         3Wwk5DbfWj2MbbJDpbjtLI2OfbbVC8QeuzJA44t7f6R28slvVPKZAhYOyzlGDNXcER1n
         Gqqjj8I2uWaO7Np5tYb4iFMiQArsM9vHizgCvYHnC3iEKizTshcrUfwfDszkSSy9STcE
         zdtMFtOBq58xjB59D8wYeLDzKj49T+jBu3wRP9l/5rekGbaY1GlSH+GcyP7S2IfoIoYA
         B0xnAkqIZYHKzAeu/VT6DJgnhOAkZBWRSaUtMg3l8rLplTk6kQlpGLOIMvq9rEVX4cXe
         41uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=b+W2KgD1+35cPMUuyiWExE3u77Z/RdE9Diza4aKRjG0=;
        b=DH5i5vNDFu8tS/mJNtSy3AfbH8GG0uE9hld2QtrVA1UL4/2CyfmY5Rtv1M0jV2vfMv
         snZvidg/xDz/Uf2KoPw7BpC2MBBl+wLAAUqLX/nd1o93OY2D+GU4JY2zmFU2QICb5jvs
         BlGP4UZeRZWM7KcH75wLCisONtn+/q/zO4zlgivckmHnkhuBeiZEzoZzhT/qhILE/yZa
         xXkR6pI812mSAniy4lzSS0RN2BNDnLBTy3GJQIMlMGNL64qHD/DKqo16Yu8jLTF1ukxu
         NmAcyETcguXwTdsLC5EeBP4+rZ8NV0S6B2A0md7CLx/bcHcTs50smUl8nUy0vzAiAKTM
         oZ6Q==
X-Gm-Message-State: APzg51DDKn3ZBr8ZkLSlPK3amGnbnFmGf7QnPD0eODSyidwzozogiMmI
        q9y+MfPs+j60l8Z5XzI8Yfs1DUjm
X-Google-Smtp-Source: ANB0VdaljgWZLZYJ36dkrdue0k8g7ktq7ArBHNs/phx0gwJrmHu9ZuL0XWbdQmIBGncnlBOoxDFxIQ==
X-Received: by 2002:a62:8704:: with SMTP id i4-v6mr23607957pfe.62.1537152379837;
        Sun, 16 Sep 2018 19:46:19 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.45? ([2402:f000:1:1501:200:5efe:a66f:472d])
        by smtp.gmail.com with ESMTPSA id i25-v6sm15691041pgi.31.2018.09.16.19.46.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Sep 2018 19:46:19 -0700 (PDT)
Subject: Re: [BUG] mfd: ezx-pcap: Possible sleep-in-atomic-context bugs in
 pcap_adc_irq()
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <f83a444a-1943-6c8c-5cd4-88e2acb17fa6@gmail.com>
 <20180917010340.GA3900@dell>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <e371a365-7dac-8e20-4823-f5395602211d@gmail.com>
Date:   Mon, 17 Sep 2018 10:46:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180917010340.GA3900@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/9/17 9:03, Lee Jones wrote:
> On Sat, 15 Sep 2018, Jia-Ju Bai wrote:
>
>> The driver may sleep in an interrupt handler.
>> The function call paths (from bottom to top) in Linux-4.17 are:
>>
>> [FUNC] mutex_lock_nested
>> drivers/mfd/ezx-pcap.c, 272:
>>      mutex_lock_nested in pcap_adc_irq (interrupt handler)
>>
>> [FUNC] mutex_lock_nested
>> drivers/mfd/ezx-pcap.c, 100:
>>      mutex_lock_nested in ezx_pcap_read
>> drivers/mfd/ezx-pcap.c, 281:
>>      ezx_pcap_read in pcap_adc_irq (interrupt handler)
>>
>> [FUNC] mutex_lock_nested
>> drivers/mfd/ezx-pcap.c, 85:
>>      mutex_lock_nested in ezx_pcap_write
>> drivers/mfd/ezx-pcap.c, 285:
>>      ezx_pcap_write in pcap_adc_irq (interrupt handler)
>>
>> [FUNC] mutex_lock_nested
>> drivers/mfd/ezx-pcap.c, 244:
>>      mutex_lock_nested in pcap_adc_trigger
>> drivers/mfd/ezx-pcap.c, 299:
>>      pcap_adc_trigger in pcap_adc_irq (interrupt handler)
>>
>> These bugs are found by my static analysis tool DSAC.
> Not sure what you want me to do with this.
>
> Do you have something in mind?
>

I find some possible bugs in this driver, but I do not know how to 
correctly fix them...
Could you find a good solution?


Best wishes,
Jia-Ju Bai
