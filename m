Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D7EC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D8CF21872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730609AbfBAQKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 11:10:00 -0500
Received: from verein.lst.de ([213.95.11.211]:35628 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbfBAQJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 11:09:59 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 2C19A68D93; Fri,  1 Feb 2019 17:09:57 +0100 (CET)
Date:   Fri, 1 Feb 2019 17:09:57 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, John Crispin <john@phrozen.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Felipe Balbi <balbi@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org,
        iommu@lists.linux-foundation.org
Subject: Re: [alsa-devel] don't pass a NULL struct device to DMA API
 functions
Message-ID: <20190201160957.GD6532@lst.de>
References: <20190201084801.10983-1-hch@lst.de> <s5ho97v8x9j.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5ho97v8x9j.wl-tiwai@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 02:16:08PM +0100, Takashi Iwai wrote:
> Actually there are a bunch of ISA sound drivers that still call
> allocators with NULL device.
> 
> The patch below should address it, although it's only compile-tested.

Oh, I missed these "indirect" calls.  This looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
