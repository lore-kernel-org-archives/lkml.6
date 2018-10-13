Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047F2C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 16:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF8342054F
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 16:35:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF8342054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbeJNANc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 20:13:32 -0400
Received: from verein.lst.de ([213.95.11.211]:58171 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbeJNANb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 20:13:31 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id CB63268C73; Sat, 13 Oct 2018 18:35:40 +0200 (CEST)
Date:   Sat, 13 Oct 2018 18:35:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH 4/8] sound: hpios: don't pass GFP_DMA32 to
 dma_alloc_coherent
Message-ID: <20181013163540.GA2947@lst.de>
References: <20181013151707.32210-1-hch@lst.de> <20181013151707.32210-5-hch@lst.de> <s5hpnwdn7l7.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hpnwdn7l7.wl-tiwai@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2018 at 06:18:28PM +0200, Takashi Iwai wrote:
> On Sat, 13 Oct 2018 17:17:03 +0200,
> Christoph Hellwig wrote:
> > 
> > The DMA API does its own zone decisions based on the coherent_dma_mask.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Reviewed-by: Takashi Iwai <tiwai@suse.de>
> 
> 
> Would you like to take this as a series, or shall I take individually
> through sound tree?

There is nothing that depends on this, so feel free to apply the
two sound patches to your tree.
