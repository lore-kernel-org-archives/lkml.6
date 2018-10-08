Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1254FC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A172084D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A172084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbeJHRcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 13:32:41 -0400
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:38308 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726193AbeJHRcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 13:32:41 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud9.xs4all.net with ESMTPA
        id 9SfQgLZR8SskC9SfTgfsL3; Mon, 08 Oct 2018 12:21:40 +0200
Subject: Re: [RFC PATCH v2] media: docs-rst: Document m2m stateless video
 decoder interface
To:     Paul Kocialkowski <contact@paulk.fr>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Alexandre Courbot <acourbot@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pawel Osciak <posciak@chromium.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20181004081119.102575-1-acourbot@chromium.org>
 <f1fa989b372b514f0a7534057de80b0c453cc8a3.camel@paulk.fr>
 <5085f73bc44424b20f1bd0dc1332d9baabecb090.camel@ndufresne.ca>
 <dc1045e5806638d58ae5ace796541cb8a3d29481.camel@paulk.fr>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <f8369e54-e2b6-890c-d9d7-b720072bb210@xs4all.nl>
Date:   Mon, 8 Oct 2018 12:21:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <dc1045e5806638d58ae5ace796541cb8a3d29481.camel@paulk.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfBkTqyYWVeAl6OwZQU8wzekJDt9IssAM26rCtTICTCtKZ3LA5g2Ryb3GeHf3zySJoWqtoxgVIX1LFV2qd8eCUWJiqDjFZw+rA6QgZzidSjyrxAcnU9Fr
 Ebcij4ub0DGRhcsguk9huHF9nvh40cCCMyrP7Y50RDedNA00nzOiw6WMYPOaFQFjBfnwSCFVm0NKRtmQeUOWCLJL92mHlR2Ufsw5T/c3DsqRrZBQHkPWv5nw
 P7cvWXsbnJOtlhQKWd0Imqi3qbGFqxaeXCRFnz8By+XZjcFhZb/xhrx58wKIILvTCembiJax5Gfoml5sbjnwNH54muYW87GhSk4/Y292yH67FiGEVw+a6HN6
 qFVq4lssTlm1tyAfXojqvTEBPux7jXkin9myW78QWkGIgNx1ZMQugxZJs7wUusyuKLs/H6cAIM84lDuGpoKPT2Kidzatpw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2018 07:10 PM, Paul Kocialkowski wrote:
> Hi,
> 
> Le jeudi 04 octobre 2018 à 14:10 -0400, Nicolas Dufresne a écrit :
>> Le jeudi 04 octobre 2018 à 14:47 +0200, Paul Kocialkowski a écrit :
>>>> +    Instance of struct v4l2_ctrl_h264_scaling_matrix, containing the scaling
>>>> +    matrix to use when decoding the next queued frame. Applicable to the H.264
>>>> +    stateless decoder.
>>>> +
>>>> +``V4L2_CID_MPEG_VIDEO_H264_SLICE_PARAM``
>>>
>>> Ditto with "H264_SLICE_PARAMS".
>>>
>>>> +    Array of struct v4l2_ctrl_h264_slice_param, containing at least as many
>>>> +    entries as there are slices in the corresponding ``OUTPUT`` buffer.
>>>> +    Applicable to the H.264 stateless decoder.
>>>> +
>>>> +``V4L2_CID_MPEG_VIDEO_H264_DECODE_PARAM``
>>>> +    Instance of struct v4l2_ctrl_h264_decode_param, containing the high-level
>>>> +    decoding parameters for a H.264 frame. Applicable to the H.264 stateless
>>>> +    decoder.
>>>
>>> Since we require all the macroblocks to decode one frame to be held in
>>> the same OUTPUT buffer, it probably doesn't make sense to keep
>>> DECODE_PARAM and SLICE_PARAM distinct.
>>>
>>> I would suggest merging both in "SLICE_PARAMS", similarly to what I
>>> have proposed for H.265: https://patchwork.kernel.org/patch/10578023/
>>>
>>> What do you think?
>>
>> I don't understand why we add this arbitrary restriction of "all the
>> macroblocks to decode one frame". The bitstream may contain multiple
>> NALs per frame (e.g. slices), and stateless API shall pass each NAL
>> separately imho. The driver can then decide to combine them if needed,
>> or to keep them seperate. I would expect most decoder to decode each
>> slice independently from each other, even though they write into the
>> same frame.
> 
> Well, we sort of always assumed that there is a 1:1 correspondency
> between request and output frame when implemeting the software for
> cedrus, which simplified both userspace and the driver. The approach we
> have taken is to use one of the slice parameters for the whole series
> of slices and just append the slice data.
> 
> Now that you bring it up, I realize this is an unfortunate decision.
> This may have been the cause of bugs and limitations with our driver
> because the slice parameters may very well be distinct for each slice.
> Moreover, I suppose that just appending the slices data implies that
> they are coded in the same order as the picture, which is probably
> often the case but certainly not anything guaranteed. 
> 
> So I think we should change our software to associate one request per
> slice, not per frame and drop this limitation that all the macroblocks
> for the frame must be included.
> 
> This will require a number of changes to our driver and userspace, but
> also to the MPEG-2 controls where I don't think we have the macroblock
> position specified.
> 
> So it certainly makes sense to keep SLICE_PARAMS separate from
> DECODE_PARAMS for H.264. I should probably also rework the H.265
> controls to reflect this. Still, all controls must be passed per slice
> (and the hardware decoding pipeline is fully reconfigured then), so I
> guess it doesn't make such a big difference in practice.
> 
> Thanks for pointing this out, it should help bring the API closer to
> what is represented in the bitstream.

One concern I have with this:

If we support slices with one slice per buffer, then I think our
current max of 32 buffers will be insufficient, right? So that will
have to be fixed. That's a fair amount of work since we want to do this
right.

Regards,

	Hans
