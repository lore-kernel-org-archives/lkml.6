Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C471C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D192A21708
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rJ+b5MAe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D192A21708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbeHHJNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 05:13:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42334 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbeHHJNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 05:13:16 -0400
Received: by mail-wr1-f65.google.com with SMTP id e7-v6so963058wrs.9;
        Tue, 07 Aug 2018 23:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2mVjfWc8COTOWZIBA7XFHqwdwcCpFivRHJJ88Pc2RJA=;
        b=rJ+b5MAe7Fe8wfx8Cal7PBFAEtiSaoU+FCCk0UqkHWO+q85iZ4t5UFiF6y1xNUEO8N
         LJjGM3islvYnY3wmO/0MiQZQvuEvhNZonvH9QjBbNAIAKkEg3ptxURseSZJCtwO2Lity
         GtcFvJGlO2iiF/0p7smMXyUOxnXjE2lyTSoz/5Fr7pxbDTRFX3iPIsTwX840I/4wcwI8
         iVJBiav8pm8+TU4mUgf78bviYkmoWtu+BzDHo63JBpFEih9vt5ozUy612DvItyYXa8sH
         eQowdLTXazrmKQgqM7W4smuqLbT7mm9G14uPXecNarh//IvwCKVSKCTMm9XORPIRocdv
         jyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2mVjfWc8COTOWZIBA7XFHqwdwcCpFivRHJJ88Pc2RJA=;
        b=nwOyvNUrqEYLs8Ey0bwkakZEoCfOCVzzfQONm+A/EkVXAVZYiPj9aGFH9FD2f61P4K
         T0uA3qieJE/rqcjdg4bYB6FTqidhAnYOTOjaeU9VLDiJgcnShLX6mTIz9Zc2XUazx1ba
         ruRFXeBtXbmk6KKib6P+0Mm8YVzs0EVLSQ98EONbNvOfgTIxHJS/9DGmiM3/6TKngxzm
         sHP/32hHVR6gpo3a+Dtsq7m4T4RhdNPXBRDFBBcXDKQgud6tJVc68K2cPTVidgU1EbC8
         LjrZnUxmvcK5J1xjFkxOIiW/lQp2Muvb+pFh6+CezjPOZlePZzhec451rUhlJQAWiTm+
         si5A==
X-Gm-Message-State: AOUpUlFxltBg9seDMHVbT+Ni1q1IleLQmxczxgcV7a/Edcen+/x5Up8f
        hbnKU8z8cDlMKtw8Vgw/ytw=
X-Google-Smtp-Source: AA+uWPztBOU/GLXzplLA2nTDvIX34E4yxdhGvHaUNcsjnK+mAVew/hSgoyx2gYKI9GH7X0awe/yTpA==
X-Received: by 2002:adf:93a3:: with SMTP id 32-v6mr969739wrp.140.1533711297317;
        Tue, 07 Aug 2018 23:54:57 -0700 (PDT)
Received: from [192.168.19.74] (host86-155-227-141.range86-155.btcentralplus.com. [86.155.227.141])
        by smtp.googlemail.com with ESMTPSA id t6-v6sm5212800wmf.8.2018.08.07.23.54.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 23:54:56 -0700 (PDT)
Subject: Re: [PATCH 1/2] media: docs-rst: Document memory-to-memory video
 decoder interface
To:     Hans Verkuil <hverkuil@xs4all.nl>, Tomasz Figa <tfiga@chromium.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pawel Osciak <posciak@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>, kamil@wypas.org,
        a.hajda@samsung.com, Kyungmin Park <kyungmin.park@samsung.com>,
        jtp.park@samsung.com, Philipp Zabel <p.zabel@pengutronix.de>,
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
 <20180724140621.59624-2-tfiga@chromium.org>
 <37a8faea-a226-2d52-36d4-f9df194623cc@xs4all.nl>
 <CAAFQd5BgGEBmd8gNGc-qqtUtLo=Mh8U+TVTWRsKYMv1LmeBQMA@mail.gmail.com>
 <e0da6268-c7f6-1048-83b9-a7e67cfe000e@xs4all.nl>
 <CAAFQd5CK6NSy6cmDFmaMNjFwoS1w7jx1zX8WD_80x2LB0LeZLA@mail.gmail.com>
 <fa0b9a5d-a2c6-85af-694c-0bd7bedb4bb3@xs4all.nl>
