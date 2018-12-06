Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D07FC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7077A20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:45:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7077A20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbeLFSpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:45:35 -0500
Received: from verein.lst.de ([213.95.11.211]:58885 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbeLFSpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:45:35 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 51C2868AA6; Thu,  6 Dec 2018 19:45:33 +0100 (CET)
Date:   Thu, 6 Dec 2018 19:45:33 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC] avoid indirect calls for DMA direct mappings
Message-ID: <20181206184533.GC30039@lst.de>
References: <20181206153720.10702-1-hch@lst.de> <20181206184351.4d9ece54@redhat.com> <A9F9D621-445E-4F3C-95FE-3963A3DAEF98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A9F9D621-445E-4F3C-95FE-3963A3DAEF98@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 10:29:35AM -0800, Nadav Amit wrote:
> Did you happen to see my RFC for "automatic" indirect call promotion? 
> 
> 	https://lkml.org/lkml/2018/10/18/175
> 
> I hope to get v1 based on Josh responses next week.

I'll take a look when you repost it.  Although I'm always a little vary
of under the hood magic like this..
