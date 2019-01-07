Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BECDC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E28B72183F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="f4d+jL7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfAGXwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 18:52:51 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46747 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbfAGXwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 18:52:50 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so835676pgp.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 15:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7M+J8GEvF1aT9FXcizwG4PtDtQMPDdVwrS/MmWnVUWs=;
        b=f4d+jL7hSQ7oWPBki4k1xxR5UQ8vHZBVczvlTTOCgTj2Brbqc1741bUdmtS/Z/2oWL
         XRr6wBpAs/cZYC2uHSqWKhASUedeENEWX5umDUuYnjMYyOA9QAe2f5qGy/1EQkbxb3V4
         3dJmPSnRIKUaWCEPcvrJLuG3DViRRT/Zn7sat5CdViPul/d1JapTjOxVVwoR/HCjThdg
         fMVlW10ySZ/9pGf/5gkR9QUl6dO9bgmeHs3tCV41RMM1Jg7ty/wgeH6pW2MUjgzq5E5B
         gES0UEnE+f2PLlnM4cRokaLMJLnnBD/0Xyo9fp7uN+7YEOcJ3AQeFd6EU5JX/DA5m4st
         MTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7M+J8GEvF1aT9FXcizwG4PtDtQMPDdVwrS/MmWnVUWs=;
        b=MwtCds3B5gpiiwqYpA1EgwQU9bXf+8xsewXUcASZ34bVUtfYy5tTLxsLyR+MvYKD6d
         UIxz9M1gbKzVm4WtHU5zBwdzJRCVRM6IyPYEVIGXLZsWudS4IJqIlLo/rbSqcT2ShkN4
         JfO+zfJAelOFTNtKLwTVBpjsV+ysaAg7a7RJcHpVFf86J8UGUcfS/vvK5hZ9YtIvz0hU
         nfYG7PF295KqATp1xa/CwK90ryGFinaoKgv+d4UyXgJtLUQvkXL0FSqSKaOBo07yCB98
         S5gEz0Hg0WcpTLHACq6CRufQvKz7QTbzvxEWsnv2tBHPAVTT1og9Kr6+ro+XeQs/brmx
         6fnA==
X-Gm-Message-State: AJcUukfyvMlCTNIx95USL29qdfhrOk7AkQ5xhqViGwVgiykMkeAb+BiF
        t2l8l2x9g8TWnT3UnmZBRKYrR/v7/0o=
X-Google-Smtp-Source: AFSGD/V+5fBL4iDLmTcTAu+zTe/nm3uzra3dEBupQycE+SofglNhiP8aBUKgwBxwzC+OUk/zJlf9NQ==
X-Received: by 2002:a62:13c3:: with SMTP id 64mr64788283pft.93.1546905169161;
        Mon, 07 Jan 2019 15:52:49 -0800 (PST)
Received: from [10.61.2.175] ([122.99.82.10])
        by smtp.gmail.com with ESMTPSA id c23sm89597987pfi.83.2019.01.07.15.52.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 15:52:48 -0800 (PST)
Subject: Re: [PATCH] vfio_pci: Add local source directory as include
To:     Alex Williamson <alex.williamson@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Laura Abbott <labbott@redhat.com>, kvm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190104195714.30045-1-labbott@redhat.com>
 <874lakc09x.fsf@concordia.ellerman.id.au>
 <CAK7LNAQLEYc=czrJvzK8UXeXYm08TuLB62uMN2kFedkcW9b1pw@mail.gmail.com>
 <20190107120716.51d95854.cohuck@redhat.com>
 <CAK7LNAQtsW5KoOQmOB4uSv2zHM80azmHnEMj=2BunikhJQEpig@mail.gmail.com>
 <20190107131341.00581863@x1.home>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
