Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67373C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E46F206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:39:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E46F206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbeIFMNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 08:13:44 -0400
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:50542 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725929AbeIFMNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 08:13:43 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud8.xs4all.net with ESMTPA
        id xot0fLoQSxO9Bxot3f451h; Thu, 06 Sep 2018 09:39:34 +0200
Subject: Re: [PATCH v8 4/8] media: platform: Add Cedrus VPU decoder driver
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     contact@paulk.fr,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        thomas.petazzoni@bootlin.com, ayaka <ayaka@soulik.info>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-sunxi@googlegroups.com
References: <20180828073424.30247-1-paul.kocialkowski@bootlin.com>
 <20180828073424.30247-5-paul.kocialkowski@bootlin.com>
 <5faf5eed-eb2c-f804-93e3-5a42f6204d99@xs4all.nl>
 <b7b3cb2320978d45acb34475d15abd7bf03da367.camel@paulk.fr>
 <461c6a0d-a346-b9da-b75e-4aab907054df@xs4all.nl>
 <CAAFQd5Cmc7uFhprsoTU6Gq19n3z2eiUfZZ2ZjDW4QWVWMDN6tg@mail.gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <7a2167a3-5b61-0937-7f06-8b36fa12e7a0@xs4all.nl>
Date:   Thu, 6 Sep 2018 09:39:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAAFQd5Cmc7uFhprsoTU6Gq19n3z2eiUfZZ2ZjDW4QWVWMDN6tg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfLyW0xyCb2ptchsVdKyYNj3IaKV/ES8v49v8AFCF1hMz8NFis2f9WIbZlYpbDNuPBjipXVhIFk4grydyHqzRecsWKSo8HiszOJ9gYMX3+GN3eCfgoogh
 jadLTd40u1yjE2nLPKvFdNmpgi/EgWUSNf6Z0Py2x0UJuMI+OM66vya3vtMVZGD740v+FBPIce8+OAP9FPalCiXnRPrt7BnOfaQImiKIqjRm06u6V6g1gN8S
 MHuASnTJRVWz3VSlfHvsvqpej/3vMFAy/UMcSvx9y1sAfyPUBursdyOHadXql23ADvrf+tyWJ93k47B55YBac+0EjxLlooUA45eCpsX3tA0SAdfnTaXQF4xk
 tucs5c6MEMyH25QJdxZItUFUKn7gnr2fdIr3AuEZPL4E2lYttgYNY1L16bglf5Z/dDTukI36ahcYSYI5oV5ElJxqo+v8cEElUnIiGUpCKE38/n4RQBL3a87a
 FAEA0QPT0YwF6E8XCH/idehNJ3DVynWqHSbAss8EqmDNZdQGKPiQ85tJqN4mULHyOH+AGmRZxGahYAubMGYYaFWdmuGzsqaKHX26/C2Q22W080O8t+l+M3kL
 M8h7Gs/Jc295LQ9hK8aIBazMezCfZDUI1IVsnEuO6P0TTf/tKSthJ0sYHbM1vIi/8Nioq9Vl8he0kcpqZIOVX/K1kEaJUt3UJDSmuaShP+zW8rcAr+XWwSzK
 kqVI+7tTrpQxxAm89XeKXbmYW2epf6e0/vW/+aqoRTl3iTUUifzwbKHXjwdtpsbCJUApCCN7eQuwqf1scwMmN0QrU4VM7YsXg+MfWjL/CnCluL3qhuGg5ZNm
 EI6AlbfRX4KyfBjjbJ+hJ1pl9QbjuEefoAxUa21TjldcwlgRcLOdxWKcsgwsYZSmd4kHj8EXhqheubQbOEPWEB+5HKvKzKks2mV8miBCkjMAAWtFzVS7Mzbk
 AIPL3w80ey6nDodzyx4rjeTewmS4Q92+KYU8yWIKcu1y1QYL
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2018 09:25 AM, Tomasz Figa wrote:
> On Thu, Sep 6, 2018 at 4:01 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>>
>> On 09/05/2018 06:29 PM, Paul Kocialkowski wrote:
>>> Hi and thanks for the review!
>>>
>>> Le lundi 03 septembre 2018 à 11:11 +0200, Hans Verkuil a écrit :
>>>> On 08/28/2018 09:34 AM, Paul Kocialkowski wrote:
>>>>> +static int cedrus_request_validate(struct media_request *req)
>>>>> +{
>>>>> +   struct media_request_object *obj, *obj_safe;
>>>>> +   struct v4l2_ctrl_handler *parent_hdl, *hdl;
>>>>> +   struct cedrus_ctx *ctx = NULL;
>>>>> +   struct v4l2_ctrl *ctrl_test;
>>>>> +   unsigned int i;
>>>>> +
>>>>> +   list_for_each_entry_safe(obj, obj_safe, &req->objects, list) {
>>>>
>>>> You don't need to use the _safe variant during validation.
>>>
>>> Okay, I'll use the regular one then.
>>>
>>>>> +           struct vb2_buffer *vb;
>>>>> +
>>>>> +           if (vb2_request_object_is_buffer(obj)) {
>>>>> +                   vb = container_of(obj, struct vb2_buffer, req_obj);
>>>>> +                   ctx = vb2_get_drv_priv(vb->vb2_queue);
>>>>> +
>>>>> +                   break;
>>>>> +           }
>>>>> +   }
>>>>
>>>> Interesting question: what happens if more than one buffer is queued in the
>>>> request? This is allowed by the request API and in that case the associated
>>>> controls in the request apply to all queued buffers.
>>>>
>>>> Would this make sense at all for this driver? If not, then you need to
>>>> check here if there is more than one buffer in the request and document in
>>>> the spec that this is not allowed.
>>>
>>> Well, our driver was written with the (unformal) assumption that we
>>> only deal with a pair of one output and one capture buffer. So I will
>>> add a check for this at request validation time and document it in the
>>> spec. Should that be part of the MPEG-2 PIXFMT documentation (and
>>> duplicated for future formats we add support for)?
>>
>> Can you make a patch for vb2_request_has_buffers() in videobuf2-core.c
>> renaming it to vb2_request_buffer_cnt() and returning the number of buffers
>> in the request?
>>
>> Then you can call it here to check that you have only one buffer.
>>
>> And this has to be documented with the PIXFMT.
>>
>> Multiple buffers are certainly possible in non-codec scenarios (vim2m and
>> vivid happily accept that), so this is an exception that should be
>> documented and checked in the codec driver.
> 
> Hmm, isn't it still 1 buffer per 1 queue and just multiple queues
> included in the request?

No. The request API allows multiple buffers for the same vb2_queue to be
queued for the same request (obviously when the request is committed, the
buffers are queued to the driver in the same order).

> 
> If we indeed allow multiple buffers for the same queue in a request,
> we shouldn't restrict this on a per-driver basis. It's definitely not
> a hardware limitation, since the driver could just do the same as if 2
> requests with the same controls were given.

That's how it operates: for all buffers in the request the same controls
apply. But does this make sense for codecs? If the control(s) with the
codec metadata always change for every buffer, then having more than one
buffer in the request is senseless and the driver should check for this
in the validation step.

If it *does* make sense in some circumstances to have the same metadata
for multiple buffers, then it should be checked if the cedrus driver
handles this correctly.

Regards,

	Hans
