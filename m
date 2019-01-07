Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97579C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69D762183E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864896;
	bh=n9PDA56nBUe5oiA/yp5OaG36vcx03R+vFSKlozLj0Qc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LAWUuzjf3BbnB2JoL2M+OqVwW/5JO+fiCB90PyviMd0C/gmceiZ0aYZg6qOAjRDmo
	 RFTdecDuo8yeDRsaizZQ++G9Sux02H6ibIPJw/CXbW9LoI1oOWXULiTyie+SjjeA2W
	 /4K7xOA2zhAlHQuj7P/dlVQN9QpGrW++9ZwWKcqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbfAGMlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:41:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:56834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727960AbfAGMld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:41:33 -0500
Received: from localhost (unknown [171.76.109.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7E0321873;
        Mon,  7 Jan 2019 12:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864892;
        bh=n9PDA56nBUe5oiA/yp5OaG36vcx03R+vFSKlozLj0Qc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dh+m4OfNOnCmY/ejLBHzDcaFk9FzFgFWJ9Yp8AvDfA0j+fmFsLlvO427wp6fUxyec
         laDcSR3+8wRjs24AHzCp7k5lx269W9VhBYAokJZtskNZ8p1nR0vvsCqzpWucTXZOPL
         kXKypQqE9ux5t6Bpg3wsMzWE/9yCypAck3hQSjzE=
Date:   Mon, 7 Jan 2019 18:09:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: dma-jz4780: Use struct_size() in
 devm_kzalloc()
Message-ID: <20190107123955.GG13372@vkoul-mobl.Dlink>
References: <20181224065217.GA10629@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181224065217.GA10629@embeddedor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-12-18, 00:52, Gustavo A. R. Silva wrote:
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
> This issue was detected with the help of Coccinelle.

Applied, thanks

-- 
~Vinod
