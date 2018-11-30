Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50179C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CF952147D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jjtLYjWS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF952147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbeLADNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 22:13:14 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36883 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbeLADNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 22:13:14 -0500
Received: by mail-wr1-f68.google.com with SMTP id j10so5786805wru.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 08:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e0yU3aF3N5EoBQB8hOIFIONtlSEFhDfgKSrxkNHR24k=;
        b=jjtLYjWSTx2gDwG+i3D1OKa0cYoJts6t/hwfl/b3b9uaG+OBnAmE23SALBV7MzkM3R
         QZAsD6ZZKMAfdkdBAIefLPmegcSat9FBDi//eURGPx5HK+NK0kVysNuDIs2co1sE5YsS
         3Ssl1RTJwt8yWf3x4z6Pqw38nyXWelHM/lwdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e0yU3aF3N5EoBQB8hOIFIONtlSEFhDfgKSrxkNHR24k=;
        b=a6FMljDK2yPc0zyrkrp47ZgfxnUWmGFPJoF/TdEgo0z5BmIfGcK+bWzbfC6H4u6wM5
         6MPR/EohhJysu3vo8gnN27/tf4/AgMuQnfGD8s9oue3L92WXkew43mJAM1PGC6tL11/C
         X6TAKRy7Mydx5ix9IIwcLkIv7ePPg6jSSGC3CrUiTTKQYov0ZzsYp1r8CMpKl0m3hAk2
         W9JnTo4V6fEa66Gc5gcRpztb8A9RYufljF34OFOAplyELck3cuDpOR9G8tbWbapvtCm9
         VbRVsv5xZeuAznm7AuB6AkgxzXzUKdfqPQePNiGpGEfGJf4bezWtOE/gmdzs1Yri2qgi
         TaBA==
X-Gm-Message-State: AA+aEWY43SQV73U/sWggbsU9lcT8Ku+CrHw8/uOOX4+ypEerdy+GW1hv
        n6VFSGdRtln2NFtV6uzwwIt8xw==
X-Google-Smtp-Source: AFSGD/Url35w2pPkx2dHh7TkhZGrgocplNH8DySZcG8QOoJ4aNdnoIGGEvCQ79qLD81kHlAbRl17fw==
X-Received: by 2002:adf:8b83:: with SMTP id o3mr5718427wra.81.1543593804462;
        Fri, 30 Nov 2018 08:03:24 -0800 (PST)
Received: from [192.168.86.29] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id 125sm7317048wml.35.2018.11.30.08.03.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 08:03:23 -0800 (PST)
Subject: Re: [RFC PATCH 3/6] char: fastrpc: Add support for context Invoke
 method
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, bkumar@qti.qualcomm.com,
        thierry.escande@linaro.org
References: <20181130104657.14875-1-srinivas.kandagatla@linaro.org>
 <20181130104657.14875-4-srinivas.kandagatla@linaro.org>
 <CAK8P3a1mFWJyXCn74_Yd_y3Df0JN=qM4nw4-2t_LjRO7yXmXBw@mail.gmail.com>
 <3c177508-cf6f-1f8d-a324-5bec40fd9a9c@linaro.org>
 <CAK8P3a0d=VRP+9vZm+eJeJM933PWYL4sruMAYBYzWjg5B_kL2g@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <633cb111-f5d7-3648-54af-a476f3cbb279@linaro.org>
