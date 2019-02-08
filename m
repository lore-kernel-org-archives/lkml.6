Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77253C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 427ED21917
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sUeImJAH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfBHJN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 04:13:58 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54828 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbfBHJN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 04:13:58 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x189Dav3071524;
        Fri, 8 Feb 2019 03:13:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549617216;
        bh=U2UKrUHXgUYKxGAm3YhrUxVAeTB3rTWQlw1ignZV0Fw=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=sUeImJAHZ4BeKvOk5ZPnJ4ltcC2oENEwBS+onzNIhxKZh++2fz00cU0Zqo3ZK5ULI
         6hhN7KHBQAKNiicb3Ye6lFDSFA2EhIelLy6juQv4+tGVzCW/m6xFLOJv3xfd8OmZAY
         LkZWb75LKSMvs9a0Q/XwLrQ4/YSY1NMCQH/IvxBw=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x189Dauh083638
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Feb 2019 03:13:36 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 8
 Feb 2019 03:13:36 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 8 Feb 2019 03:13:36 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x189DXTr006435;
        Fri, 8 Feb 2019 03:13:34 -0600
Subject: Re: [PATCH v2 0/2] drm/omap: panel-tpo-td028ttec1: add backlight
 support
To:     Andreas Kemnade <andreas@kemnade.info>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <laurent.pinchart@ideasonboard.com>,
        <sre@kernel.org>, <dri-devel@lists.freedesktop.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <letux-kernel@openphoenux.org>
References: <20190205063813.14873-1-andreas@kemnade.info>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <a54e7427-ff84-d105-aab7-c5eab42e6df9@ti.com>
Date:   Fri, 8 Feb 2019 11:13:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190205063813.14873-1-andreas@kemnade.info>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/2019 08:38, Andreas Kemnade wrote:
> This panel has a backlight, so add a property describing that and
> add the code to use that.
> This makes things like xset dpms force off
> also turn off the backlight, so we do not need to rely on additional
> userspace programs to do that.
> 
> Andreas Kemnade (2):
>   drm/omap: panel-tpo-td028ttec1: add backlight support
>   dt-bindings: panel: td028ttec1: add backlight property
> 
>  .../devicetree/bindings/display/panel/tpo,td028ttec1.txt       |  2 ++
>  drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c        | 10 ++++++++++
>  2 files changed, 12 insertions(+)
> 

Thanks, I'll pick these up.

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
