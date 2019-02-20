Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7356C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C79420700
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xPiBaCkX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfBTKix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:38:53 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:35546 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbfBTKix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 05:38:53 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1KAciEU020161;
        Wed, 20 Feb 2019 04:38:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550659124;
        bh=VxbV4lIfH8O+URkt7IRt0vUHSPgS+YYb7pt/OABM/7k=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=xPiBaCkXPAHks2jVWQCnj/WAHK5255lhiJYyH+lN4EzNyNCHJVQnYoY1VrBe9dlpf
         YEwbce8UWUlESXmNP20hLLjZpB3rzixK9E66aV/qmoWHl0z5cUQ0e05sn5+9z7USpa
         YvZLUUa52GV6j3zSQmPMMwnpp0YTIuZs9suuq+Js=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1KAciLC004610
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Feb 2019 04:38:44 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 20
 Feb 2019 04:38:43 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 20 Feb 2019 04:38:43 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1KAcfX4030312;
        Wed, 20 Feb 2019 04:38:41 -0600
Subject: Re: [PATCH 4/4] drm/panel: Add OSD101T2587-53TS driver
To:     Sam Ravnborg <sam@ravnborg.org>
CC:     <thierry.reding@gmail.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <devicetree@vger.kernel.org>, <tomi.valkeinen@ti.com>,
        <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>
References: <20190215140315.18046-1-peter.ujfalusi@ti.com>
 <20190215140315.18046-5-peter.ujfalusi@ti.com>
 <20190215180759.GA26944@ravnborg.org>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <fefcd92c-4171-ed86-28d2-4145d409a73d@ti.com>
Date:   Wed, 20 Feb 2019 12:39:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190215180759.GA26944@ravnborg.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

On 15/02/2019 20.07, Sam Ravnborg wrote:
>> +#include <linux/backlight.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/regulator/consumer.h>
>> +
>> +#include <drm/drmP.h>
> Please do not use drmP.h in new drivers - we try to get rid of this file.

...

>> +static int osd101t2587_panel_get_modes(struct drm_panel *panel)
>> +{
>> +	struct osd101t2587_panel *osd101t2587 = to_osd101t2587_panel(panel);
>> +	struct drm_display_mode *mode;
>> +
>> +	mode = drm_mode_duplicate(panel->drm, osd101t2587->default_mode);
>> +	if (!mode) {
>> +		dev_err(panel->drm->dev, "failed to add mode %ux%ux@%u\n",

drm/drmP.h is needed for this dev_err.

Regards,
- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
