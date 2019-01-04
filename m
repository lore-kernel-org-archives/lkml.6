Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98776C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F34721871
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546614971;
	bh=wsfe6IuqWuCbT5gSVmur/eXPCBKKwyCnBR7CjO3jnnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=m3PYA2/1jB/Zq67NPlvl4qXNoQvV1gaXu1KWiCZQFu2uWBp1TYrmMEC0X8bnF16Gb
	 1+YGZmUKZJuDG7fSwHmDWhUq5k1ByjILtD/0dRUuJ+zBESPWUGGUogUrZqRK7WeCBu
	 WYMSZAS2mDkovYhHbjscgy++6uUB2qsRJjc8sdtI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfADPQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 10:16:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:40492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbfADPQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 10:16:10 -0500
Received: from localhost (unknown [171.76.109.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D146F2070C;
        Fri,  4 Jan 2019 15:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546614969;
        bh=wsfe6IuqWuCbT5gSVmur/eXPCBKKwyCnBR7CjO3jnnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z2EoPervy+OLh208eqP0fe0pyJdm/gO/5VjdHQbmXTozpZ+qWmJIKt2K7eeaD4zy+
         vhNxw3QHdfL6QsYbsFDFguvm41pSTC9AzOi1VNncIvmil/7pjALkFjFk8W2dwVEqpl
         n2VXITiZEpTW3K+hdKg5Ej3cb3ZDS2Hpkeo5xCLo=
Date:   Fri, 4 Jan 2019 20:44:32 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v1] dmaengine: imx-sdma: refine to load context only once
Message-ID: <20190104151432.GJ13372@vkoul-mobl.Dlink>
References: <1544107081-7440-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544107081-7440-1-git-send-email-yibin.gong@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-12-18, 06:36, Robin Gong wrote:
> The context loaded only one time before channel running,but
                                                        ^^
space after comma please

> currently sdma_config_channel() and dma_prep_* duplicated with
> sdma_load_context(), so refine it to load context only one time
> before channel running and reload after the channel terminated.

I was going to apply it, but it fails to apply for me, please rebase and
send

-- 
~Vinod
