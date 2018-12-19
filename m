Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB23C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4844218C3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hx3VYrFz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbeLSRx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 12:53:56 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41560 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728491AbeLSRx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 12:53:56 -0500
Received: by mail-pl1-f194.google.com with SMTP id u6so9783973plm.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 09:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4Z/v67/vlB54ndWsugDUscflQWUKBr9V+KlB0WvHYZw=;
        b=Hx3VYrFziGa2DVTMXCDNlosgpUJ/zRB8k78pTwd4bmKEscjZDe4+D6hHGO4CJxnbT3
         uGPGvF62Cdf7ScAJ6PrlTCgUE3QVtiQ049UY88QfSyszj0VWYpf6PdK0vsm+N9NZbtJK
         6He+N+c/0xnOQRysHmCSIRols/kX2cIdQd9Xf92oU16twSo640yff09fAkdlt7bTMTcR
         ZFRzCNFDYaeG9lZ7Mr6XDLp0IzEK06ypVJV8e1MKRw5dkcZVC3CKatgEUh1gQYJnGm1q
         xOF24TZo5m3H2zbbASfDcq0kkXjNWtpzTYOEh1AwAerSb/og8YalaEUlvzN0UIVnOR2e
         bwsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4Z/v67/vlB54ndWsugDUscflQWUKBr9V+KlB0WvHYZw=;
        b=qXQGXSjwjN0LoigwcEW5UzVq8H0oReK4P9ASAIdBJU+lxh569xcRMhtcJFy5CIKgiT
         4J/AejRwIgYuDYXfNcYIHELH8huzdVs3gBOpRZjS5xsgxNy2q6lFoeWwdAyXyLTBf/Vm
         bc/IvID186klw+HpWKov+wtwUkcXyiWyeYDJpQDv04AfY91PEKth1wueF+tK+e80YCs7
         XJ86rnZzsB0QdcI6HNY5CuR9AHg+eTWeYiWuJVv0HPzktIcUKxQWM+qZThxDe/sk5abK
         kEmyNEY3VT0Y2Vheyj+OqQs2uGjCxlKb66vUEs6lqF571ZQkeA/ceI+O0sD5rCGQUMl0
         lTEQ==
X-Gm-Message-State: AA+aEWYjeX5TJswHXYpjWRVJax+N5uAZZ+YRLSOa6KPFrUWc90NveQxD
        T3wbGBk+OLXz+cWHyXKmryg=
X-Google-Smtp-Source: AFSGD/UbNhHOefpDnzzqCzysbDNbBrPvgMVJvQmUEFkQYENsOYIHCel63FcjdtvQy9B53O/vKV3PfQ==
X-Received: by 2002:a17:902:2969:: with SMTP id g96mr21059005plb.295.1545242035230;
        Wed, 19 Dec 2018 09:53:55 -0800 (PST)
Received: from [192.168.2.145] ([94.29.36.169])
        by smtp.googlemail.com with ESMTPSA id c7sm31069782pfa.24.2018.12.19.09.53.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 09:53:54 -0800 (PST)
Subject: Re: [PATCH 2/2] drm: Revert syncobj timeline changes.
To:     Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, Chunming Zhou <david1.zhou@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jason Ekstrand <jason@jlekstrand.net>
References: <20181108160422.17743-1-eric@anholt.net>
 <20181108160422.17743-3-eric@anholt.net>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <faf15d58-a076-49fb-c903-15acdf6f8ffe@gmail.com>
