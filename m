Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F19C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D2C20864
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXnw6pkh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2D2C20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933968AbeGIRaR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 13:30:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933479AbeGIR3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 13:29:45 -0400
Received: from localhost (unknown [106.201.46.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 834C6208A5;
        Mon,  9 Jul 2018 17:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531157385;
        bh=L6mTdTsEG7kxPYs6X+Y3M0wFuI94a2Yu5AfLGQ1RwwA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uXnw6pkhRe1NKzqZ7wE56NffkQqwwoqTxevF0Y+VjJNCaX6PmWb0w09e+jzLa/dei
         9ih8sVrVsqwXGrU27cMbi5oLF0EW7ilJD3oUD1EJCgG0YWQ4GWuZCzlZM/b1nW+i0m
         7MNjHmrucI7LUMAcOcZBhWJTncBU5cgoBk65OMvo=
Date:   Mon, 9 Jul 2018 22:59:37 +0530
From:   Vinod <vkoul@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     dmaengine@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mark Brown <broonie@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] dma: add support for reporting pause and resume
 separately
Message-ID: <20180709172937.GP22377@vkoul-mobl>
References: <CGME20180702130819eucas1p2e11d8fabec93ba78d9e84f4ca6e5fd65@eucas1p2.samsung.com>
 <20180702130819eucas1p2e11d8fabec93ba78d9e84f4ca6e5fd65~9jzNWZMqQ1216712167eucas1p27@eucas1p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702130819eucas1p2e11d8fabec93ba78d9e84f4ca6e5fd65~9jzNWZMqQ1216712167eucas1p27@eucas1p2.samsung.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-07-18, 15:08, Marek Szyprowski wrote:
> 'cmd_pause' DMA channel capability means that respective DMA engine
> supports both pausing and resuming given DMA channel. However, in some
> cases it is important to know if DMA channel can be paused without the
> need to resume it. This is a typical requirement for proper residue
> reading on transfer timeout in UART drivers. There are also some DMA
> engines with limited hardware, which doesn't really support resuming.
> 
> Reporting pause and resume capabilities separately allows UART drivers to
> properly check for the really required capabilities and operate in DMA
> mode also in systems with limited DMA hardware. On the other hand drivers,
> which rely on full channel suspend/resume support, should now check for
> both 'pause' and 'resume' features.
> 
> Existing clients of dma_get_slave_caps() have been checked and the only
> driver which rely on proper channel resuming is soc-generic-dmaengine-pcm
> driver, which has been updated to check the newly added capability.
> Existing 'cmd_pause' now only indicates that DMA engine support pausing
> given DMA channel.

Applied after fixing the subsystem name, thanks

-- 
~Vinod
