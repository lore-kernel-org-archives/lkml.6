Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6CEC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A4892087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="IVxx0sJ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfAGP6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 10:58:36 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:36197 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbfAGP6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 10:58:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=hEECdDzhuir97/EfgmFy5ryZ7pvhBn+YzMG/kdYerMw=;
        b=IVxx0sJ9czjkQBlhKhR5vJ4N4fIFI7vTNdqo4FGUqPjy/JTrWcQ83+eqVQu1WnbobsligxKARoNjuNX9+YdV+Z5JMdK0gNZGDdiUrrv2Qi2DJC4BSJSxB+y9QicoSB/g3Kem8fcXqw6/HS71D4mE33Sd66hWqYARBcZg0mS/n0OhiwJW8nPUO++orKBIXHWAYDXXfW2QJpGiVwQL4PenmQsi92zxYU9PGgELd6QwteYkskDI4M9ox4NHVvmN7F6vEE/vut1Q4k/593APhKlnqOOIBSjXT1lKMoG95d3XdSfDCn8b4VSYJjSlPU+WMnWYEBJaeHdhdTFLoON/97Wgyg==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:64479 helo=[192.168.10.174])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1ggXIQ-0000tj-4V; Mon, 07 Jan 2019 16:58:34 +0100
Subject: Re: [PATCH v2 11/14] drm/arc: do not reply on drmP.h from
 drm_gem_cma_helper.h
To:     Sam Ravnborg <sam@ravnborg.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Alexey Brodkin <abrodkin@synopsys.com>
References: <20181230174838.32330-12-sam@ravnborg.org>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <765a11d0-b8e6-760d-32d7-a877201fafaa@tronnes.org>
Date:   Mon, 7 Jan 2019 16:58:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20181230174838.32330-12-sam@ravnborg.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 30.12.2018 18.48, skrev Sam Ravnborg:
> drmP.h was the only header file in the past and a lot
> of files rely on that drmP.h defines everything.
> The goal is to one day to delete drmP.h and
> as a step towards this it will no longer be included in the
> headers files in include/drm/
> 
> To prepare arc/ for this add dependencies that
> othwewise was pulled in by drmP.h from drm_gem_cma_helper.h
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Alexey Brodkin <abrodkin@synopsys.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: David Airlie <airlied@linux.ie>
> ---

Acked-by: Noralf Trønnes <noralf@tronnes.org>
