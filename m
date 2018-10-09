Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B371EC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DACC2087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:08:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DACC2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbeJIPXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 11:23:41 -0400
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:58613 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725855AbeJIPXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 11:23:40 -0400
Received: from [IPv6:2001:420:44c1:2579:9980:eade:362a:f91e] ([IPv6:2001:420:44c1:2579:9980:eade:362a:f91e])
        by smtp-cloud9.xs4all.net with ESMTPA
        id 9n3YgXVqrSskC9n3cgmAWu; Tue, 09 Oct 2018 10:07:57 +0200
Subject: Re: [RFC PATCH v2] media: docs-rst: Document m2m stateless video
 decoder interface
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Alexandre Courbot <acourbot@chromium.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pawel Osciak <posciak@chromium.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181004081119.102575-1-acourbot@chromium.org>
 <676a5e92-86c2-cf5a-9409-ef490ad8e828@xs4all.nl>
 <CAAFQd5AULSY9d0wHXBD227k-F_ER4f+=LkMnp8GOdV3uaCsyeA@mail.gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <4fc9af27-3086-f4bd-c77c-5515ab872d10@xs4all.nl>
Date:   Tue, 9 Oct 2018 10:07:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAAFQd5AULSY9d0wHXBD227k-F_ER4f+=LkMnp8GOdV3uaCsyeA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPCownw/NNb0u4zkrycEOVxIsolpBZL7ThNbuaGmPqlpiuIHCyb7QQ0LiIrWQFDpc29UPrI6KdDWrUG8FrXL+xm/3ExKVlSM4sFVtmRcBazmxZ7RxZ/x
 Kmdx9HukT+wTYC/omYPvevwY/dkMWiRvwhTKSUKyDaApgE2UyccuUFLmfP1b3b+uk2zNmiZduyBPHsgb+JjI4fNatlOvv8PsIpFo7L+7o9Q1UMj65i9zmt4d
 iEeYN6BjHRlGI0SqBPEziUXu2G6/s5JyAjVtCuGCM9yTRhK21K04hC0icREn2T5uw7pNAK2bF93hnLBvFVO+xEfE0mcynRE1K9by/zkRSEg7qtJYMdvP9+Cu
 FaQwEHL7UDYGeeiVg56JURhFdRDDAOLgIohRrcIwmOaAOEIyhLSFizR9X+Fz6otZT7lY7vTmoHvda2SAA4bkRZ40BkiXOUKcXvnDTyhbx/x4wpxykYdL89uG
 pBwuEIlwAcvOufec6fX/7+CTi+9ytMkL5eIPMg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/18 09:41, Tomasz Figa wrote:
> On Mon, Oct 8, 2018 at 8:02 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>>
>> On 10/04/2018 10:11 AM, Alexandre Courbot wrote:
>>> This patch documents the protocol that user-space should follow when
>>> communicating with stateless video decoders. It is based on the
>>> following references:
>>>
>>> * The current protocol used by Chromium (converted from config store to
>>>   request API)
>>>
>>> * The submitted Cedrus VPU driver
>>>
>>> As such, some things may not be entirely consistent with the current
>>> state of drivers, so it would be great if all stakeholders could point
>>> out these inconsistencies. :)
>>>
>>> This patch is supposed to be applied on top of the Request API V18 as
>>> well as the memory-to-memory video decoder interface series by Tomasz
>>> Figa.
>>>
>>> Changes since V1:
>>>
>>> * Applied fixes received as feedback,
>>> * Moved controls descriptions to the extended controls file,
>>> * Document reference frame management and referencing (need Hans' feedback on
>>>   that).
>>>
>>> Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
>>> ---
>>>  .../media/uapi/v4l/dev-stateless-decoder.rst  | 348 ++++++++++++++++++
>>>  Documentation/media/uapi/v4l/devices.rst      |   1 +
>>>  .../media/uapi/v4l/extended-controls.rst      |  25 ++
>>>  .../media/uapi/v4l/pixfmt-compressed.rst      |  54 ++-
>>>  4 files changed, 424 insertions(+), 4 deletions(-)
>>>  create mode 100644 Documentation/media/uapi/v4l/dev-stateless-decoder.rst
>>>
>>> diff --git a/Documentation/media/uapi/v4l/dev-stateless-decoder.rst b/Documentation/media/uapi/v4l/dev-stateless-decoder.rst
>>
>> <snip>
>>
>>> +Buffer management during decoding
>>> +=================================
>>> +Contrary to stateful decoder drivers, a stateless decoder driver does not
>>> +perform any kind of buffer management. In particular, it guarantees that
>>> +``CAPTURE`` buffers will be dequeued in the same order as they are queued. This
>>> +allows user-space to know in advance which ``CAPTURE`` buffer will contain a
>>> +given frame, and thus to use that buffer ID as the key to indicate a reference
>>> +frame.
>>> +
>>> +This also means that user-space is fully responsible for not queuing a given
>>> +``CAPTURE`` buffer for as long as it is used as a reference frame. Failure to do
>>> +so will overwrite the reference frame's data while it is still in use, and
>>> +result in visual corruption of future frames.
>>> +
>>> +Note that this applies to all types of buffers, and not only to
>>> +``V4L2_MEMORY_MMAP`` ones, as drivers supporting ``V4L2_MEMORY_DMABUF`` will
>>> +typically maintain a map of buffer IDs to DMABUF handles for reference frame
>>> +management. Queueing a buffer will result in the map entry to be overwritten
>>> +with the new DMABUF handle submitted in the :c:func:`VIDIOC_QBUF` ioctl.
>>
>> The more I think about this, the more I believe that relying on capture buffer
>> indices is wrong. It's easy enough if there is a straightforward 1-1 relationship,
>> but what if you have H264 slices as Nicolas mentioned and it becomes a N-1 relationship?
>>
>> Yes, you can still do this in userspace, but it becomes a lot more complicated.
>>
>> And what if in the future instead of having one capture buffer per decoded frame
>> there will be multiple capture buffers per decoded frame, each with a single
>> slice (for example)?
> 
> Is there any particular scenario you have in mind, where such case would happen?

Video conferencing to reduce the latency, i.e. no need to wait for the full frame
to be available, just start processing as soon as a decoded slice arrives.

> 
>>
>> I would feel much happier if we used a 'cookie' to refer to buffers.
> 
> Hmm, how would this cookie work in a case of N OUTPUT -> 1 CAPTURE case?

The output buffers would use the same cookie.

Regards,

	Hans

> 
> Best regards,
> Tomasz
> 

