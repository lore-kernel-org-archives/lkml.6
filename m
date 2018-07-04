Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C180CC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 04:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 783F0224F8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 04:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yk0DReu5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 783F0224F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932456AbeGDEU1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 00:20:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:33262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932188AbeGDEU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 00:20:26 -0400
Received: from localhost (unknown [171.76.122.136])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A395224F8;
        Wed,  4 Jul 2018 04:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530678025;
        bh=+foADhvrGTaxH9PN3DQTZGg/Xy0bAE2t3cAABT0SHRc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yk0DReu5Ry4uJdmYvp/02usWfVeXv7VsaoxH9RR2hYkPZJ0Nm/19wXVg8Sn9RjXP6
         uBUrWly4bwpPJS8dz2TDDak29/NhZVqjwzXk9LJY/cWbFnFv04Y3rLR+dQmhb6qjbN
         ZJmK7CX1cCuLepWZ2tWSJLSYlnvTDKzKDHvFdees=
Date:   Wed, 4 Jul 2018 09:50:17 +0530
From:   Vinod <vkoul@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Angelo Dureghello <angelo@sysam.it>
Subject: Re: linux-next: build warning after merge of the slave-dma tree
Message-ID: <20180704042017.GW22377@vkoul-mobl>
References: <20180704133006.4d42d1a6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704133006.4d42d1a6@canb.auug.org.au>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 04-07-18, 13:30, Stephen Rothwell wrote:
> 
> After merging the slave-dma tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
> 
> WARNING: modpost: missing MODULE_LICENSE() in drivers/dma/fsl-edma-common.o

Thanks for the report, I have fixed it by adding this and pushed out.

-- 
~Vinod
