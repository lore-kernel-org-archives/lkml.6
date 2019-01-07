Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCD2C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D94D62089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="hnuInWtP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfAGP4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 10:56:12 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:56021 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfAGP4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 10:56:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=5EJoY6vuV/rslcBRmqiZlw/Dw3eSF7aLh9hg0/FXmyI=;
        b=hnuInWtPwilaYjZS2LdnDy1G/46Bo5DWC/X8f/rKm+kkvvsHyxH1fiF6m0+qrCe20o0wsBXp5HHtqzGmw4L/alSj5JSW8dPcxaiygkItETa03aeYp84VyO2szvwOKBD1PDUQAduVcaXbb2D5eFKd7Pg/qEwDhhinXtIvnj1rPn4/FzfhEFiwXG2HAQ6UgX+0uRL1VWIFQLLdWUTZIIBmH5hKHiafKmC+gcQQ4dQ6TeBa6DZ9Kx3HDK3xIbDRXigB9w9E2zOkroaw2NiVkGkwIM2PmtuKvwn+3x3GXKOiFh6fwGgxTRCurfDjc0qwKPWZEr6qwX8vEC9vUj0aX8DqAw==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:64468 helo=[192.168.10.174])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1ggXG6-00005y-2N; Mon, 07 Jan 2019 16:56:10 +0100
Subject: Re: [PATCH v2 05/14] drm: make drm_file.h self contained
To:     Sam Ravnborg <sam@ravnborg.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Jani Nikula <jani.nikula@intel.com>
References: <20181230174838.32330-6-sam@ravnborg.org>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <489cb248-07e4-cfff-336e-6e86fdbecda2@tronnes.org>
Date:   Mon, 7 Jan 2019 16:56:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20181230174838.32330-6-sam@ravnborg.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 30.12.2018 18.48, skrev Sam Ravnborg:
> drm_file.h embed struct idr, so this file need to know
> the full type definition.
> 
> With this change users of drm_file.h are no longer forced
> to include idr.h - a file they usually get from drmP.h
> 
> This makes it simpler to remove drmP.h includes
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: David Airlie <airlied@linux.ie>
> ---

Acked-by: Noralf Trønnes <noralf@tronnes.org>
