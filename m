Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7658C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 03:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B862146E
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 03:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CD0SthG6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62B862146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbeKKNMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 08:12:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:46332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727037AbeKKNMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 08:12:20 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E96320989;
        Sun, 11 Nov 2018 03:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541906706;
        bh=97HaA+i+YycfA0E771E95SzhIdIq1rY5m4KXD/AyiZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CD0SthG6vIIjw9OxvEy1BReAZiXa+GYM8+2hb/owFWbTEnyAcXX1VIM4w4Zrd4X0F
         JZXYJvRvQxcUDSy5kJtZ6fsdOatqV/66emxCViWOHn1NjYSQdV3F8V/oLjFYbWycOw
         kvDcteCfD1ovDccT+CgaUKzbFVHHeZ2bkDLo0vKY=
Date:   Sat, 10 Nov 2018 17:11:05 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     stable@vger.kernel.org,
        Pierre Yves MORDRET <pierre-yves.mordret@st.com>,
        Hugues Fruchet <hugues.fruchet@st.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: Re: [PATCH for-stable] dmaengine: stm32-dma: fix incomplete
 configuration in cyclic mode
Message-ID: <20181111011105.GA18060@kroah.com>
References: <20181017000003.GC140578@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017000003.GC140578@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 05:00:03PM -0700, Joel Fernandes (Google) wrote:
> From: Pierre Yves MORDRET <pierre-yves.mordret@st.com>
> 
> commit e57cb3b3f10d005410f09d4598cc6d62b833f2b0 upstream.
> 
> When in cyclic mode, the configuration is updated after having started the
> DMA hardware (STM32_DMA_SCR_EN) leading to incomplete configuration of
> SMxAR registers.
> 
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> ---
>  drivers/dma/stm32-dma.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

I'm just guessing you want this for 4.14.y?  I've added it there.  If
not, please give me a hint :)
