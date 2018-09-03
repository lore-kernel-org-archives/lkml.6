Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1549BC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EDD220868
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOBfWoZy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EDD220868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbeICQZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 12:25:37 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51262 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbeICQZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 12:25:37 -0400
Received: by mail-wm0-f66.google.com with SMTP id y2-v6so954013wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 05:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=XmlH+vjlCUvCJegkf+onBk0FnlaHOrdJmdKR0a5enRY=;
        b=gOBfWoZyyGPjCi4B6sjyJrKRe34qr2h2vfdSobaHSlf3PY934eFWetE8gDmoa+IZHy
         kG3iX7+NOuOxx4F82Fgr0/pvtlY0GTpg94m2PynMQblLhBn4/eofuTbMgR9UFKjbI4Vr
         1RyhEJBCXbG8s8jXpgbGMqBjq2F0n4E//Oz8V5geJsUzb4RghZ9dT7WsWchsOhQxPfy1
         mNFJLxNqVcY/IA0/+tn6i5QzAtJ/NVbwQoUauneKOu91ji6CZjeFsHOUdZHcOHH8VfTA
         UtX+JNIwn6P/CGKk1jCJ45DWiwo1SygVUwTYwz1aUnZwcpGKlfn05tW/AFBh1ZFKaUBP
         jFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=XmlH+vjlCUvCJegkf+onBk0FnlaHOrdJmdKR0a5enRY=;
        b=mEoKKVF1VE8jUjYqV/IcGARN3/6NZ9sY5VGXDFs4TTcP15I0/m1q6dS8S4giDVdqaL
         5BPlIEPaJaxb+HoA0cgR8869l5/wPcZAN9s4ICDoTcp4JsvWvv7rzgEo8gbIORSu5fVN
         V8rYJsY/2PO7hNoBAQxbh7HVMyCDthO5HK9WuExUeZzQD5wIoZoUF+Dh7eyLoWt+7jEW
         97iMTaxELuvbXHSxM1oCAid+wyspt5pz2gDLRkxaTF8/i2LxHlWaPun4sgtvza4JCZV9
         cgWXajy8z2ifu9zTObhcBzb+9BFQk/RH1nCG1Cqm6yU6knkrHZoeRuJSa8PLs5v98dWo
         zFyA==
X-Gm-Message-State: APzg51Bc2p72zkXUj7RDPaM0nWrzYa4LHUbUtoYpa7EUWkjfLFy5UbXV
        4I+CGY23OC+wsNDq2rJvhv8=
X-Google-Smtp-Source: ANB0VdbmwJH8dLyidx1XTWcNxh0vf4CPxqhJs/a+HIxST3EZ1cVCOxZRvGEoUVHXW1hmv8vtD8aDBw==
X-Received: by 2002:a1c:4e16:: with SMTP id g22-v6mr5349693wmh.111.1535976344383;
        Mon, 03 Sep 2018 05:05:44 -0700 (PDT)
Received: from ?IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740? ([2a02:908:1257:4460:1ab8:55c1:a639:6740])
        by smtp.gmail.com with ESMTPSA id l10-v6sm18456319wre.0.2018.09.03.05.05.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 05:05:43 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH] gpu: drm: drm_mm: Fix a sleep-in-atomic-context bug in
 show_leaks()
To:     Chris Wilson <chris@chris-wilson.co.uk>,
        Jia-Ju Bai <baijiaju1990@gmail.com>, airlied@linux.ie,
        gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        seanpaul@chromium.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Alex Deucher <alexdeucher@gmail.com>,
        amd-gfx@lists.freedesktop.org, David Zhou <David1.Zhou@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20180901122041.2357-1-baijiaju1990@gmail.com>
 <153580517420.12034.2035309606925619207@skylake-alporthouse-com>
 <20180903075244.GE21634@phenom.ffwll.local>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <8e811ad1-ed57-0e1c-1b52-df0dc02923dc@gmail.com>
Date:   Mon, 3 Sep 2018 14:05:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180903075244.GE21634@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 03.09.2018 um 09:52 schrieb Daniel Vetter:
> On Sat, Sep 01, 2018 at 01:32:54PM +0100, Chris Wilson wrote:
>> Quoting Jia-Ju Bai (2018-09-01 13:20:41)
>>> The driver may sleep with holding a spinlock.
>>>
>>> The function call paths (from bottom to top) in Linux-4.16 are:
>>>
>>> [FUNC] kmalloc(GFP_KERNEL)
>>> drivers/gpu/drm/drm_mm.c, 130:
>>>          kmalloc in show_leaks
>>> drivers/gpu/drm/drm_mm.c, 913:
>>>          show_leaks in drm_mm_takedown
>>> drivers/gpu/drm/drm_vma_manager.c, 107:
>>>          drm_mm_takedown in drm_vma_offset_manager_destroy
>>> drivers/gpu/drm/drm_vma_manager.c, 106:
>>>          _raw_write_lock in drm_vma_offset_manager_destroy
>>>
>>> [FUNC] kmalloc(GFP_KERNEL)
>>> drivers/gpu/drm/drm_mm.c, 130:
>>>          kmalloc in show_leaks
>>> drivers/gpu/drm/drm_mm.c, 913:
>>>          show_leaks in drm_mm_takedown
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c, 71:
>>>          drm_mm_takedown in amdgpu_vram_mgr_fini
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c, 70:
>>>          spin_lock in amdgpu_vram_mgr_fini
>>>
>>> [FUNC] kmalloc(GFP_KERNEL)
>>> drivers/gpu/drm/drm_mm.c, 130:
>>>          kmalloc in show_leaks
>>> drivers/gpu/drm/drm_mm.c, 913:
>>>          show_leaks in drm_mm_takedown
>>> drivers/gpu/drm/ttm/ttm_bo_manager.c, 128:
>>>          drm_mm_takedown in ttm_bo_man_takedown
>>> drivers/gpu/drm/ttm/ttm_bo_manager.c, 126:
>>>          spin_lock in ttm_bo_man_takedown
>>>
>>> To fix this bug, GFP_KERNEL is replaced with GFP_ATOMIC.
>> The bug are above, since those spinlocks do not protect the data and
>> imply use-after-free.
> Adding amdgpu, since that's where the bug seems to be.

When we have use after free we might have concurrent uses as well.

I think taking the lock here is probably a good idea if you don't want 
to accidentally access freed memory in show_leaks.

So Chris change sounds valid to me.

Christian.

> -Daniel

