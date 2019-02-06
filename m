Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0907FC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB6C22175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1XRxbRw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfBFSio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:38:44 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41187 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfBFSin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:38:43 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so8727851wrs.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 10:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=MbFwoMgUhiXyNtpcCvwACbIJvZ6c0BECx7NE8js6t78=;
        b=H1XRxbRwgKVCQ9Ljq7xEvqlKpI9UNcQiipOfDNSMhGASAcMrPpX4Rhm1Uc4kbpT5nw
         VzjWXdaPNmf+BLQukVHJ6+qlL/K3fv292cTnwDAebRxC7HSdrwt50bPhnZN2YRlquMTV
         vzU9tGj44JzCdu1G16BNdAYawMGb1oaw1PIj4K+OyJADV3iDYbxfV3fbyW0Zk2jByITh
         ZRVoQ9O+tArQeKIHy0OR2q4VcdwUfW6rR9Ib9klteFLMduJTWlwpkm0ViogBaHVYjxzT
         vCDwYFNCCM9WsrvNbfZSxdOCqKgg3jpN8xPC1J2mPVu5a/2IrvrkqpqDAZWlSFL88DLS
         PtVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=MbFwoMgUhiXyNtpcCvwACbIJvZ6c0BECx7NE8js6t78=;
        b=gLRD3uCyWSGIB/lrBHTEyVLPvM+NJnPzKLrp1RAbHznmlCiWrNzpOavbjl1Azt9PwQ
         VPYld+snrZnPsGQjrLnAj7i0+ODFt0TjdOzaYQ9JEcyzh5STUeXQIQWYt4vivHA7LCdr
         u2shsljCHc91OgPnGInEaZ06hYAAwgsmS/loHIwvCn64FpTOq/ajxtM7/XA9ODBoVTuk
         jWrDfrdtJqVUWMt3LGnqTmzM/8Q65bLLstJWthcHLk7bx9UF8546wxE4M38+K4Lvp1tc
         6GPwMP9xHNz1UuSIlrKbRgDHdh8xKVyCBYYaDx9woR/nKreJ9wCS7L9mqiBofJyJlkoJ
         bZuA==
X-Gm-Message-State: AHQUAuYYG1N+A2uPi68yQZ8q7fIaZVImmbMyzzEELTtOxuiAOIKG8pLl
        +fa2WMmm/4BRN9nZUu6bwqM=
X-Google-Smtp-Source: AHgI3IbiyIjOuNw8QTjdk18aVp2glLugGCAMBpzpPvstKZLHP58L23nP4fiH/iuwPY5Xk4B5ckpFuQ==
X-Received: by 2002:adf:f9cb:: with SMTP id w11mr8863806wrr.201.1549478321369;
        Wed, 06 Feb 2019 10:38:41 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id t12sm9151887wra.63.2019.02.06.10.38.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 10:38:40 -0800 (PST)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH] drm: enable uncached DMA optimization for ARM and arm64
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Koenig, Christian" <christian.koenig@amd.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Carsten Haitzler <Carsten.Haitzler@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        David Airlie <airlied@linux.ie>,
        "Daenzer, Michel" <Michel.Daenzer@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Zhang, Jerry" <Jerry.Zhang@amd.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexdeucher@gmail.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Sean Paul <sean@poorly.run>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Robin Murphy <robin.murphy@arm.com>
References: <20190124120658.30288-1-ard.biesheuvel@linaro.org>
 <3cca35a9-c71c-a100-b29d-31ba0d1d10b1@amd.com>
 <CAKv+Gu9OG3O4+4F2nioaQ-3U-1kwRBr5KVj-1gD1ZEsUx_Ud5A@mail.gmail.com>
 <CADnq5_PETD6umm9Df7OZ9BdaV5MZutmhN+HTAnVkcRLg5=TNWw@mail.gmail.com>
 <CAKv+Gu-Yk1iEe+cF30ee7R+hcrke9XH9MdTeERA2P-0s2QpaLw@mail.gmail.com>
 <961e758d-b0a0-8f6c-a8fa-c3047e058706@gmail.com>
 <CAKv+Gu_faPAf+0NBTNM03EUH4-_0vWbPfDQneshps5vbaU4R_Q@mail.gmail.com>
 <CAKv+Gu-4=1r8X8BUvRjcTwgxj=sZpZLyY3ABBZyzh-RsSm1eXg@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <f6bdd647-722b-8145-92d4-3f6c52f8a74c@gmail.com>
