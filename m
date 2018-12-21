Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F3BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F1621970
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpmsUmYQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391517AbeLUS7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 13:59:36 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33724 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731021AbeLUS7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 13:59:36 -0500
Received: by mail-pl1-f194.google.com with SMTP id z23so2898962plo.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 10:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aMJEbotsY0CcZMlWLeMf5Uy0Q/EdQui9y5jYRTd4RfU=;
        b=ZpmsUmYQBgK71TI7MvLTByionVl0kD61PcPeuLkSJ80tNnbmSbQnMg9v+B8pUNR9o8
         358tXxXDZU4NBJKblxU+Sm1zddTKbD5geU8cs/2beNVnkTSlWLEqsdPO4lLNXRv88Lfa
         01qs0IMXnfrsFm7fCrzOEEmj80GJvVdYaTAefor/YIsp+Pkno7gO/YLMf5tMf3ARG4Tu
         fDLjDBDdpN8uk+J08BWnf1f4m92MUPOCCBrfRq61SUZs9K1CKjVF6NPPkqhFqMUpzr2J
         9WDEg/IRy2f39EBqKMg66UUhCf+As99mFuLqDjHiNRcmEGDDXj4A7yg/YM+TsLLRwLTs
         sY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aMJEbotsY0CcZMlWLeMf5Uy0Q/EdQui9y5jYRTd4RfU=;
        b=QcOTw0AZK86GU8xum+wd33CLe8MGC/FU0oGxUR5VDDww0j5IfQ65VgPvESvHWHUH9z
         rqSFmAowsf8NUbGsVZink0NaSIk6lR70UtyZS3hn9XcSFcf+2Uwbcshc2l2Q4pi5SG64
         CnCiS6kaZZf2Wv36ENBN6UXEVtO1EejypR5NjR4B0owKx2dkbwhtz+LfU4RE8UzNVqSN
         rM53xyv21orB1DT7jtMSNlmfD7nCMhf0hz7ww3XS0a32NiEcSSuGp/yWKXYxmWfrud+y
         +ZqUdUAFd37RAmrimynAr91zSTvblfE9Llzm1yG/zvfDJaos8T1ipppd6iRS1aDjZcRn
         nNXA==
X-Gm-Message-State: AJcUukfeFyX3LEUB9ekZpRbzjv0eXH+EHPoLqTjYQEfMhWOyo4KtkRUr
        2zV2VSD8+fq79qJyorJ9l4pSwSjX
X-Google-Smtp-Source: ALg8bN4vJSOGEKAC0zfHBKKq3GARueXSm1EUkMlA2QM2PH3gKpci4Xf32Hq/mgfw2acsJKMx5BGUmg==
X-Received: by 2002:a17:902:8a91:: with SMTP id p17mr3687563plo.316.1545418775929;
        Fri, 21 Dec 2018 10:59:35 -0800 (PST)
Received: from [192.168.2.145] ([94.29.36.169])
        by smtp.googlemail.com with ESMTPSA id h9sm34899448pgd.53.2018.12.21.10.59.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 10:59:35 -0800 (PST)
Subject: Re: [PATCH 2/2] drm: Revert syncobj timeline changes.
To:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        Eric Anholt <eric@anholt.net>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jason Ekstrand <jason@jlekstrand.net>
References: <20181108160422.17743-1-eric@anholt.net>
 <20181108160422.17743-3-eric@anholt.net>
 <faf15d58-a076-49fb-c903-15acdf6f8ffe@gmail.com>
 <fadfc03c-7f80-216b-299f-27a1d8d7877b@gmail.com>
 <44f25278-fbbd-f95b-c2ab-87834e5d095e@gmail.com>
 <6773eadb-5c15-8168-9bba-5e1cfd1c3194@amd.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <540f2669-4686-fec1-31f5-b8dacc5c16d4@gmail.com>
Date:   Fri, 21 Dec 2018 21:59:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <6773eadb-5c15-8168-9bba-5e1cfd1c3194@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.12.2018 21:45, Koenig, Christian wrote:
> Am 21.12.18 um 19:35 schrieb Dmitry Osipenko:
>> On 21.12.2018 21:27, Christian König wrote:
>>> Am 19.12.18 um 18:53 schrieb Dmitry Osipenko:
>>>> [SNIP]
>>>>> @@ -931,9 +718,6 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>>>>>          if (flags & DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT) {
>>>>>            for (i = 0; i < count; ++i) {
>>>>> -            if (entries[i].fence)
>>>>> -                continue;
>>>>> -
>>>>>                drm_syncobj_fence_get_or_add_callback(syncobjs[i],
>>>>>                                      &entries[i].fence,
>>>>>                                      &entries[i].syncobj_cb,
>>>> Hello,
>>>>
>>>> The above three removed lines we added in commit 337fe9f5c1e7de ("drm/syncobj: Don't leak fences when WAIT_FOR_SUBMIT is set") that fixed a memleak. Removal of the lines returns the memleak because of disbalanced fence refcounting and it looks like they were removed unintentionally in this patch.
>>> That was already fixed with 61a98b1b9a8c7 drm/syncobj: remove drm_syncobj_cb and cleanup.
>>>
>>> This cleanup removed all the duplicate checking and is now adding the callback only once.
>> Okay, though that commit is not in linux-next. I assume it will show up eventually.
> 
> Need to double check, that could indeed be a problem.

Thanks for taking care!