From:   Ian Arkver <ian.arkver.dev@gmail.com>
Message-ID: <2348260b-aa1f-a1e1-cf3e-a155c5aca20d@gmail.com>
Date:   Wed, 8 Aug 2018 07:54:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <fa0b9a5d-a2c6-85af-694c-0bd7bedb4bb3@xs4all.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On 08/08/18 07:43, Hans Verkuil wrote:
> On 08/08/2018 05:11 AM, Tomasz Figa wrote:
>> On Tue, Aug 7, 2018 at 4:13 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>>>
>>> On 07/26/2018 12:20 PM, Tomasz Figa wrote:
>>>> Hi Hans,
>>>>
>>>> On Wed, Jul 25, 2018 at 8:59 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>>>>>> +
>>>>>> +14. Call :c:func:`VIDIOC_STREAMON` to initiate decoding frames.
>>>>>> +
>>>>>> +Decoding
>>>>>> +========
>>>>>> +
>>>>>> +This state is reached after a successful initialization sequence. In this
>>>>>> +state, client queues and dequeues buffers to both queues via
>>>>>> +:c:func:`VIDIOC_QBUF` and :c:func:`VIDIOC_DQBUF`, following standard
>>>>>> +semantics.
>>>>>> +
>>>>>> +Both queues operate independently, following standard behavior of V4L2
>>>>>> +buffer queues and memory-to-memory devices. In addition, the order of
>>>>>> +decoded frames dequeued from ``CAPTURE`` queue may differ from the order of
>>>>>> +queuing coded frames to ``OUTPUT`` queue, due to properties of selected
>>>>>> +coded format, e.g. frame reordering. The client must not assume any direct
>>>>>> +relationship between ``CAPTURE`` and ``OUTPUT`` buffers, other than
>>>>>> +reported by :c:type:`v4l2_buffer` ``timestamp`` field.
>>>>>
>>>>> Is there a relationship between capture and output buffers w.r.t. the timestamp
>>>>> field? I am not aware that there is one.
>>>>
>>>> I believe the decoder was expected to copy the timestamp of matching
>>>> OUTPUT buffer to respective CAPTURE buffer. Both s5p-mfc and coda seem
>>>> to be implementing it this way. I guess it might be a good idea to
>>>> specify this more explicitly.
>>>
>>> What about an output buffer producing multiple capture buffers? Or the case
>>> where the encoded bitstream of a frame starts at one output buffer and ends
>>> at another? What happens if you have B frames and the order of the capture
>>> buffers is different from the output buffers?
>>>
>>> In other words, for codecs there is no clear 1-to-1 relationship between an
>>> output buffer and a capture buffer. And we never defined what the 'copy timestamp'
>>> behavior should be in that case or if it even makes sense.
>>
>> You're perfectly right. There is no 1:1 relationship, but it doesn't
>> prevent copying timestamps. It just makes it possible for multiple
>> CAPTURE buffers to have the same timestamp or some OUTPUT timestamps
>> not to be found in any CAPTURE buffer.
> 
> We need to document the behavior. Basically there are three different
> corner cases that need documenting:
> 
> 1) one OUTPUT buffer generates multiple CAPTURE buffers
> 2) multiple OUTPUT buffers generate one CAPTURE buffer
> 3) the decoding order differs from the presentation order (i.e. the
>     CAPTURE buffers are out-of-order compared to the OUTPUT buffers).
> 
> For 1) I assume that we just copy the same OUTPUT timestamp to multiple
> CAPTURE buffers.

I'm not sure how this interface would handle something like a temporal
scalability layer, but conceivably this assumption might be invalid in
that case.

Regards,
Ian.

> 
> For 2) we need to specify if the CAPTURE timestamp is copied from the first
> or last OUTPUT buffer used in creating the capture buffer. Using the last
> OUTPUT buffer makes more sense to me.
> 
> And 3) implies that timestamps can be out-of-order. This needs to be
> very carefully documented since it is very unexpected.
> 
> This should probably be a separate patch, adding text to the v4l2_buffer
> documentation (esp. the V4L2_BUF_FLAG_TIMESTAMP_COPY documentation).
> 
> Regards,
> 
> 	Hans
> 
