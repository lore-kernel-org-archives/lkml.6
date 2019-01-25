Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9216C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD90B218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="lotdwdbJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbfAYP65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 10:58:57 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:39906 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfAYP64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 10:58:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=gjs9O3Whnwkz2lduN+uXBvUw/50oEWu6tE7l4ZAumXc=;
        b=lotdwdbJmcHWD4FPb9H63a1RA5bRRMnxvpD13iv6IWc/x+tKQNwKHQjJvURNI+irUqSOpZuLHLPklOSobA2JsAgWEkKGq6+OCKTK0P8gFaVdKSHassz8MePX2PzqX4cvmsES3zLX9wIJnSRFfTATeEHel68upAepaXF/7MxvcWG5ssn6W82vtYNWYahYYBELCAiS7JsPskLA5is079Q93gyVOwHhedCEiFG4B+UBCAkvpmbLe7G9aWAfz8trpEPEa1A4I2uHLhsJo8qBCI4Qq3E+sU23TgO6sNLeNGID6WfGzSpsu6S9RFSXw7wvDk15wjlZOCVpOImEMi6UnV57yg==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:49321 helo=[192.168.10.176])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1gn3sc-0003mp-Ab; Fri, 25 Jan 2019 16:58:54 +0100
Subject: Re: [PATCH v3 08/23] drm/qxl: use QXL_GEM_DOMAIN_SURFACE for shadow
 bo.
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>
References: <20190118122020.27596-1-kraxel@redhat.com>
 <20190118122020.27596-9-kraxel@redhat.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <8dd61878-2b4a-3ea4-4f2a-54bf7d3a183d@tronnes.org>
Date:   Fri, 25 Jan 2019 16:58:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190118122020.27596-9-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 18.01.2019 13.20, skrev Gerd Hoffmann:
> The shadow bo is used as qxl surface, so allocate it as
> QXL_GEM_DOMAIN_SURFACE.  Should usually be allocated in
> PRIV ttm domain then, so this reduces VRAM memory pressure.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---

Acked-by: Noralf Trønnes <noralf@tronnes.org>
