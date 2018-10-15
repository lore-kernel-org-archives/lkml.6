Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441D7C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E94D6208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVfCLPBo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E94D6208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbeJPAq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 20:46:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:41304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbeJPAq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 20:46:58 -0400
Received: from localhost (unknown [106.201.39.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A18DF204FD;
        Mon, 15 Oct 2018 17:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539622854;
        bh=9tc3y6KR7YwIexILyj67snyFm0V3CTgnCZjFzMV8W6U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eVfCLPBof0vjBh8Z/HhL3myunvcbi0yC2kEwNaitheXrtv6k+pMThREHNVfWAO0+1
         0H/nKT7hiadCYv+CoohZHA/nMOZr3IBN3aS2BE1LuNOrDw+t1vheYS3ITmO3nQE1Sx
         4UPBZh01YfhFSo5eqUwsw4OHFNeIPlP7ZEO8My8U=
Date:   Mon, 15 Oct 2018 22:30:45 +0530
From:   Vinod <vkoul@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     stable@vger.kernel.org, gregkh@linuxfoundation.org,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 0/7] NULL pointer deref fix for stm32-dma
Message-ID: <20181015170045.GI2400@vkoul-mobl>
References: <20181009054752.145978-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009054752.145978-1-joel@joelfernandes.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

On 08-10-18, 22:47, Joel Fernandes (Google) wrote:
> Hi Greg,
> 
> While looking at android-4.14, I found a NULL pointer deref with
> stm32-dma driver using Coccicheck errors. I found that upstream had a
> bunch of patches on stm32-dma that have fixed this and other issues, I
> applied these patches cleanly onto Android 4.14. I believe these should
> goto stable and flow into Android 4.14 from there, but I haven't tested
> this since I have no hardware to do so.
> 
> Atleast I can say that the coccicheck error below goes away when running:
> make coccicheck MODE=report
> ./drivers/dma/stm32-dma.c:567:18-24: ERROR: chan -> desc is NULL but dereferenced.
> 
> Anyway, please consider this series for 4.14 stable, I have CC'd the
> author and others, thanks.
> 
> Pierre Yves MORDRET (7):
>   dmaengine: stm32-dma: threshold manages with bitfield feature
>   dmaengine: stm32-dma: fix incomplete configuration in cyclic mode
>   dmaengine: stm32-dma: fix typo and reported checkpatch warnings
>   dmaengine: stm32-dma: Improve memory burst management
>   dmaengine: stm32-dma: fix DMA IRQ status handling
>   dmaengine: stm32-dma: fix max items per transfer
>   dmaengine: stm32-dma: properly mask irq bits

It would be good to only cherry pick fixes for this. I do not feel that
some of them which are adding or enhancing driver belong to stable.

Thanks
-- 
~Vinod
