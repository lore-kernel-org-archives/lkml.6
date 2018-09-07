Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7913FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D68B2075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:52:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D68B2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbeIGSdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 14:33:09 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:45916 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725942AbeIGSdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 14:33:09 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud7.xs4all.net with ESMTPA
        id yHB2fjZUHw2L8yHB5fDnkL; Fri, 07 Sep 2018 15:52:04 +0200
Subject: Re: [PATCH v9 5/9] media: platform: Add Cedrus VPU decoder driver
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Paul Kocialkowski <contact@paulk.fr>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com, Randy Li <ayaka@soulik.info>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
References: <20180906222442.14825-1-contact@paulk.fr>
 <20180906222442.14825-6-contact@paulk.fr>
 <4b30c0bf-e525-1868-f625-569d4a104aa0@xs4all.nl>
 <20180907132620.lmsvlwpa3rzioj2h@flea>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <2c9689b2-c5a6-58b7-b467-fc53208ecd2d@xs4all.nl>
Date:   Fri, 7 Sep 2018 15:52:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180907132620.lmsvlwpa3rzioj2h@flea>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfC3pm72lIpWZIiqpcolSosgniYy2MNgJtY7BYNsy8u67ySMXAugL9+VwR/v4TvSV7K6+1IxJcqCtdKhEkdXlZRdbeYG+FtxCjJ8dYCMRyOjzEVItq61P
 j6W4aKqmBOWNqqlQKQcBtRvZyqsIUWhQzYmzi2nyA9E4QSifcMUKmgzIARPVZ37stEzQQh8knqQmYjzKSbMmbc+soG/QpLKonB4OSu+RoHeWScYjAdS5+eNC
 1CRRvhz//UEf+xUfSLA9iBcob3gM0kGns8rGZB0bUYYchu1Ege3pu15G0yUkKhlEU35Odi+vzETMaFboi/DFgxn6WcEQJAyB9Ob6PG/5tRHnhsGZOydKq3pB
 IlyhLutSqxbZqs+X/8OG3e+X3hsjmTKYg9AVzO5ZhNh1rmg0vlS/2LlPLNNTVtNxHGfskDokYmKaVg54HdCyzBIqjJc6k0/hAkR5SV5uQP4T7aH2bmKNfdOE
 kJpW0KHb9watFZgTf6VvOOI4MVfEN/C5SrVNiAxJH4BPPmjQBEYV2PhcbW4Bty3hPPesZL80wPEQMQJImMrR1H7KKFQanXU9SFFnMi4vRr8+P8s+YNNXTVeH
 B+X4NMXUDGgDEsbE0hTd2hJz6nRNiAMlgKeQQGagtlyCvvOceSuAu1JJliRPN3wKxlTJj5E+kRAwM82c1gHCgJsD+Lpmp0kfCaXbF/1MwoxAynqkskZV0/xP
 Yka28J+XKUkaCBmYbYx1B5xs5BzT/JCFCCSpt3cFqTghbh3lGwa+x7Dov4PSD42DggDq8/8Sio/IKh9WNkjysHPCjaqc/MPchcPC2aMZbZncxxZT2T+fYW2V
 MpnWa5l+vAzFAH6dZ7cSgb1cGMNUZklCOCHeNjc6B5BkAOuUoZG8yYJavuI/S2FPrcly9twRuQcS1CLEEgFvTzZQRjXC32OJl8zC7TALL5mjSXPmcNr8daoi
 WnihqA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2018 03:26 PM, Maxime Ripard wrote:
> Hi Hans,
> 
> On Fri, Sep 07, 2018 at 03:13:19PM +0200, Hans Verkuil wrote:
>> On 09/07/2018 12:24 AM, Paul Kocialkowski wrote:
>>> From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>>>
>>> This introduces the Cedrus VPU driver that supports the VPU found in
>>> Allwinner SoCs, also known as Video Engine. It is implemented through
>>> a V4L2 M2M decoder device and a media device (used for media requests).
>>> So far, it only supports MPEG-2 decoding.
>>>
>>> Since this VPU is stateless, synchronization with media requests is
>>> required in order to ensure consistency between frame headers that
>>> contain metadata about the frame to process and the raw slice data that
>>> is used to generate the frame.
>>>
>>> This driver was made possible thanks to the long-standing effort
>>> carried out by the linux-sunxi community in the interest of reverse
>>> engineering, documenting and implementing support for the Allwinner VPU.
>>>
>>> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>>> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
>>
>> One high-level comment:
>>
>> Can you add a TODO file for this staging driver? This can be done in
>> a follow-up patch.
>>
>> It should contain what needs to be done to get this out of staging:
>>
>> - Request API needs to stabilize
>> - Userspace support for stateless codecs must be created
> 
> On that particular note, as part of the effort to develop the driver,
> we've also developped two userspace components:
> 
>   - v4l2-request-test, that has a bunch of sample frames for various
>     codecs and will rely solely on the kernel request api (and DRM for
>     the display part) to test and bringup a particular driver
>     https://github.com/bootlin/v4l2-request-test
> 
>   - libva-v4l2-request, that is a libva implementation using the
>     request API
>     https://github.com/bootlin/libva-v4l2-request
> 
> Did you have something else in mind?

Reviewing this will be the next step. I haven't looked at the userspace components
at all yet, so I don't know yet whether it is what we expect/want/need.

I think this might be a very good topic for the media summit in October if we
can get all the stakeholders together.

Regards,

	Hans
