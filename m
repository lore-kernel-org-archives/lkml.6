Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9682C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 18:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 565452087C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 18:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="cB6lRzZn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 565452087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389321AbeGKS4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 14:56:13 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:54888 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733295AbeGKS4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 14:56:12 -0400
Received: by mail-it0-f68.google.com with SMTP id s7-v6so4176160itb.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 11:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pE7veCBpisVuVPrQqoVkEecpd15qzGrGiePjgqtrC/A=;
        b=cB6lRzZnWWVmHBQK+6oDhPrE/jibo93p1eROJXF3icCn2eA9YeCFE4c3e6+KpeSBmo
         J1cVaKacuATXr0gxWNzGKqvFP7qA9qTjxIx5ieFGeRTJ3EnMEqkRfWy6dsC26eIvyO4p
         ATrw365xEDmJv1621mBSyY+YjtLoWFijm5/8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pE7veCBpisVuVPrQqoVkEecpd15qzGrGiePjgqtrC/A=;
        b=XSzcXv9Jck2UrDppJ2i61d/gdXNBa3u62bu7lHSoLKOIGG4pTP0penvaQTQyLW0V+z
         PR0Xe65qZMSpN1F/8LXJng/65grH22mxOEfbdlOrR+EHDuv78vidXZoRwWGMAP1Ef+aK
         vHnX4RtfI2pT8xNl6HcOjex9W6gJalwUSanSlrDVCqLoDNdbu3UzDcH8973BHi1tKxLC
         YCVrRgU+ZuTBctXdEC0McJlLcSsx1I92SeIT73hwlz4jaTOfQkKdK5R2W5wMtgFBsOyW
         xg523GxBzyV/nARVn5Zj1/p/G5Y5hRWxP/sjyj2d1TqLAXk2UlE3sIH4JnbF0kfPnV2p
         /x0Q==
X-Gm-Message-State: AOUpUlFHNM9V/4GCp59CDSDHG9B63HMPztg3f4VkzsfnLNoXv9jg+NOX
        aj9IItJ2SICPMcT7jrUFd/by4Bnh4QHcPzpWod1VRA==
X-Google-Smtp-Source: AAOMgpfW5HoZCd74A+toAkhKitybZr+riUFGjHyuGQnaCWcGT1Gmkng+8YpWM5TTKnsVnSTvP2ObDuWWOkYClSiw9pY=
X-Received: by 2002:a24:558a:: with SMTP id e132-v6mr9664itb.2.1531335034586;
 Wed, 11 Jul 2018 11:50:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:e492:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 11:50:34
 -0700 (PDT)
X-Originating-IP: [2a02:168:5628:0:496f:7dc5:66d7:a057]
In-Reply-To: <965184f9-e5ed-3c8b-bfd7-a033a252371b@kernel.dk>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
 <20180709083650.23549-2-daniel.vetter@ffwll.ch> <20180711164058.GC72677@devbig577.frc2.facebook.com>
 <20180711164536.GD72677@devbig577.frc2.facebook.com> <965184f9-e5ed-3c8b-bfd7-a033a252371b@kernel.dk>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed, 11 Jul 2018 20:50:34 +0200
Message-ID: <CAKMK7uE5aJq-1wd0ZOhwFaTy3iKMAZsfdAf=Tw+eGxtCmfcVQg@mail.gmail.com>
Subject: Re: [PATCH 02/12] blk: use for_each_if
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Shaohua Li <shli@fb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 8:30 PM, Jens Axboe <axboe@kernel.dk> wrote:
> On 7/11/18 10:45 AM, Tejun Heo wrote:
>> On Wed, Jul 11, 2018 at 09:40:58AM -0700, Tejun Heo wrote:
>>> On Mon, Jul 09, 2018 at 10:36:40AM +0200, Daniel Vetter wrote:
>>>> Makes the macros resilient against if {} else {} blocks right
>>>> afterwards.
>>>>
>>>> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
>>>> Cc: Tejun Heo <tj@kernel.org>
>>>> Cc: Jens Axboe <axboe@kernel.dk>
>>>> Cc: Shaohua Li <shli@fb.com>
>>>> Cc: Kate Stewart <kstewart@linuxfoundation.org>
>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
>>>> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
>>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>>
>>> Acked-by: Tejun Heo <tj@kernel.org>
>>>
>>> Jens, it'd probably be best to route this through block tree.
>>
>> Oops, this requires an earlier patch to move the for_each_if def to a
>> common header and should be routed together.
>
> Yeah, this is a problem with the submission.
>
> Always (ALWAYS) CC folks on at least the cover letter and generic
> earlier patches. Getting just one patch sent like this is mostly
> useless, and causes more harm than good.

Ime sending a patch with more than 20 or so recipients means it gets
stuck everywhere in moderation queues. Or outright spam filters. I
thought the correct way to do this is to cc: mailing lists (lkml has
them all), but apparently that's not how it's done. Despite that all
the patch series I get never have the cover letter addressed to me
either.

So what's the magic way to make this possible?
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
