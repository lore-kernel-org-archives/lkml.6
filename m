Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690A6C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16659208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16659208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbeJPVko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 17:40:44 -0400
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:54021 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727043AbeJPVko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 17:40:44 -0400
Received: from [IPv6:2001:420:44c1:2579:9a8:54a0:8ffa:2301] ([IPv6:2001:420:44c1:2579:9a8:54a0:8ffa:2301])
        by smtp-cloud9.xs4all.net with ESMTPA
        id CPjTgGDfxSskCCPjWg8bwr; Tue, 16 Oct 2018 15:50:08 +0200
Subject: Re: [PATCH 2/2] media: docs-rst: Document memory-to-memory video
 encoder interface
To:     Tomasz Figa <tfiga@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pawel Osciak <posciak@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>, kamil@wypas.org,
        a.hajda@samsung.com, Kyungmin Park <kyungmin.park@samsung.com>,
        jtp.park@samsung.com,
        =?UTF-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        =?UTF-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?= 
        <andrew-ct.chen@mediatek.com>, todor.tomov@linaro.org,
        nicolas@ndufresne.ca,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dave.stevenson@raspberrypi.org,
        Ezequiel Garcia <ezequiel@collabora.com>
References: <20180724140621.59624-1-tfiga@chromium.org>
 <20180724140621.59624-3-tfiga@chromium.org>
 <4168da98-fa01-ea2f-8162-385501e666be@xs4all.nl>
 <CAAFQd5BqtKFeJniNaqahi9h_zKR+rPrWUiyx004Z=MWDj7q++w@mail.gmail.com>
 <CAAFQd5Djur9y+=UHTx9ZSx310p2ShCsBTqsEA1UHCMoawuDscA@mail.gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <7b8b56e7-1617-5de6-9fa9-a10897a8f2f1@xs4all.nl>
Date:   Tue, 16 Oct 2018 15:49:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAAFQd5Djur9y+=UHTx9ZSx310p2ShCsBTqsEA1UHCMoawuDscA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLpy65hUflpLqKJJD9QesvS+BzueFdFXQnnL6ns7THT21td4E++XJ3rD/RpcdamuyR7Rm1xJTMSKowW0cQy5VxOBOBBYK/qvMBWqD7Uf5N92G4MUtRs2
 yVScfVZfYtBssixaHo9V8Fi1J2zQhWBFBlAYZSt6AvmuGAqKwfeU33bGuxkWjFimeepbeOQn5ei4UNiwTcWrk4vqDoBos1PPgj1g38JO1hWx1gY+93nP4MmB
 sRD8CQ1c8qRW/grl/Yvzn3mhgbf6nhPLLvlhOHMqlMK6TaHUugxtopu70pNBe8zCBfPBxq7IXMuc+6dT/o1BO/6OuTZ+fn8Hnw2TtpMK3toCHtgWIlChwZTX
 3QZGgyFoi7u9Hvy9yHvKdTw2fuDITV2q76udIhrkumyPnRwXe6nW9LkUgtxmXFISjTGVklqOKPN3+P24zbvdF0fapEt1jTZFhM2hl7zavkx7JYKtyqJ6WAD+
 yO9kbcyTcvZaGBj3E8iwZe4zxJAz0V3kfRpqKvMc5r7zmK8lIWN67sWyeSNgvsXWGImgZKo0nPOOUEj5UgPos1LLLvoc4XNdqNE07ANHoKiHqj9vp83HE4qJ
 nDzr1MEnTaZ+bVadvcVEZ/nWCUPiSxzuhI3ViDlpYLMYlIEou+NPv1K36iHffF78iU7TE8bHlhbsqYCEI1mplYq582d82fDkVAnHpQzp2J2NhZ28/8/r/iQm
 qZf3ZnI7C30qmuyvNbv0xji42XP4E+AtdCLurv9HMptppwhJUdtgYnfuDP3hduLGPP+cZz1+ZWwOTe+r0nyYEgZVqE+2aihwVaPUnZrSskSlFpEtNQP5ExUS
 WncUk1rOqBmDGmLRDCIeOncL3XHixFOi7/TDTTS4w9//96AYXzq9JXDfO4ezkuPvKKdO5AjU4+1KeFIeCuKV5Dd5IUaolJ8QHDNcHEj2Lv00tcFZ8ULkpyyz
 oy3v+c/IcnjFClVcfzZSeZ4I6xw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/18 09:36, Tomasz Figa wrote:
