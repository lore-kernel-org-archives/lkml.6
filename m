Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF684C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 06:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC2E21473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 06:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3jZ8sKj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EC2E21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbeJDNFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 09:05:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:57888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbeJDNFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 09:05:00 -0400
Received: from localhost (unknown [171.76.113.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C60F320877;
        Thu,  4 Oct 2018 06:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538633601;
        bh=P/MnLDch3FK9oOTboHolwGz15cu5dgt/cvo7Q3vhjUk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q3jZ8sKjgBruK4Zu4g1/7eUq3vCZ6K5XzhfwgAFsRYPKYWTU37kvm4AzYyorTkXDd
         4fouAO4LxmN81YXd8P2V2iB7Eerl0FrnJzOJQFEj/WSAIV+RSFBTdBFV9kDmbn5sKm
         pJcZaNtfQC1Slu92SNVSAOedJXmMRd8KMLrpUTyk=
Date:   Thu, 4 Oct 2018 11:43:12 +0530
From:   Vinod <vkoul@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Angelo Dureghello <angelo@sysam.it>
Subject: Re: linux-next: build failure after merge of the slave-dma tree
Message-ID: <20181004061312.GC2372@vkoul-mobl>
References: <20181004154438.64f9d8c2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004154438.64f9d8c2@canb.auug.org.au>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 04-10-18, 15:44, Stephen Rothwell wrote:
> Hi Vinod,
> 
> After merging the slave-dma tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
> 
> drivers/dma/fsl-edma.c:67: warning: "EDMA_SEEI_SEEI" redefined
>  #define EDMA_SEEI_SEEI(x) ((x) & 0x1F)
> 
> In file included from drivers/dma/fsl-edma.c:25:
> drivers/dma/fsl-edma-common.h:21: note: this is the location of the previous definition
>  #define EDMA_SEEI_SEEI(x) ((x) & GENMASK(4, 0))
> 
>  ...
> 
> drivers/dma/fsl-edma.c:115:6: error: nested redefinition of 'enum fsl_edma_pm_state'
>  enum fsl_edma_pm_state {
>       ^~~~~~~~~~~~~~~~~
> drivers/dma/fsl-edma.c:115:6: error: redeclaration of 'enum fsl_edma_pm_state'
> In file included from drivers/dma/fsl-edma.c:25:
> drivers/dma/fsl-edma-common.h:63:6: note: originally defined here
>  enum fsl_edma_pm_state {
>       ^~~~~~~~~~~~~~~~~
> 
> and so on ...
> 
> Caused by commit
> 
>   101d256a45ed ("Merge branch 'testing/dirn_remove' into next")
> 
> which reintroduced a whole lot of stuff into drivers/dma/fsl-edma.c that
> had been modev out in commit
> 
>   9d831528a656 ("dmaengine: fsl-edma: extract common fsl-edma code (no changes in behavior intended)")

I got a merge conflict but for include, so looks like merge went bad.
I will redo it and push

> I used the slave-dma tree from next-20181003 for today.

Thanks for updating

Best Regards,
-- 
~Vinod
