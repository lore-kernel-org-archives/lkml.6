Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E437ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E707214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E707214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbeJQVbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:31:18 -0400
Received: from gloria.sntech.de ([185.11.138.130]:53128 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727000AbeJQVbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:31:18 -0400
Received: from ip5f5a8a55.dynamic.kabel-deutschland.de ([95.90.138.85] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gClz2-0003yh-D6; Wed, 17 Oct 2018 15:35:32 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, kernel@collabora.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-rockchip@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] clk: rockchip: Fix static checker warning in rockchip_ddrclk_get_parent call
Date:   Wed, 17 Oct 2018 15:35:31 +0200
Message-ID: <2363939.EMdi4fOIx9@phil>
In-Reply-To: <20181016134144.12461-1-enric.balletbo@collabora.com>
References: <20181016134144.12461-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 16. Oktober 2018, 15:41:44 CEST schrieb Enric Balletbo i Serra:
> Fixes the signedness bug returning '(-22)' on the return type by removing the
> sanity checker in rockchip_ddrclk_get_parent(). The function should return
> and unsigned value only and it's safe to remove the sanity checker as the
> core functions that call get_parent like clk_core_get_parent_by_index already
> ensures the validity of the clk index returned (index >= core->num_parents).
> 
> Fixes: a4f182bf81f18 ("clk: rockchip: add new clock-type for the ddrclk")
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

applied to my clk-branch with Stephen's Review


Thanks
Heiko


