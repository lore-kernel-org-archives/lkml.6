Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E384C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 11:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD21920817
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 11:37:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD21920817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbeKQVxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 16:53:44 -0500
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:34261 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725929AbeKQVxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 16:53:44 -0500
Received: from [IPv6:2001:983:e9a7:1:b167:1e29:5b51:e4fb] ([IPv6:2001:983:e9a7:1:b167:1e29:5b51:e4fb])
        by smtp-cloud8.xs4all.net with ESMTPA
        id NyuWgHGU7cvkSNyuXgT0Ua; Sat, 17 Nov 2018 12:37:17 +0100
Subject: Re: [PATCH v2 2/2] media: docs-rst: Document memory-to-memory video
 encoder interface
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Tomasz Figa <tfiga@chromium.org>, linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?B?UGF3ZcWCIE/Fm2NpYWs=?= <posciak@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Kamil Debski <kamil@wypas.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jeongtae Park <jtp.park@samsung.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Todor Tomov <todor.tomov@linaro.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dave.stevenson@raspberrypi.org,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Maxime Jourdan <maxi.jourdan@wanadoo.fr>
References: <20181022144901.113852-1-tfiga@chromium.org>
 <20181022144901.113852-3-tfiga@chromium.org>
 <4cd223f0-b09c-da07-f26c-3b3f7a8868d7@xs4all.nl>
 <5fb0f2db44ba7aa3788b61f2aa9a30d4f4984de5.camel@ndufresne.ca>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <d853eb91-c05d-fb10-f154-bc24e4ebb89d@xs4all.nl>
Date:   Sat, 17 Nov 2018 12:37:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5fb0f2db44ba7aa3788b61f2aa9a30d4f4984de5.camel@ndufresne.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfCwjmUQBzHWdQ4aD9M/22k6tpAPYl1DLc2BK8J0+L12aD3UdvdKVuMnAxD4AgZ+fvlZCV1kQt0TIaRnrbYFMlnj0O51csnRqtyam3Zkv2Xc4hPBtxQeE
 dsFA3T2D2mUg/xuQZGpDOo/zJGjKT/e5TdUqe1+QW9LviBeWRiOxjXVdYW2uJjqN4nsGSHcszGicOVMYYdlK3cgHXEGWkKeu84G3GW7LEo3sJce+Y596vZj2
 srFmB7X5zQeycX2JuxKCQINfnrABch4I3m8NguEm1BXD1ER4oOu8S77kGzdTqN2RbmKMNEcykkb8Qs5eNbmwZvFVq1wvlv3Y7zw2RNkn/R0ftohP/xmZRDkq
 I8n0xl1mTlz6WhrTlKZk7c+W1tMgReCijiay/zVT/w4hnT+gcLpGLoJmcor0jJDV3xfW3N5gXCngVdTbYdoCnMEfs8aZ1kOhnyOt7d+NLQ290CEhXdRPhf5l
 ZnPGIFF6e6L+BY0ZTYztioSt050ZvRANzmjqdxTIG2ktQRi0Ajzh9PMmfldCpqWqpUakE59JUjpcqo8ly7MI0WrazWZIagR+yiBxviV5j/UWmkpSpVNj6In1
 d7sV/ZbR0xo9tmgzLFhshqL91ZkhFr0RTAClarYHqe1Xuf39H/AygmK0cNbTs+UDqlJKhsNJg4uxBwN6Kx5tDhgeM7AorjKWbt3xC129cHiL9RAeFQwQhJUV
 T+u4QR9C8VyZvZZUmoMHNI+nNhoDwv9ly+gfsKgycBYh26pPKkQ89/V64Jjk4O9upO6TZt3Y1gtxMBGj25WcVRnQ8mdh/exQTlcsbDf7ivXFw6K5iB1oi3qF
 oN+DldOPoANfcVp9stC8Iv7D6FLgjCUv809KZIl5ak0J0a7wZmR+uuxub5+s98om9fKAQZdmcNv9zEsNowhMPA7nbPv42/IewsrDFUapcQ0PMcCFknZBoSVp
 NO3y/YmQaEQ8uiDo/vOEwhxlZ6KnAPVG1uI6pg8Jwp56mIpl
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/2018 05:18 AM, Nicolas Dufresne wrote:
> Le lundi 12 novembre 2018 à 14:23 +0100, Hans Verkuil a écrit :
>> On 10/22/2018 04:49 PM, Tomasz Figa wrote:
>>> Due to complexity of the video encoding process, the V4L2 drivers of
>>> stateful encoder hardware require specific sequences of V4L2 API calls
>>> to be followed. These include capability enumeration, initialization,
>>> encoding, encode parameters change, drain and reset.
>>>
>>> Specifics of the above have been discussed during Media Workshops at
>>> LinuxCon Europe 2012 in Barcelona and then later Embedded Linux
>>> Conference Europe 2014 in Düsseldorf. The de facto Codec API that
>>> originated at those events was later implemented by the drivers we already
>>> have merged in mainline, such as s5p-mfc or coda.
>>>
>>> The only thing missing was the real specification included as a part of
>>> Linux Media documentation. Fix it now and document the encoder part of
>>> the Codec API.
>>>
>>> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
>>> ---
>>>  Documentation/media/uapi/v4l/dev-encoder.rst  | 579 ++++++++++++++++++
>>>  Documentation/media/uapi/v4l/devices.rst      |   1 +
>>>  Documentation/media/uapi/v4l/pixfmt-v4l2.rst  |   5 +
>>>  Documentation/media/uapi/v4l/v4l2.rst         |   2 +
>>>  .../media/uapi/v4l/vidioc-encoder-cmd.rst     |  38 +-
>>>  5 files changed, 610 insertions(+), 15 deletions(-)
>>>  create mode 100644 Documentation/media/uapi/v4l/dev-encoder.rst
>>>
>>> diff --git a/Documentation/media/uapi/v4l/dev-encoder.rst b/Documentation/media/uapi/v4l/dev-encoder.rst
>>> new file mode 100644
>>> index 000000000000..41139e5e48eb
>>> --- /dev/null
>>> +++ b/Documentation/media/uapi/v4l/dev-encoder.rst

