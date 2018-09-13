Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3589C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 07:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D383206B5
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 07:24:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D383206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sysam.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbeIMMcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 08:32:19 -0400
Received: from ec2-18-194-220-216.eu-central-1.compute.amazonaws.com ([18.194.220.216]:35450
        "EHLO sysam.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbeIMMcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 08:32:18 -0400
X-Greylist: delayed 386 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Sep 2018 08:32:18 EDT
Received: from localhost (localhost [127.0.0.1])
        by sysam.it (Postfix) with ESMTP id 7B2F221DEA;
        Thu, 13 Sep 2018 07:17:40 +0000 (UTC)
Received: from sysam.it ([127.0.0.1])
        by localhost (sysam.it [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DEPbEdfqqjF7; Thu, 13 Sep 2018 07:17:39 +0000 (UTC)
Received: from jerusalem (host243-1-dynamic.50-79-r.retail.telecomitalia.it [79.50.1.243])
        by sysam.it (Postfix) with ESMTPSA id 3FCAD21DE6;
        Thu, 13 Sep 2018 07:17:39 +0000 (UTC)
Date:   Thu, 13 Sep 2018 09:17:38 +0200
From:   Angelo Dureghello <angelo@sysam.it>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: linux-next: build warning after merge of the slave-dma tree
Message-ID: <20180913071738.GA11013@jerusalem>
References: <20180913122218.0fb31482@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913122218.0fb31482@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

sorry, there was no build-test robot warning anymore about it.
Will fix it in a patch in short.


On Thu, Sep 13, 2018 at 12:22:18PM +1000, Stephen Rothwell wrote:
> Hi Vinod,
> 
> After merging the slave-dma tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
> 
> drivers/dma/mcf-edma.c: In function 'mcf_edma_filter_fn':
> drivers/dma/mcf-edma.c:296:33: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>    return (mcf_chan->slave_id == (u32)param);
>                                  ^
> 
> Introduced by commit
> 
>   e7a3ff92eaf1 ("dmaengine: fsl-edma: add ColdFire mcf5441x edma support")
> 

Regards,
Angelo

> -- 
> Cheers,
> Stephen Rothwell