Openpgp: preference=signencrypt
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <4b9b6cf2-d39e-8dd2-9271-158489b03a61@ozlabs.ru>
Date:   Tue, 8 Jan 2019 10:52:43 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190107131341.00581863@x1.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/01/2019 07:13, Alex Williamson wrote:
> On Mon, 7 Jan 2019 20:39:19 +0900
> Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> 
>> On Mon, Jan 7, 2019 at 8:09 PM Cornelia Huck <cohuck@redhat.com> wrote:
>>>
>>> On Mon, 7 Jan 2019 19:12:10 +0900
>>> Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
>>>  
>>>> On Mon, Jan 7, 2019 at 6:18 PM Michael Ellerman <mpe@ellerman.id.au> wrote:  
>>>>>
>>>>> Laura Abbott <labbott@redhat.com> writes:  
>>>>>> Commit 7f92891778df ("vfio_pci: Add NVIDIA GV100GL [Tesla V100 SXM2]
>>>>>> subdriver") introduced a trace.h file in the local directory but
>>>>>> missed adding the local include path, resulting in compilation
>>>>>> failures with tracepoints:
>>>>>>
>>>>>> In file included from drivers/vfio/pci/trace.h:102,
>>>>>>                  from drivers/vfio/pci/vfio_pci_nvlink2.c:29:
>>>>>> ./include/trace/define_trace.h:89:42: fatal error: ./trace.h: No such file or directory
>>>>>>  #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
>>>>>>
>>>>>> Fix this by adjusting the include path.
>>>>>>
>>>>>> Fixes: 7f92891778df ("vfio_pci: Add NVIDIA GV100GL [Tesla V100 SXM2] subdriver")
>>>>>> Signed-off-by: Laura Abbott <labbott@redhat.com>  
>>>
>>> (...)
>>>  
>>>>> Alex I assume you'll merge this fix via the vfio tree?
>>>>>
>>>>> cheers
>>>>>  
>>>>>> diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
>>>>>> index 9662c063a6b1..08d4676a8495 100644
>>>>>> --- a/drivers/vfio/pci/Makefile
>>>>>> +++ b/drivers/vfio/pci/Makefile
>>>>>> @@ -1,3 +1,4 @@
>>>>>> +ccflags-y                               += -I$(src)
>>>>>>
>>>>>>  vfio-pci-y := vfio_pci.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o
>>>>>>  vfio-pci-$(CONFIG_VFIO_PCI_IGD) += vfio_pci_igd.o
>>>>>> --
>>>>>> 2.20.1  
>>>>
>>>>
>>>> Hi.
>>>>
>>>> If I correctly understand the usage of TRACE_INCLUDE_PATH,
>>>> the correct fix should be like follows:
>>>>
>>>>
>>>> diff --git a/drivers/vfio/pci/trace.h b/drivers/vfio/pci/trace.h
>>>> index 228ccdb..4d13e51 100644
>>>> --- a/drivers/vfio/pci/trace.h
>>>> +++ b/drivers/vfio/pci/trace.h
>>>> @@ -94,7 +94,7 @@ TRACE_EVENT(vfio_pci_npu2_mmap,
>>>>  #endif /* _TRACE_VFIO_PCI_H */
>>>>
>>>>  #undef TRACE_INCLUDE_PATH
>>>> -#define TRACE_INCLUDE_PATH .
>>>> +#define TRACE_INCLUDE_PATH ../../drivers/vfio/pci
>>>>  #undef TRACE_INCLUDE_FILE
>>>>  #define TRACE_INCLUDE_FILE trace  
>>>
>>> Going from the comments in samples/trace_events/trace-events-sample.h,
>>> I think both approaches are possible, and I see both used in various
>>> places.
>>>
>>> Personally, I'd prefer Laura's patch, as it doesn't involve hardcoding
>>> a path.
> 
> Numbering options for clarity:
> 
> 1)
>> ccflags-y += -I$(src)
>> would add the header search path for all files in drivers/vfio/pci/
>> whereas only the drivers/vfio/pci/vfio_pci_nvlink2.c needs it.
>>
> 
> 2)
>> CFLAGS_vfio_pci_nvlink2.o += -I$(src)
>> is a bit better.
>> However, it is not obvious why this extra header search path is needed
>> until you find vfio_pci_nvlink2.c including trace.h
>>
> 
> 3)
>> #define TRACE_INCLUDE_PATH ../../drivers/vfio/pci
>> clarifies the intention because the related code is all placed in trace.h
>>
>>
>>
>> From the comment in include/trace/define_trace.h
>> TRACE_INCLUDE_PATH is relative to include/trace/define_trace.h
> 
> In my scan of the tree, the most common solution seems to be 2) as this
> is essentially recommended in the sample file.  3) is well represented,
> with much fewer examples of 1), though it might depend how liberally
> we grep out or examine the use cases.  Choice 1) also seems to be the
> most shotgun approach, adding to the search path for all files.


The shotgun approach is always used when compiling out of tree which is
what many people do anyway without realizing that there are additional
-I. Why do not we make in-tree behave the same way? Thanks,


>  From a
> maintenance perspective I agree that 2) seems more error prone,
> especially when the build system only catches the error on in-tree
> builds, something I rarely do.  Therefore I'm leaning towards option
> 3).  The hardcoded path here doesn't seem much of an issue relative to
> the negatives of the other approaches (how often do we move these
> files?) and it keeps the trace support relatively self-contained.  Are
> there further arguments for or against these options?  Otherwise who
> wants to formally post the TRACE_INCLUDE_PATH version?  Thanks,

-- 
Alexey
