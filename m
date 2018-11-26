Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E205C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C9F3208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C9F3208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbeK0KdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:33:05 -0500
Received: from gloria.sntech.de ([185.11.138.130]:33086 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726888AbeK0KdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:33:05 -0500
Received: from ip5f5a905a.dynamic.kabel-deutschland.de ([95.90.144.90] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gRQRA-0003EK-K3; Tue, 27 Nov 2018 00:37:08 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Simon Xue <xxm@rock-chips.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 2/9] iommu: rockchip: make it explicitly non-modular
Date:   Tue, 27 Nov 2018 00:37:07 +0100
Message-ID: <3696101.6o5idU3W3V@phil>
In-Reply-To: <1543271498-28966-3-git-send-email-paul.gortmaker@windriver.com>
References: <1543271498-28966-1-git-send-email-paul.gortmaker@windriver.com> <1543271498-28966-3-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 26. November 2018, 23:31:31 CET schrieb Paul Gortmaker:
> The Kconfig currently controlling compilation of this code is:
> 
> drivers/iommu/Kconfig:config ROCKCHIP_IOMMU
> drivers/iommu/Kconfig:  bool "Rockchip IOMMU Support"
> 
> ...meaning that it currently is not being built as a module by anyone.
> 
> The bind/unbind/remove was already explicitly disabled in commit
> 98b72b94def9 ("iommu/rockchip: Prohibit unbind and remove").
> 
> Lets remove the remaining traces of  modular infrastructure, so that
> when reading the driver there is no doubt it is builtin-only.
> 
> Since module_init was not in use by this code, the init ordering
> remains unchanged with this commit.
> 
> Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.
> 
> We also delete the MODULE_LICENSE tag etc. since all that information
> was (or is now) contained at the top of the file in the comments.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Simon Xue <xxm@rock-chips.com>
> Cc: Daniel Kurtz <djkurtz@chromium.org>
> Cc: Jeffy Chen <jeffy.chen@rock-chips.com>
> Cc: iommu@lists.linux-foundation.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-rockchip@lists.infradead.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Acked-by: Heiko Stuebner <heiko@sntech.de>


