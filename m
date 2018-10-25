Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83845C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 283F92082D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="mOyqMi7M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 283F92082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbeJYQ1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 12:27:36 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38466 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbeJYQ1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 12:27:36 -0400
Received: by mail-ed1-f67.google.com with SMTP id c1-v6so7538621ede.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 00:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=0J9jQQ383DO4cVbVvJLdlB5/kE189wIQ7lwT9bMOnjQ=;
        b=mOyqMi7Me+B2HHZFBZICz6MfDHzcgp+kAy8tgH5iYasdxg9nKIsidpJbN5OVZxlUZX
         4VF2o5Pny+NYJJV0dF3MJmmVYL7+Rkhrto9jWCsVe+wrrGBCCLdIQkx9VuOV4envGE4x
         OIdeXMw8B2HxRgAzyAxY3/2EAR994mWQCDL3SLMCEoXpuSI7ovsiepa+xRj6++Hn43fc
         dmj0GGFNVBv/ojbfV1BWP66UgnH7DdRoVh1Oqtjgy5mnHshGYf/BE58G34LGLhHWx7Gz
         JS0dF3FfrovZeG7esG6qSGhfp0QAmqN4pjEwep08w78ajINvMF06LrfVnV8EYtO/1aIw
         3Idg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=0J9jQQ383DO4cVbVvJLdlB5/kE189wIQ7lwT9bMOnjQ=;
        b=ppbZk9C7z/1kWTlFzQA82jL8q/tSV1D1vsEAr7EZEmNoWEAB8ZvjswZ+PknLbNVSLc
         LdDSwcnWfcKjml8g6e5KJYM9/3/nH4Fjj5sREy7MDndtsL+iHWTQX8ptA838KpNxWQ8e
         XvK9IkHHyQbYUuP+pxZV0fkZYaI7alFb4qWHoBjzwN0rMpPKhL7y8ITkeWCYduK4VlNr
         fyCK2bU046j/oV3qXZrzV1Eb2jOPqrSYd398Fd1LraqgFxV1yWl00eIr/r0mCs/96X1l
         Ze8ZpRblMGxfeNkyLMhsNdjEGlBtdAbjwqSFdAJJncSoJyIKtoyiKoNLw5Nx2PGdLfid
         0P7Q==
X-Gm-Message-State: AGRZ1gKs76jXPU5QqkDWl0gcz9L30JzFMEvLVPPMLdnIfETkAilh8Q/5
        OAgjZYzJ6N8rEswBEzYN9A==
X-Google-Smtp-Source: AJdET5eIWPmdB/aBlOPUjy3EZ/Vi1UjypuC0wReuLPIaGcJYo3k2vsO85SSzqfg7/eaa7XJjwAj2Dw==
X-Received: by 2002:a50:b003:: with SMTP id i3-v6mr747556edd.120.1540454158826;
        Thu, 25 Oct 2018 00:55:58 -0700 (PDT)
Received: from ?IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740? ([2a02:908:1257:4460:1ab8:55c1:a639:6740])
        by smtp.gmail.com with ESMTPSA id m19-v6sm1437967ejz.70.2018.10.25.00.55.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 00:55:58 -0700 (PDT)
Subject: Re: [PATCH] drm: fix call_kern.cocci warnings (fwd)
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Chunming Zhou <david1.zhou@amd.com>
Cc:     kbuild-all@01.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
References: <alpine.DEB.2.21.1810241955110.3776@hadrien>
 <995c8e64-46d3-7320-744e-b9bd1cb66530@linux.intel.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <easy2remember.chk@googlemail.com>
Message-ID: <fab6e370-29aa-4fec-678b-8b022619b0dc@googlemail.com>
Date:   Thu, 25 Oct 2018 09:55:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <995c8e64-46d3-7320-744e-b9bd1cb66530@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 25.10.18 um 09:50 schrieb Maarten Lankhorst:
> Op 24-10-18 om 20:57 schreef Julia Lawall:
>> The containing function is called with a spin_lock held, so GFP_KERNEL
>> can't be used.
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
>> drivers/gpu/drm/drm_syncobj.c:202:4-14: ERROR: function drm_syncobj_find_signal_pt_for_point called on line 390 inside lock on line 389 but uses GFP_KERNEL
>>
>>   Find functions that refer to GFP_KERNEL but are called with locks held.
>>
>> Semantic patch information:
>>   The proposed change of converting the GFP_KERNEL is not necessarily the
>>   correct one.  It may be desired to unlock the lock, or to not call the
>>   function under the lock in the first place.
>>
>> Generated by: scripts/coccinelle/locks/call_kern.cocci
>>
>> Fixes: 48197bc564c7 ("drm: add syncobj timeline support v9")
>> CC: Chunming Zhou <david1.zhou@amd.com>
>> Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
> The issue appears to be real and the patch looks sane. Chunming Zhou, do you want to fix it like this, or preallocate
> a fence obj? If former, just ack. :)

Well, wait a second with that advise1

The problem here is that userspace (indirectly) controls when this 
allocation is made. So what you could do is to construct some code to 
force the kernel into doing a *lot* of GFP_ATOMIC allocations.

And when the kernel runs out of GFP_ATOMIC space, then well bad things 
start to happen :)

Christian.

>
> ~Maarten
>> tree:   git://anongit.freedesktop.org/drm/drm-tip drm-tip
>> head:   8d7ffd2298c607c3e1a16f94d51450d7940fd6a7
>> commit: 48197bc564c7a1888c86024a1ba4f956e0ec2300 [1968/2033] drm: add syncobj timeline support v9
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
>

