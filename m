Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84817C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4892420846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:09:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4892420846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbeGZKZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 06:25:35 -0400
Received: from verein.lst.de ([213.95.11.211]:35506 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727951AbeGZKZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 06:25:34 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id AD97668D64; Thu, 26 Jul 2018 11:13:23 +0200 (CEST)
Date:   Thu, 26 Jul 2018 11:13:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>, hch@lst.de
Subject: Re: [PATCH 2/4] ARC: allow to use IOC and non-IOC DMA devices
        simultaneously
Message-ID: <20180726091323.GB24209@lst.de>
References: <20180724101001.31965-1-Eugeniy.Paltsev@synopsys.com> <20180724101001.31965-3-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724101001.31965-3-Eugeniy.Paltsev@synopsys.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  	select DMA_NONCOHERENT_OPS
> +	select DMA_DIRECT_OPS

DMA_NONCOHERENT_OPS already selects DMA_DIRECT_OPS.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
