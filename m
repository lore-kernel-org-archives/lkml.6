Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85136C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46FED205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46FED205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tronnes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966767AbeFSPgc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:36:32 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:47405 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966078AbeFSPga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:36:30 -0400
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:54397 helo=[192.168.10.173])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1fVIgG-0001mb-GT; Tue, 19 Jun 2018 17:36:28 +0200
Subject: Re: [PATCH v2 0/4] drm/tinydrm: new dirver for ILI9341 displays
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
To:     David Lechner <david@lechnology.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>, limor@ladyada.net,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Nitin Patil <nitin@mindsensors.com>
References: <20180525193623.15533-1-david@lechnology.com>
 <8840212b-fd46-e700-58a1-cb1b882c5771@tronnes.org>
 <d5297fc5-94f2-edcd-5a11-95d7a9dca78d@lechnology.com>
 <ecd75b89-14a6-12f7-0ec4-222b1f984e49@tronnes.org>
Message-ID: <5a2bc4e7-c6cd-b270-61d3-61bfa5d9e90d@tronnes.org>
Date:   Tue, 19 Jun 2018 17:36:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <ecd75b89-14a6-12f7-0ec4-222b1f984e49@tronnes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Den 05.06.2018 17.49, skrev Noralf Trønnes:
> (cc: drm-misc maintainers)
>
>
> Den 04.06.2018 03.21, skrev David Lechner:
>>
>>
>> On 6/3/18 5:00 PM, Noralf Trønnes wrote:
>>>
>>> Den 25.05.2018 21.36, skrev David Lechner:
>>>> This series adds a new tinydrm driver for the Ilitek ILI9341 
>>>> controller and
>>>> a 2.4" display panel that uses this controller.
>>>
>>> David, do you have commit rights now?
>>
>> No. Opened a bug a while back to request access, but I guess the
>> right person didn't see it.
>>
>> https://bugs.freedesktop.org/show_bug.cgi?id=105166
>>
>
> Could someone please look at this?
>

David, let's not stall this, if you resend with fixed up commit message 
and acks/rbs, I'll apply it.

Noralf.

> Noralf.
>
>>>
>>> Noralf.
>>>
>>>> A few things to note here:
>>>> * The datasheet for this display[1] doesn't have a vendor mentioned 
>>>> on it
>>>>    anywhere, so I have used "adafruit" as the vendor prefix. If 
>>>> someone has a
>>>>    better suggestion, please speak up.
>>>> * The MAINTAINERS patch for ili9225 is included so we don't end up 
>>>> with a merge
>>>>    conflict later on.
>>>>
>>>> v2 changes:
>>>> * change vendor prefix from "noname" to "adafruit"
>>>> * new patch for "adafruit" vendor prefix
>>>> * minor style changes
>>>> * drop regulator from driver (instead of adding to DT bindings)
>>>>
>>>> [1]: 
>>>> https://cdn-learn.adafruit.com/assets/assets/000/046/879/original/SPEC-YX240QV29-T_Rev.A__1_.pdf 
>>>>
>>>>
>>>>
>>>> David Lechner (4):
>>>>    MAINTAINERS: fix path to ilitek,ili9225 device tree bindings
>>>>    dt-bindings: Add vendor prefix for Adafruit
>>>>    dt-bindings: new binding for Ilitek ILI9341 display panels
>>>>    drm/tinydrm: new driver for ILI9341 display panels
>>>>
>>>>   .../bindings/display/ilitek,ili9341.txt       |  27 ++
>>>>   .../devicetree/bindings/vendor-prefixes.txt   |   1 +
>>>>   MAINTAINERS                                   |   8 +-
>>>>   drivers/gpu/drm/tinydrm/Kconfig               |  10 +
>>>>   drivers/gpu/drm/tinydrm/Makefile              |   1 +
>>>>   drivers/gpu/drm/tinydrm/ili9341.c             | 233 
>>>> ++++++++++++++++++
>>>>   6 files changed, 279 insertions(+), 1 deletion(-)
>>>>   create mode 100644 
>>>> Documentation/devicetree/bindings/display/ilitek,ili9341.txt
>>>>   create mode 100644 drivers/gpu/drm/tinydrm/ili9341.c
>>>>
>>>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>

