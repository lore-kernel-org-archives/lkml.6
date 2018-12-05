Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC99C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06D4820989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOn0JkPR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06D4820989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbeLEKDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:03:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:39838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728164AbeLEKDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 05:03:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF92F214C1;
        Wed,  5 Dec 2018 10:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544004188;
        bh=id3Hy8SLfpthRW254ddehmNdy5cfWf1emeIptw9dh6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iOn0JkPRyAQ500q+vw3nLPO22McBxoX8XhWS4ob/nZ4jpEWjMhMW/H9Shtk5mf/By
         e2fGoNAMu8yHmMiS7JvCjU9PNl1bFhIhPtHHjHUNWWbSrIWpQPlCK6eilPNmf4q2M1
         yCnNMVdxUWcNFiQwK7usG2Qe88fBKH1DYaeXEHBI=
Date:   Wed, 5 Dec 2018 11:03:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Long Cheng <long.cheng@mediatek.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jiri Slaby <jslaby@suse.com>,
        Sean Wang <sean.wang@mediatek.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, srv_heupstream@mediatek.com,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>
Subject: Re: [PATCH v2 0/4] add uart DMA function
Message-ID: <20181205100306.GA12106@kroah.com>
References: <1543999380-7946-1-git-send-email-long.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543999380-7946-1-git-send-email-long.cheng@mediatek.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 04:42:56PM +0800, Long Cheng wrote:
> In Mediatek SOCs, the uart can support DMA function.
> Base on DMA engine formwork, we add the DMA code to support uart. And put the code under drivers/dma.
> 
> This series contains document bindings, Kconfig to control the function enable or not,
> device tree including interrupt and dma device node, the code of UART DM

I've queued up patches 1 and 3 from this series in my tty tree, thanks.

greg k-h
