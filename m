Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C37C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F9E214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546967120;
	bh=P7Df4GZ4QSMd1sxpEX5Fugh8tTAhqO/rXUyWwhoUkD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Petwdm62LVRZgchuW/jP/nS0eRGKLeGsE7QBM2JM1zQSjDNxTm4CMUnwsEM+kJMcR
	 XRbuv0Uz/wZRkjtUed6rgDSF7zacuWl39d2GaNnrhgcP3vYmGPooHWMIrH1DlTTnaY
	 hn0xAVc8Tceicvb7zD58QBu58KG5nVc1JfdtobYQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbfAHRFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 12:05:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:54114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727677AbfAHRFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 12:05:18 -0500
Received: from localhost (unknown [171.76.109.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8B4020883;
        Tue,  8 Jan 2019 17:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546967117;
        bh=P7Df4GZ4QSMd1sxpEX5Fugh8tTAhqO/rXUyWwhoUkD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SmeK0w10q8MG4pwMJa22s3jrDwGPuCbZO4Pc1Mv8HEkjhEo791lMB80uTa3KseSp+
         Pc7i+L5yXTItTNbsiERZAaRdK2wl8IgEVNh1i0HRxbL7d2OvGO8tUhGG3zbcz2kR6u
         BllR93BnEDHo+R7wBvlrVtuF/sZhwsNx0WFKoIJ4=
Date:   Tue, 8 Jan 2019 22:33:41 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v2] dmaengine: imx-sdma: refine to load context only once
Message-ID: <20190108170341.GR13372@vkoul-mobl.Dlink>
References: <1546977740-10846-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546977740-10846-1-git-send-email-yibin.gong@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-01-19, 12:00, Robin Gong wrote:
> The context loaded only one time before channel running,but
> currently sdma_config_channel() and dma_prep_* duplicated with
> sdma_load_context(), so refine it to load context only one time
> before channel running and reload after the channel terminated.

Applied, thanks

-- 
~Vinod
