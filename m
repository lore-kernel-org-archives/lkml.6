Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F2EC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E9723F16
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="eqlia9cB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09E9723F16
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933337AbeGFNA2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:00:28 -0400
Received: from 8bytes.org ([81.169.241.247]:54056 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932955AbeGFNA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:00:26 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 0FE651F0; Fri,  6 Jul 2018 15:00:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1530882025; bh=7Luan9Co5qOQnJqcrrFLXCA+a/yuB6a6TgpGFHetXgc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eqlia9cBcsOq8rhX8EuekvHzDLSPkZoEF3KTo6RM50rPsBOCC1+8fIo7MRtaM3Kly
         lsL+ry468tf5T/8DANCoxtpYFzj2Tc1gTXBuPIzqqYphMslYg9GCQ8d+sxqO9X+Xum
         Va6J4Ksz2NQ8U4xj35zSUKqg2nbniEjjyvsXC0eRNST5QcJ27/+cjx8CfI8a8xEhIW
         8ms+vRD01qTMk5RrCX8Q9FphVlqUi3K7rbml4D+GvtjSeBPcsa3SYdnWEXSHN/nmeW
         01/iqFn5+aGyXsfS3bF0LSV6/rQFTtT2lEcrf/CAvMxb4Tv1YrGeb2rorLdEQNWCgL
         NDWKcqnivU3Ow==
Date:   Fri, 6 Jul 2018 15:00:24 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Joe Perches <joe@perches.com>
Cc:     Walter Harms <wharms@bfs.de>, "Hook, Gary" <ghook@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        iommu@lists.linux-foundation.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: fix missing tag from dev_err message
Message-ID: <20180706130024.GD13903@8bytes.org>
References: <1540588259.84011.1530637026831@ox-groupware.bfs.de>
 <cb5702b95b8d4914612526125f625c4bc2cedfcc.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb5702b95b8d4914612526125f625c4bc2cedfcc.camel@perches.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 10:34:12AM -0700, Joe Perches wrote:
> On Tue, 2018-07-03 at 18:57 +0200, Walter Harms wrote:
> > It is only cosmetics but even the author got lost about the loose bracket.
> > I would suggest to remove all the brackets or if needed to move the [ in the
> > message. We have enought memory this days.
> 
> My suggestion would be to remove the separate dev_err
> and use "Event log [" in each dev_err.
> 
> So here's an actual suggested patch that does a few things:
> 
> o Coalesce formats and realigns arguments
> o Uses pr_fmt and dev_fmt to prefix "AMD-Vi: " to all messages
> o Remove embedded "AMD-Vi: " from various formats

Nice cleanup! But I got lost a bit in the patches floating around in
this thread and their dependencies. Can someone sort it out and send it
a new patch-set to me?


Thanks,

	Joerg

