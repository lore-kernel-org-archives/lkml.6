Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045BCC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 06:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A121C219A3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 06:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+kJLmOO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A121C219A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbeHFIOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 04:14:04 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46288 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725735AbeHFIOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 04:14:03 -0400
Received: by mail-lj1-f193.google.com with SMTP id 203-v6so9549012ljj.13
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 23:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aX/hXeWXzWUjwQPIfcrhQPJQVVlkzFyWGTr4KRH4nWQ=;
        b=H+kJLmOOqSt2zrVNeJvUjvQ2/n/AsuKI7D1CT2YXHnKartdKCM6JzW9o198flFqvWz
         PH5qaKQx1GGd4qUvMJVzGYCJQKLQIo5sMBoM74sDPpWmKChdpsev26E1nWfO4r4Lt58r
         Q/hi6i+yKTwyKU8hNEhpTUE+xFmNAdjRucJlm1z6jDvhLwlGcBwsqDSyA/ko0s2WZ/xX
         7F5qbHglL/fVllzuXaPEDPjJQC/OeKwdyRxSPdddJYgY+I16ibbj2Yh/C9bxIr6HDc+V
         M51ybe8r94tJRleg4XTKOuXJ9NWLFjAqCfT0cB/iAUA1ucrWEBJennvBclN4CUn2etm+
         TJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aX/hXeWXzWUjwQPIfcrhQPJQVVlkzFyWGTr4KRH4nWQ=;
        b=DNOZJcDaN0UhZZvRxk+vgVE5M/Qqu9lh2DIo2soLPLRkBisNuFpcB6zosozrrjPfAs
         3L2Qj2a6ZVHonZ4UUW3qulqsf+po180C4jhH31FtnnbJrIWTU1rtyha0MklidordNZJR
         9Goh+eb0jhniI4nl94lEl+4EeBsaRU2b9vjRgAn3x+nwktZiTR+NmCdPlUW7EhuJ97ci
         uekY2M+WLpcSr8R7mH12Q2cf3jsQv5bThU/6MDcu8xP0y2YYEsb07C7TwymHprbrXkUy
         IwAoMdMG9A2/yu168qy9W9yqjhWeac3sP9VPmOoFjpY85lnvkg3Me2bG1b9y0GVK4WMC
         WIbQ==
X-Gm-Message-State: AOUpUlEGFrt2k3K+io4r5zORnTFUwCiLC1FM6peWtZRKQnsvM4QwkN/T
        I8njMhrddGckw8rmAiD0m61t2okHPR+71SDM16bmzg==
X-Google-Smtp-Source: AAOMgpf4i1BpSnD4wX1JJQqw/y7YGYxlecb7PFJBeVOuPaMSVld0eodboP4CUcb/nrtbDvsdxnn35CCC0n4WcUVOzo4=
X-Received: by 2002:a2e:8617:: with SMTP id a23-v6mr12216050lji.43.1533535593129;
 Sun, 05 Aug 2018 23:06:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b14:0:0:0:0:0 with HTTP; Sun, 5 Aug 2018 23:06:32 -0700 (PDT)
In-Reply-To: <5B63FE39.4070402@hisilicon.com>
References: <20180719160426.GA21958@jordon-HP-15-Notebook-PC>
 <CAFqt6zY_KUx0RgRiuTt6x6xmtfwD=iR8xR6665eZYmKmXKgDNA@mail.gmail.com>
 <CAFqt6zZdOJe1VmCC3=cEANEU_X05whezkFZsG+FtoS64FXnpeg@mail.gmail.com> <5B63FE39.4070402@hisilicon.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 6 Aug 2018 11:36:32 +0530
Message-ID: <CAFqt6zbuTRTxf+dw_C-YMK_qn8cB=5xWq+b_M22dep_NEWWghw@mail.gmail.com>
Subject: Re: [PATCH] gpu/drm/hisilicon: Convert drm_atomic_helper_suspend/resume()
To:     xinliang <z.liuxinliang@hisilicon.com>
Cc:     Zou Rongrong <zourongrong@gmail.com>,
        kong.kongxinwei@hisilicon.com, puck.chen@hisilicon.com,
        airlied@linux.ie, noralf@tronnes.org,
        Sean Paul <seanpaul@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Ajit Linux <ajitn.linux@gmail.com>,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 3, 2018 at 12:33 PM, xinliang <z.liuxinliang@hisilicon.com> wrote:
>
>
> On 2018/8/2 17:57, Souptick Joarder wrote:
>>
>> On Thu, Jul 26, 2018 at 1:37 PM, Souptick Joarder<jrdr.linux@gmail.com>
>> wrote:
>>>
>>> >On Thu, Jul 19, 2018 at 9:34 PM, Souptick Joarder<jrdr.linux@gmail.com>
>>> > wrote:
>>>>
>>>> >>convert drm_atomic_helper_suspend/resume() to use
>>>> >>drm_mode_config_helper_suspend/resume().
>>>> >>
>>>> >>Fixed one sparse warning by making hibmc_drm_interrupt
>>>> >>static.
>>>> >>
>>>> >>Signed-off-by: Souptick Joarder<jrdr.linux@gmail.com>
>>>> >>Signed-off-by: Ajit Negi<ajitn.linux@gmail.com>
>>>> >>---
>>>
>>> >
>>> >Any comment on this patch ?
>>
>> Any review comment for this patch ?
>
> Sorry for late reply. Looks good to me. Thanks.
> Reviewed-by: Xinliang Liu <z.liuxinliang@hisilicon.com>

Xinliang,

I will do little more clean up by removing ret variable from
suspend / resume function and post v2.

>
>
