Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B3EC43444
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E53CE208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="LwxTS64R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732423AbfACQwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 11:52:00 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46110 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730564AbfACQwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 11:52:00 -0500
Received: by mail-qk1-f194.google.com with SMTP id q1so19980821qkf.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 08:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eTcWC8aP+IOpk0fgM16IKOQMUhiJ4XIVLwxp5FBnT3Q=;
        b=LwxTS64R10wav6JCqUbL27g7+lj12GYZj1xjYoMJnpcnmvSnj5JwZzgMKcD1Q8iDqW
         QulxNta33lB9rO8/OOUigEBI1t3cfwrljZ6VdH38dKGYxEErlnk6Cl4Kyxr4cMr+HJOR
         Al6kYZq9vBFfyujjRViah+BCFzmtXvSJK7+MrEj1WKq9fIlvzfvAtgbQ7ICIiDEX3R2X
         MHXFLE4y/jIGZqB7YO9VkoLJYN1jrvMbATa5LObb2kZEPrJLO1S15Z4cDsXA0ei+3Cat
         okVDLrk5Qn0QQjgn1x2qJdkmk/qcUyjSsSjT2uZjjHMAfWqAQiumM5b/W8XxkThVc1EC
         G9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eTcWC8aP+IOpk0fgM16IKOQMUhiJ4XIVLwxp5FBnT3Q=;
        b=FZhNOybH+y1OS5NnzyKmDAouHF61AB2ptrax/CGw1rAz4PSlm0c0j5aYkC1ScWB02u
         ZgFgHtwSP3uB6iQdTLlJ0O0tVqC7uve+GPoauePPMu82FoGKGSzJIIl8ZMR0xrcoW3on
         7aECDQKYcX5OqpmemBuWrKvVppGha7sU4ZAhj5DjEzOwpzcVA7dPg87JQdajXouh1PYZ
         9M3rbo7qZslKrN5vgfjSFjsHBORqAPXOxQesu516n6vYV/+6ag/H9gFVDvYTzk42sv7f
         mx1VHDeVd5Jq0ilcWpMijmXaBZU1yBUq2oR9V66AqEzHFe3Tsy0RIYxH2vyC0Y8gWaPy
         15TQ==
X-Gm-Message-State: AJcUukdBGSCgUOw9fBG6VIxklvVRPBBa6YvBSbJrm9PzdwVD2RldTsWQ
        fENXL+C3kmMP0dtN5hHcODyCdf54kDq7Yg==
X-Google-Smtp-Source: ALg8bN7wffEiYyHR2tCu+ZbcK873oDboQAE4S/oLrZx02+jCcKPK5Yj1gzIshM6JuMSL1EPBm1fJUw==
X-Received: by 2002:a37:ccc2:: with SMTP id n63mr43818779qkl.82.1546534318637;
        Thu, 03 Jan 2019 08:51:58 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id f19sm29773261qtf.1.2019.01.03.08.51.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 08:51:58 -0800 (PST)
Subject: Re: [PATCH v2] kmemleak: survive in a low-memory situation
To:     Michal Hocko <mhocko@kernel.org>
Cc:     catalin.marinas@arm.com, akpm@linux-foundation.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20190102165931.GB6584@arrakis.emea.arm.com>
 <20190102180619.12392-1-cai@lca.pw> <20190103093201.GB31793@dhcp22.suse.cz>
From:   Qian Cai <cai@lca.pw>
Message-ID: <9197d86b-a684-c7f4-245b-63c890f1104f@lca.pw>
Date:   Thu, 3 Jan 2019 11:51:57 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190103093201.GB31793@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/19 4:32 AM, Michal Hocko wrote:
> On Wed 02-01-19 13:06:19, Qian Cai wrote:
> [...]
>> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
>> index f9d9dc250428..9e1aa3b7df75 100644
>> --- a/mm/kmemleak.c
>> +++ b/mm/kmemleak.c
>> @@ -576,6 +576,16 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
>>  	struct rb_node **link, *rb_parent;
>>  
>>  	object = kmem_cache_alloc(object_cache, gfp_kmemleak_mask(gfp));
>> +#ifdef CONFIG_PREEMPT_COUNT
>> +	if (!object) {
>> +		/* last-ditch effort in a low-memory situation */
>> +		if (irqs_disabled() || is_idle_task(current) || in_atomic())
>> +			gfp = GFP_ATOMIC;
>> +		else
>> +			gfp = gfp_kmemleak_mask(gfp) | __GFP_DIRECT_RECLAIM;
>> +		object = kmem_cache_alloc(object_cache, gfp);
>> +	}
>> +#endif
> 
> I do not get it. How can this possibly help when gfp_kmemleak_mask()
> adds __GFP_NOFAIL modifier to the given gfp mask? Or is this not the
> case anymore in some tree?

Well, __GFP_NOFAIL can still fail easily without __GFP_DIRECT_RECLAIM in a
low-memory situation.

__alloc_pages_slowpath():

/* Caller is not willing to reclaim, we can't balance anything */
if (!can_direct_reclaim)
	goto nopage;

nopage:

/*
 * All existing users of the __GFP_NOFAIL are blockable, so
 * warn of any new users that actually require GFP_NOWAIT
 */
if (WARN_ON_ONCE(!can_direct_reclaim))
	goto fail;
