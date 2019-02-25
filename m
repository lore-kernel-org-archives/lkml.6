Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA95C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 408F12147C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HhI0z1LK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfBYOis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 09:38:48 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:41200 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbfBYOip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 09:38:45 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1PEcXgd046586;
        Mon, 25 Feb 2019 08:38:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1551105513;
        bh=xgUjiT/5frNoVoRI3pGY10i15F4ckE92GNBGcd3PJV4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=HhI0z1LKqxHeKkdsZ/QKtVIYdn69t3rA45ar19bcnjnRKxqZgDttfKOV4Ekj7QiKe
         Y6VbHF2D7T2H9I4pTLqN7+2XUPjLG2BNGpMPywtR7LPCyaeis++cu5NGvMfacVvmUs
         6lenhnBnxwBe7fpN28OrHW3TuezWa9dFfhdGBRuc=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1PEcXhl105887
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Feb 2019 08:38:33 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 25
 Feb 2019 08:38:33 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 25 Feb 2019 08:38:33 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1PEcUkd014303;
        Mon, 25 Feb 2019 08:38:31 -0600
Subject: Re: [PATCH v2 4/4] drm/panel: Add OSD101T2587-53TS driver
To:     Sam Ravnborg <sam@ravnborg.org>
CC:     <thierry.reding@gmail.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <tomi.valkeinen@ti.com>
References: <20190222131618.20520-1-peter.ujfalusi@ti.com>
 <20190222131618.20520-5-peter.ujfalusi@ti.com>
 <20190223193805.GA21790@ravnborg.org>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <37fcd744-b32c-d77a-b422-fb44d6f2c952@ti.com>
Date:   Mon, 25 Feb 2019 16:39:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190223193805.GA21790@ravnborg.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

On 23/02/2019 21.38, Sam Ravnborg wrote:
> Hi Peter.
> 
> Driver looks to be in good shape now.
> With the few comments below addressed you can add my:
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> 
> 	Sam
> 
> On Fri, Feb 22, 2019 at 03:16:18PM +0200, Peter Ujfalusi wrote:
>> The panel is similar to OSD101T2045-53TS (which is handled by panel-simple)
>> with one big difference: osd101t2587-53ts needs MIPI_DSI_TURN_ON_PERIPHERAL
>> message to be sent from the host to be operational and thus can not be
>> handled by panel-simple.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  drivers/gpu/drm/panel/Kconfig                 |   6 +
>>  drivers/gpu/drm/panel/Makefile                |   1 +
>>  .../drm/panel/panel-osd-osd101t2587-53ts.c    | 254 ++++++++++++++++++
>>  3 files changed, 261 insertions(+)
>>  create mode 100644 drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c
>>
>> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
>> index 3e070153ef21..351661920838 100644
>> --- a/drivers/gpu/drm/panel/Kconfig
>> +++ b/drivers/gpu/drm/panel/Kconfig
>> @@ -122,6 +122,12 @@ config DRM_PANEL_ORISETECH_OTM8009A
>>  	  Say Y here if you want to enable support for Orise Technology
>>  	  otm8009a 480x800 dsi 2dl panel.
>>  
>> +config DRM_PANEL_OSD_OSD101T2587_53TS
>> +	tristate "OSD OSD101T2587-53TS DSI 1920x1200 video mode panel"
>> +	depends on OF
>> +	depends on DRM_MIPI_DSI
>> +	depends on BACKLIGHT_CLASS_DEVICE
> Please add a help-text

Sure, I forgot this.

>> +
>> +static int osd101t2587_panel_unprepare(struct drm_panel *panel)
>> +{
>> +	struct osd101t2587_panel *osd101t2587 = to_osd101t2587_panel(panel);
>> +
>> +	if (!osd101t2587->prepared)
>> +		return 0;
>> +
>> +	regulator_disable(osd101t2587->supply);
>> +	osd101t2587->prepared = false;
>> +
>> +	return 0;
>> +}
>> +
>> +static int osd101t2587_panel_prepare(struct drm_panel *panel)
>> +{
>> +	struct osd101t2587_panel *osd101t2587 = to_osd101t2587_panel(panel);
>> +	int ret;
>> +
>> +	if (osd101t2587->prepared)
>> +		return 0;
>> +
>> +	ret = regulator_enable(osd101t2587->supply);
>> +	if (!ret)
>> +		osd101t2587->prepared = true;
> 
> Logic is wrong here. regulator_enable() will return a negative value on error
> and 0 in the good case.
> So osd101t2587->prepared is set to true only in the error case, not in the good case.

It is good as it is:
'if (!0)' == 'if (1)'
'if (!-X)' == 'if (0)'

>> +
>> +	ret = mipi_dsi_attach(dsi);
>> +	if (ret)
>> +		drm_panel_remove(&osd101t2587->base);
> 
> I do not see panel-simple.c do a drm_panel_remove() if mipi_dsi_attach() fails.
> Maybe the driver core will call remove() is probe fails?
> Or maybe panel-simple() should call drm_panel_remove()
> 
> Keep the above as is - I just wanted to express that this looks different
> from the panle-simple() driver.

I have a patch for panel-simple as well with the following commit message:
"drm/panel: simple: Fix panel_simple_dsi_probe

In case mipi_dsi_attach() fails remove the registered panel to avoid
added panel without corresponding device."

It has the same bug.

>> +static int osd101t2587_panel_remove(struct mipi_dsi_device *dsi)
>> +{
>> +	struct osd101t2587_panel *osd101t2587 = mipi_dsi_get_drvdata(dsi);
>> +	int ret;
>> +
>> +	ret = osd101t2587_panel_disable(&osd101t2587->base);
>> +	if (ret < 0)
>> +		dev_warn(&dsi->dev, "failed to disable panel\n");
> This is already warned in lower layers and I think you could
> drop the dev_warn().

I think there is no warning from lower layer, but not sure as I never
hit this case.

>> +
>> +	osd101t2587_panel_unprepare(&osd101t2587->base);
>> +
>> +	drm_panel_remove(&osd101t2587->base);
>> +
>> +	ret = mipi_dsi_detach(dsi);
>> +	if (ret < 0)
>> +		dev_warn(&dsi->dev, "failed to detach from DSI host\n");
> Add error code in logging.

OK

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
