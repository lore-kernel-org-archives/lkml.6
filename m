Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93442C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4552B20858
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4552B20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbeH2Pig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 11:38:36 -0400
Received: from gloria.sntech.de ([185.11.138.130]:43610 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727514AbeH2Pig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 11:38:36 -0400
Received: from wd0180.dip.tu-dresden.de ([141.76.108.180] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1fuyr9-0001Q0-64; Wed, 29 Aug 2018 13:41:51 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Sandy Huang <hjc@rock-chips.com>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] drm/rockchip: Use struct_size() in devm_kzalloc()
Date:   Wed, 29 Aug 2018 13:41:50 +0200
Message-ID: <2639880.ggikvLCEDc@phil>
In-Reply-To: <20180826184712.GA9330@embeddedor.com>
References: <20180826184712.GA9330@embeddedor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 26. August 2018, 20:47:12 CEST schrieb Gustavo A. R. Silva:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct foo {
> 	int stuff;
>         void *entry[];
> };
> 
> instance = devm_kzalloc(dev, sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
> 
> or, like in this particular case:
> 
> size = sizeof(struct foo) + sizeof(void *) * count;
> instance = devm_kzalloc(dev, size, GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
> 
> instance = devm_kzalloc(dev, struct_size(instance, entry, count),
> GFP_KERNEL);
> 
> This issue was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

applied to drm-misc with Kees' Review

Thanks
Heiko


