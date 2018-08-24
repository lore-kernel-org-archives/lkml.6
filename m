Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B878AC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 11:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE1C21581
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 11:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sO6/HYrT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE1C21581
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbeHXPRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 11:17:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42009 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbeHXPRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 11:17:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id v17-v6so7228087wrr.9;
        Fri, 24 Aug 2018 04:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=e9ql2+sj+GkRkDzKAPhZVeGuZiOG2t4QiKIhZtz0KGY=;
        b=sO6/HYrTIYO+HeWeym0gBEJ5t9TVhEMJMBNc5FxlwH839RfRj1DzhbMEqJykkDM4aq
         LPtLlKVVxcFCVGwFGrE8YDjjGgfumhe5As4HODcx62WU1frQGUab99fr+c4thgKDokAt
         FAZOo9ZqQvgePwslnbqpqibs/5f73hoihudRiElvC+AyiOZq1XOYY1VDEi36qmv2oaLT
         J9qfOoN30Zax9cMsEgfHXR0u+sYWC6jZSYnQgh+gQbKy1wM5hHfc+qpEIDMkL6qa7KD3
         mjfU+11tmbKIpjV3HvTRz4z5OyNlYc62KhuyzT14n5djIsoBuognCWt2bOm24CXM6QeF
         r1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=e9ql2+sj+GkRkDzKAPhZVeGuZiOG2t4QiKIhZtz0KGY=;
        b=qw6QSZprqVSuxjzIF38Wr5AE7GrFuHUrF3/NOjty5wYVMDNA1RZQ8x/4CggvWI1+hO
         H7UWbgsPAoSZN0fCZhhoFH8bwrGqgqT9BBdqhGGpf8YOQTBtvzh3nUI/G16QjAKJTrx6
         PkpnYjiGe2+CDzQT0BHhr5EERvIkUutzYsi7V/qvoB9e1Iy/587QCopIPk46X2ds+FOu
         yQXpo30AbD6sbMwMeIpQNLNl0jef7I9Gs9kl0QWgrd510NWcDCf45wXQTW/qA/tgHCmr
         zHkCJYHX8n7hgmoZIFnoZL/tKn75LpUeK1XcX8yC+Ye/bEIMbvdXHwG/CzfQ0HuDZDvU
         PUpA==
X-Gm-Message-State: APzg51CXJkaI89BgVriL+km8r8YlugpXM4BxfYnnW1yJ2M7sYqWRw4Ue
        vE10s4AuT7qtOp0rs0LQStM=
X-Google-Smtp-Source: ANB0VdbLnhDQoAznumzophkUhtkbk+2ZTqfs22ejzpIGWRWDuxOIAMobOmlKa576Ju7W87M22me8wQ==
X-Received: by 2002:adf:f410:: with SMTP id g16-v6mr979074wro.256.1535110999376;
        Fri, 24 Aug 2018 04:43:19 -0700 (PDT)
Received: from ?IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740? ([2a02:908:1257:4460:1ab8:55c1:a639:6740])
        by smtp.gmail.com with ESMTPSA id g126-v6sm1646800wmg.5.2018.08.24.04.43.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 04:43:18 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH] mm, oom: distinguish blockable mode for mmu notifiers
To:     Michal Hocko <mhocko@kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     kvm@vger.kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Dimitri Sivanich <sivanich@sgi.com>,
        linux-rdma@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        David Rientjes <rientjes@google.com>,
        xen-devel@lists.xenproject.org, intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Felix Kuehling <felix.kuehling@amd.com>
References: <20180716115058.5559-1-mhocko@kernel.org>
 <8cbfb09f-0c5a-8d43-1f5e-f3ff7612e289@I-love.SAKURA.ne.jp>
 <20180824113248.GH29735@dhcp22.suse.cz>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <b088e382-e90e-df63-a079-19b2ae2b985d@gmail.com>
Date:   Fri, 24 Aug 2018 13:43:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180824113248.GH29735@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 24.08.2018 um 13:32 schrieb Michal Hocko:
> On Fri 24-08-18 19:54:19, Tetsuo Handa wrote:
>> Two more worries for this patch.
>>
>>
>>
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
>>> @@ -178,12 +178,18 @@ void amdgpu_mn_unlock(struct amdgpu_mn *mn)
>>>    *
>>>    * @amn: our notifier
>>>    */
>>> -static void amdgpu_mn_read_lock(struct amdgpu_mn *amn)
>>> +static int amdgpu_mn_read_lock(struct amdgpu_mn *amn, bool blockable)
>>>   {
>>> -       mutex_lock(&amn->read_lock);
>>> +       if (blockable)
>>> +               mutex_lock(&amn->read_lock);
>>> +       else if (!mutex_trylock(&amn->read_lock))
>>> +               return -EAGAIN;
>>> +
>>>          if (atomic_inc_return(&amn->recursion) == 1)
>>>                  down_read_non_owner(&amn->lock);
>> Why don't we need to use trylock here if blockable == false ?
>> Want comment why it is safe to use blocking lock here.
> Hmm, I am pretty sure I have checked the code but it was quite confusing
> so I might have missed something. Double checking now, it seems that
> this read_lock is not used anywhere else and it is not _the_ lock we are
> interested about. It is the amn->lock (amdgpu_mn_lock) which matters as
> it is taken in exclusive mode for expensive operations.

The write side of the lock is only taken in the command submission IOCTL.

So you actually don't need to change anything here (even the proposed 
changes are overkill) since we can't tear down the struct_mm while an 
IOCTL is still using.

> Is that correct Christian? If this is correct then we need to update the
> locking here. I am struggling to grasp the ref counting part. Why cannot
> all readers simply take the lock rather than rely on somebody else to
> take it? 1ed3d2567c800 didn't really help me to understand the locking
> scheme here so any help would be appreciated.

That won't work like this there might be multiple 
invalidate_range_start()/invalidate_range_end() pairs open at the same 
time. E.g. the lock might be taken recursively and that is illegal for a 
rw_semaphore.

Regards,
Christian.

>
> I am wondering why we cannot do
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> index e55508b39496..93034178673d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> @@ -180,14 +180,11 @@ void amdgpu_mn_unlock(struct amdgpu_mn *mn)
>    */
>   static int amdgpu_mn_read_lock(struct amdgpu_mn *amn, bool blockable)
>   {
> -	if (blockable)
> -		mutex_lock(&amn->read_lock);
> -	else if (!mutex_trylock(&amn->read_lock))
> -		return -EAGAIN;
> -
> -	if (atomic_inc_return(&amn->recursion) == 1)
> -		down_read_non_owner(&amn->lock);
> -	mutex_unlock(&amn->read_lock);
> +	if (!down_read_trylock(&amn->lock)) {
> +		if (!blockable)
> +			return -EAGAIN;
> +		down_read(amn->lock);
> +	}
>   
>   	return 0;
>   }
> @@ -199,8 +196,7 @@ static int amdgpu_mn_read_lock(struct amdgpu_mn *amn, bool blockable)
>    */
>   static void amdgpu_mn_read_unlock(struct amdgpu_mn *amn)
>   {
> -	if (atomic_dec_return(&amn->recursion) == 0)
> -		up_read_non_owner(&amn->lock);
> +	up_read(&amn->lock);
>   }
>   
>   /**
>

