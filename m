Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D2AC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 06:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E10621019
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 06:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546409106;
	bh=i5+Tzid5nPl2ZrJEsOWzT6avBy4GUJPyiNvxAmFr/iU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bNdx2sHFg5jR+xnxDsm4jKu0dcsEVcdP8vhEat7zkF9mP0l07RFVPqzyt+7O0RgVh
	 KDjG24FETfRDlAr46n2Y9g6+eWTvFswJmi7AAAmYMtpj9q8ifQtR2tOmD6P0X5vCc5
	 tu0fLlKlckNKe8XfPpX2Wo9zHflphQl4TrCzKh88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbfABGFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 01:05:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:58732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727836AbfABGFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 01:05:05 -0500
Received: from localhost (unknown [171.76.109.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC3562089F;
        Wed,  2 Jan 2019 06:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546409104;
        bh=i5+Tzid5nPl2ZrJEsOWzT6avBy4GUJPyiNvxAmFr/iU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TtCXeomeLfZ/nFgLpI+5ZG5wDuH0ANAj51T8Ku/Vfjfg+xf4fbkN5Ec7wwxbgoUIZ
         d24cPUdA07PPx/yxeNm5+Gm7MQyeNm3VWxNq9Og8HSq12Dzv4b44U7jv/LnuwX9OeO
         7tQ6DXUFWswTz7K33MXNF5TDMg0ikcpg8D0q9UAc=
Date:   Wed, 2 Jan 2019 11:33:24 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Viresh Kumar <vireshk@kernel.org>, kernel-janitors@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/20] dmaengine: dw: drop useless LIST_HEAD
Message-ID: <20190102060324.GF7581@vkoul-mobl>
References: <1545555435-24576-1-git-send-email-Julia.Lawall@lip6.fr>
 <1545555435-24576-13-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545555435-24576-13-git-send-email-Julia.Lawall@lip6.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-12-18, 09:57, Julia Lawall wrote:
> Drop LIST_HEAD where the variable it declares is never used.
> 
> Commit ab703f818ac3 ("dmaengine: dw: lazy allocation of dma
> descriptors") removed the uses, but not the declaration.
> 
> The semantic patch that fixes this problem is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> identifier x;
> @@
> - LIST_HEAD(x);
>   ... when != x
> // </smpl>

Applied, thanks

-- 
~Vinod
