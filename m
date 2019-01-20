Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A816C61CE4
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 05:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1106C2085B
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 05:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547961615;
	bh=CTvA5eFE/pLaalZrX6aKtMDntzbOD+sieNqrjCB3NJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ur1U0nUcAIhBKsfCqRNH3HAOnUBFEqREWSGESFtY3tFhwnypETIuZ+uPBrtXmsLSL
	 u1v60dgAUm9I2C9Up3lz6R8+Xh4quQhLGyNZyR6oT4HwjdsjqR1bOu5rDsGOONe1iG
	 uLm5MdpSjLUmBsioaTVi6zAI1av673hsLc3QIxgY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfATFUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 00:20:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:52658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbfATFUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 00:20:11 -0500
Received: from localhost (unknown [122.178.235.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FCBE2084A;
        Sun, 20 Jan 2019 05:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547961610;
        bh=CTvA5eFE/pLaalZrX6aKtMDntzbOD+sieNqrjCB3NJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2e31rffkN+DcdBN9MxpEzTeg9TPbvS/8QQVsCc+ps28YUtxB/+yt1glcmH+hCdlt3
         IvMNlPlefsFCe0DFgWFD3FITE8FxnXhVCXAttKvaz+UABm4vt25xnHlXQKQ9o/PEyz
         OZzkCbPM5Y7v9CxYDuQa5Jb+YVinYIN5Ffb/Iw18=
Date:   Sun, 20 Jan 2019 10:48:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: tegra210-adma: Use struct_size() in
 devm_kzalloc()
Message-ID: <20190120051836.GJ4635@vkoul-mobl>
References: <20190107170631.GA32119@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107170631.GA32119@embeddedor>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-01-19, 11:06, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct foo {
>     int stuff;
>     void *entry[];
> };
> 
> instance = devm_kzalloc(dev, sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
> 
> instance = devm_kzalloc(dev, struct_size(instance, entry, count), GFP_KERNEL);
> 
> This code was detected with the help of Coccinelle.

Applied, thanks

-- 
~Vinod
