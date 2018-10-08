Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A002AC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DFB120841
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfouDHZI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DFB120841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbeJHVWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 17:22:36 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44867 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbeJHVWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 17:22:35 -0400
Received: by mail-pf1-f193.google.com with SMTP id r9-v6so8280857pff.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 07:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ulzkMJCJsILoTluYkIWiWRjJ6mhH68q5GY+RdXtVPNo=;
        b=bfouDHZIvcNEA0SPq+Qa0r5k5szyo9QmGMoEHk+qiaRBm7OQ8gt4thFh0i7rPSNkoI
         N1ABYV6/EMvzT6ThTyYhc9uuT7YAX2T5Xv0rkJOJ0otByrrS8f6n04pg96OKQ21XkoIJ
         fECmwq5FVMsvvHRcN819m4KnSjNIdumkNow7Mj4XA3Z75jqDtB/XJD4r15Fh9JiTt2kJ
         eVDQoBmtjok0yBhslyQrVGl32BaSqTqXO5L8z0oS5hcWm4tm5hSuEJwWLcRpcCzMHPI6
         BJNWG9tn5tFCb2G5WAmpQ3tU50P/+CY643nsHpxJ7SzbEtR6zX5yQ/5P/ZRjJO04M/nx
         PAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ulzkMJCJsILoTluYkIWiWRjJ6mhH68q5GY+RdXtVPNo=;
        b=Yb3+yQVHVEP2HrVBT5mrgqRIZYfJBV+JMEQK2OepohXV8Jh84S6M3FVm4znqfqjOxx
         CqmO4WsQo5OacHxYH9EWISUAg7Ag9EVoXbWkKksmhJu76eHtj/uK6xhiUj+zvF38+qZL
         T/xmRz8pOgukh2Mq6YtYt6GSBop3aGuP1UWvnaSHz2i8i2lRg411RgJfWBBcKi0ZjJr+
         Yj9F9HwzvzyQ8kqEc5xJwFyWVwUFnplc/stZbIIb2m0ln4fJMCDV44nVpdUCQRX48sVi
         GJ+eHViHacbfcPqpWgqIe87QcWnTxx9BFi0uzH7baJbEk9RwNdhXEl1yjIeejUKj76iS
         +/1g==
X-Gm-Message-State: ABuFfoi26+XD4Sp/hP0KKa0vaQDgeIV5kPQRl5FipmHLK4Pn0tziHCXR
        7/ZGNRX5yHb4fKa6peD5Pbc=
X-Google-Smtp-Source: ACcGV61M+nCuPJ0/6ma8tlxmK0u8/gldRdgnOYvjbOuGDgMWnopRCtd2+ONzvRzPt1SMVPx2UFXjzw==
X-Received: by 2002:a63:84c1:: with SMTP id k184-v6mr11748437pgd.196.1539007840385;
        Mon, 08 Oct 2018 07:10:40 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id u124-v6sm36020227pgc.0.2018.10.08.07.10.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 07:10:39 -0700 (PDT)
Subject: Re: [PATCH] amdgpu/gmc : fix compile warning
To:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        Peng Hao <peng.hao2@zte.com.cn>
Cc:     "airlied@linux.ie" <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <1536919552-116245-1-git-send-email-peng.hao2@zte.com.cn>
 <20181004185237.GA20667@roeck-us.net>
 <022e41c0-8465-dc7a-a45c-64187ecd9684@amd.com>
 <4772f72c-6018-3556-6324-5f49faa00073@roeck-us.net>
 <4da23fcb-4a94-2695-ad80-929025e84bd2@gmail.com>
 <c72a23ea-efea-4c0e-d397-623d6ac16ebb@roeck-us.net>
 <c43669b7-1074-714c-fb22-81685826b3ad@amd.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <74078dc6-ef08-586b-fd58-51eb2c0b5060@roeck-us.net>
Date:   Mon, 8 Oct 2018 07:10:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c43669b7-1074-714c-fb22-81685826b3ad@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2018 06:47 AM, Koenig, Christian wrote:
> Am 08.10.2018 um 15:33 schrieb Guenter Roeck:
>> On 10/08/2018 01:00 AM, Christian König wrote:
>>> Am 05.10.2018 um 10:38 schrieb Guenter Roeck:
>>>> On 10/05/2018 01:14 AM, Koenig, Christian wrote:
>>>>> Am 04.10.2018 um 20:52 schrieb Guenter Roeck:
>>>>>> Hi,
>>>>>>
>>>>>> On Fri, Sep 14, 2018 at 06:05:52PM +0800, Peng Hao wrote:
>>>>>>> drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:
>>>>>>>        In function ‘gmc_v8_0_process_interrupt’:
>>>>>>> drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:1447:10:
>>>>>>>        warning: missing braces around initializer [-Wmissing-braces]
>>>>>>>
>>>>>>> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
>>>>>> Was there any feedback on this patch ? The problem does affect us,
>>>>>> and we'll need a fix.
>>>>>
>>>>> Well as discussed using "{ { 0 } }" is as wrong as using "{ 0 }".
>>>>>
>>>>
>>>> Ah, sorry, I must have missed the discussion.
>>>>
>>>> It is for sure not the best solution, but at least it compiles, and
>>>> it seems
>>>> to be proliferating.
>>>
>>> Yeah, and exactly that's the problem. As the discussion showed "{ { 0
>>> } }" is buggy because it tells the compiler to only initialize the
>>> first member of the structure, but not all of it.
>>>
>>> That is incorrect and rather dangerous cause it can lead to
>>> unforeseen results and should probably trigger a warning.
>>>
>>>>
>>>> $ git grep "{ *{ *0 *} *}" | wc
>>>>      144    1180   11802
>>>> $ git grep "{ *{ *0 *} *}" drivers/gpu/drm/amd/ | wc
>>>>       50     459    5239
>>>>
>>>>> We should either use only "{ }" or even better make nails with
>>>>> heads and
>>>>> use memset().
>>>>
>>>> I'd rather leave it up to the compiler to decide what is most
>>>> efficient.
>>>
>>> And I would rather prefer to have a working driver :)
>>>
>>
>> So { } isn't correct either ?
> 
> Yes, initializing structures with { } is known to be problematic as well.
> 
> It doesn't necessary initialize all bytes when you have padding causing
> random failures when structures are memcmp().
> 
>>
>> One thing I found missing in the discussion was the reference to the C
>> standard.
>> The C99 standard states in section 6.7.8 (Initialization) clause 19:
>> "... all
>> subobjects that are not initialized explicitly shall be initialized
>> implicitly
>> the same as objects that have static storage duration". Clause 21
>> makes further
>> reference to partial initialization, suggesting the same. Various online
>> resources, including the gcc documentation, all state the same. I
>> don't find
>> any reference to a partial initialization which would leave members of
>> a structure
>> undefined. It would be interesting for me to understand how and why
>> this does
>> not apply here.
>>
>> In this context, it is interesting that the other 48 instances of the
>> { { 0 } } initialization in the same driver don't raise similar concerns,
>> nor seemed to have caused any operational problems.
> 
> Feel free to provide patches to replace those with memset().
> 

Not me. As I see it, the problem, if it exists, would be a violation of the
C standard. I don't believe hacking around bad C compilers. I would rather
blacklist such compilers.

>>
>> Anyway, I fixed up the code in our tree (with { }), so I'll leave it
>> up to you folks to decide what if anything to do about it.
> 
> Well considering the known problems with {} initialization I'm certainly
> rejecting all patches which turns memset() into {}.
> 

Please point me to specific instances of this problem.

Thanks,
Guenter
