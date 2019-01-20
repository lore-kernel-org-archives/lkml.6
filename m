Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2626C61CE4
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 10:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF2E2087B
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 10:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547981884;
	bh=E5/uUMvQ2r7ZLc3lWQpx3UmTxsXBlsIzqE92brbvv2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fRVfNFENb+x4Tq9MeR36kNrlZ2CFIuTJUtTUbRwxyakesX/cZhXq36928rvnLEMdF
	 ZofeHkl2lRLzcmAySowldB/u85LQrwehECUpJI2njL6tYDepLZnlw703hG4pSF1+nm
	 KgISPTOwMXZTI2euycqJQIzbdjuKYVjE3bddQEGc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbfATK6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 05:58:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:50846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730458AbfATK6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 05:58:02 -0500
Received: from localhost (unknown [122.178.235.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 636112084F;
        Sun, 20 Jan 2019 10:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547981882;
        bh=E5/uUMvQ2r7ZLc3lWQpx3UmTxsXBlsIzqE92brbvv2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MHH3kW1+QuHsD0z00Ih2QqtgJj0sAK3nNyj1JxSGSFX7ZWqTWwbP5Re+sMrwXE0Rg
         IfuvbeCxqUHWvM+F6PSMnMKcJe0bc7oTt7gDHEryQCR9TGiZmoaYQOetSP07X2EJtf
         ISzIjB8RIxiOexx7CtITrbMg7J/ELm3uJY1XCLgk=
Date:   Sun, 20 Jan 2019 16:26:28 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>
Subject: Re: [PATCH] dma: imx-sdma: pass ->dev to dma_alloc_coherent() API
Message-ID: <20190120105628.GQ4635@vkoul-mobl>
References: <20190111142930.21193-1-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111142930.21193-1-daniel.baluta@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-01-19, 14:29, Daniel Baluta wrote:
> From: Andy Duan <fugang.duan@nxp.com>
> 
> Pass ->dev to dma_alloc_coherent() API. We need this
> becase dma_alloc_coherent() makes use of dev parameter
  ^^^^^
Typo

> and receiving NULL will result in a crash.

Applied after fixing typo and subsystem name, thanks
-- 
~Vinod
