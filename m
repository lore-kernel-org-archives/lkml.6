Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD5EC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 22:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADB51206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 22:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbfABWbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 17:31:11 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40425 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfABWbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 17:31:11 -0500
Received: by mail-qk1-f193.google.com with SMTP id y16so18724958qki.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 14:31:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3B7HDnSwm2VRIrSZrUeHQUVz6hdh1IAvnt5peV3ONbs=;
        b=bVsny4fwW9FbuSjmw7Lq3tLJNF5Ssm9bsZjE78ukx6o9ZKn326iEjnMcQVK1+OdO6Q
         zJwDg2TQ/Y+x8iZkTLJ99n6xD/Ox38odHoaMhlyOizfdG5Wtsn2/OxZXeR2xEcd5SJ0u
         hPIcACrq+XtLlOLRX/yU7K78lMROaIaMbIv9gOHxEaGjzfVipShNiYjKup+SVjMPoR4R
         gQ9c5nnE0tX0p4m017m6DxiXTGmAAKyo5OS6crVJREiCSKUtJh256u7qTTjjCJSnm3ra
         nnyELIiCYEnS6p5lU/SI6cueTGcnfcSdapnZ+tCbZW30o/hdRiyaUvkrPRfXLiim6jZB
         I7Rw==
X-Gm-Message-State: AJcUukehiRQLRZtGgW2Cw9ZLIU4UNojI9mMWrcN0eXBVeuX2uuJJKV/A
        d4cvQ95zhxgIuvJSn94R/6SVxQWzaRc=
X-Google-Smtp-Source: ALg8bN7aoRqe1000H6AXkZjhfUIufqsxeZ4tXoRio7O5V/CT9Ztq4nXtnlmOBMVt7MRKR0KL3Xp+/w==
X-Received: by 2002:a37:15c5:: with SMTP id 66mr42196959qkv.16.1546468269867;
        Wed, 02 Jan 2019 14:31:09 -0800 (PST)
Received: from ?IPv6:2601:602:9800:dae6::814b? ([2601:602:9800:dae6::814b])
        by smtp.gmail.com with ESMTPSA id p42sm26487911qte.8.2019.01.02.14.31.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 14:31:08 -0800 (PST)
Subject: Re: [PATCH] staging: android: ion: add buffer flag update ioctl
To:     "Zengtao (B)" <prime.zeng@hisilicon.com>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1545239943-15414-1-git-send-email-prime.zeng@hisilicon.com>
 <b0cc8d05-b313-9433-4e48-d0d39aa1858b@redhat.com>
 <678F3D1BB717D949B966B68EAEB446ED24E2926A@dggemm526-mbx.china.huawei.com>
 <786ad55f-4651-56ce-cd5c-ca02f7ac4093@redhat.com>
 <678F3D1BB717D949B966B68EAEB446ED24E2B495@dggemm526-mbx.china.huawei.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <58278bab-413c-ef5e-3074-5afbcc1b86de@redhat.com>
