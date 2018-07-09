Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AC0C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26635208A5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofsTksSX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26635208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933519AbeGIRPJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 13:15:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:56322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933360AbeGIRPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 13:15:07 -0400
Received: from localhost (unknown [106.201.46.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F55C20871;
        Mon,  9 Jul 2018 17:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531156507;
        bh=mnbJASZQ6vB8nBRDMUBh+xawH7madxOgrKeixrgkcv8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ofsTksSX/OSzuLwld6bgnPx84JXyEDgvLYae5hmFcq+C5xpapSSGuRBb/I0fIcKof
         jIDXVppVVgwFinJ1GeQtA0su3VJjeNr7YXz+c9bYAjmLJ8+18eMxpOg0bg+v4aYWS8
         +ZLT7+W3eKh2+jiMfpsxQfXqGEcRZ1U+iPc6w4Qc=
Date:   Mon, 9 Jul 2018 22:44:58 +0530
From:   Vinod <vkoul@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 06/14] dmaengine: dma-jz4780: Add support for the JZ4725B
 SoC
Message-ID: <20180709171458.GL22377@vkoul-mobl>
References: <20180703123214.23090-1-paul@crapouillou.net>
 <20180703123214.23090-7-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703123214.23090-7-paul@crapouillou.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-07-18, 14:32, Paul Cercueil wrote:
> The JZ4725B has one DMA core starring six DMA channels.
> As for the JZ4770, each DMA channel's clock can be enabled with
> a register write, the difference here being that once started, it
> is not possible to turn it off.

ok so disable for this, right..

> @@ -204,6 +205,8 @@ static inline void jz4780_dma_chan_enable(struct jz4780_dma_dev *jzdma,
>  {
>  	if (jzdma->version == ID_JZ4770)
>  		jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DCKES, BIT(chn));
> +	else if (jzdma->version == ID_JZ4725B)
> +		jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DCKE, BIT(chn));

but you are writing to a different register here.. 

-- 
~Vinod
