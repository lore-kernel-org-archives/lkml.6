Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B6CC61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 13:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEA0D2086D
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 13:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547903434;
	bh=nON8GoinCEOLVQKU9bABVEj4YhDJWmMxkszDWqzvndQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YGPv2oe5wtdgREL7hzQuNyAIAcD7E955AiX6U8R7+O+cYEbQbzSKisbXVNiwuUThN
	 FpJboYkG69eAC/qTZ/uG1sTrTmX8jnorUYjNa/XfpRgSDOiIcy0eK42P3GeRgU4Rc7
	 iQeA+/tVOQ0d8HgliTcoO5k19s0RFJKd2LUiI+/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbfASNKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 08:10:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:51500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727965AbfASNKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 08:10:32 -0500
Received: from localhost (unknown [122.178.235.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 050D52086D;
        Sat, 19 Jan 2019 13:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547903432;
        bh=nON8GoinCEOLVQKU9bABVEj4YhDJWmMxkszDWqzvndQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U+v2Z88NDtuHYvLeylGJhVKOAsdsWOh8d8tkK0j4k46+AVLBH1em4ntkex4OUQzD1
         Soh1p5ShG6XWVUBX0GlblN/+vYZqYnDXHppCy437QU1RygVgYiWf4ELbeA3rcKKIfy
         nwKKz7Fp+dLpu8MfVNa6JORa2JxtNYxHb2XALBjA=
Date:   Sat, 19 Jan 2019 18:38:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     dan.j.williams@intel.com, leoyang.li@nxp.com, jerry.huang@nxp.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: fsl-dpaa2-qdma: Add qDMA controller driver
 for Layerscape SoCs
Message-ID: <20190119130857.GG4635@vkoul-mobl>
References: <20181225110447.31628-1-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181225110447.31628-1-peng.ma@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-12-18, 11:04, Peng Ma wrote:
> Add NXP Data Path Acceleration Architecture 2 (dpaa2) queue direct
> memory(qDMA) controller driver support.
> This module can be found on NXP LS2 SoCs.
> 
> Signed-off-by: Peng Ma <peng.ma@nxp.com>
> ---
>  drivers/dma/Kconfig                         |    2 +
>  drivers/dma/Makefile                        |    1 +
>  drivers/dma/fsl-dpaa2-qdma/Kconfig          |    8 +
>  drivers/dma/fsl-dpaa2-qdma/Makefile         |    8 +
>  drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c     |  781 +++++++++++++++++++++++++++
>  drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h     |  152 ++++++
>  drivers/dma/fsl-dpaa2-qdma/dpdmai.c         |  483 +++++++++++++++++
>  drivers/dma/fsl-dpaa2-qdma/fsl_dpdmai.h     |  524 ++++++++++++++++++
>  drivers/dma/fsl-dpaa2-qdma/fsl_dpdmai_cmd.h |  197 +++++++
>  9 files changed, 2156 insertions(+), 0 deletions(-)

Sorry I cant review a patch that is this big. Please split and explain
why this is such a big driver...

-- 
~Vinod
