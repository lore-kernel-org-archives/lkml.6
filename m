Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D781C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3E621841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfBTSk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 13:40:58 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40533 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfBTSk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 13:40:57 -0500
Received: by mail-qt1-f195.google.com with SMTP id j36so28387300qta.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 10:40:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YPa0LQeW9jP5a+AtG2tN9T0YFHqPWVgL9XKkp1acwoQ=;
        b=kPZ9pe2HVuCzZLWm+3+wDusI9iVbsMZyYXJWOl4UN6s3uJJGyJQBYlZ+HS8C5EMMGW
         UQrfK/0iqI8gRNC7hdrzbbbuvb7nSpTizpjaXbzaenZQQ9AR0PQakAWkfYh1qkhPXfaA
         92tJ2njhiRdSPAcHqAfr+4MSInbDhiuQ/MyCRJyoWnbVVSrdJpmNW8YDjYZTFkBRWLri
         WXimfJU4agvfnAT7gZg/nIj2o8vthkxIGY1CERny8tWqzruOTo7dRST7gdtY8X41IkEr
         myyjiiJfFCbOkd0r8XODQG/o8vhopXJn7BkrchW/QZDnL1m8zN8551AyiPfHDPTxYOod
         mtOw==
X-Gm-Message-State: AHQUAuYeH58yImppaGWoitJYn/X9zEY9oHIDals4Mgod+1l24LDI102i
        3dPXBMxqOqiq6a0Xwel+yZC7xko2TWA=
X-Google-Smtp-Source: AHgI3IaHtD5+DblL4sBR6OFwLd2VnvSJijEYqtwCo9d1CCtNXaxJEN8onQQdu8LyU4NYJ3drRY43dg==
X-Received: by 2002:aed:3b13:: with SMTP id p19mr29167971qte.128.1550688056283;
        Wed, 20 Feb 2019 10:40:56 -0800 (PST)
Received: from ?IPv6:2601:602:9800:dae6::112f? ([2601:602:9800:dae6::112f])
        by smtp.gmail.com with ESMTPSA id d80sm3852741qkg.83.2019.02.20.10.40.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 10:40:55 -0800 (PST)
Subject: Re: [PATCH] s390/jump_label: Correct asm contraint
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Andreas Krebbel <krebbel@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190123125513.20210-1-labbott@redhat.com>
 <20190123132401.GG3424@osiris>
 <898d52cc-fa76-0888-429f-27446190653b@redhat.com>
 <20190205124349.GA10167@osiris>
 <541cdc96-7ce0-de6a-0f8b-778ee826a378@redhat.com>
 <20190220085809.GC3992@osiris>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <d7226c3e-6af3-714f-9444-44ba1a5b1f06@redhat.com>
Date:   Wed, 20 Feb 2019 10:40:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190220085809.GC3992@osiris>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/19 12:58 AM, Heiko Carstens wrote:
> On Sat, Feb 09, 2019 at 12:34:20PM -0800, Laura Abbott wrote:
>> On 2/5/19 12:43 PM, Heiko Carstens wrote:
>>> On Tue, Jan 29, 2019 at 08:25:58AM +0100, Laura Abbott wrote:
>>>> On 1/23/19 5:24 AM, Heiko Carstens wrote:
>>>>> On Wed, Jan 23, 2019 at 01:55:13PM +0100, Laura Abbott wrote:
>>>>>> There's a build failure with gcc9:
>>>>>>
>>>>>>   ./arch/s390/include/asm/jump_label.h: Assembler messages:
>>>>>>   ./arch/s390/include/asm/jump_label.h:23: Error: bad expression
>>>>>>   ./arch/s390/include/asm/jump_label.h:23: Error: junk at end of line, first unrecognized character is `r'
>>>>>>   make[1]: *** [scripts/Makefile.build:277: init/main.o] Error 1
>>> ...
>>>> I've had to turn off s390 in Fedora until this gets fixed :(
>>>
>>> Laura, the patch below should fix this (temporarily). If possible,
>>> could you give it a try? It seems to work for me.
>>>
>>> Subject: [PATCH] s390: disable section anchors
>> Tested-by: Laura Abbott <labbott@redhat.com><
> 
> The patch won't be used. In the meantime Ilya provided a gcc 9 and
> kernel patch which should fix this. The kernel patch is available here
> https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?h=features&id=146448524bddbf6dfc62de31957e428de001cbda
> and will go upstream during the next merge window.
> 
> Note: this obviously also requires to update the gcc 9 version in
> Fedora, so it contains Ilya's patch, to be able to compile the kernel.
> 
> Thanks,
> Heiko
> 

Thanks. I'll keep an eye out for that during the next merge
window.
