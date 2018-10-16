Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A222C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD37A2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:00:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD37A2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbeJPUur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 16:50:47 -0400
Received: from gloria.sntech.de ([185.11.138.130]:44114 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbeJPUuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 16:50:46 -0400
Received: from wd0405.dip.tu-dresden.de ([141.76.109.149] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gCOxQ-0004fF-Ky; Tue, 16 Oct 2018 15:00:20 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     David Airlie <airlied@linux.ie>, kernel@collabora.com,
        linux-kernel@vger.kernel.org, Sandy Huang <hjc@rock-chips.com>,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drm/rockchip: psr: do not dereference encoder before it is null checked.
Date:   Tue, 16 Oct 2018 15:00:20 +0200
Message-ID: <6610441.t0YFBFda2e@phil>
In-Reply-To: <20181013105654.11827-1-enric.balletbo@collabora.com>
References: <20181013105654.11827-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 13. Oktober 2018, 12:56:54 CEST schrieb Enric Balletbo i Serra:
> 'encoder' is deferenced before it is null sanity checked, hence we
> potentially have a null pointer dereference bug. Instead, initialise
> drm_drv from encoder->dev->dev_private after we are sure 'encoder' is
> not null.
> 
> Fixes: 5182c1a556d7f ("drm/rockchip: add an common abstracted PSR driver")
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

added a stable-tag and applied to drm-misc-next

Thanks
Heiko