Date:   Wed, 2 Jan 2019 14:31:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <678F3D1BB717D949B966B68EAEB446ED24E2B495@dggemm526-mbx.china.huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/23/18 6:47 PM, Zengtao (B) wrote:
> Hi laura:
> 
>> -----Original Message-----
>> From: Laura Abbott [mailto:labbott@redhat.com]
>> Sent: Friday, December 21, 2018 4:50 AM
>> To: Zengtao (B) <prime.zeng@hisilicon.com>; sumit.semwal@linaro.org
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Arve Hjønnevåg
>> <arve@android.com>; Todd Kjos <tkjos@android.com>; Martijn Coenen
>> <maco@android.com>; Joel Fernandes <joel@joelfernandes.org>;
>> devel@driverdev.osuosl.org; dri-devel@lists.freedesktop.org;
>> linaro-mm-sig@lists.linaro.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH] staging: android: ion: add buffer flag update ioctl
>>
>> On 12/19/18 5:39 PM, Zengtao (B) wrote:
>>> Hi laura:
>>>
>>>> -----Original Message-----
>>>> From: Laura Abbott [mailto:labbott@redhat.com]
>>>> Sent: Thursday, December 20, 2018 2:10 AM
>>>> To: Zengtao (B) <prime.zeng@hisilicon.com>;
>> sumit.semwal@linaro.org
>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Arve
>> Hjønnevåg
>>>> <arve@android.com>; Todd Kjos <tkjos@android.com>; Martijn
>> Coenen
>>>> <maco@android.com>; Joel Fernandes <joel@joelfernandes.org>;
>>>> devel@driverdev.osuosl.org; dri-devel@lists.freedesktop.org;
>>>> linaro-mm-sig@lists.linaro.org; linux-kernel@vger.kernel.org
>>>> Subject: Re: [PATCH] staging: android: ion: add buffer flag update
>>>> ioctl
>>>>
>>>> On 12/19/18 9:19 AM, Zeng Tao wrote:
>>>>> In some usecases, the buffer cached attribute is not determined at
>>>>> allocation time, it's determined just before the real cpu mapping.
>>>>> And from the memory view of point, a buffer should not have the
>>>> cached
>>>>> attribute util is really mapped by the cpu. So in this patch, we
>>>>> introduced the new ioctl command to target the requirement.
>>>>>
>>>>
>>>> This is racy and error prone. Can you explain more what problem you
>>>> are trying to solve?
>>>
>>> My use case is like this:
>>> 1.  There are two process A and B, A takes case of ion buffer allocation,
>> and
>>>    pass the buffer fd to B, then B maps and uses it.
>>> 2.  Process B need to map the buffer with different cached attribute
>>> for different use case, for example, if the buffer is used for pure
>>> software algorithm, then we need to map it as cached, otherwise
>>> non-cached, and B needs to deal with both cases.
>>> And unfortunately the mmap syscall takes no cached flags and we can't
>>> decide the cache attribute when we are doing the mmap, so I introduce
>>> new the ioctl even though I think the solution is not as good.
>>>
>>>
>>
>> Thanks for the explanation, this was about the use case I expected.
>> I'm pretty sure I had this exact problem once upon a time and we didn't
>> come up with a solution. I'd still like to get rid of uncached buffers in
>> general and just use cached buffers (see
>> http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-N
>> ovember/128842.html)
>> What's your usecase for uncached buffers?
> 
> Some buffers are only used by HW, in this case, we tend to use uncached buffers.
> But sometimes the SW need to read few buffer contents for debug purpose and
> no synchronization is needed.
> 

If this is primarily for debug, that's not really a compelling reason to
support uncached buffers. It's incredibly difficult to do uncached
buffers correctly I'd rather spend effort on making the cached
use cases work better.

Thanks,
Laura

