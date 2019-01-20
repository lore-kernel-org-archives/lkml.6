Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AECC61CE4
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 05:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB2B2084A
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 05:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547961354;
	bh=N3Safwsq+5lbAEx2AAtM926+JbI8/1L3k+2+SjSdlRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zbWExWwQ1LG+D4NNRAKxHULIdOWWn1BzN97aXrVS3bt2tqPX/e72fpj7FKcjMzMRm
	 +IN/mOen6IS5GhwiMEumswccQ//8tsVV+AZR2v/s+NDLWLOtyzu+6W1er/TkmRju5C
	 bHB/sh/AJckfRr4awZCH/qgQzMqtXYfOcb/dgOEA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfATFPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 00:15:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:51250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbfATFPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 00:15:39 -0500
Received: from localhost (unknown [122.178.235.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C31A2084A;
        Sun, 20 Jan 2019 05:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547961338;
        bh=N3Safwsq+5lbAEx2AAtM926+JbI8/1L3k+2+SjSdlRQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IcqByOJaOaVdPFdHIUhnzL/6haJ+DbXvohLQoZTIoeJ1nzjuhkA3sfTaNrPG3aSlH
         eHQ1GN7Xxb5D6q0b+r8cXdkyEBL00rAGzpeP0zJgsolGWOVYDHsHGuOh10TC3JHlo9
         zBkTh+xcscbXfsfXH2rdGgbFybfr2Po0AR+TiYaA=
Date:   Sun, 20 Jan 2019 10:44:05 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Shunyong Yang <shunyong.yang@hxt-semitech.com>
Cc:     okaya@kernel.org, andy.gross@linaro.org, david.brown@linaro.org,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Joey Zheng <yu.zheng@hxt-semitech.com>
Subject: Re: [PATCH v2 1/2] dmaengine: qcom_hidma: initialize tx flags in
 hidma_prep_dma_*
Message-ID: <20190120051405.GI4635@vkoul-mobl>
References: <8109d1ab70fe6dbacdbe89fda38d8dcb450c884c.1546823811.git.shunyong.yang@hxt-semitech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8109d1ab70fe6dbacdbe89fda38d8dcb450c884c.1546823811.git.shunyong.yang@hxt-semitech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-01-19, 09:32, Shunyong Yang wrote:
> In async_tx_test_ack(), it uses flags in struct dma_async_tx_descriptor
> to check the ACK status. As hidma reuses the descriptor in a free list
> when hidma_prep_dma_*(memcpy/memset) is called, the flag will keep ACKed
> if the descriptor has been used before. This will cause a BUG_ON in
> async_tx_quiesce().
> 
>   kernel BUG at crypto/async_tx/async_tx.c:282!
>   Internal error: Oops - BUG: 0 1 SMP
>   ...
>   task: ffff8017dd3ec000 task.stack: ffff8017dd3e8000
>   PC is at async_tx_quiesce+0x54/0x78 [async_tx]
>   LR is at async_trigger_callback+0x98/0x110 [async_tx]
> 
> This patch initializes flags in dma_async_tx_descriptor by the flags
> passed from the caller when hidma_prep_dma_*(memcpy/memset) is called.

Applied both, thanks

-- 
~Vinod
