Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2174C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C5A21872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GpspPied"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbfADUDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 15:03:55 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:43308 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfADUDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 15:03:55 -0500
Received: by mail-pf1-f202.google.com with SMTP id b8so37792907pfe.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 12:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uKI/AHKX0JyUjvz9YhN2UpQb0lqvTA+uLkQzBS73lt8=;
        b=GpspPiedLWy4By+huorr5Fo7uBig5NplAKWE+cvBIVWxJ5Y0Vcs7GYP03xTHDMU9LF
         CyOIgfzNkTLpxcLSeSowo52Uyprd2+7+2cElrxuq6mprcQpGOxPpyrCPFGpVC9KNhbaP
         Ce2IwlbbAf7pZi7axtwxGnRHWsNACdNMWC8w6CWna6aLPKgvSQbcVvZNc0il+eO9zyam
         0DC8ACa4H9sr+KEzu5AP8GAZ308Pvb9MCNg18zfk0fkDbjckU8X1HPy/vrmwfVk6F22e
         BFPEZZp+9U98DNUOiBXjzkBtjRlZTqqWIssEO5bWQLVFMwULesgnmkI0Ry42nVtQ2XyZ
         nopg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uKI/AHKX0JyUjvz9YhN2UpQb0lqvTA+uLkQzBS73lt8=;
        b=bEOSnnu8Ja2brzAHroge8ZYUBN8N/He6lPLdNFuLN8GvVEv87h3koWg4LtnU9FMuSt
         w1MhnP1eMz+7/9tCDxE02ZNKJtzCq0/sI9fyo6Xd4FXk2O+0OU2JD5loAQgSRfU2irqe
         ir52qDM9+Fnp0zFYOe1XO0gYitEODffWr+4ztoEGA/pf/S0aRKxsY3DJlkmxSAvM0vWU
         rP4ZkjHVVeBuR4llR2h+9pgfz5LnzaBYnZKaQEQAFDFiATr5RdGLZJhBLXE4bfsNMywP
         Wxc6fsCMtR4xnSNd/Tz4oKaIhDEfbvdPH5oO848bMGS8z3jXUY3xJ554NlKx4gxxYqWd
         4y0A==
X-Gm-Message-State: AJcUukd8wLLGTdjMcokB8dDMd5ZusjKrPDNwNUC1AM0UF3UN7QvBK2nL
        aYgsyRryINYs5lDVyfA9Z7+nft4Axe8a
X-Google-Smtp-Source: ALg8bN7l3/kviGQ3pulE0Gggr8LyfhyGpGug8yffoz6JoUs00SygGzht6Y4ARXT5rDzsyiwSlGdARZsk7p+c
X-Received: by 2002:a63:e504:: with SMTP id r4mr23689714pgh.107.1546632234102;
 Fri, 04 Jan 2019 12:03:54 -0800 (PST)
Date:   Fri, 04 Jan 2019 12:03:51 -0800
In-Reply-To: <88b4d986-0b3c-cbf0-65ad-95f3e8ccd870@linux.alibaba.com>
Message-Id: <xr93y380xk9k.fsf@gthelen.svl.corp.google.com>
Mime-Version: 1.0
References: <1546459533-36247-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190103101215.GH31793@dhcp22.suse.cz> <b3ad06ed-f620-7aa0-5697-a1bbe2d7bfe1@linux.alibaba.com>
 <20190103181329.GW31793@dhcp22.suse.cz> <6f43e926-3bb5-20d1-2e39-1d30bf7ad375@linux.alibaba.com>
 <20190103185333.GX31793@dhcp22.suse.cz> <d610c665-890f-3bf0-1e2a-437150b6ddfb@linux.alibaba.com>
 <20190103192339.GA31793@dhcp22.suse.cz> <88b4d986-0b3c-cbf0-65ad-95f3e8ccd870@linux.alibaba.com>
Subject: Re: [RFC PATCH 0/3] mm: memcontrol: delayed force empty
From:   Greg Thelen <gthelen@google.com>
To:     Yang Shi <yang.shi@linux.alibaba.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yang Shi <yang.shi@linux.alibaba.com> wrote:

> On 1/3/19 11:23 AM, Michal Hocko wrote:
>> On Thu 03-01-19 11:10:00, Yang Shi wrote:
>>>
>>> On 1/3/19 10:53 AM, Michal Hocko wrote:
>>>> On Thu 03-01-19 10:40:54, Yang Shi wrote:
>>>>> On 1/3/19 10:13 AM, Michal Hocko wrote:
>> [...]
>>>>>> Is there any reason for your scripts to be strictly sequential here? In
>>>>>> other words why cannot you offload those expensive operations to a
>>>>>> detached context in _userspace_?
>>>>> I would say it has not to be strictly sequential. The above script is just
>>>>> an example to illustrate the pattern. But, sometimes it may hit such pattern
>>>>> due to the complicated cluster scheduling and container scheduling in the
>>>>> production environment, for example the creation process might be scheduled
>>>>> to the same CPU which is doing force_empty. I have to say I don't know too
>>>>> much about the internals of the container scheduling.
>>>> In that case I do not see a strong reason to implement the offloding
>>>> into the kernel. It is an additional code and semantic to maintain.
>>> Yes, it does introduce some additional code and semantic, but IMHO, it is
>>> quite simple and very straight forward, isn't it? Just utilize the existing
>>> css offline worker. And, that a couple of lines of code do improve some
>>> throughput issues for some real usecases.
>> I do not really care it is few LOC. It is more important that it is
>> conflating force_empty into offlining logic. There was a good reason to
>> remove reparenting/emptying the memcg during the offline. Considering
>> that you can offload force_empty from userspace trivially then I do not
>> see any reason to implement it in the kernel.
>
> Er, I may not articulate in the earlier email, force_empty can not be 
> offloaded from userspace *trivially*. IOWs the container scheduler may 
> unexpectedly overcommit something due to the stall of synchronous force 
> empty, which can't be figured out by userspace before it actually 
> happens. The scheduler doesn't know how long force_empty would take. If 
> the force_empty could be offloaded by kernel, it would make scheduler's 
> life much easier. This is not something userspace could do.

If kernel workqueues are doing more work (i.e. force_empty processing),
then it seem like the time to offline could grow.  I'm not sure if
that's important.

I assume that if we make force_empty an async side effect of rmdir then
user space scheduler would not be unable to immediately assume the
rmdir'd container memory is available without subjecting a new container
to direct reclaim.  So it seems like user space would use a mechanism to
wait for reclaim: either the existing sync force_empty or polling
meminfo/etc waiting for free memory to appear.

>>>> I think it is more important to discuss whether we want to introduce
>>>> force_empty in cgroup v2.
>>> We would prefer have it in v2 as well.
>> Then bring this up in a separate email thread please.
>
> Sure. Will prepare the patches later.
>
> Thanks,
> Yang
