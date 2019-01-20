Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F67C61CE4
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 05:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27732085B
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 05:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547961817;
	bh=3DdBv8T1XZjd63F7p9OoILoZYiEEU5Jq1ddcvLGMq1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xQHw58vZn/h6iQlSNIio0lKpQKbyhN8ZG1QmRIg1d+xcldOvzKNz6cN57PGHN/DTn
	 VTPefUaZcjQwrbJCBGFPL3gmX3KSilJZyW0oZYReD/fXHvRvgLsSDwOcv3luMGYse4
	 oZ0LCvR0YjZI0EFet7ffi0jtVd2YOjCdPUdQdTjQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfATFXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 00:23:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:53830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbfATFXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 00:23:35 -0500
Received: from localhost (unknown [122.178.235.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28F612084A;
        Sun, 20 Jan 2019 05:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547961815;
        bh=3DdBv8T1XZjd63F7p9OoILoZYiEEU5Jq1ddcvLGMq1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AE2k0Sf0UoETWDXP++0j1/1gO4E3OPAAFpJIQManlI9pv3TKqIzkgw118pWMsNi9f
         7JJN88EHDBDtSuE9YQpgxVM83zlFWPYiRKHWZmWKo3UuRzOJd3gOnScSTk3N2Uz4PZ
         s0dhtRYfC2B3KmXo/RaBGiawSkq60BOBr5PzIx0s=
Date:   Sun, 20 Jan 2019 10:52:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: axi-dmac: Use struct_size() in kzalloc()
Message-ID: <20190120052201.GL4635@vkoul-mobl>
References: <20190109144437.GA10733@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109144437.GA10733@embeddedor>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-01-19, 08:44, Gustavo A. R. Silva wrote:
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
