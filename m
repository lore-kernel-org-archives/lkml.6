Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCFDC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B9F20840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22B9F20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbeKIR3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 12:29:19 -0500
Received: from verein.lst.de ([213.95.11.211]:60373 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727789AbeKIR3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 12:29:19 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id F2F1368C48; Fri,  9 Nov 2018 08:49:55 +0100 (CET)
Date:   Fri, 9 Nov 2018 08:49:55 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     John Stultz <john.stultz@linaro.org>
Cc:     hch@lst.de, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        robin.murphy@arm.com, konrad.wilk@oracle.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH 06/10] swiotlb: use swiotlb_map_page in
 swiotlb_map_sg_attrs
Message-ID: <20181109074955.GA27489@lst.de>
References: <20181008080246.20543-1-hch@lst.de> <20181008080246.20543-7-hch@lst.de> <CANcMJZAzrxA9LGNvP-epv2DwsUacEM_hcgA1n5gmaPuWRJG4iw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANcMJZAzrxA9LGNvP-epv2DwsUacEM_hcgA1n5gmaPuWRJG4iw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 05:27:14PM -0800, John Stultz wrote:
> But at that point if I just re-apply "swiotlb: use swiotlb_map_page in
> swiotlb_map_sg_attrs", I reproduce the hangs.
> 
> Any suggestions for how to further debug what might be going wrong
> would be appreciated!

Very odd.  In the end map_sg and map_page are defined to do the same
things to start with.  The only real issue we had in this area was:

"[PATCH v2] of/device: Really only set bus DMA mask when appropriate"

so with current mainline + that you still see a problem, and if you
rever the commit we are replying to it still goes away?
