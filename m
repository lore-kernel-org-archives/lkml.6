Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5053DC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B6CB218CD
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546616966;
	bh=vTbiuBlWy8oEFEO3CSJCQZaK/1TBaTw/SDjVJsn2SSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=igE3eM4pJnrCPvQLvB8SAovuQhRZCZZi5x4RsN5WJ/I0aIH/F708/oqgBeHToOubm
	 uDBJIjHG1MH0sxPDyOAmnUu8bsGnx8u2xl7CbXN99VAqTBjylBxMilFXJwfBACcVxW
	 e8fyl2+BJZsWAL86oNBUsGtHaJbFi9UwYs1zg90I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbfADPtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 10:49:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:37716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbfADPtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 10:49:24 -0500
Received: from localhost (unknown [171.76.109.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50E7721874;
        Fri,  4 Jan 2019 15:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546616964;
        bh=vTbiuBlWy8oEFEO3CSJCQZaK/1TBaTw/SDjVJsn2SSI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sytG6HuJuZjPjxmXOFAk3sqcH7v9rxW11+Jm1bSAirS3qR1nHnYJK1wRbloeI9IKi
         pDwg8UiLTF/JFYBAOxcdCA4GBMjnekM0re84P7xBrvuFVAtk6WzIJSKByh5xLnNehj
         oBpAIRsyejjIMmK673r3dm1p5EhQy/pq7WQfxpEQ=
Date:   Fri, 4 Jan 2019 21:17:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v1] dmaengine: stm32-dma: check FIFO error
 interrupt enable
Message-ID: <20190104154746.GO13372@vkoul-mobl.Dlink>
References: <1546510649-16744-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546510649-16744-1-git-send-email-pierre-yves.mordret@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-01-19, 11:17, Pierre-Yves MORDRET wrote:
> For avoiding false FIFO detection, check FIFO Error interrupt is
> enabled prior raising any errors.
> This will prevent having spurious FIFO error where it shouldn't.

Applied, thanks

-- 
~Vinod