Date:   Wed, 6 Feb 2019 19:38:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu-4=1r8X8BUvRjcTwgxj=sZpZLyY3ABBZyzh-RsSm1eXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 06.02.19 um 18:23 schrieb Ard Biesheuvel:
> On Fri, 25 Jan 2019 at 11:35, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> On Fri, 25 Jan 2019 at 12:30, Christian König
>> <ckoenig.leichtzumerken@gmail.com> wrote:
>>> Am 25.01.19 um 09:43 schrieb Ard Biesheuvel:
>>>> On Thu, 24 Jan 2019 at 15:01, Alex Deucher <alexdeucher@gmail.com> wrote:
>>>>> On Thu, Jan 24, 2019 at 9:00 AM Ard Biesheuvel
>>>>> <ard.biesheuvel@linaro.org> wrote:
>>>>>> On Thu, 24 Jan 2019 at 13:31, Koenig, Christian
>>>>>> <Christian.Koenig@amd.com> wrote:
>>>>>>> Am 24.01.19 um 13:06 schrieb Ard Biesheuvel:
>>>>>>>> The DRM driver stack is designed to work with cache coherent devices
>>>>>>>> only, but permits an optimization to be enabled in some cases, where
>>>>>>>> for some buffers, both the CPU and the GPU use uncached mappings,
>>>>>>>> removing the need for DMA snooping and allocation in the CPU caches.
>>>>>>>>
>>>>>>>> The use of uncached GPU mappings relies on the correct implementation
>>>>>>>> of the PCIe NoSnoop TLP attribute by the platform, otherwise the GPU
>>>>>>>> will use cached mappings nonetheless. On x86 platforms, this does not
>>>>>>>> seem to matter, as uncached CPU mappings will snoop the caches in any
>>>>>>>> case. However, on ARM and arm64, enabling this optimization on a
>>>>>>>> platform where NoSnoop is ignored results in loss of coherency, which
>>>>>>>> breaks correct operation of the device. Since we have no way of
>>>>>>>> detecting whether NoSnoop works or not, just disable this
>>>>>>>> optimization entirely for ARM and arm64.
>>>>>>>>
>>>>>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>> Cc: David Zhou <David1.Zhou@amd.com>
>>>>>>>> Cc: Huang Rui <ray.huang@amd.com>
>>>>>>>> Cc: Junwei Zhang <Jerry.Zhang@amd.com>
>>>>>>>> Cc: Michel Daenzer <michel.daenzer@amd.com>
>>>>>>>> Cc: David Airlie <airlied@linux.ie>
>>>>>>>> Cc: Daniel Vetter <daniel@ffwll.ch>
>>>>>>>> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>>>>>>>> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
>>>>>>>> Cc: Sean Paul <sean@poorly.run>
>>>>>>>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>>>>>>>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>>>>>>> Cc: Will Deacon <will.deacon@arm.com>
>>>>>>>> Cc: Christoph Hellwig <hch@infradead.org>
>>>>>>>> Cc: Robin Murphy <robin.murphy@arm.com>
>>>>>>>> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
>>>>>>>> Cc: dri-devel <dri-devel@lists.freedesktop.org>
>>>>>>>> Reported-by: Carsten Haitzler <Carsten.Haitzler@arm.com>
>>>>>>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>>>>>> The subject line should probably read "disable uncached...".
>>>>>>>
>>>>>> Ugh, of course ...
>>>>>>
>>>>>>> With that fixed the patch is Reviewed-by: Christian König
>>>>>>> <christian.koenig@amd.com>.
>>>>>>>
>>>>> Same:
>>>>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>
>>>> Thanks all
>>>>
>>>> Should I resend the patch with the subject corrected?
>>> I will update the subject line and push it upstream through
>>> drm-misc-next if nobody objects.
>>>
>> Wonderful, thanks.
> Hi Christian,
>
> Are you still planning to merge this for v5.1?

My bad, only pushed this to our internal branch, but forgot out 
drm-misc-next.

Fixed now, thanks for the reminder.

Christian.

>
> Thanks,
> Ard.
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

