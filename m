Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD4DC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 06:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A1CA2089D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 06:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ACjJTlDd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A1CA2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbeI3N3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 09:29:16 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:48692 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbeI3N3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 09:29:16 -0400
Received: from avalon.localnet (unknown [212.145.226.69])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 326B26F8;
        Sun, 30 Sep 2018 08:57:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1538290649;
        bh=T7moeQX7Hfp39z8EZ4ZDw6tlY+lwrG1y93ShYtBDyyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ACjJTlDdJXsKENIM60ohWUtv91gySPCjRAQ/dIfiaO4sHN+jEnDsF9isLjlo8LJQE
         q0ilnX08Xxg4lF6GT0VJi38EF9Z+Y9NicOMKPESCM55rX81QGjwAxQRnpDyGXOgUkH
         vJcgkZ/9blGLyk1y3+5vF/d/6WiGQK8JzxGene2w=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Daniel Vetter <daniel@ffwll.ch>, airlied@linux.ie,
        sean@poorly.run, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/rcar-du: Convert drm_atomic_helper_suspend/resume()
Date:   Sun, 30 Sep 2018 09:57:45 +0300
Message-ID: <1998688.b6VzpE9tkn@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <CAFqt6zbx2tSpnE+reNLN4pC7Br5XbgSuYP4-taxyyWraVpHoMg@mail.gmail.com>
References: <20180918163903.GA11172@jordon-HP-15-Notebook-PC> <20809880.gF2CxujBy3@avalon> <CAFqt6zbx2tSpnE+reNLN4pC7Br5XbgSuYP4-taxyyWraVpHoMg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Souptick,

On Friday, 28 September 2018 23:02:32 EEST Souptick Joarder wrote:
> On 28-Sep-2018 9:00 PM, "Laurent Pinchart" wrote:
> > On Friday, 28 September 2018 18:05:18 EEST Laurent Pinchart wrote:
> >> On Thursday, 27 September 2018 09:34:18 EEST Souptick Joarder wrote:
> >>> On Tue, Sep 18, 2018 at 10:05 PM Souptick Joarder wrote:
> >>>> convert drm_atomic_helper_suspend/resume() to use
> >>>> drm_mode_config_helper_suspend/resume().
> >>>>=20
> >>>> remove suspend_state field from the rcar_du_device
> >>>> structure as it is no more required.
> >>>>=20
> >>>> With this conversion, also drm_fbdev_cma_set_suspend_unlocked()
> >>>> will left with no consumer. So this function can be removed.
> >>>>=20
> >>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> >>>=20
> >>> Laurent, any comment on this patch ??
> >>=20
> >> Sorry for the delay, and thanks for pinging me.
> >>=20
> >> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >>=20
> >> Should I apply this to my tree or do you plan to merge it through
> >> drm-misc as it touches drm_fb_cma_helper.c ?
> >=20
> > I just realized that the same patch got supplied by Noralf Tr=F8nnes ne=
arly
> > a year ago, and was later superseded by https://patchwork.freedesktop.o=
rg/
> > patch/247861/. I think we should thus apply Noralf's patches instead (o=
nce
> > he sends v4 out).
>=20
> Sure, you can go ahead with his patch.
>=20
> Shall I remove drm_fbdev_cma_set_suspend_unlocked in a separate patch once
> all the consumer remove this function ?

Sure, if the function isn't removed as part of Noralf's patch series, pleas=
e=20
send a separate patch to remove it.

=2D-=20
Regards,

Laurent Pinchart



