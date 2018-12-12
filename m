Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57906C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25B1920849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:44:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25B1920849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbeLLHoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 02:44:23 -0500
Received: from verein.lst.de ([213.95.11.211]:60443 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbeLLHoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 02:44:22 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 1095568DD2; Wed, 12 Dec 2018 08:44:21 +0100 (CET)
Date:   Wed, 12 Dec 2018 08:44:20 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Miller <davem@davemloft.net>, Christoph Hellwig <hch@lst.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: linux-next: manual merge of the sparc-next tree with the
 dma-mapping tree
Message-ID: <20181212074420.GB29137@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212093042.00fbf6be@canb.auug.org.au>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 09:30:42AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the sparc-next tree got a conflict in:
> 
>   arch/sparc/kernel/ioport.c
> 
> between commit:
> 
>   53b7670e5735 ("sparc: factor the dma coherent mapping into helper")
> 
> from the dma-mapping tree and commit:
> 
>   86ef771ed543 ("sparc: Use DT node full_name instead of name for resources")
> 
> from the sparc-next tree.

Dave, Sam:

should I just apply a version of Rob's tree that takes the refactoring
into account to the dma-mapping tree?  That way we should get the right
result independent of the merge order.
