Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD5CC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4598D22565
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ly14UsEQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4598D22565
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754770AbeGCKWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 06:22:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:46236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754536AbeGCKWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 06:22:14 -0400
Received: from localhost (unknown [171.61.87.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4884722565;
        Tue,  3 Jul 2018 10:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530613334;
        bh=rnAI7EYHCFrglzNaBu1JMMc+u3zlTalWd8KhTX5R50M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ly14UsEQMg8hgeQFurTlXph36waOI/nS5c1qLeVjvZR6DL0ikb03VxzJZsK5g+YHR
         I96hJHnEuaLMeYIHp/KZ8VL+8c7tVzUC550bApUG4RjSeJY0k5Cz3WEkeEQQfI5TfZ
         m4SeGeqMm110d5H2+TAUPg8j6xjePZ4uyes7Kyn8=
Date:   Tue, 3 Jul 2018 15:52:05 +0530
From:   Vinod <vkoul@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH v1] dmaengine: imx-sdma: add structure description to
 eliminate build warning with 'W=1'
Message-ID: <20180703102205.GP22377@vkoul-mobl>
References: <1530640175-3478-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530640175-3478-1-git-send-email-yibin.gong@nxp.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Robin,

On 04-07-18, 01:49, Robin Gong wrote:

No need to mention W=1 is patch title. Title should only describe the
change being done, so "add missing structure description" would suffice.

> Some member description or colons miss cause build warning with 'W=1'
> as below:
> 
> drivers/dma/imx-sdma.c:326: warning: Function parameter or member 'vd' not described in 'sdma_desc'
> drivers/dma/imx-sdma.c:326: warning: Function parameter or member 'num_bd' not described in 'sdma_desc'
> drivers/dma/imx-sdma.c:326: warning: Function parameter or member 'bd_phys' not described in 'sdma_desc'
> drivers/dma/imx-sdma.c:326: warning: Function parameter or member 'buf_tail' not described in 'sdma_desc'
> drivers/dma/imx-sdma.c:326: warning: Function parameter or member 'buf_ptail' not described in 'sdma_desc'
> drivers/dma/imx-sdma.c:326: warning: Function parameter or member 'period_len' not described in 'sdma_desc'
> drivers/dma/imx-sdma.c:326: warning: Function parameter or member 'chn_real_count' not described in 'sdma_desc'
> drivers/dma/imx-sdma.c:326: warning: Function parameter or member 'chn_count' not described in 'sdma_desc
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> Reported-by: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>

No need for your s-o-b twice, once is enough

>  /**
>   * struct sdma_desc - descriptor structor for one transfer

s/structor/structure

> - * @vd			descriptor for virt dma
> - * @num_bd		max NUM_BD. number of descriptors currently handling
> - * @buf_tail		ID of the buffer that was processed
> - * @buf_ptail		ID of the previous buffer that was processed
> - * @period_len		period length, used in cyclic.
> - * @chn_real_count	the real count updated from bd->mode.count
> - * @chn_count		the transfer count set
> - * @sdmac		sdma_channel pointer
> - * @bd			pointer of allocate bd
> + * @vd:			descriptor for virt dma
> + * @num_bd:		max NUM_BD. number of descriptors currently handling

Number (title case)
-- 
~Vinod
