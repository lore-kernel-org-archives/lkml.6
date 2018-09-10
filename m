Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D331BC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F9A206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93F9A206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbeIJSMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:12:51 -0400
Received: from verein.lst.de ([213.95.11.211]:37696 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728597AbeIJSMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:12:51 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 8FFDF68D00; Mon, 10 Sep 2018 15:23:04 +0200 (CEST)
Date:   Mon, 10 Sep 2018 15:23:04 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Meelis Roos <mroos@linux.ee>
Cc:     Linux Kernel list <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org
Subject: Re: 4.19-rc3: IOMMU PT warnings: WARNING: CPU: 0 PID: 1 at
 mm/page_alloc.c:4065 __alloc_pages_slowpath+0xb7b/0xcd0
Message-ID: <20180910132304.GA20244@lst.de>
References: <alpine.LRH.2.21.1809101111040.31938@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.1809101111040.31938@math.ut.ee>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 11:16:12AM +0300, Meelis Roos wrote:
> In 4.19-rc1, I found that to keep Intel integrated graphics working when 
> VT-d is on, I need to have IOMMU passthough on or GPU init would fail 
> with DMAR error and the screen would display static gibberish. So I 
> turned IOMMU PT on by default in kernel config. It worked, also in rc2.
> 
> Now with rc3, it still works but I get some warning splats in dmesg 
> about IOMMU passthrough:

Any chance you could bisect this down to a specific commit?  For
a start it might be worth if it is reproducable with:

   git://git.infradead.org/users/hch/dma-mapping.git dma-mapping-4.19-2

which were the only dma-mapping changes post -rc2.