<snip>

>>> +6. Allocate buffers for both ``OUTPUT`` and ``CAPTURE`` via
>>> +   :c:func:`VIDIOC_REQBUFS`. This may be performed in any order.
>>> +
>>> +   * **Required fields:**
>>> +
>>> +     ``count``
>>> +         requested number of buffers to allocate; greater than zero
>>> +
>>> +     ``type``
>>> +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``OUTPUT`` or
>>> +         ``CAPTURE``
>>> +
>>> +     other fields
>>> +         follow standard semantics
>>> +
>>> +   * **Return fields:**
>>> +
>>> +     ``count``
>>> +          actual number of buffers allocated
>>> +
>>> +   .. warning::
>>> +
>>> +      The actual number of allocated buffers may differ from the ``count``
>>> +      given. The client must check the updated value of ``count`` after the
>>> +      call returns.
>>> +
>>> +   .. note::
>>> +
>>> +      To allocate more than the minimum number of buffers (for pipeline depth),
>>> +      the client may query the ``V4L2_CID_MIN_BUFFERS_FOR_OUTPUT`` or
>>> +      ``V4L2_CID_MIN_BUFFERS_FOR_CAPTURE`` control respectively, to get the
>>> +      minimum number of buffers required by the encoder/format, and pass the
>>> +      obtained value plus the number of additional buffers needed in the
>>> +      ``count`` field to :c:func:`VIDIOC_REQBUFS`.
>>
>> Does V4L2_CID_MIN_BUFFERS_FOR_CAPTURE make any sense for encoders?
> 
> We do account for it in GStreamer (the capture/output handling is
> generic), but I don't know if it's being used anywhere. 

Do you use this value directly for REQBUFS, or do you use it as the minimum
value but in practice use more buffers?

> 
>>
>> V4L2_CID_MIN_BUFFERS_FOR_OUTPUT can make sense depending on GOP size etc.
> 
> Not really the GOP size. In video conference we often run the encoder
> with an open GOP and do key frame request on demand. Mostly the DPB
> size. DPB is specific term use in certain CODEC, but they nearly all
> keep some backlog, except for key frame only codecs (jpeg, png, etc.).
> 
>>

<snip>

>>> +.. note::
>>> +
>>> +   To let the client distinguish between frame types (keyframes, intermediate
>>> +   frames; the exact list of types depends on the coded format), the
>>> +   ``CAPTURE`` buffers will have corresponding flag bits set in their
>>> +   :c:type:`v4l2_buffer` struct when dequeued. See the documentation of
>>> +   :c:type:`v4l2_buffer` and each coded pixel format for exact list of flags
>>> +   and their meanings.
>>
>> Is this required? (I think it should, but it isn't the case today).
> 
> Most CODEC do provide this metadata, if it's absent, placing the stream
> into a container may require more parsing.
> 
>>
>> Is the current set of buffer flags (Key/B/P frame) sufficient for the current
>> set of codecs?
> 
> Doe it matter ? It can be extended when new codec get added. There is a
> lot things in AV1 as an example, but we can add these when HW and
> drivers starts shipping.

I was just curious :-) It doesn't really matter, I agree.

<snip>

>>> +      rely on it. The ``V4L2_BUF_FLAG_LAST`` buffer flag should be used
>>> +      instead.
>>
>> Question: should new codec drivers still implement the EOS event?
> 
> I'm been asking around, but I think here is a good place. Do we really
> need the FLAG_LAST in userspace ? Userspace can also wait for the first
> EPIPE return from DQBUF.

I'm interested in hearing Tomasz' opinion. This flag is used already, so there
definitely is a backwards compatibility issue here.

> 
>>
>>> +
>>> +3. Once all ``OUTPUT`` buffers queued before the ``V4L2_ENC_CMD_STOP`` call and
>>> +   the last ``CAPTURE`` buffer are dequeued, the encoder is stopped and it will
>>> +   accept, but not process any newly queued ``OUTPUT`` buffers until the client
>>> +   issues any of the following operations:
>>> +
>>> +   * ``V4L2_ENC_CMD_START`` - the encoder will resume operation normally,
>>
>> Perhaps mention that this does not reset the encoder? It's not immediately clear
>> when reading this.
> 
> Which drivers supports this ? I believe I tried with Exynos in the
> past, and that didn't work. How do we know if a driver supports this or
> not. Do we make it mandatory ? When it's not supported, it basically
> mean userspace need to cache and resend the header in userspace, and
> also need to skip to some sync point.

Once we agree on the spec, then the next step will be to add good compliance
checks and update drivers that fail the tests.

To check if the driver support this ioctl you can call VIDIOC_TRY_ENCODER_CMD
to see if the functionality is supported.

Regards,

	Hans
