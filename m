Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E12C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 06:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96CB920848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 06:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="kLt1NHZs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96CB920848
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbeJYPYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 11:24:49 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:47058 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbeJYPYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 11:24:48 -0400
Received: by mail-ed1-f68.google.com with SMTP id v22-v6so7354668edq.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 23:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=xZcWlcKoxIvp2oN0SDfTpxhhXheBlMiscBUxHBaiXzs=;
        b=kLt1NHZsB5c6TIM0cOmGi8q4XHFX2CT1wnyCu3aSOwLXb/fFZEuuDRESYsc3itY6TL
         tTy/n764AWCkVRNjYATrNdkX+s06n6XoXVNv4qgs1zGbtYgMuKi6fTBRW6aHR5q1rHYb
         IfJ+OhWd2aIQTdUZTumLNHNEkOotslQzmBj9fZKq4XtfKNnJAtFF0IK97Kr8puybXqUH
         QQ/dGED2vZXEcQX4dl0Zw11NIucMEL+gEuK3PA27AHKmskoFlhLIbSRN5aeVSoi3DGTz
         AYkFRxZESrvSLa6feR3K0utR81brsW4+UowNTOaF+yZs8jxwghqzR+b6DL1Ipbga3WnY
         +cug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xZcWlcKoxIvp2oN0SDfTpxhhXheBlMiscBUxHBaiXzs=;
        b=ZM3z7RWrJ/Z5SXE8gBNNK54z5ER4degcmgNqhMuX1iQXzfI8bMvXoKaZiwBWiP8QwJ
         RmWoez8EFuvDRLE6cDaGqDhFs3RiHh4L8LK/D00J0I70V+nnHhFKFNXmjuFOcln5mcMj
         LoD/cmmSNSD9coiSQIHIdODdQPdntezxu+ZNiSy5EL4l4w2+KuZDRq6hc4+sxHBaTZIo
         kUX6rw8ewkcRPmUvRHPLPAEhJunqf5CGLWOQvd76PUctfCz6mNY7TP2TeVXQeO2v2ViY
         JegW7oF/pr+TGqPcglRxTH1UZ3BdG1UAG0IvXOjW0Lsm3Cb+2YRzkXsijd6TCBi7xB5L
         +EKw==
X-Gm-Message-State: AGRZ1gIXYUu5Swe0LKebGUm5CMbJmAw61hLzmywMSx2kRqOX9I7zFyod
        V9YvMOYEsTUFNPmkfD871g==
X-Google-Smtp-Source: AJdET5dBRhCnLq9GugZNX98eAwwHBhApTqWjgtgrBhSXdgjCSYKEcf1XoAeZf0gWgJPwo3wKZMhR0g==
X-Received: by 2002:a17:906:3010:: with SMTP id 16-v6mr460629ejz.4.1540450403964;
        Wed, 24 Oct 2018 23:53:23 -0700 (PDT)
Received: from ?IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740? ([2a02:908:1257:4460:1ab8:55c1:a639:6740])
        by smtp.gmail.com with ESMTPSA id g13-v6sm2444829edv.48.2018.10.24.23.53.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 23:53:23 -0700 (PDT)
Subject: Re: [PATCH] drm: fix call_kern.cocci warnings (fwd)
To:     "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        Julia Lawall <julia.lawall@lip6.fr>
Cc:     "kbuild-all@01.org" <kbuild-all@01.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <alpine.DEB.2.21.1810241955110.3776@hadrien>
 <BY1PR12MB05028BA16A21896179679800B4F70@BY1PR12MB0502.namprd12.prod.outlook.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <easy2remember.chk@googlemail.com>
Message-ID: <823eb7cc-ba7e-b816-1821-c73dfd4c70bf@googlemail.com>
Date:   Thu, 25 Oct 2018 08:53:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <BY1PR12MB05028BA16A21896179679800B4F70@BY1PR12MB0502.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 25.10.18 um 03:28 schrieb Zhou, David(ChunMing):
> Reviewed-by: Chunming Zhou <david1.zhou@amd.com>

