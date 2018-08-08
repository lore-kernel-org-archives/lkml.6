Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554AFC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 048CE2170A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:43:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 048CE2170A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbeHHJCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 05:02:10 -0400
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:38143 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726957AbeHHJCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 05:02:09 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud9.xs4all.net with ESMTPA
        id nICDfU6wWEJtcnICHf86BH; Wed, 08 Aug 2018 08:43:53 +0200
Subject: Re: [PATCH 1/2] media: docs-rst: Document memory-to-memory video
 decoder interface
To:     Tomasz Figa <tfiga@chromium.org>
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
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <fa0b9a5d-a2c6-85af-694c-0bd7bedb4bb3@xs4all.nl>
Date:   Wed, 8 Aug 2018 08:43:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAAFQd5CK6NSy6cmDFmaMNjFwoS1w7jx1zX8WD_80x2LB0LeZLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFOiV5Q3vlCgzOLEJ5GWzdWLEVqxmwFtBQpN2CLdyvYEkz4J6n58tdVgBrECyinrLdJ9JXGKfhaOylwMf4pNfR3sZiFep4MivHh7Az5OSJHs2+ipbt90
 Yhdxs3nRCAJnkc8vvm69HOTfK8+rcft8512sV3fECX6XlYnYk7h291FGsWXrhdvzYNM6vdvugoq+x++x6hPC/xxZ+kmaCHvFRIj1tfZGv9lBrY7MOFhR+Aoc
 uTwbnkRJMLfwRCqMs7m3frluVaqD6qLQenOAVhzuGlHf5qQj1rLzZBmuF1+ZOvzxOepwp5YIa53UJPq1aqLvNLmUMssVNR/I6IkN7VptYocb1u3NagRuxcRf
 r1zzY9qAi6wc/W4BJICt7d7pUZQ7qENHSy6dGH6oMp7wBIivB4N55C74GcBT/5O9FzsUWwvJCx5xOrzWBQowPlqPrJGWL/+Yo6CDSg0cMalg6YNawSzMpEDV
 q+enqiW/qyxXxoE0tDUI38PPxswgllAGc2sqWtdthai6e8PDiV+ztXoEQ9+dsdpFfN7uliYHxd8g/Ic0PTleIIPrp/fI+p/V3kXehPJ05ahJwKwtceoVUhrI
 rC65EFUBDi+WdHoa5bbl5NOhW9Of9mZpLzCIeMFWXVBT05LUv/FgXgxCIBik8POltLpN4djo6HJOA7Fjr9+M9IhyrU/+e18TunhXABAbgAvwXUXelnxYIE44
 5Yo2wFRPVmk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2018 05:11 AM, Tomasz Figa wrote:
> On Tue, Aug 7, 2018 at 4:13 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>>
>> On 07/26/2018 12:20 PM, Tomasz Figa wrote:
>>> Hi Hans,
>>>
>>> On Wed, Jul 25, 2018 at 8:59 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>>>>> +
>>>>> +14. Call :c:func:`VIDIOC_STREAMON` to initiate decoding frames.
>>>>> +
>>>>> +Decoding
>>>>> +========
>>>>> +
>>>>> +This state is reached after a successful initialization sequence. In this
>>>>> +state, client queues and dequeues buffers to both queues via
>>>>> +:c:func:`VIDIOC_QBUF` and :c:func:`VIDIOC_DQBUF`, following standard
>>>>> +semantics.
>>>>> +
>>>>> +Both queues operate independently, following standard behavior of V4L2
>>>>> +buffer queues and memory-to-memory devices. In addition, the order of
>>>>> +decoded frames dequeued from ``CAPTURE`` queue may differ from the order of
>>>>> +queuing coded frames to ``OUTPUT`` queue, due to properties of selected
>>>>> +coded format, e.g. frame reordering. The client must not assume any direct
>>>>> +relationship between ``CAPTURE`` and ``OUTPUT`` buffers, other than
>>>>> +reported by :c:type:`v4l2_buffer` ``timestamp`` field.
>>>>
>>>> Is there a relationship between capture and output buffers w.r.t. the timestamp
>>>> field? I am not aware that there is one.
>>>
>>> I believe the decoder was expected to copy the timestamp of matching
>>> OUTPUT buffer to respective CAPTURE buffer. Both s5p-mfc and coda seem
>>> to be implementing it this way. I guess it might be a good idea to
>>> specify this more explicitly.
>>
>> What about an output buffer producing multiple capture buffers? Or the case
>> where the encoded bitstream of a frame starts at one output buffer and ends
>> at another? What happens if you have B frames and the order of the capture
>> buffers is different from the output buffers?
>>
>> In other words, for codecs there is no clear 1-to-1 relationship between an
>> output buffer and a capture buffer. And we never defined what the 'copy timestamp'
>> behavior should be in that case or if it even makes sense.
> 
> You're perfectly right. There is no 1:1 relationship, but it doesn't
> prevent copying timestamps. It just makes it possible for multiple
> CAPTURE buffers to have the same timestamp or some OUTPUT timestamps
> not to be found in any CAPTURE buffer.

We need to document the behavior. Basically there are three different
corner cases that need documenting:

1) one OUTPUT buffer generates multiple CAPTURE buffers
2) multiple OUTPUT buffers generate one CAPTURE buffer
3) the decoding order differs from the presentation order (i.e. the
   CAPTURE buffers are out-of-order compared to the OUTPUT buffers).

For 1) I assume that we just copy the same OUTPUT timestamp to multiple
CAPTURE buffers.

For 2) we need to specify if the CAPTURE timestamp is copied from the first
or last OUTPUT buffer used in creating the capture buffer. Using the last
OUTPUT buffer makes more sense to me.

And 3) implies that timestamps can be out-of-order. This needs to be
very carefully documented since it is very unexpected.

This should probably be a separate patch, adding text to the v4l2_buffer
documentation (esp. the V4L2_BUF_FLAG_TIMESTAMP_COPY documentation).

Regards,

	Hans
