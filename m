Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AADC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 01:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F6D2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 01:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfARBqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 20:46:38 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:11630 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726821AbfARBqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 20:46:36 -0500
X-UUID: 0a6aeb7d5f90481196010165a620197b-20190118
X-UUID: 0a6aeb7d5f90481196010165a620197b-20190118
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1657153879; Fri, 18 Jan 2019 09:46:17 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 18 Jan 2019 09:46:15 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 18 Jan 2019 09:46:16 +0800
Message-ID: <1547775975.4221.11.camel@mtksdaap41>
Subject: Re: Aw: [PATCH 2/2] drm/mediatek: Add Mediatek framebuffer device
From:   CK Hu <ck.hu@mediatek.com>
To:     Frank Wunderlich <frank-w@public-files.de>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        <srv_heupstream@mediatek.com>, David Airlie <airlied@linux.ie>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        "\"Noralf =?UTF-8?Q?Tr=EF=BF=BDnnes=22?=" <noralf@tronnes.org>,
        <linux-mediatek@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 18 Jan 2019 09:46:15 +0800
In-Reply-To: <trinity-1adab8be-573a-4816-9e9f-feddf07bdcd3-1547734452313@3c-app-gmx-bs28>
References: <20190116013924.11345-1-ck.hu@mediatek.com>
         <20190116013924.11345-2-ck.hu@mediatek.com>
         <trinity-1adab8be-573a-4816-9e9f-feddf07bdcd3-1547734452313@3c-app-gmx-bs28>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Frank:

On Thu, 2019-01-17 at 15:14 +0100, Frank Wunderlich wrote:
> Hi,
> 
> this Patchset does not hang on Bananapi R2, but does not show anything on FB-Console...seems anything is missing
> 
> https://github.com/frank-w/BPI-R2-4.14/tree/4.20-fbdev
> 
> dmesg | grep 'fb\|framebuffer'
> [    0.000000] Linux version 4.20.0-rc7-bpi-r2-fbdev (frank@frank-N56VZ) (gcc version 7.3.0 (Ubuntu/Linaro 7.3.0-27ubuntu1~18.04)) 9
> [    0.000000] cma: Reserved 64 MiB at 0xfb800000
> [    0.000000] Kernel command line: board=bpi-r2 console=earlyprintk console=tty1 fbcon=map:0 console=ttyS0,115200 root=/dev/mmcblk7
> [    5.733185] [drm:drm_fb_helper_generic_probe] surface width(1280), height(1024) and bpp(32)
> [    5.754452] [drm:drm_mode_addfb2] [FB:44]
> [    5.792878] mediatek-drm 14000000.dispsys: fb0: DRM emulated frame buffer device
> [    5.814067] [drm:drm_fb_helper_hotplug_event.part.11] 
> [    6.203083] mediatek-drm 14000000.dispsys: [drm:drm_client_dev_hotplug] fbdev: ret=0
> [   24.930347] mediatek-drm 14000000.dispsys: [drm:drm_client_dev_restore] fbdev: ret=0
> [   25.196872] mediatek-drm 14000000.dispsys: [drm:drm_client_dev_restore] fbdev: ret=0
> [   25.281184] [drm:drm_mode_addfb2] [FB:49]
> [   27.947962] [drm:drm_mode_addfb2] [FB:49]

The log does not show any information of error, but it close fbdev at
the time 24.930347.

I just test vmap() by writing white color into framebuffer after vmap()
and use user space program to control fbdev to show this framebuffer and
the panel shows white screen. So I believe that vmap() and fbdev works
fine, but I'm not sure what happen to fbcon. I would try to setup fbcon
to find out the bug. If you could try to debug parallelly, it would be
much help.

Regards,
CK

> 
> regards Frank
> 
> 
> > Gesendet: Mittwoch, 16. Januar 2019 um 02:39 Uhr
> > Von: "CK Hu" <ck.hu@mediatek.com>
> > An: "Philipp Zabel" <p.zabel@pengutronix.de>, "David Airlie" <airlied@linux.ie>, "Daniel Vetter" <daniel@ffwll.ch>, "Matthias Brugger" <matthias.bgg@gmail.com>, "Noralf Tr�nnes" <noralf@tronnes.org>, "Frank Wunderlich" <frank-w@public-files.de>
> > Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com, "CK Hu" <ck.hu@mediatek.com>
> > Betreff: [PATCH 2/2] drm/mediatek: Add Mediatek framebuffer device
> >
> > For Mediatek drm driver, use fbdev emulation to create a framebuffer
> > device.
> > 
> > Signed-off-by: CK Hu <ck.hu@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > index 6ec4ca070382..5fcc0e294696 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > @@ -16,6 +16,7 @@
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_fb_helper.h>
> >  #include <drm/drm_gem.h>
> >  #include <drm/drm_gem_cma_helper.h>
> >  #include <drm/drm_of.h>
> > @@ -378,6 +379,10 @@ static int mtk_drm_bind(struct device *dev)
> >  	if (ret < 0)
> >  		goto err_deinit;
> >  
> > +	ret = drm_fbdev_generic_setup(drm, 32);
> > +	if (ret)
> > +		DRM_ERROR("Failed to initialize fbdev: %d\n", ret);
> > +
> >  	return 0;
> >  
> >  err_deinit:
> > -- 
> > 2.18.1
> > 
> >
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek


