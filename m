Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB9BC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 163032083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ynOy+GQG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 163032083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbeJBVq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:46:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727970AbeJBVq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:46:28 -0400
Received: from localhost (unknown [171.76.113.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BBA420666;
        Tue,  2 Oct 2018 15:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538492558;
        bh=XzMW2mi9ykGzG1GqBVcER0tbk+5fM/RRh3d3vc7FVAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ynOy+GQG2F2GW8YCvYZPqOTGITbHi9btxemZb7ckI+u8dxXzdohOE8dknGIKk6Odr
         80nqAW2B3y119m8lPIZ31lAcgQQaWLXQ4qOVeL9MlnFhyhasOSMNO5IRgkFZ+XrTjb
         q2pxPzSYqKdlmG7zM9EYERgbOq+1T1944igoFtBI=
Date:   Tue, 2 Oct 2018 20:32:29 +0530
From:   Vinod <vkoul@kernel.org>
To:     Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] dmaengine: stm32-dma: check whether length is
 aligned on FIFO threshold
Message-ID: <20181002150229.GI19792@vkoul-mobl>
References: <1536651076-17005-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536651076-17005-1-git-send-email-pierre-yves.mordret@st.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-09-18, 09:31, Pierre-Yves MORDRET wrote:
> When a period length is not multiple of FIFO some data may be stuck
> within FIFO.
> 
> Burst/FIFO Threshold/Period or buffer length check has to be hardened
> 
> In any case DMA will grant any request from client but will degraded
> any parameters whether awkward.

Applied, thanks

-- 
~Vinod
