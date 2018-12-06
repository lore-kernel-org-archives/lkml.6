Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA057C04EBF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8092E20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8092E20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbeLFBbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 20:31:01 -0500
Received: from muru.com ([72.249.23.125]:56530 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727514AbeLFBa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 20:30:58 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 0ECF0803A;
        Thu,  6 Dec 2018 01:30:59 +0000 (UTC)
Date:   Wed, 5 Dec 2018 17:30:54 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Tony Battersby <tonyb@cybernetics.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        John Garry <john.garry@huawei.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org
Subject: dmapool regression in next
Message-ID: <20181206013054.GI6707@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Looks like with commit 26abe88e830d ("mm/dmapool.c: improve scalability
of dma_pool_free()") I'm now getting spammed with lots of "(bad vaddr)"
on at least omap4 pandaboard, see below.

Any ideas what might be going wrong?

Regards,

Tony

8< ---------------------
omap-dma-engine 4a056000.dma-controller: dma_pool_free 4a056000.dma-controller, (ptrval) (bad vaddr)/0xbe800000
omap-dma-engine 4a056000.dma-controller: dma_pool_free 4a056000.dma-controller, (ptrval) (bad vaddr)/0xbe80001c
omap-dma-engine 4a056000.dma-controller: dma_pool_free 4a056000.dma-controller, (ptrval) (bad vaddr)/0xbe800038
...
