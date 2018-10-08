Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7858BC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1334F20841
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJ/2aTJT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1334F20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbeJHUot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:44:49 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41438 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeJHUot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:44:49 -0400
Received: by mail-pg1-f194.google.com with SMTP id 23-v6so7834403pgc.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 06:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VtEHbccDRCRrqQWJs3dAnp6MFzQy/P0pI8rQ2g044NY=;
        b=CJ/2aTJTfTkQF6+ylziQMQvQphQuU4FfimGnGoJTtKUI/MTkW3RiGi1nsNedBGs426
         Xcw5b1R0TZ8uWFFhzrPUDq9cPcclLEg3gMmOiyCyldKVChpFDxxpLMaVXylVzhji2fb9
         8v6+OIVBQLrDeLHX7TNEzX1ykcIVqZUzk4WyUZr1salPkIorv+58Dpjp1B1V+NdALfB4
         soPnsAIKCit2b21YaqARes8nUl5Swo8qAuIv/PJnEB2qcF/taDYUYNzDNsCCzeARmE+2
         eSOCH8bsC8QCFe1yFFCPRZrUOB04K5G4g3sq7p4k+zMPyOUQfrODw9cLjYPFR0cQHRFM
         W1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VtEHbccDRCRrqQWJs3dAnp6MFzQy/P0pI8rQ2g044NY=;
        b=bieBPAUb6CPCmG5RLC/Ns6Np+e/eivc6wnN8EQIH2DYxgtuL65f4ENA0hAFoKZo1yx
         VeV8XvysxkA6jbFsMy9JpfPSDBohZbrtpiXL9q48H1H5Vu0Rw0pQS2GLY0BQAgoEXRJW
         32aXBgPxgOZKxtpccOsBoIC856c9+Xaxc8+7ic9d6IZEK8j5O5WO6OylH6UHV72bER7s
         XY/wdXg8w9CUsBysnlA0pYp6EPTxJHWQAdPAiJuWZOsqSDHvep8DUAwPlZSLoB3Bvm97
         e6Z8+0oHT6MpekJ0JzZOnceUVNoB/4gY37mWfT+uAB3v5aXGMdOVN4R/V/FkMvf2dzaN
         qbYw==
X-Gm-Message-State: ABuFfohh2jBm6lZNh3q8Rxw6F2UxRMegRF6FUfJVG4aClRLXXrd+X7bU
        KanzHnUAc/6Bzesy8wgrg6qdEeeH
X-Google-Smtp-Source: ACcGV62w0Nb1/6demP6+RqBlqAIMZiPuapUrkTj5PuTyrKyGsALTGcmC4zcznQYMB6gtYprxouC3dg==
X-Received: by 2002:a63:1411:: with SMTP id u17-v6mr20869404pgl.247.1539005583642;
        Mon, 08 Oct 2018 06:33:03 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id h14-v6sm19345585pfn.80.2018.10.08.06.33.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 06:33:02 -0700 (PDT)
Subject: Re: [PATCH] amdgpu/gmc : fix compile warning
To:     christian.koenig@amd.com, Peng Hao <peng.hao2@zte.com.cn>
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
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <c72a23ea-efea-4c0e-d397-623d6ac16ebb@roeck-us.net>
Date:   Mon, 8 Oct 2018 06:33:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <4da23fcb-4a94-2695-ad80-929025e84bd2@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2018 01:00 AM, Christian König wrote:
> Am 05.10.2018 um 10:38 schrieb Guenter Roeck:
>> On 10/05/2018 01:14 AM, Koenig, Christian wrote:
>>> Am 04.10.2018 um 20:52 schrieb Guenter Roeck:
>>>> Hi,
>>>>
>>>> On Fri, Sep 14, 2018 at 06:05:52PM +0800, Peng Hao wrote:
>>>>> drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:
>>>>>       In function ‘gmc_v8_0_process_interrupt’:
>>>>> drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:1447:10:
>>>>>       warning: missing braces around initializer [-Wmissing-braces]
>>>>>
>>>>> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
>>>> Was there any feedback on this patch ? The problem does affect us,
>>>> and we'll need a fix.
>>>
>>> Well as discussed using "{ { 0 } }" is as wrong as using "{ 0 }".
>>>
>>
>> Ah, sorry, I must have missed the discussion.
>>
>> It is for sure not the best solution, but at least it compiles, and it seems
>> to be proliferating.
> 
> Yeah, and exactly that's the problem. As the discussion showed "{ { 0 } }" is buggy because it tells the compiler to only initialize the first member of the structure, but not all of it.
> 
> That is incorrect and rather dangerous cause it can lead to unforeseen results and should probably trigger a warning.
> 
>>
>> $ git grep "{ *{ *0 *} *}" | wc
>>     144    1180   11802
>> $ git grep "{ *{ *0 *} *}" drivers/gpu/drm/amd/ | wc
>>      50     459    5239
>>
>>> We should either use only "{ }" or even better make nails with heads and
>>> use memset().
>>
>> I'd rather leave it up to the compiler to decide what is most efficient.
> 
> And I would rather prefer to have a working driver :)
> 

So { } isn't correct either ?

One thing I found missing in the discussion was the reference to the C standard.
The C99 standard states in section 6.7.8 (Initialization) clause 19: "... all
subobjects that are not initialized explicitly shall be initialized implicitly
the same as objects that have static storage duration". Clause 21 makes further
reference to partial initialization, suggesting the same. Various online
resources, including the gcc documentation, all state the same. I don't find
any reference to a partial initialization which would leave members of a structure
undefined. It would be interesting for me to understand how and why this does
not apply here.

In this context, it is interesting that the other 48 instances of the
{ { 0 } } initialization in the same driver don't raise similar concerns,
nor seemed to have caused any operational problems.

Anyway, I fixed up the code in our tree (with { }), so I'll leave it
up to you folks to decide what if anything to do about it.

Thanks,
Guenter
