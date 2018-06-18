Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3A0C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D173B2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oejTEKmB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D173B2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934986AbeFROhF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 10:37:05 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51357 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934732AbeFROhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 10:37:03 -0400
Received: by mail-wm0-f65.google.com with SMTP id r15-v6so14492782wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 07:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=o34j44tVEGj8rQg2aAPlVCkLvR0VvXuTr5Pe55aeq7s=;
        b=oejTEKmBkG/tVGFYVi8X8oO/ySqxHKM64rhcYQAmsGeVgC7j/EadWeMjMisR9ZZO+3
         EfhgeWOoWkGTGI45HggL+PqlY60HBS4TciPH8WD1qhEtlpVZ7C9KnedWPC70JXgSTvWb
         k9z4zQo5JL3dAR+qwrC1yu2LbblaB/ZU5W1ypWyxU9j5vJEaggCQtpLJuWh/i2PFJ9Yo
         ABObDr6M7R/KdS7wqpaqDVctyW78GHyiXMqBBfF3glSUWB4sZAHj9rYQ48ISy9Wr9Fn2
         RcV7ILh8SUhE7yq7kJtL3gXQkavVSZP4K+G/ur0Nd/RQUy7ab3iFeTXGydCdDqRiiKG1
         STAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=o34j44tVEGj8rQg2aAPlVCkLvR0VvXuTr5Pe55aeq7s=;
        b=GjrJ8ShI2fliDkB0KJwIF4jXoTakAp7hAbU4MQUQqnE2lqGkeQBCohH4Vt+A+NUvR6
         aWnaJjq56NciR3a3TjgdnxbwTX11LAHM2Yvmki3EU812cA66eHmPT0nN67V87vDaz1Xx
         lUXzYpJirYP45ilYr3mc6wP3Zfej5/9CtOJshFdxofLiIzZ7jI+w975gT1GZZThqGp0v
         SxNgqzLASxxWsExP0Vqz4wAbU806RwwEUu0H0U5v58/4EJE57AlRa49Jlk3N1xGy3V1n
         v2AirSWQpqlLFyFji9LCo/+PIbhoGm0R4hKZVh6lmg0u60WKO65Zc7hIftk+c3z9MNOo
         eELg==
X-Gm-Message-State: APt69E28bIyq7VsXk3Klc4EdCr9+wLpJxTLtnN8k+HpBhnZTXHcrnrLV
        JCEElLEfcpBO/wGUsvRJivBUwQQOCpOEULMLcRE=
X-Google-Smtp-Source: ADUXVKIfj2SoJRxdS6yPxnUnRfYw16OIc48mpBZIYe7JacRTCuTnPgrOIlv5u1WGjF0PSVI4R0ZdzWzSU2fi6TqgGnw=
X-Received: by 2002:a1c:d482:: with SMTP id l124-v6mr8169391wmg.22.1529332622636;
 Mon, 18 Jun 2018 07:37:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a3cf:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 07:37:02
 -0700 (PDT)
In-Reply-To: <625b2c05-c923-cd5c-cc48-cbc51ba3d3ee@amd.com>
References: <20180617085218.7753-1-stefan@agner.ch> <625b2c05-c923-cd5c-cc48-cbc51ba3d3ee@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 18 Jun 2018 10:37:02 -0400
Message-ID: <CADnq5_Or8naSMnEBYTGKf6bEprByphrJENf335dVesLeSKLSyA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: use first uvd instance to avoid clang build error
To:     James Zhu <jamesz@amd.com>
Cc:     Stefan Agner <stefan@agner.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        James Zhu <James.Zhu@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 17, 2018 at 10:03 PM, James Zhu <jamesz@amd.com> wrote:
>
>
> On 2018-06-17 04:52 AM, Stefan Agner wrote:
>>
>> Explicitly use the first uvd instance to avoid a build error when
>> using clang 6:
>> drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1148:52: error: expected ')'
>>                  container_of(work, struct amdgpu_device,
>> uvd.inst->idle_work.work);
>>                                                                   ^
>> drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1148:3: note: to match this '('
>>                  container_of(work, struct amdgpu_device,
>> uvd.inst->idle_work.work);
>>                  ^
>> ./include/linux/kernel.h:967:21: note: expanded from macro 'container_of'
>>          ((type *)(__mptr - offsetof(type, member))); })
>>                             ^
>> ./include/linux/stddef.h:17:32: note: expanded from macro 'offsetof'
>>                                  ^
>> ./include/linux/compiler-gcc.h:170:20: note: expanded from macro
>>        '__compiler_offsetof'
>>          __builtin_offsetof(a, b)
>>                            ^
>> drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1147:24: error: initializing
>>        'struct amdgpu_device *' with an expression of incompatible type
>> 'void'
>>          struct amdgpu_device *adev =
>>                                ^
>> 2 errors generated.
>>
>> Fixes: 10dd74eac4db ("drm/amdgpu/vg20:Restruct uvd.inst to support
>> multiple instances")
>> Cc: James Zhu <James.Zhu@amd.com>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>> index bcf68f80bbf0..6666a5888c44 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>> @@ -1145,7 +1145,7 @@ int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring
>> *ring, uint32_t handle,
>>   static void amdgpu_uvd_idle_work_handler(struct work_struct *work)
>>   {
>>         struct amdgpu_device *adev =
>> -               container_of(work, struct amdgpu_device,
>> uvd.inst->idle_work.work);
>> +               container_of(work, struct amdgpu_device,
>> uvd.inst[0].idle_work.work);
>
> Hi Alex,
> If all instances share one idle work from hardware view currently and in the
> future ,
> should we move struct delayed_work idle_work from struct amdgpu_uvd_inst to
> struct amdgpu_uvd?

Yes, please do.

Alex

> James
>>
>>         unsigned fences = 0, i, j;
>>         for (i = 0; i < adev->uvd.num_uvd_inst; ++i) {
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
