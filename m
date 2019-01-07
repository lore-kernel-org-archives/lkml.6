Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2EAC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CBAB2177B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864949;
	bh=3Kv8Hca8SVuTNNHBP4DpRkWak9TZX0b+v7Y2EhG6ahs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vXOSFGRHjFWJoR1RoPjVPDtnnO+K/WTNpZlOjq3dkzdDMVo++aEQkdKhxMsog4g6X
	 nxz8dgLn+4Aui/Z9i3Cf4V/2bnqXsJ2q9pN/oT1zkV1oDFF+Z690wdbiaRH79sYoUG
	 5SGbHFNDtxzcMG0yF/5naJA+lJpCv2RwaSaxtVws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbfAGMm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:42:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:58090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728261AbfAGMmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:42:24 -0500
Received: from localhost (unknown [171.76.109.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DD3B20665;
        Mon,  7 Jan 2019 12:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864944;
        bh=3Kv8Hca8SVuTNNHBP4DpRkWak9TZX0b+v7Y2EhG6ahs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LrWpanJ+iGgggXIF0T3AjWWvorzbkJCdXp0AF9M8Bg2D+cfO+KvIUZMoQlTSaOHEc
         u7+hzWSzwrxxgwRNyoR/DploAin21i8Go04iOJ4A39Ga25yqMccvYUq8p/ENyjAtyb
         SnVEs1VpljYc6zOT3Qykto9iYnWysfyag0LDF5y0=
Date:   Mon, 7 Jan 2019 18:10:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: tegra-apb: Use struct_size() in devm_kzalloc()
Message-ID: <20190107124052.GJ13372@vkoul-mobl.Dlink>
References: <20190104211612.GA14300@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190104211612.GA14300@embeddedor>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-01-19, 15:16, Gustavo A. R. Silva wrote:
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
