Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C276C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 11:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B08820C09
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 11:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mp36BoSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B08820C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbeHUOtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 10:49:18 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38222 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbeHUOtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 10:49:18 -0400
Received: by mail-wm0-f67.google.com with SMTP id t25-v6so2514228wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 04:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C8OADzc/wroQdlSxR4jeB2HnTrE30HbvAoL2XXg5vEE=;
        b=Mp36BoSmmV4PBAJa7IRBeWLONfx0jUK4Yp0BO3V800wcg5isF7SQVC8jY8m/T15q/r
         fQNHS1VtZ6AKdger4DJRjo5GnMrIODuIMtFFqnqjQdeGjnoNdb9vfXaDzvtBEaSlpA2L
         GjR5DpfIzM9n2/5024YZMwJ44XTfVq9QZ9e00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C8OADzc/wroQdlSxR4jeB2HnTrE30HbvAoL2XXg5vEE=;
        b=DB0DNJkMmpkKbCASFKKyr5SpdB9sMvnD+FF45yy9oZq8g5dHphAY74WBsowrPMFIap
         hX6200SuhAM7kOk1wgzGxsgz6mPZumottGtPUyZD6h2fJNyqRHtbnK3dGZ2a6+lgfRRp
         H/Qv0W1WnvfW4mPsBUEx1ueLY06VokxZsNkravPEBLli2eNjAM+GCfRyZi8brKfdwyBO
         I+/hJj/6I9DUyieO15/2Ga+w4PExVyyFxsjsrVRjU5u3aNx+syKc63sL2g6NEYzVHPff
         btJgH6+QFLoSjt/4lQy1JtatsDiBA3yI8PXqEwG+zX7zF5Kr85w+aFFJMqj2Qjxxcja5
         v+CQ==
X-Gm-Message-State: AOUpUlHB5odBLNJOs8YyDf4kPe+5aPYkw0G6za1lN085CRjonqQdw5Z4
        ZDiwi47eC0UYl4tirgIdQ6SYyQ==
X-Google-Smtp-Source: AA+uWPwuc9R/kHEflNG9BVv7vpSI+g/PS7bn2BtIJTr2nZoMz9wSdXiqXnIkpYLNkT+BbAIytQKjLQ==
X-Received: by 2002:a1c:ef0f:: with SMTP id n15-v6mr26905555wmh.116.1534850970095;
        Tue, 21 Aug 2018 04:29:30 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id h82-v6sm3595450wme.11.2018.08.21.04.29.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 04:29:28 -0700 (PDT)
Subject: Re: [PATCH 1/2] media: docs-rst: Document memory-to-memory video
 decoder interface
To:     Tomasz Figa <tfiga@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>
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
 <a6af3dc9-1d09-a414-ce31-bc1b3e69894f@xs4all.nl>
 <CAAFQd5AnC+hWy4QUGE-s+qgRvvgGC7rMhH6x8koTfYJzTLw8Cg@mail.gmail.com>
 <f0aa7c84-08e3-9b04-8d1b-95f741d6817b@xs4all.nl>
 <CAAFQd5ACWO0FxzZdxf-N-GStCMOSWzxKxhcpCRUh=BqT7jLJWw@mail.gmail.com>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <41ee7486-9c7c-51ea-9355-1bf6c44f1639@linaro.org>
Date:   Tue, 21 Aug 2018 14:29:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAAFQd5ACWO0FxzZdxf-N-GStCMOSWzxKxhcpCRUh=BqT7jLJWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomasz,

On 08/08/2018 05:55 AM, Tomasz Figa wrote:
> On Tue, Aug 7, 2018 at 4:37 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:

>>>>>>> +7.  If all the following conditions are met, the client may resume the
>>>>>>> +    decoding instantly, by using :c:func:`VIDIOC_DECODER_CMD` with
>>>>>>> +    ``V4L2_DEC_CMD_START`` command, as in case of resuming after the drain
>>>>>>> +    sequence:
>>>>>>> +
>>>>>>> +    * ``sizeimage`` of new format is less than or equal to the size of
>>>>>>> +      currently allocated buffers,
>>>>>>> +
>>>>>>> +    * the number of buffers currently allocated is greater than or equal to
>>>>>>> +      the minimum number of buffers acquired in step 6.
>>>>>>
>>>>>> You might want to mention that if there are insufficient buffers, then
>>>>>> VIDIOC_CREATE_BUFS can be used to add more buffers.
>>>>>>
>>>>>
>>>>> This might be a bit tricky, since at least s5p-mfc and coda can only
>>>>> work on a fixed buffer set and one would need to fully reinitialize
>>>>> the decoding to add one more buffer, which would effectively be the
>>>>> full resolution change sequence, as below, just with REQBUFS(0),
>>>>> REQBUFS(N) replaced with CREATE_BUFS.
>>>>
>>>> What happens today in those drivers if you try to call CREATE_BUFS?
>>>
>>> s5p-mfc doesn't set the .vidioc_create_bufs pointer in its
>>> v4l2_ioctl_ops, so I suppose that would be -ENOTTY?
>>
>> Correct for s5p-mfc.
> 
> As Philipp clarified, coda supports adding buffers on the fly. I
> briefly looked at venus and mtk-vcodec and they seem to use m2m
> implementation of CREATE_BUFS. Not sure if anyone tested that, though.
> So the only hardware I know for sure cannot support this is s5p-mfc.

In Venus case CREATE_BUFS is tested with Gstreamer.

-- 
regards,
Stan
