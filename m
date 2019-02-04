Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC632C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC59C217D9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbfBDStQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 13:49:16 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:43525 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbfBDStP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 13:49:15 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 4899120037;
        Mon,  4 Feb 2019 19:49:12 +0100 (CET)
Date:   Mon, 4 Feb 2019 19:49:11 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Nicholas Mc Guire <der.herr@hofr.at>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Fabio Rafael da Rosa <fdr@pid42.net>,
        Emil Velikov <emil.velikov@collabora.com>
Subject: Re: [PATCH 1/2] staging/vboxvideo: don't set dev_priv_size = 0
Message-ID: <20190204184911.GB2834@ravnborg.org>
References: <20190204103114.30772-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204103114.30772-1-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=QyXUC8HyAAAA:8 a=ag1SF4gXAAAA:8 a=20KFwNOVAAAA:8
        a=QX4gbG5DAAAA:8 a=mhguMBvjAAAA:8 a=7gkXJVJtAAAA:8 a=YK85hFrOxrTASf_v_CEA:9
        a=CjuIK1q_8ugA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 a=AbAUZ8qAyYyZVLSsDulk:22
        a=suj-f_xPwWGbp6UAD3fP:22 a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel

On Mon, Feb 04, 2019 at 11:31:13AM +0100, Daniel Vetter wrote:
> The compiler already clears this for us.
> 
> More important, someone might look what this is actually used for,
> and freak out about the dragon staring back at them.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Nicholas Mc Guire <der.herr@hofr.at>
> Cc: Emil Velikov <emil.velikov@collabora.com>
> Cc: Fabio Rafael da Rosa <fdr@pid42.net>
> ---
>  drivers/staging/vboxvideo/vbox_drv.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/vboxvideo/vbox_drv.c b/drivers/staging/vboxvideo/vbox_drv.c
> index b0d73d5fba5d..43c3d0a4fa1a 100644
> --- a/drivers/staging/vboxvideo/vbox_drv.c
> +++ b/drivers/staging/vboxvideo/vbox_drv.c
> @@ -222,7 +222,6 @@ static void vbox_master_drop(struct drm_device *dev, struct drm_file *file_priv)
>  static struct drm_driver driver = {
>  	.driver_features =
>  	    DRIVER_MODESET | DRIVER_GEM | DRIVER_PRIME | DRIVER_ATOMIC,
> -	.dev_priv_size = 0,
>  
>  	.lastclose = drm_fb_helper_lastclose,
>  	.master_set = vbox_master_set,

I have stared at the file for a long time and so far no dragon
was staring back at me. There was a few "#ifdef" that screamed
at me, and a drm_fb_helper_fbdev_setup() that looked
suspicious alas no dragon :-(

As for the change above, dragon or no dragon:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

	Sam
