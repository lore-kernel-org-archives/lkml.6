Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1954C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A59B620879
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbfAKBbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 20:31:50 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:52283 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726369AbfAKBbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 20:31:50 -0500
X-UUID: b2a527fe380b4a38854dbd2a139b7a58-20190111
X-UUID: b2a527fe380b4a38854dbd2a139b7a58-20190111
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1819157637; Fri, 11 Jan 2019 09:31:30 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 11 Jan 2019 09:31:28 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 11 Jan 2019 09:31:28 +0800
Message-ID: <1547170288.29836.2.camel@mtksdaap41>
Subject: Re: Aw: Re: [PATCH] drm/mediatek: Add MTK Framebuffer-Device
 (mt7623)
From:   CK Hu <ck.hu@mediatek.com>
To:     Frank Wunderlich <frank-w@public-files.de>
CC:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Alexander Ryabchenko <d3adme4t@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 11 Jan 2019 09:31:28 +0800
In-Reply-To: <trinity-0da588a3-1277-4421-ad6b-1f6aeb129dd6-1547146897687@3c-app-gmx-bs35>
References: <20190102084917.4049-1-frank-w@public-files.de>
         <20190107103640.GH21184@phenom.ffwll.local>
         <CAKMK7uEqxz4TAt_iwEC+dMWboVxCeCduyABsSwD0Ns7k=Z_UWA@mail.gmail.com>
         <trinity-0da588a3-1277-4421-ad6b-1f6aeb129dd6-1547146897687@3c-app-gmx-bs35>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 0A9927583E6C4C5F7B56FD85D3FBAA413171D2A9E01E6C960CD787995FFDBB712000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Frank:

On Thu, 2019-01-10 at 20:01 +0100, Frank Wunderlich wrote:
> Hi Daniel,
> 
> > > Would be good to use the new generic fbdev emulation code here, for even
> > > less code. Or at least know why this isn't possible to use for mtk (and
> > > maybe address that in the core code). Hand-rolling fbdev code shouldn't be
> > > needed anymore.
> > 
> > Back on the mailing list, no private replies please:
> 
> i don't wanted to spam all people with dumb questions ;)
> 
> > For examples please grep for drm_fbdev_generic_setup(). There's also a
> > still in-flight series from Gerd Hoffmann to convert over bochs. That,
> > plus all the kerneldoc linked from there should get you started.
> > -Daniel
> 
> this is one of google best founds if i search for drm_fbdev_generic_setup:
> 
> https://lkml.org/lkml/2018/12/19/305
> 
> not very helpful...
> 
> so i tried kernel-doc
> 
> https://www.kernel.org/doc/html/latest/gpu/drm-kms-helpers.html?highlight=drm_fbdev_generic_setup#c.drm_fbdev_generic_setup
> 
> which is nice function-reference but i've found no generic workflow
> 
> as the posted driver is "only" a driver ported from kernel 4.4 by Alexander, i don't know if this new framework can be used and which parts need to be changed. I only try to bring his code Mainline....
> Maybe CK Hu can help here because driver is originally from him and he knows internals. Or maybe you can help here?

I could help on this but I'm a little busy now, so I'm not sure how long
this process takes.

Regards,
CK

> 
> i personally make my first steps as spare-time kernel-developer :)
> 
> regards Frank
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek


