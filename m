Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C79C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 05:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA6920875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 05:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZD9lqf2z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA6920875
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbeJEMHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 08:07:15 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36766 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbeJEMHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 08:07:14 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w955ABpU047730;
        Fri, 5 Oct 2018 00:10:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538716211;
        bh=MU3QX72uhJtzMvFMqTHu1k0AQM9UxEbfbAZd52EvTiM=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=ZD9lqf2ze2151psQCgDr3kFAtLYYB0EZoV5N7oU+8Eavp0sCKOuHELRGXrXP1dgBi
         eVb8Pycn6gse0nrdZugcHB8a43VRcrXwhKaGjL0G9G3oGWvLcvyLxfDitQxAp+Bwh+
         7V7tcw8xVUKeZDipS6aqJGqKjhO5xqfsCBEYFeR8=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w955ABkl021157;
        Fri, 5 Oct 2018 00:10:11 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 5 Oct
 2018 00:10:11 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 5 Oct 2018 00:10:10 -0500
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w955A7Ch017372;
        Fri, 5 Oct 2018 00:10:08 -0500
Subject: Re: [PATCH 0/5] ti_am335x_tsc: Enable wakeup capability
From:   Vignesh R <vigneshr@ti.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-input@vger.kernel.org>
References: <20180630103318.25355-1-vigneshr@ti.com>
 <dcb4a63b-9ecb-a72e-bfb8-ebb62017b4f7@ti.com> <20180718074736.GA4641@dell>
 <20180718170902.vk7rahyoaevucxbi@penguin> <20180723053708.GA4213@dell>
 <2236aa96-ca56-fa30-157d-2f484c6968cc@ti.com> <20180725052621.GB5835@dell>
 <f61848d8-57f6-14c0-eb74-cab488ceda50@ti.com>
Message-ID: <c53a8853-2571-75bc-0cd0-bda9ba906e0a@ti.com>
Date:   Fri, 5 Oct 2018 10:41:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f61848d8-57f6-14c0-eb74-cab488ceda50@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 September 2018 11:42 AM, Vignesh R wrote:
> Hi Lee,
> 
> On Wednesday 25 July 2018 10:56 AM, Lee Jones wrote:
> [...]
>>>>>>>>
>>>>>>>> Vignesh R (5):
>>>>>>>>   mfd: ti_am335x_tscadc: Don't mark TSCADC MFD as wakeup capable
>>>>>>>>   Input: ti_am335x_tsc: Mark TSC device as wakeup source
>>>>>>>>   mfd: ti_am335x_tscadc: Keep ADC interface on if child is wakeup
>>>>>>>>     capable
>>>>>>>>   iio: adc: ti_am335x_adc: Disable ADC during suspend unconditionally
>>>>>>>>   Input: ti_am335x_tsc: Mark IRQ as wakeup capable
>>>>>>>>
>>>>>>>>  drivers/iio/adc/ti_am335x_adc.c           | 12 ++++--------
>>>>>>>>  drivers/input/touchscreen/ti_am335x_tsc.c | 22 +++++++++++++++++-----
>>>>>>>>  drivers/mfd/ti_am335x_tscadc.c            | 14 +++++++++++++-
>>>>>>>>  3 files changed, 34 insertions(+), 14 deletions(-)
>>>>>>>>
>>>>>>>
>>>>>>> Gentle ping... Could you review/pick this series? MFD amd IIO bits are
>>>>>>> already ACKed
>>>>>>
>>>>>> MFD patches are reviewed "for my own reference" meaning that we
>>>>>> haven't yet agreed on a merge plan yet.
>>>>>
>>>>> I think this series makes sense to be pushed through a single tree as
>>>>> opposed to being spread between 3, even if it could technically be
>>>>> possible. It looks like Jonathan is fine with going it through either
>>>>> his or some other tree, I am fine with it going through MFD.
>>>>
>>>> I'm happy either way.
>>>>
>>> Thanks Dmitry, Jonathan and Lee Jones!
>>>
>>> Could this be applied to one of the trees now? MFD perhaps?
>>
>> It'll be applied, when it's applied. ;)
> 
> I see that this series was not picked up for v4.19. Could you consider
> this series for v4.20? Patches apply cleanly against linux-next.
> 
> 

Gentle ping...


-- 
Regards
Vignesh