>>
>>>>
>>>>> Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>
>>>>> ---
>>>>>     drivers/staging/android/ion/ion-ioctl.c |  4 ++++
>>>>>     drivers/staging/android/ion/ion.c       | 17
>> +++++++++++++++++
>>>>>     drivers/staging/android/ion/ion.h       |  1 +
>>>>>     drivers/staging/android/uapi/ion.h      | 22
>>>> ++++++++++++++++++++++
>>>>>     4 files changed, 44 insertions(+)
>>>>>
>>>>> diff --git a/drivers/staging/android/ion/ion-ioctl.c
>>>>> b/drivers/staging/android/ion/ion-ioctl.c
>>>>> index a8d3cc4..60bb702 100644
>>>>> --- a/drivers/staging/android/ion/ion-ioctl.c
>>>>> +++ b/drivers/staging/android/ion/ion-ioctl.c
>>>>> @@ -12,6 +12,7 @@
>>>>>
>>>>>     union ion_ioctl_arg {
>>>>>     	struct ion_allocation_data allocation;
>>>>> +	struct ion_buffer_flag_data update;
>>>>>     	struct ion_heap_query query;
>>>>>     };
>>>>>
>>>>> @@ -83,6 +84,9 @@ long ion_ioctl(struct file *filp, unsigned int
>>>>> cmd, unsigned long arg)
>>>>>
>>>>>     		break;
>>>>>     	}
>>>>> +	case ION_IOC_BUFFER_UPDATE:
>>>>> +		ret = ion_buffer_update(data.update.fd, data.update.flags);
>>>>> +		break;
>>>>>     	case ION_IOC_HEAP_QUERY:
>>>>>     		ret = ion_query_heaps(&data.query);
>>>>>     		break;
>>>>> diff --git a/drivers/staging/android/ion/ion.c
>>>>> b/drivers/staging/android/ion/ion.c
>>>>> index 9907332..f1404dc 100644
>>>>> --- a/drivers/staging/android/ion/ion.c
>>>>> +++ b/drivers/staging/android/ion/ion.c
>>>>> @@ -436,6 +436,23 @@ int ion_alloc(size_t len, unsigned int
>>>> heap_id_mask, unsigned int flags)
>>>>>     	return fd;
>>>>>     }
>>>>>
>>>>> +int ion_buffer_update(unsigned int fd, unsigned int flags) {
>>>>> +	struct dma_buf *dmabuf;
>>>>> +	struct ion_buffer *buffer;
>>>>> +
>>>>> +	dmabuf = dma_buf_get(fd);
>>>>> +
>>>>> +	if (!dmabuf)
>>>>> +		return -EINVAL;
>>>>> +
>>>>> +	buffer = dmabuf->priv;
>>>>> +	buffer->flags = flags;
>>>>> +	dma_buf_put(dmabuf);
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>>     int ion_query_heaps(struct ion_heap_query *query)
>>>>>     {
>>>>>     	struct ion_device *dev = internal_dev; diff --git
>>>>> a/drivers/staging/android/ion/ion.h
>>>>> b/drivers/staging/android/ion/ion.h
>>>>> index c006fc1..99bf9ab 100644
>>>>> --- a/drivers/staging/android/ion/ion.h
>>>>> +++ b/drivers/staging/android/ion/ion.h
>>>>> @@ -199,6 +199,7 @@ int ion_heap_pages_zero(struct page *page,
>>>> size_t size, pgprot_t pgprot);
>>>>>     int ion_alloc(size_t len,
>>>>>     	      unsigned int heap_id_mask,
>>>>>     	      unsigned int flags);
>>>>> +int ion_buffer_update(unsigned int fd, unsigned int flags);
>>>>>
>>>>>     /**
>>>>>      * ion_heap_init_shrinker
>>>>> diff --git a/drivers/staging/android/uapi/ion.h
>>>>> b/drivers/staging/android/uapi/ion.h
>>>>> index 5d70098..99753fc 100644
>>>>> --- a/drivers/staging/android/uapi/ion.h
>>>>> +++ b/drivers/staging/android/uapi/ion.h
>>>>> @@ -74,6 +74,20 @@ struct ion_allocation_data {
>>>>>     	__u32 unused;
>>>>>     };
>>>>>
>>>>> +/**
>>>>> + * struct ion_buffer_flag_data - metadata passed from userspace for
>>>>> +update
>>>>> + * buffer flags
>>>>> + * @fd:			file descriptor of the buffer
>>>>> + * @flags:		flags passed to the buffer
>>>>> + *
>>>>> + * Provided by userspace as an argument to the ioctl  */
>>>>> +
>>>>> +struct ion_buffer_flag_data {
>>>>> +	__u32 fd;
>>>>> +	__u32 flags;
>>>>> +}
>>>>> +
>>>>>     #define MAX_HEAP_NAME			32
>>>>>
>>>>>     /**
>>>>> @@ -116,6 +130,14 @@ struct ion_heap_query {
>>>>>     				      struct ion_allocation_data)
>>>>>
>>>>>     /**
>>>>> + * DOC: ION_IOC_BUFFER_UPDATE - update the specified ion buffer
>>>> flags
>>>>> + *
>>>>> + * Takes an ion_buffer_flag_data structure and returns the result
>>>>> +of the
>>>>> + * buffer flag update operation.
>>>>> + */
>>>>> +#define ION_IOC_BUFFER_UPDATE	_IOWR(ION_IOC_MAGIC, 1, \
>>>>> +				      struct ion_buffer_flag_data)
>>>>> +/**
>>>>>      * DOC: ION_IOC_HEAP_QUERY - information about available
>> heaps
>>>>>      *
>>>>>      * Takes an ion_heap_query structure and populates information
>>>> about
>>>>>
>>>
> 

