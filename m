Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35847C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1FF1241A6
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJjQoxxf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1FF1241A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752594AbeGEFBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 01:01:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:48636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750971AbeGEFBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 01:01:34 -0400
Received: from localhost (unknown [223.226.33.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F8F8241A6;
        Thu,  5 Jul 2018 05:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530766894;
        bh=c1j0fSaaRpbz6JJN3FWI0oAftDcdiBtz/OW4F0wtJUU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mJjQoxxf6agnJIgJvBmcILWtXGDwz0bWyzJa28HimC4hkWCOl4b2yttpDfzH+V3Z9
         EDofB8OVpD9sb90HwMg/sYnrS5SarXRRqfU4iwXdDTViBLYMxQ/HfwFdh/zUVpie4W
         FLNg0afM/oUAtlKE+xka9IdXgSU6IriK3SV1TQLo=
Date:   Thu, 5 Jul 2018 10:31:25 +0530
From:   Vinod <vkoul@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Angelo Dureghello <angelo@sysam.it>
Subject: Re: linux-next: build warning after merge of the slave-dma tree
Message-ID: <20180705050125.GF22377@vkoul-mobl>
References: <20180704133006.4d42d1a6@canb.auug.org.au>
 <20180704042017.GW22377@vkoul-mobl>
 <20180705124701.0454b482@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705124701.0454b482@canb.auug.org.au>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 05-07-18, 12:47, Stephen Rothwell wrote:
> On Wed, 4 Jul 2018 09:50:17 +0530 Vinod <vkoul@kernel.org> wrote:
> > On 04-07-18, 13:30, Stephen Rothwell wrote:
> > > 
> > > After merging the slave-dma tree, today's linux-next build (x86_64
> > > allmodconfig) produced this warning:
> > > 
> > > WARNING: modpost: missing MODULE_LICENSE() in drivers/dma/fsl-edma-common.o  
> > 
> > Thanks for the report, I have fixed it by adding this and pushed out.
> 
> Unfortunately, my arm multi_v7_defconfig build now gets this failure:
> 
> drivers/dma/fsl-edma-common.c:672:16: error: expected declaration specifiers or '...' before string constant
>  MODULE_LICENSE("GPL v2");   
>                 ^~~~~~~~
> 
> presumable a missing include of module.h ...

Thanks for reporting will check and fix this.

-- 
~Vinod
