Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBB1C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16C4A2089D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iy4IC1V6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16C4A2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbeJPA4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 20:56:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:43726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbeJPA4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 20:56:24 -0400
Received: from localhost (unknown [106.201.39.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42A2520644;
        Mon, 15 Oct 2018 17:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539623418;
        bh=FtfQ/jvNTDiwj4NgRCwu8wJyxbBK/1bG4S0h7mrnccU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iy4IC1V6Udxj9Ee9sNoreJOqRcW/BdAGIsV31ZZE2jY3cqxalDnYWdXAvVsNx2lBp
         4CnRbC2T2oGjoU4uTgOBfBSv1O/TyHJ7MuosJ62w4KBXzhpJYI2PhE+J58m3H0ep/5
         qOVI5jTCwX6ibQSmlrskj7kpK72vgueSUTdxP7SQ=
Date:   Mon, 15 Oct 2018 22:40:10 +0530
From:   Vinod <vkoul@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     afaerber@suse.de, dmaengine@vger.kernel.org,
        liuwei@actions-semi.com, 96boards@ucrobotics.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        manivannanece23@gmail.com, thomas.liau@actions-semi.com,
        pn@denx.de, edgar.righi@lsitec.org.br
Subject: Re: [PATCH] dmaengine: owl: Fix warnings generated during build
Message-ID: <20181015171010.GL2400@vkoul-mobl>
References: <20181008171631.5603-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008171631.5603-1-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-10-18, 22:46, Manivannan Sadhasivam wrote:
> Following warnings are generated when compiled with W=1,
> 
> drivers/dma/owl-dma.c:170: warning: Function parameter or member 'cyclic'
> not described in 'owl_dma_txd'
> drivers/dma/owl-dma.c:198: warning: Function parameter or member 'cfg' not
> described in 'owl_dma_vchan'
> drivers/dma/owl-dma.c:198: warning: Function parameter or member 'drq' not
> described in 'owl_dma_vchan'
> drivers/dma/owl-dma.c:225: warning: Function parameter or member 'irq' not
> described in 'owl_dma'
> 
> Fix this by adding comments for relevant struct members to appear in
> kernel-doc.
> 
> Fixes: d64e1b3f5cce ("dmaengine: owl: Add Slave and Cyclic mode support for
> Actions Semi Owl S900 SoC")
> 

This empty line is not required

> Reported-by: Vinod Koul <vinod.koul@linaro.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>


Applied after removing the bogus empty line, thanks
-- 
~Vinod
