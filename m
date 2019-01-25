Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314B0C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEB8D218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="Y3+mNld/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbfAYSo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:44:29 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:57757 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfAYSo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:44:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=xoK0S/04v1rNSscREKgCB+tF3/1xDyMXedZE++gdUio=;
        b=Y3+mNld/YDXIDSLzADA6b03HqlZVCTuS0ZA/ZWYZTl5pp/8kUBtcntMFTSPfygRSZkxXgDhBpTA0rzOPo4+UXfvDswmagkHI23PHDAm6wdoR/WrmoPfitb28d8S/o2Nr3C6T30W32UQ499sudiGL1jL+TKE72zCDl2swidzfwdv1iy8HzTfEY5CIl8XSVGo1vOB3UHRr7xlVz15Dmuxf/hZi6e28IgnDi+rQRfeTYshnBN7PKFxJ+ZySwffK4Ot33vMtdIo4YFg6QvXVWutCQiLtAxv7QkvMwifutQ8/F7PcN1s4tPqSiwwo3WpK6mYLOi14PDbcVnaP6PBtC2CuaQ==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:51443 helo=[192.168.10.176])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1gn6Sn-0000QB-Uo; Fri, 25 Jan 2019 19:44:26 +0100
Subject: Re: [PATCH v3 18/23] drm/qxl: remove dead qxl fbdev emulation code
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>
References: <20190118122020.27596-1-kraxel@redhat.com>
 <20190118122020.27596-19-kraxel@redhat.com>
 <e5a15f7e-b3f1-b609-4a0f-bd66ea711951@tronnes.org>
 <20190125181009.GA8230@ravnborg.org>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <076761d5-f4d7-bf06-45ae-06361b284076@tronnes.org>
Date:   Fri, 25 Jan 2019 19:44:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190125181009.GA8230@ravnborg.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 25.01.2019 19.10, skrev Sam Ravnborg:
> Hi Noralf.
> 
>>> Lovely diffstat, thanks to the new generic fbdev emulation.
>>>
>>>  drm/qxl/Makefile   |    2
>>>  drm/qxl/qxl_draw.c |  232 ----------------------------------------
>>>  drm/qxl/qxl_drv.h  |   21 ---
>>>  drm/qxl/qxl_fb.c   |  300 -----------------------------------------------------
>>>
>>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>>> ---
>>>  drivers/gpu/drm/qxl/qxl_drv.h  |  21 ---
>>>  drivers/gpu/drm/qxl/qxl_draw.c | 232 -------------------------------
>>>  drivers/gpu/drm/qxl/qxl_fb.c   | 300 -----------------------------------------
>>>  drivers/gpu/drm/qxl/Makefile   |   2 +-
>>>  4 files changed, 1 insertion(+), 554 deletions(-)
>>>  delete mode 100644 drivers/gpu/drm/qxl/qxl_fb.c
>>>
>>
>> Nice!
>>
>> Acked-by: Noralf Trønnes <noralf@tronnes.org>
> It must be a very satisfying experience to see such benefits
> of the many hours of works you have put into the genric
> fbdev emulation code.

Indeed and having more users of the code increases the chance of
detecting any bugs lurking underneath the surface.

> Well done, and indeed a nice patch from Gerd.
> 
> 	Sam
> 
