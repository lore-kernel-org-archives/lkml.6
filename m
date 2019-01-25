Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E820C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B19217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7hsD2HS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbfAYLag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 06:30:36 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56057 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728243AbfAYLa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 06:30:28 -0500
Received: by mail-wm1-f65.google.com with SMTP id y139so6351774wmc.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 03:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=sCdp2Rt8P2db7n8Wc/FgdknXH7w2aWs6zOYycWOYUKw=;
        b=D7hsD2HSGukLPUiAdy7pxgVxpTIlbFUspp94Zb1X3ecIViMsWAF3a6dQdKxb16wgSK
         2jJJD1gqPACPdAwYKe67IMrXSiSdgTd+GtUZVmSJjI85YFdc5ruBBREFor0J13cxHvEp
         mik/KbUPn+jlyilaviJf+ZRpZpC2NgsnkWqax8AwGC157ULRioO2BW65g1mTkpJx+2JG
         UdCGw+7Wk5AKrnTygjPCxIz5+k9u+YLpvhXP+S1zJVP0yn8J2+ol714AUW3+c+NT5J/m
         CWMGxGNajjrXdHZBeJvKVGG7q9otj8bUVQoOFHMfPWflfQBzUlbJtFYS/ILRmaUODDTJ
         javw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=sCdp2Rt8P2db7n8Wc/FgdknXH7w2aWs6zOYycWOYUKw=;
        b=pWunyWDytb1mEtw+0PZZoVEmYUe4GtxRzYHvhU91MbAfjc6YN9TGiTBylsvIIjCbgP
         3xTZoPgI2eirR+B9r/ecyYCOzsGAj3bdQ93g0EUJW7oZpCbi9M8NOwzZ9IChDKg890HW
         rZ9x/3Nzgg1abu8UFTDQk1qfFKRrGkgqL0Bhx7yuwGiD7BIObu9ODPxF7PAhoD46weks
         fvQv5AoyOHpAbXgUjlHy2hK4u4MQ2Ol5vew35FDa3z98NghAhDyouNM/EVhoFF6mayY+
         5xQ9rnvjVEgGof56A2czHRokU7Fj8GwGqG/TYZzqoPcDi1AYFGLcoM/EyNwC2Zbtc1wg
         zSGg==
X-Gm-Message-State: AJcUukdMpltGFpywGWeE/BshLiiTffMX/P72izODa7fV6/rlufS8daU0
        lNPXNYz8iiUArL0lQ5ouSTs=
X-Google-Smtp-Source: ALg8bN7kx19hKSpc1uuOm4Ioz6PhXpMkVoP20wE7P34Sg70Lt+9UZyYG+elF2rJDrqyKlqIq4GqDHw==
X-Received: by 2002:a7b:c4cb:: with SMTP id g11mr6491725wmk.149.1548415825578;
        Fri, 25 Jan 2019 03:30:25 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id p5sm33889642wmh.16.2019.01.25.03.30.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 03:30:25 -0800 (PST)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH] drm: enable uncached DMA optimization for ARM and arm64
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Alex Deucher <alexdeucher@gmail.com>
Cc:     "Daenzer, Michel" <Michel.Daenzer@amd.com>,
        Carsten Haitzler <Carsten.Haitzler@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Zhang, Jerry" <Jerry.Zhang@amd.com>,
        Christoph Hellwig <hch@infradead.org>,
        David Airlie <airlied@linux.ie>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Will Deacon <will.deacon@arm.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Sean Paul <sean@poorly.run>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Robin Murphy <robin.murphy@arm.com>
References: <20190124120658.30288-1-ard.biesheuvel@linaro.org>
 <3cca35a9-c71c-a100-b29d-31ba0d1d10b1@amd.com>
 <CAKv+Gu9OG3O4+4F2nioaQ-3U-1kwRBr5KVj-1gD1ZEsUx_Ud5A@mail.gmail.com>
 <CADnq5_PETD6umm9Df7OZ9BdaV5MZutmhN+HTAnVkcRLg5=TNWw@mail.gmail.com>
 <CAKv+Gu-Yk1iEe+cF30ee7R+hcrke9XH9MdTeERA2P-0s2QpaLw@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <961e758d-b0a0-8f6c-a8fa-c3047e058706@gmail.com>
Date:   Fri, 25 Jan 2019 12:30:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu-Yk1iEe+cF30ee7R+hcrke9XH9MdTeERA2P-0s2QpaLw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 25.01.19 um 09:43 schrieb Ard Biesheuvel:
> On Thu, 24 Jan 2019 at 15:01, Alex Deucher <alexdeucher@gmail.com> wrote:
>> On Thu, Jan 24, 2019 at 9:00 AM Ard Biesheuvel
>> <ard.biesheuvel@linaro.org> wrote:
>>> On Thu, 24 Jan 2019 at 13:31, Koenig, Christian
>>> <Christian.Koenig@amd.com> wrote:
>>>> Am 24.01.19 um 13:06 schrieb Ard Biesheuvel:
>>>>> The DRM driver stack is designed to work with cache coherent devices
>>>>> only, but permits an optimization to be enabled in some cases, where
>>>>> for some buffers, both the CPU and the GPU use uncached mappings,
>>>>> removing the need for DMA snooping and allocation in the CPU caches.
>>>>>
>>>>> The use of uncached GPU mappings relies on the correct implementation
>>>>> of the PCIe NoSnoop TLP attribute by the platform, otherwise the GPU
>>>>> will use cached mappings nonetheless. On x86 platforms, this does not
>>>>> seem to matter, as uncached CPU mappings will snoop the caches in any
>>>>> case. However, on ARM and arm64, enabling this optimization on a
>>>>> platform where NoSnoop is ignored results in loss of coherency, which
>>>>> breaks correct operation of the device. Since we have no way of
>>>>> detecting whether NoSnoop works or not, just disable this
>>>>> optimization entirely for ARM and arm64.
>>>>>
>>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>> Cc: David Zhou <David1.Zhou@amd.com>
>>>>> Cc: Huang Rui <ray.huang@amd.com>
>>>>> Cc: Junwei Zhang <Jerry.Zhang@amd.com>
>>>>> Cc: Michel Daenzer <michel.daenzer@amd.com>
>>>>> Cc: David Airlie <airlied@linux.ie>
>>>>> Cc: Daniel Vetter <daniel@ffwll.ch>
>>>>> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>>>>> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
>>>>> Cc: Sean Paul <sean@poorly.run>
>>>>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>>>>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>>>> Cc: Will Deacon <will.deacon@arm.com>
>>>>> Cc: Christoph Hellwig <hch@infradead.org>
>>>>> Cc: Robin Murphy <robin.murphy@arm.com>
>>>>> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
>>>>> Cc: dri-devel <dri-devel@lists.freedesktop.org>
>>>>> Reported-by: Carsten Haitzler <Carsten.Haitzler@arm.com>
>>>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>>> The subject line should probably read "disable uncached...".
>>>>
>>> Ugh, of course ...
>>>
>>>> With that fixed the patch is Reviewed-by: Christian König
>>>> <christian.koenig@amd.com>.
>>>>
>> Same:
>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>>
> Thanks all
>
> Should I resend the patch with the subject corrected?

I will update the subject line and push it upstream through 
drm-misc-next if nobody objects.

Christian.

> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