Date:   Fri, 30 Nov 2018 16:03:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0d=VRP+9vZm+eJeJM933PWYL4sruMAYBYzWjg5B_kL2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/11/18 15:08, Arnd Bergmann wrote:
> On Fri, Nov 30, 2018 at 4:01 PM Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>> Thanks Arnd for the review comments!
>> On 30/11/18 13:41, Arnd Bergmann wrote:
>>> On Fri, Nov 30, 2018 at 11:48 AM Srinivas Kandagatla
>>> <srinivas.kandagatla@linaro.org> wrote:
> 
>>>> +static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
>>>> +                                unsigned long arg)
>>>> +{
>>>> +       struct fastrpc_user *fl = (struct fastrpc_user *)file->private_data;
>>>> +       struct fastrpc_channel_ctx *cctx = fl->cctx;
>>>> +       char __user *argp = (char __user *)arg;
>>>> +       int err;
>>>> +
>>>> +       if (!fl->sctx) {
>>>> +               fl->sctx = fastrpc_session_alloc(cctx, 0);
>>>> +               if (!fl->sctx)
>>>> +                       return -ENOENT;
>>>> +       }
>>>
>>> Shouldn't that session be allocated during open()?
>>>
>> Yes, and no, we do not need context in all the cases. In cases like we
>> just want to allocate dmabuf.
> 
> Can you give an example what that would be good for?
> 

Currently the instance which does not need session is used as simple 
memory allocator (rpcmem), TBH, this is the side effect of trying to fit 
in with downstream application infrastructure which uses ion for andriod 
usecases.

>>
>>>> +static void fastrpc_notify_users(struct fastrpc_user *user)
>>>> +{
>>>> +       struct fastrpc_invoke_ctx *ctx, *n;will go
>>>> +
>>>> +       spin_lock(&user->lock);
>>>> +       list_for_each_entry_safe(ctx, n, &user->pending, node)
>>>> +               complete(&ctx->work);
>>>> +       spin_unlock(&user->lock);
>>>> +}
>>>
>>> Can you explain here what it means to have multiple 'users'
>>> a 'fastrpc_user' structure? Why are they all done at the same time?

user is allocated on every open(). Having multiple users means that 
there are more than one compute sessions running on a given dsp.

They reason why all the users are notified here is because the dsp is 
going down, so all the compute sessions associated with it will not see 
any response from dsp, so any pending/waiting compute contexts are 
explicitly notified.

>>>
>> This is the case where users need to be notified if the dsp goes down
>> due to crash or shut down!
> 
> What is a 'user' then? My point is that it seems to refer to two
> different things here. I assume 'fastrpc_user' is whoever
> has opened the file descriptor.
> 
>>>
>>>> +struct fastrpc_ioctl_invoke {
>>>> +       uint32_t handle;        /* remote handle */
>>>> +       uint32_t sc;            /* scalars describing the data */
>>>> +       remote_arg_t *pra;      /* remote arguments list */
>>>> +       int *fds;               /* fd list */
>>>> +       unsigned int *attrs;    /* attribute list */
>>>> +       unsigned int *crc;
>>>> +};
>>>
>>> This seems too complex for an ioctl argument, with
>>> multiple levels of pointer indirections. I'd normally
>>> try to make each ioctl argument either a scalar, or a
>>> structure with only fixed-length members.
>>>
>> I totally agree with you and many thanks for your expert inputs,
>> May be something like below with fixed length members would work?
>>
>> struct fastrpc_remote_arg {
>>          __u64 ptr;      /* buffer ptr */
>>          __u64 len;      /* length */
>>          __u32 fd;       /* dmabuf fd */
>>          __u32 reserved1
>>          __u64 reserved2
>> };
>>
>> struct fastrpc_remote_fd {
>>          __u64 fd;
>>          __u64 reserved1
>>          __u64 reserved2
>>          __u64 reserved3
>> };
>>
>> struct fastrpc_remote_attr {
>>          __u64 attr;
>>          __u64 reserved1
>>          __u64 reserved2
>>          __u64 reserved3
>> };
>>
>> struct fastrpc_remote_crc {
>>          __u64 crc;
>>          __u64 reserved1
>>          __u64 reserved2
>>          __u64 reserved3
>> };
> 
> I don't see a need to add extra served fields for structures
> that are already naturally aligned here, e.g. in
> fastrpc_remote_arg we need the 'reserved1' but not
> the 'reserved2'.
Yes, I see, I overdone it!
Other idea, is, may be I can try to combine these into single structure 
something like:

struct fastrpc_invoke_arg {
	__u64 ptr;
	__u64 len;
	__u32 fd;
	__u32 reserved1
	__u64 attr;
	__u64 crc;
};

struct fastrpc_ioctl_invoke {
	__u32 handle;
	__u32 sc;
	/* The minimum size is scalar_length * 32*/
	struct fastrpc_invoke_args *args;
};

> 
>>
>> struct fastrpc_ioctl_invoke {
>>          __u32 handle;
>>          __u32 sc;
>>          /* The minimum size is scalar_length * 32 */
>>          struct fastrpc_remote_args *rargs;
>>          struct fastrpc_remote_fd *fds;
>>          struct fastrpc_remote_attr *attrs;
>>          struct fastrpc_remote_crc *crc;
>> };
> 
> Do these really have to be indirect then? Are they all
> lists of variable length? How do you know how long?
Yes, they are variable length and will be scalar length long.
Scalar length is derived from sc variable in this structure.

--srini


> 
>        Arnd
> 
