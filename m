Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id c0+7McolGVtXbgAAmS7hNA
	; Thu, 07 Jun 2018 12:33:28 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8F2E7608B8; Thu,  7 Jun 2018 12:33:28 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2/pn+DZ"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E0424607E7;
	Thu,  7 Jun 2018 12:33:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E0424607E7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753610AbeFGMdT (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 08:33:19 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:39522 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753149AbeFGMdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 08:33:18 -0400
Received: by mail-lf0-f67.google.com with SMTP id t134-v6so14423920lff.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 05:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ggJIrkGvnqS7MZXBl9lhXRo6QP4HS/i/CZqN/A01uvI=;
        b=f2/pn+DZ9G4F7ROv/QIlCBlbowzWeJLaKQuuIrEiEMdW2/gHWucfphD5PSu+/YN1+N
         G8NfqXiGDCFpmE697eVGGdEMbzgROoZDFOP4YXiiYRFvekLFQkA4tdM2gMgtRPUprYWD
         2Tp7U9cRsVhd+6ddIUr/MGxYsmWSFPowI1MaqE2a2KnDfUXqv9o5Zwy140hemwDuwybC
         +8qJuWnJNCYNP0WPUoV5saAmbemvk182XJ2KMTUWJoHg2dGln6blVb36UmASQfYhMcDB
         NI6m2Zqlngael1afhB+NVKADzEAAIFdhEf2K9mh8bqbGQid/iEMP39ygTTjJZxejTc3v
         Ed3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ggJIrkGvnqS7MZXBl9lhXRo6QP4HS/i/CZqN/A01uvI=;
        b=logcvdBPF1IL6/8u2rsKn+um6xOxRw3bDL+VKXkC9/PN4A8af5GfY5IC0bym9n91Ty
         A5P5Rd7h1LE+EYuUAAmrqmPmRVGASZ8b4t7tt+IG/PIoSpAq21Z068qXu/zeL209FwDr
         k8oSsUHceHIGBnS+gUOPs2ibhYGDWvhIlFirx66Jrt1THELvd0QGvv4ryYhkB42AFeqC
         Lgre8B2P7nKsVy3Agkw5QVaFtoYUnO9Okkb7pnxr7hpmKsC2OAwYLr4HmUX3BuXYyhJA
         GBOJh5AH5sxUEDwf/KFiwWF73OWj300jlqs4LWJ+gpiPpj1lyAb70swWzc+FMIZ+uH90
         KZVA==
X-Gm-Message-State: APt69E3G3Cn0W+MiUDpEiNirADgKN7+yih00p7kE0e8b+LOM4SC3ytx9
        7fMHoVE/Pwgt9tfUJS7Q+c1T2tMjyiU+z+gawg==
X-Google-Smtp-Source: ADUXVKJuoppaft1nCFlZw/UagWkQW2s1Q+Q2TQ3RRca8lson3gw5zESugtV9hr2VrFe595S4R9MV+5+fAMCOOu8qRng=
X-Received: by 2002:a19:c90d:: with SMTP id z13-v6mr1277807lff.0.1528374796670;
 Thu, 07 Jun 2018 05:33:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:e45c:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 05:32:46 -0700 (PDT)
In-Reply-To: <267c42ce-91e2-4843-3815-904ac74b2f44@amd.com>
References: <CAEJqkgiNVDzboDK1vsn9rYP0G=Q_mGDrkx1VVB8TUkm35Rs9fA@mail.gmail.com>
 <516cddbe-73c2-01f3-a552-0d9fd75ce63a@amd.com> <8f7d00f9-992f-cc07-6bd0-b1b47c5d2ccf@amd.com>
 <ae904954-18f7-180a-ce69-7e7618bd398f@daenzer.net> <CAEJqkgjErpxG44CZXn2BzvPES7Ptf24ae6748dAcYdg2n5HuZw@mail.gmail.com>
 <267c42ce-91e2-4843-3815-904ac74b2f44@amd.com>
From: Gabriel C <nix.or.die@gmail.com>
Date: Thu, 7 Jun 2018 14:32:46 +0200
Message-ID: <CAEJqkggsjnod79HFvYQHRFEsFaN-bb27P8Xf79_9DmxhLKs_Og@mail.gmail.com>
Subject: Re: Kernel and ADM hardware roulette ( was AMD graphics performance
 regression in 4.15 and later )
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
        Jean-Marc Valin <jmvalin@mozilla.com>,
        Dave Airlie <airlied@linux.ie>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, alexander.deucher@amd.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-07 9:07 GMT+02:00 Christian K=C3=B6nig <christian.koenig@amd.com>:
> Am 06.06.2018 um 17:44 schrieb Gabriel C:
>>
>> 2018-06-06 17:03 GMT+02:00 Michel D=C3=A4nzer <michel@daenzer.net>:
>>>
>>> On 2018-06-06 04:44 PM, Christian K=C3=B6nig wrote:
>>>>
>>>> Am 06.06.2018 um 16:12 schrieb Michel D=C3=A4nzer:
>>>> [SNIP]
>>>> At least in theory it should work when we use the coherent DMA
>>>> allocator.
>>>>
>>>> When that really worked before, so the most likely commit which broke
>>>> this is:
>>>>
>>>> commit fd5fd480dd8fe4910546e7b080b3ae345e57fe9f
>>>> Author: Chunming Zhou <david1.zhou@amd.com>
>>>> Date:   Fri Feb 9 10:44:09 2018 +0800
>>>>
>>>>      drm/amdgpu: only enable swiotlb alloc when need v2
>>>>
>>>>      get the max io mapping address of system memory to see if it is
>>>> over
>>>>      our card accessing range.
>>>>      v2: move checking later
>>>>
>>>>      Signed-off-by: Chunming Zhou <david1.zhou@amd.com>
>>>>      Reviewed-by: Monk Liu <monk.liu@amd.com>
>>>>      Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>>>>      Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>
>>>> Currently looking into how we could somehow improve this detection.
>>>
>>> I guess this could fit for Gabriel, but e.g.
>>> https://bugs.freedesktop.org/104437 says amdgpu was already broken with
>>> SME in 4.15, if not 4.14 (I suspect there was simply no SME support
>>> earlier).
>
>
> And what I totally missed is that Gabriel is using radeon and not amdgpu.
>
> So Gabriel you need to revert this one for testing:
> commit 1bc3d3cce8c3b44c2b5ac6cee98c830bb40e6b0f
> Author: Chunming Zhou <david1.zhou@amd.com>
> Date:   Fri Feb 9 10:44:10 2018 +0800
>
>     drm/radeon: only enable swiotlb path when need v2
>
>     swiotlb expands our card accessing range, but its path always is slow=
er
>     than ttm pool allocation.
>     So add condition to use it.
>     v2: move a bit later
>
>     Signed-off-by: Chunming Zhou <david1.zhou@amd.com>
>     Reviewed-by: Monk Liu <monk.liu@amd.com>
>     Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>     Link:
> https://patchwork.freedesktop.org/patch/msgid/20180209024410.1469-3-david=
1.zhou@amd.com
>
>> I got strange performance issue with 4.15 and 4.16 .. but SME was ON
>> on that setup ( even before it hit mainline ) and never broke the GPU li=
ke
>> this.
>
>
> Well that is very interesting, you are the first one who reports that SME=
 +
> GFX works in some way. So far we only got negative reports for that.
>
>> There is a 4.16.13 boot dmesg which has no such issue:
>>
>>
>> http://ftp.frugalware.org/pub/other/people/crazy/radeon/dmesg-radeon-SME=
-ON-kernel-4.16.txt
>>
>> With the setup as is booting 4.16.x works , while 4.17 trows the errors.
>
>
> Please do the bisect if the patch I've mentioned above doesn't help.

Ok done.. bisect points to:

b468620f2a1dfdcfddfd6fa54367b8bcc1b51248 is the first bad commit
commit b468620f2a1dfdcfddfd6fa54367b8bcc1b51248
Author: Christoph Hellwig <hch@lst.de>
Date:   Mon Mar 19 11:38:19 2018 +0100

   iommu/amd_iommu: Use CONFIG_DMA_DIRECT_OPS=3Dy and dma_direct_{alloc,fre=
e}()

   This cleans up the code a lot by removing duplicate logic.

   Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
   Tested-by: Joerg Roedel <jroedel@suse.de>
   Signed-off-by: Christoph Hellwig <hch@lst.de>
   Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
   Acked-by: Joerg Roedel <jroedel@suse.de>
   Cc: David Woodhouse <dwmw2@infradead.org>
   Cc: Joerg Roedel <joro@8bytes.org>
   Cc: Jon Mason <jdmason@kudzu.us>
   Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
   Cc: Linus Torvalds <torvalds@linux-foundation.org>
   Cc: Muli Ben-Yehuda <mulix@mulix.org>
   Cc: Peter Zijlstra <peterz@infradead.org>
   Cc: iommu@lists.linux-foundation.org
   Link: http://lkml.kernel.org/r/20180319103826.12853-8-hch@lst.de
   Signed-off-by: Ingo Molnar <mingo@kernel.org>


I'll try to revert this once I'm home.

BR
