Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42139C61CE4
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 05:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4F12085B
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 05:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547961716;
	bh=TeDRQOnqn5jMsjkjAD932Ix0jD5Na3JmmEk1y91c6/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r2LKH4ql1cmh0xFv+TERk0Ws+IjQZLrcY6asGvsEXc0FU5X6/uvESxV+9+Li5Ci6z
	 G2uErH4I7+gDrP9cksof50FZ+oIbHtdYRdM/dyg0StrzLY8szxOQluzoyTyRpzvr9m
	 5t6C2B6j334IVIPxZc5zx6CTg0prB6sa4cB3tB88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfATFVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 00:21:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:52990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbfATFVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 00:21:52 -0500
Received: from localhost (unknown [122.178.235.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C4012084A;
        Sun, 20 Jan 2019 05:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547961711;
        bh=TeDRQOnqn5jMsjkjAD932Ix0jD5Na3JmmEk1y91c6/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p8WvWV170t15/KaIjG0VDtWZuggEYY7QI86OCPvhuOqFJLMQWgrHwPBpWlQRkDMRE
         zSbtNI1BF5qKwwgsm5RA2PfRYvmCrN0L6eT4GIjHoX1dGuGz5u0rkq432h7KT4p3Di
         +kDn+Ado6m3NqP2lpgiXIUcrU135fmsAuilapH9k=
Date:   Sun, 20 Jan 2019 10:50:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: timb_dma: Use struct_size() in kzalloc()
Message-ID: <20190120052017.GK4635@vkoul-mobl>
References: <20190108155852.GA17782@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108155852.GA17782@embeddedor>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-01-19, 09:58, Gustavo A. R. Silva wrote:
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
