Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132D4C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A583923F6C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="padPkUHj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A583923F6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932140AbeF1EVe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 00:21:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:33906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751544AbeF1EVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 00:21:32 -0400
Received: from localhost (unknown [106.201.104.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DC3823C00;
        Thu, 28 Jun 2018 04:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530159691;
        bh=9/jJtRwatNFkdeqNOH75EsnimWh2YZgpU0HNOV2ozjE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=padPkUHjudOV14HzkeGp3extyq3wr2xsIx173Rx2T7sQwlLXj2Fe/dp+czgei9xNR
         KYLzcfP13zLlRcXhrc5qHxNcECrvHCPe2ZX3y9LqDMDcmCESPfOiv10pYgm24F22Z9
         +Js5rKHtBxej64tlm0mFAEjWvekyvm9n2HPEjEgY=
Date:   Thu, 28 Jun 2018 09:51:23 +0530
From:   Vinod <vkoul@kernel.org>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran@ksquared.org.uk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        dmaengine@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3] dmaengine: rcar-dmac: don't use DMAC error interrupt
Message-ID: <20180628042123.GJ22377@vkoul-mobl>
References: <87lgbgswl5.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lgbgswl5.wl%kuninori.morimoto.gx@renesas.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-06-18, 00:53, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> rcar-dmac has 2 types of interrupt, 1) error IRQ (for all),
> 2) IRQ for each channels.
> If error happens on some channels, the error IRQ will be handled
> by 1), and "all" channels will be restarted.
> But in this design, error handling itself will be problem for
> non error channel users.
> This patch removes 1) handler, and handles error IRQ on 2)
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> [Kuninori: updated patch to adjust DMACHCR/DMAOR]
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Tested-by: Nguyen Viet Dung <nv-dung@jinso.co.jp>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied, thanks

-- 
~Vinod
