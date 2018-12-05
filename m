Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABD3C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBBD220850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPNocDid"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBBD220850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbeLEHcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 02:32:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:59024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbeLEHcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 02:32:16 -0500
Received: from localhost (unknown [106.201.124.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ED9A2084C;
        Wed,  5 Dec 2018 07:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543995135;
        bh=3PlIcUwgHvANeeS4CYHKN+Bl+KZvbOusXxOyS1/ApSg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZPNocDid1A1C6p7xQm7+P7cFmai1HGl67Xt5FEY+kWH1q7qv/6VL2T8sVhM+eFtv2
         May3/3rKCCebpnuVfUfGA/f9g3wSuKNO0Tr9lDkih6cbSAQYDUZgpF7sOEqsMDluJG
         PJvKdv3ki4Z1CiexMIDtYB3PO1tgqMs6TXfz5MI4=
Date:   Wed, 5 Dec 2018 13:02:07 +0530
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
Subject: Re: [PATCH v3] dmaengine: sh: Remove R-Mobile APE6 support
Message-ID: <20181205073207.GC2847@vkoul-mobl>
References: <20181203141806.23232-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203141806.23232-1-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-12-18, 15:18, Geert Uytterhoeven wrote:
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

Applied, thanks

-- 
~Vinod
