Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541ACC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D1220850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUsFs1Dm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19D1220850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbeLEIXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 03:23:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:50732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbeLEIXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 03:23:54 -0500
Received: from localhost (unknown [106.201.124.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 283872082B;
        Wed,  5 Dec 2018 08:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543998233;
        bh=VLKzBQclZx0qTpQiE8K7BBtYo5FmmDGx+bgtttaxFls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FUsFs1Dm76X+5byZzj0FeE9ekYKwDZuRuXBQeA/WiS61LQdGvIxOXyZW9LKEJm5c3
         Y/KkgaI/xE5x3/FNNOJrlNCQ4tBhoFPlQ5zq/81eBecEhuT0Wgc/Ujt4SNN29tSRGP
         ktCqlP7h2zOFRWrP1x3+KFOu5qjDmelALDWPUer0=
Date:   Wed, 5 Dec 2018 13:53:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v3 0/4] Correct dma pool for imx-sdma
Message-ID: <20181205082345.GE2847@vkoul-mobl>
References: <1541504525-25720-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541504525-25720-1-git-send-email-yibin.gong@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-11-18, 03:40, Robin Gong wrote:
> This patch set to correct dma pool used in the commit fe5b85c656bc
> ("dmaengine: imx-sdma: alloclate bd memory from dma pool")
> because all bds should be contiguous in memory in multi bds case
> for sdma, but dma pool can't statify it and cause transfer failure
> then.Thank Lucas for the making things on the right way.
> 
> This patch set is v3 based on Lucas's V1/V2, the main refine:
>   --fix the issue I reported in V1 but Lucas workaround it by improper
>     way in V2.
>   --add vchan_synchronize() to kill tasklet in virt-dma internal.
>   --refine name: use sdma_disable_channel_async instead of
>     sdma_disable_channel_with_delay since no delay indeed for
>     device_terminate_all.
> Please refer to below link for more information:
> https://patchwork.kernel.org/patch/10601111

Applied all, thanks and CCed stable

-- 
~Vinod
