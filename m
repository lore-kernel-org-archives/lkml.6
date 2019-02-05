Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9350CC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69D8520844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbfBEQNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 11:13:50 -0500
Received: from verein.lst.de ([213.95.11.211]:54978 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728574AbfBEQNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 11:13:49 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id CC15C68D93; Tue,  5 Feb 2019 17:13:47 +0100 (CET)
Date:   Tue, 5 Feb 2019 17:13:47 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <keith.busch@intel.com>
Cc:     Takao Indoh <indou.takao@fujitsu.com>,
        Takao Indoh <indou.takao@jp.fujitsu.com>, axboe@fb.com,
        hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Enable acceleration feature of A64FX processor
Message-ID: <20190205161347.GA847@lst.de>
References: <20190201124615.16107-1-indou.takao@jp.fujitsu.com> <20190201145414.GA22199@localhost.localdomain> <20190205124757.GA28465@esprimo> <20190205143905.GG22199@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205143905.GG22199@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 07:39:06AM -0700, Keith Busch wrote:
> > Standard PCIe devices can use Relaxed Ordering (RO) by setting Attr
> > field in the TLP header, however, this mechanism cannot be utilized if
> > the device does not support RO feature. Fujitsu A64FX processor has an
> > alternate feature to enable RO in its Root Port by setting the bit 56 of
> > DMA address. This mechanism enables to utilize RO feature even if the
> > device does not support standard PCIe RO.
> 
> I think you're better of just purchasing devices that support the
> capability per spec rather than with a non-standard work around.

Agreed, this seems like a pretty gross hack.
