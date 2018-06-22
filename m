Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5E7C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77A6323E33
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77A6323E33
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751322AbeFVH2n convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 03:28:43 -0400
Received: from gloria.sntech.de ([95.129.55.99]:38570 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751119AbeFVH2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 03:28:42 -0400
Received: from p57b77a9d.dip0.t-ipconnect.de ([87.183.122.157] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.1:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <heiko@sntech.de>)
        id 1fWGUj-0008FK-Ez; Fri, 22 Jun 2018 09:28:33 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     David Wu <david.wu@rock-chips.com>
Cc:     davem@davemloft.net, robh+dt@kernel.org, mark.rutland@arm.com,
        huangtao@rock-chips.com, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: ethernet: stmmac: dwmac-rk: Add GMAC support for PX30
Date:   Fri, 22 Jun 2018 09:28:32 +0200
Message-ID: <19622369.ojvgxrHm8t@phil>
In-Reply-To: <7173b45f-17d3-2356-fede-28bdd5c658f2@rock-chips.com>
References: <1528956927-32440-1-git-send-email-david.wu@rock-chips.com> <2582999.2hZx6CH9S6@diego> <7173b45f-17d3-2356-fede-28bdd5c658f2@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Am Freitag, 22. Juni 2018, 09:22:35 CEST schrieb David Wu:
> 在 2018年06月14日 16:30, Heiko Stübner 写道:
> > And someone could convert the driver to use the new clk-bulk APIs [0],
> > so the large number of clk_prepare_enable calls would be a bit
> > trimmed down.
> 
> Some clocks need special treatment at special cases, may not know which 
> index is we need at clk_bulk_data struct.
> 1. At rmii mode, need to use mac_ref, mac_refout; but at rgmii, they are 
> not needed.
> 2. At rgmii mode, rx is coming in from external source, there is no 
> gate, and it is coming from mac_ref_clk at rmii mode, there is gate.
> 3. clk_mac needs to be configured rate 50M or 125M.
> 4. mac_clk_speed needs to be configured at PX30 Soc and next Socs.
> 
> It looks like use the clk-bulk, will not be more flexible, and we still 
> keep the present. What do you think?

yeah, you're probably right. I just saw all these clk_prepare_enable calls
and didn't think enough about the config side ;-) .


Heiko


