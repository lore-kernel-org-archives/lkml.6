Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830C4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ABD62245E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TVMd0Ww2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ABD62245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729797AbeKMC3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 21:29:43 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43821 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728199AbeKMC3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 21:29:43 -0500
Received: by mail-qk1-f193.google.com with SMTP id r71so14325452qkr.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 08:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:subject:to:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hYoQ2lSz8fR+42O1RqBQGgPomQdWTJswscGMlmCpSmc=;
        b=TVMd0Ww2KN41eqdIa3Wj5qeV6AfyGKFVGsFsTxhOn992sPfrm1EAxFiKq+BITf0F5Z
         JPOIkdh9aGXjR5JB5zX/3H2c7PHtfxSUMLD1JdcHVD76vTmi26XwhOOqbmqbj59Tj8yQ
         IsmPcKYhjiHvwOYKejLEzqYf69BKhhM8cBp28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=hYoQ2lSz8fR+42O1RqBQGgPomQdWTJswscGMlmCpSmc=;
        b=dtTeGgB0lwy0oRKegWMDayqYZ/SiRI0OzJZIG6AYoRakzHFp9G+/RvctJUt9JK/Czk
         aSZoxcaaa0vUIpIRq3O47jdEYlTvPmsKn7T6LCGArwyGAtemjuAxizdO77Y0NB3w3ZEP
         ykkYL3OCEXajrAtLAKSoncE0lpz7Brk4cDfaF3ofC1THoJT2YoakxUcQ/sqo/14rVVov
         Wat4BhH1DpgtDi4uTX3X5xDfgu8u36J1aHXZsI/1PLuIjgiIC0MQtndADWUs0CiBidKS
         J9RajFHYgWxCYTjyPgqvUzhmxZsang9GVFfU7qLCif9S3VKFo2r9x0+5WdBbIFwzYy6H
         Tkqg==
X-Gm-Message-State: AGRZ1gIJr0oGlEkj7N2FhCtomTmq48qZ/4UK06eNJJubTrPViLeYPS4v
        ehC5zAnPBwA30w37LTb5TOXURA==
X-Google-Smtp-Source: AJdET5f3L8FOrkzZk+RBBv6rjhZmH+45CrKAZ6PPWenZdoFroUCug40CikdSL/x1FBFD3GT+dEW/uA==
X-Received: by 2002:a37:2bcf:: with SMTP id r76mr1520422qkr.218.1542040543181;
        Mon, 12 Nov 2018 08:35:43 -0800 (PST)
Received: from [192.168.48.13] ([168.181.50.245])
        by smtp.gmail.com with ESMTPSA id 86sm727115qky.92.2018.11.12.08.35.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 08:35:42 -0800 (PST)
Cc:     rafael.tinoco@linaro.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: Re: [PATCH] proc: fixup map_files test on arm
To:     Cyrill Gorcunov <gorcunov@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>
References: <20181110184920.GA18252@avx2>
 <1541904527.857883.1572718104.2AE8D0DA@webmail.messagingengine.com>
 <20181112141456.GA15690@avx2> <20181112155559.GV13195@uranus.lan>
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
Organization: Linaro
Message-ID: <f1805813-62b7-8572-d906-bc49b62d1bf3@linaro.org>
Date:   Mon, 12 Nov 2018 14:35:39 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181112155559.GV13195@uranus.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/18 1:55 PM, Cyrill Gorcunov wrote:
> On Mon, Nov 12, 2018 at 05:14:57PM +0300, Alexey Dobriyan wrote:
> ...
>>>>   int main(void)
>>>>   {
>>>>   	const unsigned int PAGE_SIZE = sysconf(_SC_PAGESIZE);
>>>> +#ifdef __arm__
>>>> +	unsigned long va = 2 * PAGE_SIZE;
>>>> +#else
>>>> +	unsigned long va = 0;
>>>> +#endif
> ...
>>>
>>> I have sent a patch removing proc-self-map-files-002 AND making 001 to use as a
>>> HINT for mmap (MAP_FIXED) *at least*  *(2 * PAGE_SIZE), which would, likely,
>>> attend all  architectures, avoiding trying to make the test specific to one,
>>> and, still, test the symlinks for issues (like bad chars, spaces, so on).
>>
>> If the goal is to test the lowest address then going for 2*PAGE_SIZE is
>> a mistake.
>>
>> Which BTW hints to add a test for the highest address.
>>
>>> Both tests (001 and 002) have pretty much the same code, while they could have 2
>>> tests in a single code, using kselftest framework. Is NULL hint + MAP_FIXED
>>> something imperative for this test ? Why not to have all in a single test ?
>>
>> I dislike tests which lump everything together into one process.
>>
>>> Are you keeping the NULL hint just to test mmap, apart" from the core of
>>> this test ?
> 
> Guys, lets simply stick with Alexey's patch. I personnally think that
> testing mappings should be a separate test in vm/, but seriously this
> took too long already :) If Alexey's patch fixes the problem with arm
> I think we're fine.
> 

Fine for me. It works in armhf.

Tested-by: Rafael David Tinoco <rafael.tinoco@linaro.org>

Note: Maybe you should amend the patch and cast "va" in mmap() to avoid:

In file included from proc-self-map-files-002.c:7:
/usr/include/arm-linux-gnueabihf/sys/mman.h:57:14: note: expected ‘void 
*’ but argument is of type ‘long unsigned int’
  extern void *mmap (void *__addr, size_t __len, int __prot,

--
Rafael D. Tinoco
Linaro Kernel Validation
