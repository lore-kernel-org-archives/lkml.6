Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058B1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A989F214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fO8arnAv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A989F214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbeJJOwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 10:52:47 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32991 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeJJOwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 10:52:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id d4-v6so2194890pfn.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 00:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=44drmNbumbsdrvHTV4k5yE8FsN7iErm2hROHs2b+84Q=;
        b=fO8arnAv4lPQEw8ax3qT2PhlqA+WIeZWcCVMGpFjFqE5N8n55O3XfxP3xvaweHeDpC
         lExmV35BVcRejDKz3K/ZUOhXgUk7SChOt5xrpqEF1+D4R87oooYAjHNgxzbjJWm+lKKE
         eywmChi5et5hY6mMA9MVhwJq7nLjck0Zm7Xl8I0BqU5vDsLNnDv9ftavOZn0wdkGPRq6
         nLTLQOKtFtZPisE4zsFFcI+37eCNK3AAwLLHcQqo3lCpi7r52W+MeCds2LAohnkgdqi7
         eSxj8pJe6GAzUt7E9zF7LHQNpn0Atjdz6xMTS0eIYc5QoVOBWEwqD4UgRdgmvoBv16LW
         FGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=44drmNbumbsdrvHTV4k5yE8FsN7iErm2hROHs2b+84Q=;
        b=LoZyjTd7nfKnNIRoPh48BomNMAkQqA9Nv7ujzizorjr8Bfs5Yv1fJY2tAoEY/dYDQe
         ssYmXRceV2XpRlLzmWYohbVnzknV+nCQ7FBh/jNYPRgbH29P6iTkBzzEqUYozXi7i0NQ
         QnLIh8QzTDjEwua0H5ZwRQn7HC50tV+atIVMF+XXMk7awoNjmyqgskQxKH1Ea/vVYj0p
         /bnwARSZAxxccUefXOPfU/zxMyNUiUy0yO53f+AO/oVSPAhad5EnrWrEjMVCPaNUEAGV
         g45lUuU1zNka/4fJL2+5v/c/ORbR3Hu+oVqw+UDzCY1wlMFMOHzDRT7WkSt7oGS9BnFu
         PwnA==
X-Gm-Message-State: ABuFfog1Qrhu+2ReaTi3fDun5p7D2idiFFoPoU1BfGdaQs8pV7pzg/Pw
        rrxBY5YKA94fiXrukkhhjda80cYW
X-Google-Smtp-Source: ACcGV61uwbOVwdReH/+NHCa0XnzA2cJyz0z0szkQr3jfaU4763sdU516F/oEhaYZDkoDVh5O4HXHJA==
X-Received: by 2002:a65:4385:: with SMTP id m5-v6mr27261104pgp.219.1539156714597;
        Wed, 10 Oct 2018 00:31:54 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:4414:a441:1820:9cbd:367b? ([2402:f000:1:4414:a441:1820:9cbd:367b])
        by smtp.gmail.com with ESMTPSA id o24-v6sm36365574pfa.90.2018.10.10.00.31.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 00:31:53 -0700 (PDT)
Subject: Re: [BUG] mfd: ezx-pcap: Possible sleep-in-atomic-context bugs in
 pcap_adc_irq()
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <f83a444a-1943-6c8c-5cd4-88e2acb17fa6@gmail.com>
 <20180917010340.GA3900@dell> <e371a365-7dac-8e20-4823-f5395602211d@gmail.com>
 <20181009090715.GE4939@dell>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <8579fb94-aef5-7782-b062-0dc9bea29e4b@gmail.com>
Date:   Wed, 10 Oct 2018 15:31:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20181009090715.GE4939@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/10/9 17:07, Lee Jones wrote:
> On Mon, 17 Sep 2018, Jia-Ju Bai wrote:
>
>>
>> On 2018/9/17 9:03, Lee Jones wrote:
>>> On Sat, 15 Sep 2018, Jia-Ju Bai wrote:
>>>
>>>> The driver may sleep in an interrupt handler.
>>>> The function call paths (from bottom to top) in Linux-4.17 are:
>>>>
>>>> [FUNC] mutex_lock_nested
>>>> drivers/mfd/ezx-pcap.c, 272:
>>>>       mutex_lock_nested in pcap_adc_irq (interrupt handler)
>>>>
>>>> [FUNC] mutex_lock_nested
>>>> drivers/mfd/ezx-pcap.c, 100:
>>>>       mutex_lock_nested in ezx_pcap_read
>>>> drivers/mfd/ezx-pcap.c, 281:
>>>>       ezx_pcap_read in pcap_adc_irq (interrupt handler)
>>>>
>>>> [FUNC] mutex_lock_nested
>>>> drivers/mfd/ezx-pcap.c, 85:
>>>>       mutex_lock_nested in ezx_pcap_write
>>>> drivers/mfd/ezx-pcap.c, 285:
>>>>       ezx_pcap_write in pcap_adc_irq (interrupt handler)
>>>>
>>>> [FUNC] mutex_lock_nested
>>>> drivers/mfd/ezx-pcap.c, 244:
>>>>       mutex_lock_nested in pcap_adc_trigger
>>>> drivers/mfd/ezx-pcap.c, 299:
>>>>       pcap_adc_trigger in pcap_adc_irq (interrupt handler)
>>>>
>>>> These bugs are found by my static analysis tool DSAC.
>>> Not sure what you want me to do with this.
>>>
>>> Do you have something in mind?
>>>
>> I find some possible bugs in this driver, but I do not know how to correctly
>> fix them...
>> Could you find a good solution?
> If you have found bugs and do not intend on fixing them, please report
> them via the 'File a Bug' option here:
>
>    https://bugzilla.kernel.org/
>

Okay, thanks.


Best wishes,
Jia-Ju Bai
