Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A8BC282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D7772084A
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TztSpLaW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732739AbfAaMI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:08:59 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42956 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfAaMI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 07:08:59 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0VC8NGp130852;
        Thu, 31 Jan 2019 06:08:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548936503;
        bh=ZMOZUzLV4yZ9WKpPBnWSUn8UWpC0a4CfQgkUrNoRKLM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=TztSpLaWjcTW5LI7+FiJ8iUrT+Uo79++Xb6mlNNeaoilT6FbBku4xJbKH+934jtMQ
         SEyWzsJjFCmrYRfusSB6mhNk640qCheFNpUwrWvYlNGQOwZVUcSjkf7Y72oO5kNeHr
         xJf1K+jhfUw05E3EpsiIEbC/KEYKVWmznOMB7weo=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0VC8NF2084831
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 31 Jan 2019 06:08:23 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 31
 Jan 2019 06:08:23 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 31 Jan 2019 06:08:23 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0VC8I7s007940;
        Thu, 31 Jan 2019 06:08:19 -0600
Subject: Re: [PATCH v7 0/4] drm: add support for Cadence MHDP DPI/DP bridge.
To:     Damian Kos <dkos@cadence.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>
CC:     <jbergsagel@ti.com>, <quentin.schulz@bootlin.com>,
        <piotrs@cadence.com>, <rafalc@cadence.com>
References: <1548846209-16406-1-git-send-email-dkos@cadence.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <0f11a4d8-d576-5af8-b7f4-afe3ff26678f@ti.com>
Date:   Thu, 31 Jan 2019 14:08:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548846209-16406-1-git-send-email-dkos@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 30/01/2019 13:03, Damian Kos wrote:
> Hello!
> 
> This is the series of patches that will add support for the Cadence's DPI/DP
> bridge. Please note that this is a preliminary version of the driver and there
> will be more patches in the future with updates, fixes and improvements.
> Please keep that in mind when looking at FIXME/TODO/XXX comments.
> 
> Initially, MHDP driver was developed as a DRM bridge driver and was planed to
> be placed in drivers/gpu/drm/bridge/mhdp.c.  However, there was already
> a driver for Cadence's DP controller developed by RockChip, but that driver
> uses the different DRM framework and looks like a part of a bigger system.
> Both controllers (including firmware) are quite different internally
> (MST/FEC/DSC support, link training done by driver, additional commands, IRQ's
> etc.) but they have similar register map, except for Framer/Streamer (which is
> noticeably different), so they appear similar.
> 
> The following patches contain:
> - Moving common code to drivers/gpu/drm/bridge/cdns-mhdp-common.* and
>   modifying it a bit (mostly new prefixes for functions and data types) so it
>   can be used by two, higher level, drivers.
> - Modifying existing RockChip's DP driver to use the common code after changes
>   made to it (use the new cdns_mhdp_device structure and new function names).
> - Modifying DRM helpers a bit. Some are required for new driver, some are
>   updates from DP 1.2 to 1.3 or 1.4.
> - Adding documentation for device tree bindings.
> - Adding preliminary Cadence DPI/DP bridge driver.
> 
> Some of the things that will be added later on include (but are not limited
> to):
> - DSC support
> - FEC support
> - HDCP support

A few random comments/questions after a quick look at the patches.

The names of the source files and the kernel Kconfig are only about
"Cadence DP". But the DT bindings is for cdns,mhdp8546, and the
resulting module file is mhdp8546.ko. I think more consistency here
would be good.

I presume the part number (or family? are there other similar parts with
similar part numbers?) is relevant, so it should be in the Kconfig
option and help text, and probably in the file names too. The module
name should have "cdns" prefix there, similar to the source files and
the cdns-dsi.ko.

Or maybe the same driver will handle all Cadence DP parts, in which case
generic filenames are fine, but then the resulting kernel module should
also be just "cdns-mhdp.ko".

I see some audio functions in the code, but it's not mentioned in the DT
bindings. I'm not an audio guy, but the display bridges with audio
support I have seen have had DT bindings for the audio source too. Is
audio supported in the current driver?

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
