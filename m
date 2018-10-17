Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AD6ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835D721523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 835D721523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbeJQPOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:14:02 -0400
Received: from verein.lst.de ([213.95.11.211]:56859 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727219AbeJQPOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 11:14:02 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 8354F68C88; Wed, 17 Oct 2018 09:19:42 +0200 (CEST)
Date:   Wed, 17 Oct 2018 09:19:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-media@vger.kernel.org, linux-spi <linux-spi@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] cpufreq: tegra186: don't pass GFP_DMA32 to
 dma_alloc_coherent
Message-ID: <20181017071942.GB23407@lst.de>
References: <20181013151707.32210-1-hch@lst.de> <20181013151707.32210-2-hch@lst.de> <CAJZ5v0ju2Y=yQn9uz6HpYGw5BZovxYh2YbYD7Ujq8kajJfvLSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ju2Y=yQn9uz6HpYGw5BZovxYh2YbYD7Ujq8kajJfvLSQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 09:43:04AM +0200, Rafael J. Wysocki wrote:
> On Sat, Oct 13, 2018 at 5:17 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > The DMA API does its own zone decisions based on the coherent_dma_mask.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Can you pick it up through the cpufreq tree?
