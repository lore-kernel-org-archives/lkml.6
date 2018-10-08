Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90331C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AEF220858
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:22:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AEF220858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbeJHTdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 15:33:37 -0400
Received: from lb3-smtp-cloud9.xs4all.net ([194.109.24.30]:56701 "EHLO
        lb3-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725914AbeJHTdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 15:33:37 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud9.xs4all.net with ESMTPA
        id 9UXxgMUfPSskC9UY1ggOTW; Mon, 08 Oct 2018 14:22:08 +0200
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
        Ezequiel Garcia <ezequiel@collabora.com>,
        Maxime Jourdan <maxi.jourdan@wanadoo.fr>
References: <20180724140621.59624-1-tfiga@chromium.org>
 <20180724140621.59624-2-tfiga@chromium.org>
 <37a8faea-a226-2d52-36d4-f9df194623cc@xs4all.nl>
 <CAAFQd5BgGEBmd8gNGc-qqtUtLo=Mh8U+TVTWRsKYMv1LmeBQMA@mail.gmail.com>
 <CAAFQd5Ba+8_wpCr2D2OUSRt-PbRUPk4MV1OxMzEetntL169fBA@mail.gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <1dc5fd0b-61f0-545a-fea6-bd90721e144b@xs4all.nl>
Date:   Mon, 8 Oct 2018 14:22:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAAFQd5Ba+8_wpCr2D2OUSRt-PbRUPk4MV1OxMzEetntL169fBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfBYzNjkfdJYY18BhbkD4OBetElxiocCyJIfTiqmEOOXkB5NgKR45/7OCldj2Jlxr9SgnD68i1POH251/8yPP1gSrjB21PKEqVQoO1QtI4xigBDYt8G9U
 yEg8KXM9XNtKxisTEoc9pmqCYahdzP9k6TTcL8tX8UP7Oy3LCypSPzTuFs0xFu74ipB89LaCv1rNyPjTHmHYJ1BEXRRtHGtxA+86aaPt/s0ecTX5MgIf1aG8
 saz0esso6XEuNK9D20+vB9Oy7ef4AOswE7LbVhe/xNid+sySqsvzhsMtXiXftnbE7LCTW9Wp1yGB+rixn/ATRSTXEaPHTNIxEBcOcoLpb+cFa1IdpRZojNwn
 /OIDQJg5VCSagl89KsrFrAVm3WIkUZKE7huiNCtnD9LdXpngWL+iLyHCnu4XLDh/yqefIsXiWdtyrNCEqUzGXGOFK9oYjD/6JFGliPmeIUkoN5CFOXG63imX
 GOJ7+PbJ3AAytC5OgnLhhT9Snk9jPfpfhZXj6+RKqQLPLrYwsJNhj9bGm+1i8F/PT2G7Z7I0kf6U+Ott9Of4LWzhOGiXG2892igUBXBC7y6rT2ncA8Z+LAIH
 pyv/0kE10+0POqFmAiStcYMfM7mzW0Va30mzSe1V+4JMPhVkxfQCz4qXZ5O3FIQx5HNq8K54qcv9mT68qvFXRwe4xYS6x4II/mOOHs00tf7sXotTdi4s2hTD
 2R9ao2h5TKF9jsvASA5uXrjRiaHrQcWmzeoH2Yr9Y+pESdtVEn1GKHVl6GqcakkZbMY+l69hAtFHBcL8COPEChUM+97k5LUNQZadO4NKX0rgfeQfwstNfxN+
 GQ+o8/6lgMou72K1wmMuSLe+Rm+CvFw2/ZRcu6qtU9ecqq+huB0iImLSnMXtluXkG/0ktUornunMRn5yQPw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/19/2018 12:17 PM, Tomasz Figa wrote:
> Hi Hans,
> 
> On Thu, Jul 26, 2018 at 7:20 PM Tomasz Figa <tfiga@chromium.org> wrote:
>>
>> Hi Hans,
>>
>> On Wed, Jul 25, 2018 at 8:59 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>>>
>>> Hi Tomasz,
>>>
>>> Many, many thanks for working on this! It's a great document and when done
>>> it will be very useful indeed.
>>>
>>> Review comments follow...
>>
>> Thanks for review!
>>
>>>
>>> On 24/07/18 16:06, Tomasz Figa wrote:
> [snip]
>>>> +13. Allocate destination (raw format) buffers via :c:func:`VIDIOC_REQBUFS`
>>>> +    on the ``CAPTURE`` queue.
>>>> +
>>>> +    * **Required fields:**
>>>> +
>>>> +      ``count``
>>>> +          requested number of buffers to allocate; greater than zero
>>>> +
>>>> +      ``type``
>>>> +          a ``V4L2_BUF_TYPE_*`` enum appropriate for ``CAPTURE``
>>>> +
>>>> +      ``memory``
>>>> +          follows standard semantics
>>>> +
>>>> +    * **Return fields:**
>>>> +
>>>> +      ``count``
>>>> +          adjusted to allocated number of buffers
>>>> +
>>>> +    * The driver must adjust count to minimum of required number of
>>>> +      destination buffers for given format and stream configuration and the
>>>> +      count passed. The client must check this value after the ioctl
>>>> +      returns to get the number of buffers allocated.
>>>> +
>>>> +    .. note::
>>>> +
>>>> +       To allocate more than minimum number of buffers (for pipeline
>>>> +       depth), use G_CTRL(``V4L2_CID_MIN_BUFFERS_FOR_CAPTURE``) to
>>>> +       get minimum number of buffers required, and pass the obtained value
>>>> +       plus the number of additional buffers needed in count to
>>>> +       :c:func:`VIDIOC_REQBUFS`.
>>>
>>>
>>> I think we should mention here the option of using VIDIOC_CREATE_BUFS in order
>>> to allocate buffers larger than the current CAPTURE format in order to accommodate
>>> future resolution changes.
>>
>> Ack.
>>
> 
> I'm about to add a paragraph to describe this, but there is one detail
> to iron out.
> 
> The VIDIOC_CREATE_BUFS ioctl accepts a v4l2_format struct. Userspace
> needs to fill in this struct and the specs says that
> 
>   "Usually this will be done using the VIDIOC_TRY_FMT or VIDIOC_G_FMT
> ioctls to ensure that the requested format is supported by the
> driver."
> 
> However, in case of a decoder, those calls would fixup the format to
> match the currently parsed stream, which would likely resolve to the
> current coded resolution (~hardware alignment). How do we get a format
> for the desired maximum resolution?

You would call G_FMT to get the current format/resolution, then update
width and height and call TRY_FMT.

Although to be honest you can also just set pixelformat and width/height
and zero everything else and call TRY_FMT directly, skipping the G_FMT
ioctl.

> 
> [snip].
>>>> +
>>>> +     * The driver is also allowed to and may not return all decoded frames
> [snip]
>>>> +       queued but not decode before the seek sequence was initiated. For
>>>
>>> Very confusing sentence. I think you mean this:
>>>
>>>           The driver may not return all decoded frames that where ready for
>>>           dequeueing from before the seek sequence was initiated.
>>>
>>> Is this really true? Once decoded frames are marked as buffer_done by the
>>> driver there is no reason for them to be removed. Or you mean something else
>>> here, e.g. the frames are decoded, but the buffers not yet given back to vb2.
>>>
>>
>> Exactly "the frames are decoded, but the buffers not yet given back to
>> vb2", for example, if reordering takes place. However, if one stops
>> streaming before dequeuing all buffers, they are implicitly returned
>> (reset to the state after REQBUFS) and can't be dequeued anymore, so
>> the frames are lost, even if the driver returned them. I guess the
>> sentence was really unfortunate indeed.
>>
> 
> Actually, that's not the only case.
> 
> The documentation is written from userspace point of view. Queuing an
> OUTPUT buffer is not equivalent to having it decoded (and a CAPTURE
> buffer given back to vb2). If the userspace queues a buffer and then
> stops streaming, the buffer might have been still waiting in the
> queue, for decoding of previous buffers to finish.
> 
> So basically by "queued frames" I meant "OUTPUT buffers queued by
> userspace and not sent to the hardware yet" and by "decoded frames" I
> meant "CAPTURE buffers containing matching frames given back to vb2".
> 
> How about rewording like this:
> 
>      * The ``VIDIOC_STREAMOFF`` operation discards any remaining queued
>        ``OUTPUT`` buffers, which means that not all of the ``OUTPUT`` buffers
>        queued before the seek may have matching ``CAPTURE`` buffers produced.
>        For example, [...]

That looks correct.

Regards,

	Hans

> 
>>>> +       example, given an ``OUTPUT`` queue sequence: QBUF(A), QBUF(B),
>>>> +       STREAMOFF(OUT), STREAMON(OUT), QBUF(G), QBUF(H), any of the
>>>> +       following results on the ``CAPTURE`` queue is allowed: {A’, B’, G’,
>>>> +       H’}, {A’, G’, H’}, {G’, H’}.
>>>> +
>>>> +   .. note::
>>>> +
>>>> +      To achieve instantaneous seek, the client may restart streaming on
>>>> +      ``CAPTURE`` queue to discard decoded, but not yet dequeued buffers.
> 
> Best regards,
> Tomasz
> 

