Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82832C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 450B220673
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9Xxh0Wj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 450B220673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732924AbeK3Bat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:30:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:58040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731591AbeK3Bas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:30:48 -0500
Received: from localhost (unknown [122.178.235.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE49C2133F;
        Thu, 29 Nov 2018 14:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501516;
        bh=brrBO+ckq2npRnIgUnhQg08e7KGElKKVgvTYNN5FcAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M9Xxh0WjWpWwMnrSdWRNxv6fz6cDBs4J5jUxfTT/xrgD7ycA5JBWpYUVvtfsaOL3k
         WnSpSOct6ZQFvyRsFnuIQOrIssJ/8ZzlOVLjYslAe5v9ByeLMfOQqfWmBJ+gxivGMy
         1//1+56PVICjFEvdxOeK+j6GjVNcZ9fG0kxTwxKw=
Date:   Thu, 29 Nov 2018 19:55:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, dmaengine@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: sh: Remove R-Mobile APE6 support
Message-ID: <20181129142508.GJ3175@vkoul-mobl.Dlink>
References: <20181129111839.12879-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129111839.12879-1-geert+renesas@glider.be>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-11-18, 12:18, Geert Uytterhoeven wrote:
> Renesas R-Mobile APE6 support is currently unused:
>   - DMA slaves were never enabled in r8a73a4.dtsi,
>   - The driver relies on legacy filter matching and describing all
>     slaves and MID/RIDs in a table, unlike modern DMA engine drivers for
>     similar hardware like rcar-dmac,
>   - The driver doesn't seem to work well.
> 
> Remove the driver, it can be resurrected from git history when needed.
> 
> As this was the last user of SH_DMAE_BASE on Renesas ARM SoCs, the
> sh-dma-engine driver core is now used on SuperH only.
> 
> Note that the DT bindings are still present, as r8a73a4.dtsi uses them.

Sorry but this doesnt apply for me, can you please rebase on topic/sh
and resend.

Thanks
-- 
~Vinod
