Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04ADAC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7DE3222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731972AbfBLSjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:39:47 -0500
Received: from muru.com ([72.249.23.125]:38264 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727469AbfBLSjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:39:47 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id CC74F803A;
        Tue, 12 Feb 2019 18:39:55 +0000 (UTC)
Date:   Tue, 12 Feb 2019 10:39:43 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ben Dooks <ben-linux@fluff.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/14] mmc: omap: handle highmem pages
Message-ID: <20190212183943.GM5720@atomide.com>
References: <20190212072528.13167-1-hch@lst.de>
 <20190212072528.13167-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212072528.13167-7-hch@lst.de>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Christoph Hellwig <hch@lst.de> [190212 07:27]:
> Instead of setting up a kernel pointer to track the current PIO address,
> track the offset in the current page, and do an atomic kmap for the page
> while doing the actual PIO operations.

I'm currently having issues booting my test devices (770 and n8x0)
with this MMC controller so I can't test these patches currently.
Aaro, can you please test when you have a chance?

Regards,

Tony
