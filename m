Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E043FC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A358E21719
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A358E21719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbeHHIwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 04:52:14 -0400
Received: from gloria.sntech.de ([185.11.138.130]:56802 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbeHHIwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 04:52:14 -0400
Received: from wd0970.dip.tu-dresden.de ([141.76.111.202] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1fnI2d-00036z-Ll; Wed, 08 Aug 2018 08:33:55 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH 1/2] iommu/rockchip: Handle errors returned from PM framework
Date:   Wed, 08 Aug 2018 08:33:54 +0200
Message-ID: <1943708.zxIcSzHDJ6@phil>
In-Reply-To: <20180807085406.3863-2-marc.zyngier@arm.com>
References: <20180807085406.3863-1-marc.zyngier@arm.com> <20180807085406.3863-2-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 7. August 2018, 10:54:05 CEST schrieb Marc Zyngier:
> pm_runtime_get_if_in_use can fail: either PM has been disabled
> altogether (-EINVAL), or the device hasn't been enabled yet (0).
> Sadly, the Rockchip IOMMU driver tends to conflate the two things
> by considering a non-zero return value as successful.
> 
> This has the consequence of hiding other bugs, so let's handle this
> case throughout the driver, with a WARN_ON_ONCE so that we can try
> and work out what happened.
> 
> Fixes: 0f181d3cf7d98 ("iommu/rockchip: Add runtime PM support")
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

With Rockchip platforms always selecting PM
[see other longer thread in reply to the patch]

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



