Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499F1C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0233422360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="IAoTuPaJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0233422360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733126AbeKOB02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:26:28 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:38319 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733008AbeKOB01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 20:26:27 -0500
Received: by mail-io1-f67.google.com with SMTP id h4so7851473iom.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 07:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F87CkJ9yANATsflDsztLH+KJ/GVeWsCnxe8Zn9TTp7k=;
        b=IAoTuPaJ/kbENX11swbrOW9bCbov9wy7G8zvjHc+Xznq3Q3Raf3g3ZC2dHoUgdriza
         hL4TCNYXN1wEulWxZMecOYQMOxOEpXLwpHAnW/tDNBTgZEWg35gv6ZdHDv07XZ7pbNMJ
         QsY/gU/57E/fEzgxHsAJWohhvw/SoLg1iPtytBx5LJLyDr8a3aIACu4uztNgsxq5aPTd
         5sx/AbJcI/HwBvD7vxJq4bQShXGar9vWSgGafTUAJjlZFYzXo2QSrQSq5YGywKzF9L6g
         wkSat9hD/1zU3koii/rLX0sBgOE8zfUKJjZKvCTZmT9m4oGN8AZGFmjFNhw4w453+aLW
         qfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F87CkJ9yANATsflDsztLH+KJ/GVeWsCnxe8Zn9TTp7k=;
        b=kMIkJ7bfg5Cwm7lXYrH5ds6u8Z076EOSKRT9GqU4tBcAhM53X/rrBeJIqkDTECrixq
         Gq6Sos/zs9oNeosmohxwyEJNhKLhVSaWitH0iyxUc7hdTDMr5u61oZQL1AAGF3EnQyD7
         ZxaxENo28VuVf5T35GLdJIXaD0Qq2RBArY1GxyjkFVDnD0AchKNKQ5z0xLC8zMZGAhx5
         AuqCtJzC4IjxbaxtQJY9rr7oxPy0PtK5h9wMByYZ17utaSZstSKq+jQ67NkoJN6/89Zk
         5uXc577XEKiICt9tlwf6Vz8KkD8e6DlJ7FHBx9Ok6ghS4qA8dnnZrCoheV/2X7CUy7m8
         XWUw==
X-Gm-Message-State: AGRZ1gK3AMRTeSwu8Hp2wMqlg0GZ0juOPjYxgseaQuYOMEWwZ4Y/ZIyZ
        3BFt57/675MsjfKPxkUUe3BB2HvDVAw=
X-Google-Smtp-Source: AFSGD/WmlIJBWNzH/PTzUT9x2Eo46KoXG2mQr+1/fSag3EPpQSIjriynBEHLHAH4Bj7kOgLkPTWHCw==
X-Received: by 2002:a5e:cb07:: with SMTP id p7-v6mr1872672iom.178.1542208966746;
        Wed, 14 Nov 2018 07:22:46 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id x79sm5226616ita.34.2018.11.14.07.22.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 07:22:45 -0800 (PST)
Subject: Re: [PATCH V7 1/4] blk-mq: refactor the code of issue request
 directly
To:     Ming Lei <ming.lei@redhat.com>,
        "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1542185131-15029-1-git-send-email-jianchao.w.wang@oracle.com>
 <1542185131-15029-2-git-send-email-jianchao.w.wang@oracle.com>
 <20181114091153.GB20550@ming.t460p>
 <17b51550-d45b-9861-b172-74ee0e256d98@oracle.com>
 <20181114094343.GA13193@ming.t460p>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <42861ece-5519-bb59-e3a7-8fea1c731f19@kernel.dk>
Date:   Wed, 14 Nov 2018 08:22:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181114094343.GA13193@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/18 2:43 AM, Ming Lei wrote:
> On Wed, Nov 14, 2018 at 05:23:48PM +0800, jianchao.wang wrote:
>> Hi Ming
>>
>> On 11/14/18 5:11 PM, Ming Lei wrote:
>>>>  
>>>> -	if (!blk_mq_get_dispatch_budget(hctx))
>>>> -		goto insert;
>>>> +	if (unlikely(!blk_mq_get_dispatch_budget(hctx)))
>>>> +		goto out_unlock;
>>> The unlikely annotation is a bit misleading, since out-of-budget can
>>> happen frequently in case of low queue depth, and there are lots of
>>> such examples.
>>>
>>
>> This could be good for the case for no .get_budget and getting budget success.
>> In case of out-of-budget, we insert the request which is slow path.
> 
> In case of low queue depth, it is hard to say that 'insert request' is
> done in slow path, cause it happens quite frequently.
> 
> I suggest to remove these two unlikely() since modern CPU's branch prediction
> should work well enough.
> 
> Especially the annotation of unlikely() often means that this branch is
> missed in most of times for all settings, and it is obviously not true
> in this case.

Agree, unlikely() should only be used for the error handling case or
similar that does indeed almost never trigger. It should not be used
for cases that don't trigger a lot in "most" circumstances.


-- 
Jens Axboe

