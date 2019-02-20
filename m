Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E318C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA19F20880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZJQP5bZ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfBTMGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 07:06:23 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35774 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfBTMGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 07:06:23 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1KC675b015086;
        Wed, 20 Feb 2019 06:06:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550664367;
        bh=ok8PdiiO3baisjOzYji1e6RIYIpWQ5lP1s6gC9dXq5k=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ZJQP5bZ0zh++y3jBhhZjXhsJ3veiUwa5BJb4aD5EQdmPSX/pDtb3B7zzeJyASn0xH
         WKFKSViMamdHs9bliwc1xhOKwP9OF55xadayL823Sc0Awy+Ry00e5VNjnTSYfSbI8Q
         OibWgn15QY3L3Autm54FpnJwxob6XyTANlViUa7I=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1KC6767111899
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Feb 2019 06:06:07 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 20
 Feb 2019 06:06:06 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 20 Feb 2019 06:06:06 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1KC64Jf014076;
        Wed, 20 Feb 2019 06:06:05 -0600
Subject: Re: [PATCH 4/4] drm/panel: Add OSD101T2587-53TS driver
To:     Sam Ravnborg <sam@ravnborg.org>
CC:     <thierry.reding@gmail.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <devicetree@vger.kernel.org>, <tomi.valkeinen@ti.com>,
        <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>
References: <20190215140315.18046-1-peter.ujfalusi@ti.com>
 <20190215140315.18046-5-peter.ujfalusi@ti.com>
 <20190215180759.GA26944@ravnborg.org>
 <fefcd92c-4171-ed86-28d2-4145d409a73d@ti.com>
 <20190220115202.GA18603@ravnborg.org>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <8d973bd7-3e8b-5d37-10c3-347a7328291f@ti.com>
Date:   Wed, 20 Feb 2019 14:06:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190220115202.GA18603@ravnborg.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

On 20/02/2019 13.52, Sam Ravnborg wrote:
> Hi Peter.
> 
> On Wed, Feb 20, 2019 at 12:39:11PM +0200, Peter Ujfalusi wrote:
>> Hi Sam,
>>
>> On 15/02/2019 20.07, Sam Ravnborg wrote:
>>>> +#include <linux/backlight.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/of.h>
>>>> +#include <linux/regulator/consumer.h>
>>>> +
>>>> +#include <drm/drmP.h>
>>> Please do not use drmP.h in new drivers - we try to get rid of this file.
>>
>> ...
>>
>>>> +static int osd101t2587_panel_get_modes(struct drm_panel *panel)
>>>> +{
>>>> +	struct osd101t2587_panel *osd101t2587 = to_osd101t2587_panel(panel);
>>>> +	struct drm_display_mode *mode;
>>>> +
>>>> +	mode = drm_mode_duplicate(panel->drm, osd101t2587->default_mode);
>>>> +	if (!mode) {
>>>> +		dev_err(panel->drm->dev, "failed to add mode %ux%ux@%u\n",
>>
>> drm/drmP.h is needed for this dev_err.
> drmP.h is only a set of include files and forwards today.
> So you need to figure out what to replace it with.
> 
> Often removing drmP.h requires you to add more than one extra include file.

Replacing it with
#include <drm/drm_device.h>

works perfectly.

Thanks,
- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
