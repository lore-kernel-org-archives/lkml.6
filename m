Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E497C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 12:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3401E2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 12:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3401E2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732381AbeKNWZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 17:25:14 -0500
Received: from regular1.263xmail.com ([211.150.99.141]:46024 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbeKNWZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 17:25:14 -0500
X-Greylist: delayed 403 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Nov 2018 17:25:09 EST
Received: from david.wu?rock-chips.com (unknown [192.168.167.208])
        by regular1.263xmail.com (Postfix) with ESMTP id 3FEF820B;
        Wed, 14 Nov 2018 20:15:07 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from [172.16.12.33] (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id 0095836B;
        Wed, 14 Nov 2018 20:15:06 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: david.wu@rock-chips.com
X-FST-TO: jay.xu@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: david.wu@rock-chips.com
X-UNIQUE-TAG: <1da1d5fd2d013de4e9da29dbe4bdd030>
X-ATTACHMENT-NUM: 0
X-SENDER: wdc@rock-chips.com
X-DNS-TYPE: 0
Received: from [172.16.12.33] (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith ESMTP id 18819XRI6PC;
        Wed, 14 Nov 2018 20:15:08 +0800 (CST)
Subject: Re: [PATCH 1/2] pinctrl: rockchip: allow specifying the regmap
 location for pin-routes
To:     Heiko Stuebner <heiko@sntech.de>, linus.walleij@linaro.org
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, Heiko Stuebner <heiko.stuebner@bq.com>,
        =?UTF-8?B?6K645YmR576k?= <jay.xu@rock-chips.com>
References: <20181111210047.30375-1-heiko@sntech.de>
From:   David Wu <david.wu@rock-chips.com>
Message-ID: <62b7937e-0d7e-d142-285e-6dc15e6f5822@rock-chips.com>
Date:   Wed, 14 Nov 2018 20:15:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181111210047.30375-1-heiko@sntech.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

ÔÚ 2018/11/12 ÉÏÎç5:00, Heiko Stuebner Ð´µÀ:
> From: Heiko Stuebner<heiko.stuebner@bq.com>
> 
> Right now we expect the pin-rounting settings to be in the same area
> as the iomux setting itself. And while that seems to be true for all
> newer Rockchip socs, back in the wild west days of old this wasn't true.
> 
> Nowadays pin settings in the GRF normally stay in the GRF and the same
> is true for pins configured from PMU registers. But old socs like the
> rk3188 really sprinkle pin settings somewhat randomly through both
> for its bank0.
> 
> Therefore add the option to specify a location for the route setting,
> so that we can map older socs correctly. We'll keep "same" as the
> default, so that we only need to specify a location in the corner-cases
> described above.
> 
> Signed-off-by: Heiko Stuebner<heiko.stuebner@bq.com>

Very good, for the mixed case, really need to do the supplement.

Reviewed-by: David Wu <david.wu@rock-chips.com>