Date:   Wed, 19 Dec 2018 20:53:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181108160422.17743-3-eric@anholt.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.11.2018 19:04, Eric Anholt wrote:
> Daniel suggested I submit this, since we're still seeing regressions
> from it.  This is a revert to before 48197bc564c7 ("drm: add syncobj
> timeline support v9") and its followon fixes.
> 
> Fixes this on first V3D testcase execution:
> 
> [   48.767088] ============================================
> [   48.772410] WARNING: possible recursive locking detected
> [   48.777739] 4.19.0-rc6+ #489 Not tainted
> [   48.781668] --------------------------------------------
> [   48.786993] shader_runner/3284 is trying to acquire lock:
> [   48.792408] ce309d7f (&(&array->lock)->rlock){....}, at: dma_fence_add_callback+0x30/0x23c
> [   48.800714]
> [   48.800714] but task is already holding lock:
> [   48.806559] c5952bd3 (&(&array->lock)->rlock){....}, at: dma_fence_add_callback+0x30/0x23c
> [   48.814862]
> [   48.814862] other info that might help us debug this:
> [   48.821410]  Possible unsafe locking scenario:
> [   48.821410]
> [   48.827338]        CPU0
> [   48.829788]        ----
> [   48.832239]   lock(&(&array->lock)->rlock);
> [   48.836434]   lock(&(&array->lock)->rlock);
> [   48.840640]
> [   48.840640]  *** DEADLOCK ***
> [   48.840640]
> [   48.846582]  May be due to missing lock nesting notation
> [  130.763560] 1 lock held by cts-runner/3270:
> [  130.767745]  #0: 7834b793 (&(&array->lock)->rlock){-...}, at: dma_fence_add_callback+0x30/0x23c
> [  130.776461]
>                stack backtrace:
> [  130.780825] CPU: 1 PID: 3270 Comm: cts-runner Not tainted 4.19.0-rc6+ #486
> [  130.787706] Hardware name: Broadcom STB (Flattened Device Tree)
> [  130.793645] [<c021269c>] (unwind_backtrace) from [<c020db1c>] (show_stack+0x10/0x14)
> [  130.801404] [<c020db1c>] (show_stack) from [<c0c2c4b0>] (dump_stack+0xa8/0xd4)
> [  130.808642] [<c0c2c4b0>] (dump_stack) from [<c0281a84>] (__lock_acquire+0x848/0x1a68)
> [  130.816483] [<c0281a84>] (__lock_acquire) from [<c02835d8>] (lock_acquire+0xd8/0x22c)
> [  130.824326] [<c02835d8>] (lock_acquire) from [<c0c49948>] (_raw_spin_lock_irqsave+0x54/0x68)
> [  130.832777] [<c0c49948>] (_raw_spin_lock_irqsave) from [<c086bf54>] (dma_fence_add_callback+0x30/0x23c)
> [  130.842183] [<c086bf54>] (dma_fence_add_callback) from [<c086d4c8>] (dma_fence_array_enable_signaling+0x58/0xec)
> [  130.852371] [<c086d4c8>] (dma_fence_array_enable_signaling) from [<c086c00c>] (dma_fence_add_callback+0xe8/0x23c)
> [  130.862647] [<c086c00c>] (dma_fence_add_callback) from [<c06d8774>] (drm_syncobj_wait_ioctl+0x518/0x614)
> [  130.872143] [<c06d8774>] (drm_syncobj_wait_ioctl) from [<c06b8458>] (drm_ioctl_kernel+0xb0/0xf0)
> [  130.880940] [<c06b8458>] (drm_ioctl_kernel) from [<c06b8818>] (drm_ioctl+0x1d8/0x390)
> [  130.888782] [<c06b8818>] (drm_ioctl) from [<c03a4510>] (do_vfs_ioctl+0xb0/0x8ac)
> [  130.896187] [<c03a4510>] (do_vfs_ioctl) from [<c03a4d40>] (ksys_ioctl+0x34/0x60)
> [  130.903593] [<c03a4d40>] (ksys_ioctl) from [<c0201000>] (ret_fast_syscall+0x0/0x28)
> 
> Cc: Chunming Zhou <david1.zhou@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---


[snip]

> @@ -931,9 +718,6 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>  
>  	if (flags & DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT) {
>  		for (i = 0; i < count; ++i) {
> -			if (entries[i].fence)
> -				continue;
> -
>  			drm_syncobj_fence_get_or_add_callback(syncobjs[i],
>  							      &entries[i].fence,
>  							      &entries[i].syncobj_cb,

Hello,

The above three removed lines we added in commit 337fe9f5c1e7de ("drm/syncobj: Don't leak fences when WAIT_FOR_SUBMIT is set") that fixed a memleak. Removal of the lines returns the memleak because of disbalanced fence refcounting and it looks like they were removed unintentionally in this patch.

-- 
Dmitry