NAK, GFP_ATOMIC should be avoided.

The correct solution is to move the allocation out of the spinlock or 
drop the lock and reacquire.

Christian.

>
>> -----Original Message-----
>> From: Julia Lawall <julia.lawall@lip6.fr>
>> Sent: Thursday, October 25, 2018 2:57 AM
>> To: Zhou, David(ChunMing) <David1.Zhou@amd.com>
>> Cc: kbuild-all@01.org; intel-gfx@lists.freedesktop.org; dri-
>> devel@lists.freedesktop.org; Christian König
>> <easy2remember.chk@googlemail.com>; Gustavo Padovan
>> <gustavo@padovan.org>; Maarten Lankhorst
>> <maarten.lankhorst@linux.intel.com>; Sean Paul <sean@poorly.run>; David
>> Airlie <airlied@linux.ie>; dri-devel@lists.freedesktop.org; linux-
>> kernel@vger.kernel.org
>> Subject: [PATCH] drm: fix call_kern.cocci warnings (fwd)
>>
>> The containing function is called with a spin_lock held, so GFP_KERNEL can't
>> be used.
>>
>> julia
>>
>> ---------- Forwarded message ----------
>> Date: Tue, 23 Oct 2018 17:14:25 +0800
>> From: kbuild test robot <lkp@intel.com>
>> To: kbuild@01.org
>> Cc: Julia Lawall <julia.lawall@lip6.fr>
>> Subject: [PATCH] drm: fix call_kern.cocci warnings
>>
>> CC: kbuild-all@01.org
>> CC: intel-gfx@lists.freedesktop.org
>> CC: dri-devel@lists.freedesktop.org
>> TO: Chunming Zhou <david1.zhou@amd.com>
>> CC: "Christian König" <easy2remember.chk@googlemail.com>
>> CC: Gustavo Padovan <gustavo@padovan.org>
>> CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> CC: Sean Paul <sean@poorly.run>
>> CC: David Airlie <airlied@linux.ie>
>> CC: dri-devel@lists.freedesktop.org
>> CC: linux-kernel@vger.kernel.org
>>
>> From: kbuild test robot <fengguang.wu@intel.com>
>>
>> drivers/gpu/drm/drm_syncobj.c:202:4-14: ERROR: function
>> drm_syncobj_find_signal_pt_for_point called on line 390 inside lock on line
>> 389 but uses GFP_KERNEL
>>
>>   Find functions that refer to GFP_KERNEL but are called with locks held.
>>
>> Semantic patch information:
>>   The proposed change of converting the GFP_KERNEL is not necessarily the
>> correct one.  It may be desired to unlock the lock, or to not call the  function
>> under the lock in the first place.
>>
>> Generated by: scripts/coccinelle/locks/call_kern.cocci
>>
>> Fixes: 48197bc564c7 ("drm: add syncobj timeline support v9")
>> CC: Chunming Zhou <david1.zhou@amd.com>
>> Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
>> ---
>>
>> tree:   git://anongit.freedesktop.org/drm/drm-tip drm-tip
>> head:   8d7ffd2298c607c3e1a16f94d51450d7940fd6a7
>> commit: 48197bc564c7a1888c86024a1ba4f956e0ec2300 [1968/2033] drm: add
>> syncobj timeline support v9
>> :::::: branch date: 4 hours ago
>> :::::: commit date: 5 days ago
>>
>> Please take the patch only if it's a positive warning. Thanks!
>>
>>   drm_syncobj.c |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> --- a/drivers/gpu/drm/drm_syncobj.c
>> +++ b/drivers/gpu/drm/drm_syncobj.c
>> @@ -199,7 +199,7 @@ static struct dma_fence
>>   	    (point <= syncobj->timeline)) {
>>   		struct drm_syncobj_stub_fence *fence =
>>   			kzalloc(sizeof(struct drm_syncobj_stub_fence),
>> -				GFP_KERNEL);
>> +				GFP_ATOMIC);
>>
>>   		if (!fence)
>>   			return NULL;

