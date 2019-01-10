Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE5DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 04:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 530F021773
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 04:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="HFHUGH2B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfAJEUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 23:20:52 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38583 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfAJEUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 23:20:52 -0500
Received: by mail-qt1-f195.google.com with SMTP id p17so11049076qtl.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 20:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=euwfbUi1+DZNCNvyYFGLfj3vzX8TKIN0HdwO02YbTp0=;
        b=HFHUGH2BZEsbBV6cYvax2ofYe4aCylB2ll0jZg11JnAnivLosq8bd1TK+8MrLCiSic
         nCt4LI1Wyeyf4b4AtLSp0luqYG6sT65sbO0/77vgIuQ4ck05OGqyxIoJYGP7pmtJ1SH0
         0+KDkN75UkgAASUKIyTxVZt/QmzzwhSE/177wgTxOg6seX4dbLVkd1Ku2VEog2QM2pfu
         7H9ADpAtgXHfj7hVbK31QphMfFN1OTELIWP1XyZR3C1tvTv6FwFn0L8RKWrARXlEmXDY
         4QggEQqXgW73vsTJPrW2H6a+nGd22lPDV2dh4eU4ugamgQg/sLjuROa2Q9gbVioWo7Z+
         qdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=euwfbUi1+DZNCNvyYFGLfj3vzX8TKIN0HdwO02YbTp0=;
        b=fedvrT7RkVo/xAXx7Kbw3SrfW4+yaE+crpot1Fkj3A+S1COiI2DMLClKrc/Z84FHri
         a6B9zWJXL4InpOWjHkntgMfAZ2HtNLIcsTqldn95ReiVS/dEg4veAu0AhrxL2cVH24C5
         r7dCmQXNFIXMnGmNwVNXdip6yc1lAz1AamMtBXvvutbbPoVU4kBxoPdXwonyTcUwo/+y
         SB+feN9Zygc8La/+eqPQR4Rxg6M38M05B9VBCBnRlAv8P9UmD3zXcpP6IfRRZKHfwD3d
         0gmjCUpsN21wigq2g9ZAMfk+G8I4vkVHwLDwvbsbHxTBjIUsqP9uVeWoM8Z5NbvVGnBy
         WoJQ==
X-Gm-Message-State: AJcUukcIl4syF2iyDiKxZfZCtKt5oEaB1XeZhfeDe9AxdpehqjWbOVa4
        Q38/B+DIc0a52ghClY6SkfSvKAEQXqHZyw==
X-Google-Smtp-Source: ALg8bN5C6fsA6T9rze2VS6nNmrbrfxjOPsSTU5T/kkzxLiknK0YWU0hpRPM0in7Crsck4VoXwv/Taw==
X-Received: by 2002:a0c:fa46:: with SMTP id k6mr8189255qvo.36.1547094050904;
        Wed, 09 Jan 2019 20:20:50 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id s24sm16027146qkl.48.2019.01.09.20.20.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 20:20:50 -0800 (PST)
Subject: Re: [RESEND PATCH] x86_64: increase stack size for KASAN_EXTRA
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20181228020639.80425-1-cai@lca.pw>
 <20190109215209.2903-1-cai@lca.pw>
 <20190109140201.4434ff87880ee29bdedb37cc@linux-foundation.org>
From:   Qian Cai <cai@lca.pw>
Message-ID: <291d9d64-9eb7-517e-9ae7-30e8cc3f672a@lca.pw>
Date:   Wed, 9 Jan 2019 23:20:49 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190109140201.4434ff87880ee29bdedb37cc@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/9/19 5:02 PM, Andrew Morton wrote:
>> --- a/arch/x86/include/asm/page_64_types.h
>> +++ b/arch/x86/include/asm/page_64_types.h
>> @@ -7,7 +7,11 @@
>>  #endif
>>  
>>  #ifdef CONFIG_KASAN
>> +#ifdef CONFIG_KASAN_EXTRA
>> +#define KASAN_STACK_ORDER 2
>> +#else
>>  #define KASAN_STACK_ORDER 1
>> +#endif
>>  #else
>>  #define KASAN_STACK_ORDER 0
>>  #endif
> 
> I'm suspecting this logic could be performed in Kconfig, for all
> architectures.  Add a new always-defined CONFIG_KASAN_STACK_ORDER?
> 

Sounds doable, but KASAN only support x86_64, arm64, s390 and xtensa so far. I
am not sure I care about the later two nor I have any way to test them if they
suffer the same problem.

I'll keep looking if more arches start to implement KASAN, and then might be a
good time to reduce all those code duplication.
