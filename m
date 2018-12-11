Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE91C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D9C520851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="q0FIl0uM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D9C520851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbeLKSc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 13:32:59 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:36406 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbeLKSc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 13:32:58 -0500
Received: by mail-io1-f67.google.com with SMTP id m19so12655208ioh.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 10:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V678lObyQXAGDUycAkU7vh0Hh4W41IpIfx8gVzVLppE=;
        b=q0FIl0uMgMf2gBeTHKcNI6rkQ1BswPFMi/ChD4qKXBJViUHXx0K3ZiJgP4W1LkXZGd
         fxVc5TTqv3mi2eiEauzLhd/pAgHI2T0apPkqggAzuobKd4oF9HAb98jAe6UHwviJxK1m
         OVq5tvUzclqBHRwYUd1CI4PeySoB64EVfYQi9PhMNaGcyFvbp0EqZvJG6RZHOodcNpAr
         00c2ZFWHZmQtdKzROIHYMhfSzbLFMEloJoYHBKHtZD7rkHEDqTiWuMSuKq8I1WNKraVO
         bsdEhee/pw0e9F27yCClNV9zgQedIiZczBF9GjhKf6UmPBXFx9pRvbdWybeSaxNBbkfS
         6ghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V678lObyQXAGDUycAkU7vh0Hh4W41IpIfx8gVzVLppE=;
        b=rJ/7zzN59NR9ktz6ugedlv1NP2hIHHIA6RJegmJm1ZlpoHgil7cX+qrKry/so3LiMV
         Dg2j/L7Ojyfjl0gdmNm3a77RNJxTgB3bTSW2vHXbBnnhTtI/oz7/WTJqkvLla3Q8MAqX
         0rKoj4y+rg8NU/7B76aniCR5Xc/NhTCH3dueAGgOWUK7DjlvYmxd+ZTUv5IXEmx8kXsW
         O6KWlikpeQpVo4ornNk2j51YaqxXj7CPY6fXT9gwWKblLgDX04fbxm3p2SCoQdbHWliV
         R+YNdqsqn3uIIbTz9f6i9IysPkvY9NWjCUw3tqszAwH5JwJaTipOv477GpTPVlVbPyh7
         E+Sw==
X-Gm-Message-State: AA+aEWYWQMK2lNJJIRAFdXA7HXMd9XFOlCjE5/sBWHOlLM1PPxLFKH1T
        TD05wG7SmzKxSaDRaMjUi0vrHg==
X-Google-Smtp-Source: AFSGD/VkTT+tMPnd/nPcoK4VH9MRjsbpuWw9EEMlJsWLi3JoHgs9pBZatcFvVJTsYhiIJOAXAdM+bQ==
X-Received: by 2002:a6b:5804:: with SMTP id m4mr6753301iob.47.1544553177501;
        Tue, 11 Dec 2018 10:32:57 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id v74sm1597657ita.27.2018.12.11.10.32.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 10:32:55 -0800 (PST)
Subject: Re: [PATCH] aio: Convert ioctx_table to XArray
From:   Jens Axboe <axboe@kernel.dk>
To:     Jeff Moyer <jmoyer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kent.overstreet@gmail.com
References: <20181128183531.5139-1-willy@infradead.org>
 <x49va46e1p0.fsf@segfault.boston.devel.redhat.com>
 <x49pnuee1gm.fsf@segfault.boston.devel.redhat.com>
 <x49mupcm11r.fsf@segfault.boston.devel.redhat.com>
 <20181211175156.GF6830@bombadil.infradead.org>
 <x495zw0lz68.fsf@segfault.boston.devel.redhat.com>
 <0f77a532-0d88-78bc-b9cc-06bb203a0405@kernel.dk>
Message-ID: <6b9a45c4-47a2-4c44-aa7e-6e5e90eff9df@kernel.dk>
Date:   Tue, 11 Dec 2018 11:32:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <0f77a532-0d88-78bc-b9cc-06bb203a0405@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/18 11:05 AM, Jens Axboe wrote:
> On 12/11/18 11:02 AM, Jeff Moyer wrote:
>> Matthew Wilcox <willy@infradead.org> writes:
>>
>>> On Tue, Dec 11, 2018 at 12:21:52PM -0500, Jeff Moyer wrote:
>>>> I'm going to submit this version formally.  If you're interested in
>>>> converting the ioctx_table to xarray, you can do that separately from a
>>>> security fix.  I would include a performance analysis with that patch,
>>>> though.  The idea of using a radix tree for the ioctx table was
>>>> discarded due to performance reasons--see commit db446a08c23d5 ("aio:
>>>> convert the ioctx list to table lookup v3").  I suspect using the xarray
>>>> will perform similarly.
>>>
>>> There's a big difference between Octavian's patch and mine.  That patch
>>> indexed into the radix tree by 'ctx_id' directly, which was pretty
>>> much guaranteed to exhibit some close-to-worst-case behaviour from the
>>> radix tree due to IDs being sparsely assigned.  My patch uses the ring
>>> ID which _we_ assigned, and so is nicely behaved, being usually a very
>>> small integer.
>>
>> OK, good to know.  I obviously didn't look too closely at the two.
>>
>>> What performance analysis would you find compelling?  Octavian's original
>>> fio script:
>>>
>>>> rw=randrw; size=256k ;directory=/mnt/fio; ioengine=libaio; iodepth=1
>>>> blocksize=1024; numjobs=512; thread; loops=100
>>>>
>>>> on an EXT2 filesystem mounted on top of a ramdisk
>>>
>>> or something else?
>>
>> I think the most common use case is a small number of ioctx-s, so I'd
>> like to see that use case not regress (that should be easy, right?).
>> Kent, what were the tests you were using when doing this work?  Jens,
>> since you're doing performance work in this area now, are there any
>> particular test cases you care about?
> 
> I can give it a spin, ioctx lookup is in the fast path, and for "classic"
> aio we do it twice for each IO...

Don't see any regressions. But if we're fiddling with it anyway, can't
we do something smarter? Make the fast path just index a table, and put
all the big hammers in setup/destroy. We're spending a non-substantial
amount of time doing lookups, that's really no different before and
after the patch.

-- 
Jens Axboe

