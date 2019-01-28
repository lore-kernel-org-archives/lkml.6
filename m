Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87413C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C41214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="N9gajQtf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfA1KkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 05:40:02 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:39521 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfA1KkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 05:40:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=WvihPJ4lhjKMb8zpEHR5rdWQbbWysx/BzM0Fm3PzQrg=;
        b=N9gajQtfVJIYZ/qJUeqzzpvMX2+b59NJTbQMHBmCSMBX24ME7IQCd96w+7RK5m2V7xLZJBs9TVl1XIphv5c/iBpCuMEJkD6nn4yoSD4Gtq51401FSuc6ngaf/2Za3vrGAJ9vc1oxIbTobBcZSh4+lwywoenKtYZRU4qC7b7JSBm6e9qVWsDRPEXp1CPoTMD9OrAEQWlmmKDSp81Y39ldg50iJUpc7EAlWSADQQOTd6BOn3x1Y8qvyES4QM4JNnPKWtmCEy8ZJtdX0j5UmL2AJeX+hCjwmua6bU/WMdrT2hHz9SpQdfrUdZ8hNxEPmi029Uleo+mBloUEwv2ctbOMUA==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:61034 helo=[192.168.10.176])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1go4Kd-0008Ly-I0; Mon, 28 Jan 2019 11:39:59 +0100
Subject: Re: [PATCH v3 17/23] drm/qxl: use generic fbdev emulation
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>
References: <20190118122020.27596-1-kraxel@redhat.com>
 <20190118122020.27596-18-kraxel@redhat.com>
 <e31c0fdd-315a-59cf-e7fe-dfd6a064f6ee@tronnes.org>
 <20190128085951.gkap3by26xgkbwaa@sirius.home.kraxel.org>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <21961c13-6481-814e-5d7b-9db8509050f7@tronnes.org>
Date:   Mon, 28 Jan 2019 11:39:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190128085951.gkap3by26xgkbwaa@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 28.01.2019 09.59, skrev Gerd Hoffmann:
> On Fri, Jan 25, 2019 at 06:25:27PM +0100, Noralf Trønnes wrote:
>>
>>
>> Den 18.01.2019 13.20, skrev Gerd Hoffmann:
>>> Switch qxl over to the new generic fbdev emulation.
>>>
>>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>>> ---
>>>  drivers/gpu/drm/qxl/qxl_display.c | 7 -------
>>>  drivers/gpu/drm/qxl/qxl_drv.c     | 2 ++
>>>  2 files changed, 2 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
>>> index ef832f98ab..9c751f01e3 100644
>>> --- a/drivers/gpu/drm/qxl/qxl_display.c
>>> +++ b/drivers/gpu/drm/qxl/qxl_display.c
>>> @@ -1221,18 +1221,11 @@ int qxl_modeset_init(struct qxl_device *qdev)
>>>  	qxl_display_read_client_monitors_config(qdev);
>>>  
>>>  	drm_mode_config_reset(&qdev->ddev);
>>> -
>>> -	/* primary surface must be created by this point, to allow
>>> -	 * issuing command queue commands and having them read by
>>> -	 * spice server. */
>>> -	qxl_fbdev_init(qdev);
>>>  	return 0;
>>>  }
>>>  
>>>  void qxl_modeset_fini(struct qxl_device *qdev)
>>>  {
>>> -	qxl_fbdev_fini(qdev);
>>> -
>>>  	qxl_destroy_monitors_object(qdev);
>>>  	drm_mode_config_cleanup(&qdev->ddev);
>>>  }
>>> diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
>>> index 13c8a662f9..3fce7d16df 100644
>>> --- a/drivers/gpu/drm/qxl/qxl_drv.c
>>> +++ b/drivers/gpu/drm/qxl/qxl_drv.c
>>> @@ -93,6 +93,8 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>>>  	if (ret)
>>>  		goto modeset_cleanup;
>>>  
>>> +	drm_fb_helper_remove_conflicting_pci_framebuffers(pdev, 0, "qxl");
>>
>> I couldn't find that this was part of old fbdev code, so it would be
>> nice to mention it in the commit message.
> 
> It actually is, but a bit hidden because it doesn't use a helper you can
> easily grep for.  Instead sets fb_info->apertures->ranges[0] in
> qxlfb_create(), which has the same effect.
> 

Indeed,

Acked-by: Noralf Trønnes <noralf@tronnes.org>
