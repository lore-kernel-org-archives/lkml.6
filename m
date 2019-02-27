Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A100C00319
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0314820842
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="L8PHXGwI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730044AbfB0RLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:11:54 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:45647 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfB0RLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 12:11:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=H+82OncIe5kkYDMvpop2anEHsVTIt8SxSM0gOenPaE4=;
        b=L8PHXGwIKs1MELiyfEC9V1GXMf9w9SahjDSm7zkFsoSWUBvxFPjisl33uMGPwHAQ93im83ZSvMFjP1uAP7l8WvUV6/ijDcV8zjxTEk/Eq6e/CV0TyphlCyZj5pn5C5xW2uAch6+JP25ctBsxKwMoG6x/+xFLWtO2szyAHZwshj+SPsTvNCPG/XzTR9yhV+ly6fEq2dYurZFbkfKtdS6J2Xd/8kwD+QyFLiXpPX7RkfXFkp+IhWknRClCR7uHk/zNsZ7LA3twaOJKJubxe7FM5sJeFC26TdOOPTE0L8bxePw4rJowEDRVpvee8z6WNPa2ZMOZeQqEBVe3ychBSacOsA==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:58480 helo=[192.168.10.175])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1gz2kJ-00032l-Bt; Wed, 27 Feb 2019 18:11:51 +0100
Subject: Re: [PATCH 3/3] drm/virtio: implement prime export
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
References: <20190227144441.6755-1-kraxel@redhat.com>
 <20190227144441.6755-4-kraxel@redhat.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <733f4cdd-1141-54c4-a1f4-ceb8cd4356ed@tronnes.org>
Date:   Wed, 27 Feb 2019 18:11:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190227144441.6755-4-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 27.02.2019 15.44, skrev Gerd Hoffmann:
> Just run drm_prime_pages_to_sg() on the ttm pages list to get an
> sg_table for export.  The pages list is created at object initialization
> time, so there should be no need to handle an unpopulated page list.
> Add a sanity check nevertheless.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Acked-by: Noralf Trønnes <noralf@tronnes.org>
