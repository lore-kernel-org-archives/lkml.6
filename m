Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C6DC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 15:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04ACD208B8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 15:11:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04ACD208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeH0S6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 14:58:52 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45445 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbeH0S6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 14:58:51 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5EC1620739; Mon, 27 Aug 2018 17:11:50 +0200 (CEST)
Received: from localhost (unknown [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3006620618;
        Mon, 27 Aug 2018 17:11:50 +0200 (CEST)
Date:   Mon, 27 Aug 2018 17:11:49 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     Claudiu.Beznea@microchip.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: pm: call put_device instead of of_node_put in
 at91_pm_config_ws
Message-ID: <20180827151149.GE23428@piout.net>
References: <1534415182-34970-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534415182-34970-1-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2018 18:26:22+0800, zhong jiang wrote:
> of_find_device_by_node takes a reference to the struct device when it
> finds a match via get_device. but it fails to put_device in
> at91_pm_config_ws, for_each_matching_node_and_match will get and put
> the node properly, there is no need to call the of_put_node. Therefore,
> just call put_device instead of of_node_put in at91_pm_config_ws.
> 
> Fixes: d7484f5c6b3b ("ARM: at91: pm: configure wakeup sources for ULP1 mode")
> Suggested-by: Claudiu Beznea <Claudiu.Beznea@microchip.com>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  arch/arm/mach-at91/pm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
