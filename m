Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53234C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1873320831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DL6KsZze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1873320831
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbeKTC02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:26:28 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:40684 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729876AbeKTC02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:26:28 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAJG2JRn062108;
        Mon, 19 Nov 2018 10:02:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542643339;
        bh=a6ruWEz2+Y1fjtqc6f5/G7CBZ/Zt14HW/AivHws/jn4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=DL6KsZzeclwKMAunz+ZeSOnecNVZf83L48ymNAknJcsPV8Otq89OLp8+/CBiLXH/7
         lssU9MC13R8bT4PV1TEccuVgbHtA5enk1MK9K8thJHE5BIffHegKKDO/2uE2KbHqZ+
         gP45v+Ojo+DSlILFiB1Ha7zvNiIb/NuPpUAfHJpQ=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAJG2Jjn015451
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Nov 2018 10:02:19 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 19
 Nov 2018 10:02:19 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 19 Nov 2018 10:02:19 -0600
Received: from ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with SMTP id wAJG2Jw3006903;
        Mon, 19 Nov 2018 10:02:19 -0600
Date:   Mon, 19 Nov 2018 10:02:30 -0600
From:   Benoit Parrot <bparrot@ti.com>
To:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jyri Sarha <jsarha@ti.com>
Subject: Re: [Patch v4 0/8] drm/omap: Add virtual-planes support
Message-ID: <20181119160230.2nutnovegxqrn4j2@ti.com>
References: <20181012201703.29065-1-bparrot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181012201703.29065-1-bparrot@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping.

Benoit

Benoit Parrot <bparrot@ti.com> wrote on Fri [2018-Oct-12 15:16:55 -0500]:
> This patch series adds virtual-plane support to omapdrm driver to allow the use
> of display wider than 2048 pixels.
> 
> In order to do so we introduce the concept of hw_overlay which can then be
> dynamically allocated to a plane. When the requested output width exceed what
> be supported by one overlay a second is then allocated if possible to handle
> display wider then 2048.
> 
> This series replaces an earlier series which was DT based and using statically
> allocated resources. 
> 
> This implementation is inspired from the work done in msm/disp/mdp5
> driver.
> 
> Benoit Parrot (8):
>   drm/omap: Add ability to check if requested plane modes can be
>     supported
>   drm/omap: Add ovl checking funcs to dispc_ops
>   drm/omap: introduce omap_hw_overlay
>   drm/omap: omap_plane: subclass drm_plane_state
>   drm/omap: Add global state as a private atomic object
>   drm/omap: dynamically assign hw overlays to planes
>   drm/omap: add plane_atomic_print_state support
>   drm/omap: Add a 'right overlay' to plane state
> 
>  drivers/gpu/drm/omapdrm/Makefile       |   1 +
>  drivers/gpu/drm/omapdrm/dss/dispc.c    |  32 +++
>  drivers/gpu/drm/omapdrm/dss/omapdss.h  |   6 +
>  drivers/gpu/drm/omapdrm/omap_drv.c     | 196 ++++++++++++++++-
>  drivers/gpu/drm/omapdrm/omap_drv.h     |  30 +++
>  drivers/gpu/drm/omapdrm/omap_fb.c      |  33 ++-
>  drivers/gpu/drm/omapdrm/omap_fb.h      |   4 +-
>  drivers/gpu/drm/omapdrm/omap_overlay.c | 257 ++++++++++++++++++++++
>  drivers/gpu/drm/omapdrm/omap_overlay.h |  41 ++++
>  drivers/gpu/drm/omapdrm/omap_plane.c   | 374 ++++++++++++++++++++++++++++-----
>  drivers/gpu/drm/omapdrm/omap_plane.h   |   1 +
>  11 files changed, 922 insertions(+), 53 deletions(-)
>  create mode 100644 drivers/gpu/drm/omapdrm/omap_overlay.c
>  create mode 100644 drivers/gpu/drm/omapdrm/omap_overlay.h
> 
> -- 
> 2.9.0
> 
