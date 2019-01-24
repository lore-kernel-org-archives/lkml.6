Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2789DC282C0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 00:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B64218A1
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 00:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfAXALl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 19:11:41 -0500
Received: from muru.com ([72.249.23.125]:35050 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbfAXALk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 19:11:40 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id C0A4980FA;
        Thu, 24 Jan 2019 00:11:47 +0000 (UTC)
Date:   Wed, 23 Jan 2019 16:11:37 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Martin Sperl <kernel@martin.sperl.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Jon Hunter <jonathanh@nvidia.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org
Subject: Re: Regression in Linux next with SPI pump changes
Message-ID: <20190124001136.GL5720@atomide.com>
References: <20190123215642.GK5720@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123215642.GK5720@atomide.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [190123 21:57]:
> Hi all,
> 
> Commit 412e60373245 ("spi: core: avoid waking pump thread from spi_sync
> instead run teardown delayed") caused a PM regression in Linux next
> where a SPI device (drivers/spi/spi-omap2-mcspi.c) no longer idles
> for PM runtime.
> 
> Looks like this also breaks suspend as reported at [0].

Oh and looks like Jon already also came to the conclusion
that PM runtime is now broken at [1]. Sorry forgot to add
Jon to Cc earlier, added now.

Regards,

Tony


[0] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1899265.html
[1] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1901285.html
