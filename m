Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CA2C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F623206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="mN6Mltm+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F623206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbeIGOVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 10:21:54 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17956 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbeIGOVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 10:21:53 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5b9247ce0000>; Fri, 07 Sep 2018 02:41:34 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 07 Sep 2018 02:41:46 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 07 Sep 2018 02:41:46 -0700
Received: from [10.21.132.133] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 7 Sep
 2018 09:41:45 +0000
Subject: Re: [PATCH] [v3] drm/sun4i: fix build failure with
 CONFIG_DRM_SUN8I_MIXER=m
To:     Arnd Bergmann <arnd@arndb.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20180711144403.1022829-1-arnd@arndb.de>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <105cb1cf-577a-043a-9b50-248a37090bdd@nvidia.com>
Date:   Fri, 7 Sep 2018 10:41:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180711144403.1022829-1-arnd@arndb.de>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com;
        s=n1._domainkey.nvidia.com; t=1536313294;
        bh=mtqasAr2SQmSas9izdXwtqGB9uTH8yE7tSpRk+qnP1E=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=mN6Mltm+xpc2aK+xMZc1dTE9gOq83c+UxVGqI8u6iTTxszoKTU1wa3jAcrWAkFFhe
         lBdb3fGE1/QmP9okEHXYfh4DlJvPLKWmuBlSqlVfF620fNPEt0ymCqKm3K47dHtImh
         G8lLvAcumirEd3C/3EbmbINT05XObVtpJsiSrDUoWU3XzJE1oRI/G7zTvK/cwJSaiC
         ddhSSrzg2ZKIji2h8NhskZgy8gL+b+5xG1RTUklhKqOUTVFH6TZHECOmH7LvLgzrgy
         GTxUyilVXaAe/3VRWGhw6W+FCx5VGRE2TW2nw512E6eS38MkZ96qIUnECJlfMndroL
         NhKN0JU3fk74w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/07/18 15:43, Arnd Bergmann wrote:
> Having DRM_SUN4I built-in but DRM_SUN8I_MIXER as a loadable module results in
> a link error, as we try to access a symbol from the sun8i_tcon_top.ko module:
> 
> ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun8i-drm-hdmi.ko] undefined!
> ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun4i-drm.ko] undefined!
> 
> This solves the problem by adding a silent symbol for the tcon_top module,
> building it as a separate module in exactly the cases that we need it,
> but in a way that it is reachable by the other modules.
> 
> Fixes: 57e23de02f48 ("drm/sun4i: DW HDMI: Expand algorithm for possible crtcs")
> Fixes: ef0cf6441fbb ("drm/sun4i: Add support for traversing graph with TCON TOP")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
I am seeing the following on today's -next (20180907) as well the last
few -next versions for that matter ...

ERROR: "sun8i_tcon_top_de_config" [drivers/gpu/drm/sun4i/sun4i-tcon.ko] undefined!
ERROR: "sun8i_tcon_top_set_hdmi_src" [drivers/gpu/drm/sun4i/sun4i-tcon.ko] undefined!
ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun4i-tcon.ko] undefined!

Seems like this issue has cropped up again as Arnd's fix is present. I
am seeing this on ARM64 builds. 

Cheers
Jon

-- 
nvpublic
