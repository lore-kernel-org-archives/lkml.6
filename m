Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B1B31C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6769C208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:17:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6769C208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754982AbeFNMR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 08:17:26 -0400
Received: from verein.lst.de ([213.95.11.211]:46061 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754729AbeFNMRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 08:17:25 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E410268C4E; Thu, 14 Jun 2018 14:25:45 +0200 (CEST)
Date:   Thu, 14 Jun 2018 14:25:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] dma-mapping: move all DMA mapping code to
        kernel/dma
Message-ID: <20180614122545.GA27818@lst.de>
References: <20180614120029.27315-1-hch@lst.de> <20180614120029.27315-3-hch@lst.de> <CAHp75Vcpmx=GLU087Et+LA0_LOCF-xu1beKzb4iLxoOOi91Qmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vcpmx=GLU087Et+LA0_LOCF-xu1beKzb4iLxoOOi91Qmg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 03:13:46PM +0300, Andy Shevchenko wrote:
> For my point of view, makes sense!
> 
> > +config HAS_DMA
> > +       bool
> > +       depends on !NO_DMA
> > +       default y
> 
> I see it's just move from other file, though we might switch to
>   def_bool y
> instead of two lines.

Makes sense, but I'd rather send it together with a bunch of other
cleanups in that area for the 4.19 merge window.
