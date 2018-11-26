Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B69AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F010420663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="je/ePtiN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F010420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbeKZUUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 15:20:53 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57682 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbeKZUUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 15:20:53 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAQ9RCow090180;
        Mon, 26 Nov 2018 03:27:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543224432;
        bh=hp4KQ1BAJoznOLBupj/EAeqth06d/eQNMl1ttTzfyIA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=je/ePtiNTM1+fFB5jsgegm2+c7bXneqMC67Kea2X0oAwha3VueAsuwDplzfXkS30D
         qXLqlpUl4YEl8IAYgIwvQWIJATve+kE2kKMYSSZogiskzovX5gA0JHjS4vkbhOqtAu
         IXJN6ANXwYZ7+ZnIf9hatSSc16L75hWYoJ5HoCeQ=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAQ9RCOO072621
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Nov 2018 03:27:12 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 26
 Nov 2018 03:27:09 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 26 Nov 2018 03:27:09 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAQ9R6gw030268;
        Mon, 26 Nov 2018 03:27:07 -0600
Subject: Re: [PATCHv5 2/6] drm/omap: populate DSI platform bus earlier
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sebastian Reichel <sre@kernel.org>,
        Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        <dri-devel@lists.freedesktop.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@collabora.com>
References: <20181121160916.22017-1-sebastian.reichel@collabora.com>
 <20181121160916.22017-3-sebastian.reichel@collabora.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <d65157b6-59c7-7b51-d431-9f9cb5585593@ti.com>
Date:   Mon, 26 Nov 2018 11:27:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20181121160916.22017-3-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/18 18:09, Sebastian Reichel wrote:
> After the changes from 4.20 the DSI encoder tries to find the
> attached panel before populating the DSI bus. If the panel is
> not found -EPROBE_DEFER is returned, so the DSI bus is never
> populated and the panel never added.
> 
> Fix this by populating the DSI bus before searching for the
> video sink in dsi_init_output().
> 
> Fixes: 27d624527d992 ("drm/omap: dss: Acquire next dssdev at probe time")
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Tested-by: Tony Lindgren <tony@atomide.com>
> Tested-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/gpu/drm/omapdrm/dss/dsi.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
