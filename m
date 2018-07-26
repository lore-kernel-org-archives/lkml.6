Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA869C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEE3320846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:08:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEE3320846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbeGZKYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 06:24:06 -0400
Received: from verein.lst.de ([213.95.11.211]:35499 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728547AbeGZKYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 06:24:06 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E221B68D64; Thu, 26 Jul 2018 11:11:55 +0200 (CEST)
Date:   Thu, 26 Jul 2018 11:11:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>, hch@lst.de
Subject: Re: [PATCH] ARC: fix broken noncoherent cache ops
Message-ID: <20180726091155.GA24209@lst.de>
References: <20180724141302.4305-1-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724141302.4305-1-Eugeniy.Paltsev@synopsys.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 05:13:02PM +0300, Eugeniy Paltsev wrote:
> All DMA devices on ARC haven't worked with SW cache control
> since commit a8eb92d02dd7 ("arc: fix arc_dma_{map,unmap}_page")
> This happens because we don't check direction argument at all in
> new implementation. Fix that.
> 
> Fixies: commit a8eb92d02dd7 ("arc: fix arc_dma_{map,unmap}_page")
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>

Looks sensible.  Might be worth explaining that ARC can speculate
into the areas under DMA, which is why this is required.