> On Tue, Aug 7, 2018 at 3:54 PM Tomasz Figa <tfiga@chromium.org> wrote:
>>>> +   * The driver must expose following selection targets on ``OUTPUT``:
>>>> +
>>>> +     ``V4L2_SEL_TGT_CROP_BOUNDS``
>>>> +         maximum crop bounds within the source buffer supported by the
>>>> +         encoder
>>>> +
>>>> +     ``V4L2_SEL_TGT_CROP_DEFAULT``
>>>> +         suggested cropping rectangle that covers the whole source picture
>>>> +
>>>> +     ``V4L2_SEL_TGT_CROP``
>>>> +         rectangle within the source buffer to be encoded into the
>>>> +         ``CAPTURE`` stream; defaults to ``V4L2_SEL_TGT_CROP_DEFAULT``
>>>> +
>>>> +     ``V4L2_SEL_TGT_COMPOSE_BOUNDS``
>>>> +         maximum rectangle within the coded resolution, which the cropped
>>>> +         source frame can be output into; always equal to (0, 0)x(width of
>>>> +         ``V4L2_SEL_TGT_CROP``, height of ``V4L2_SEL_TGT_CROP``), if the
>>>> +         hardware does not support compose/scaling

Re-reading this I would rewrite this a bit:

if the hardware does not support composition or scaling, then this is always
equal to (0, 0)x(width of ``V4L2_SEL_TGT_CROP``, height of ``V4L2_SEL_TGT_CROP``).

>>>> +
>>>> +     ``V4L2_SEL_TGT_COMPOSE_DEFAULT``
>>>> +         equal to ``V4L2_SEL_TGT_CROP``
>>>> +
>>>> +     ``V4L2_SEL_TGT_COMPOSE``
>>>> +         rectangle within the coded frame, which the cropped source frame
>>>> +         is to be output into; defaults to
>>>> +         ``V4L2_SEL_TGT_COMPOSE_DEFAULT``; read-only on hardware without
>>>> +         additional compose/scaling capabilities; resulting stream will
>>>> +         have this rectangle encoded as the visible rectangle in its
>>>> +         metadata
>>>> +
>>>> +     ``V4L2_SEL_TGT_COMPOSE_PADDED``
>>>> +         always equal to coded resolution of the stream, as selected by the
>>>> +         encoder based on source resolution and crop/compose rectangles
>>>
>>> Are there codec drivers that support composition? I can't remember seeing any.
>>>
>>
>> Hmm, I was convinced that MFC could scale and we just lacked support
>> in the driver, but I checked the documentation and it doesn't seem to
>> be able to do so. I guess we could drop the COMPOSE rectangles for
>> now, until we find any hardware that can do scaling or composing on
>> the fly.
>>
> 
> On the other hand, having them defined already wouldn't complicate
> existing drivers too much either, because they would just handle all
> of them in the same switch case, i.e.
> 
> case V4L2_SEL_TGT_COMPOSE_BOUNDS:
> case V4L2_SEL_TGT_COMPOSE_DEFAULT:
> case V4L2_SEL_TGT_COMPOSE:
> case V4L2_SEL_TGT_COMPOSE_PADDED:
>      return visible_rectangle;
> 
> That would need one change, though. We would define
> V4L2_SEL_TGT_COMPOSE_DEFAULT to be equal to (0, 0)x(width of
> V4L2_SEL_TGT_CROP - 1, height of ``V4L2_SEL_TGT_CROP - 1), which

" - 1"? Where does that come from?

Usually rectangles are specified as widthxheight@left,top.

> makes more sense than current definition, since it would bypass any
> compose/scaling by default.

I have no problem with drivers optionally implementing these rectangles,
even if they don't do scaling or composition. The question is, should it
be required for decoders? If there is a good reason, then I'm OK with it.

Regards,

	Hans
