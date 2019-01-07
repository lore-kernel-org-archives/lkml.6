Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0995C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E242147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864976;
	bh=S6rBbCMpVW/xXVHEgXrUkirbTv4T+Rf/nIBOhTFp5vI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VnUNOBQfj3uGixYELw+L4tJy519MPZLQ/uE2yGXWqMfFq/TvAhjzc+tVnTMC4zy+y
	 FlVAj418U4SByyL0Pe5yZBs/6cXVYVzppejfwmubuT+yduAiYbYBN+S9v8RubLhcpZ
	 V/b9uuPvp39AMCm0G6rO8nuQ+dR7+QdQKXAGn0sU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbfAGMmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:42:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:58424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728305AbfAGMmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:42:40 -0500
Received: from localhost (unknown [171.76.109.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E8C620665;
        Mon,  7 Jan 2019 12:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864960;
        bh=S6rBbCMpVW/xXVHEgXrUkirbTv4T+Rf/nIBOhTFp5vI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SSqPq/pAfnYmdVZYoV/Y5UyYQp49GuLGMAU195Rjelc3JsVBVPyAtVZgFDqamtSrQ
         hD1wq7GazdwA+kx6K4X3qsqvEcDlKI/Ue3gz45YN4P/w2aGEzbilEmqLPj00UHepWI
         aXN05SqNVzWzMIjjeiwa64phmb8dloFqdR//uWjo=
Date:   Mon, 7 Jan 2019 18:11:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: fsl-edma: use struct_size() in kzalloc()
Message-ID: <20190107124108.GK13372@vkoul-mobl.Dlink>
References: <20190104212545.GA16927@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190104212545.GA16927@embeddedor>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-01-19, 15:25, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding the
> size of a structure that has a zero-sized array at the end, along with memory
> for some number of elements for that array. For example:
> 
> struct foo {
>     int stuff;
>     void *entry[];
> };
> 
> instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can now
> use the new struct_size() helper:
> 
> instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
> 
> This code was detected with the help of Coccinelle.

Applied, thanks

-- 
~Vinod
