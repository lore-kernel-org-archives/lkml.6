Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E27C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE2A20811
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfBEOjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 09:39:41 -0500
Received: from mga05.intel.com ([192.55.52.43]:9637 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfBEOjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 09:39:40 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2019 06:39:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,564,1539673200"; 
   d="scan'208";a="297418131"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga005.jf.intel.com with ESMTP; 05 Feb 2019 06:39:39 -0800
Date:   Tue, 5 Feb 2019 07:39:06 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Takao Indoh <indou.takao@fujitsu.com>
Cc:     Takao Indoh <indou.takao@jp.fujitsu.com>, axboe@fb.com, hch@lst.de,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Enable acceleration feature of A64FX processor
Message-ID: <20190205143905.GG22199@localhost.localdomain>
References: <20190201124615.16107-1-indou.takao@jp.fujitsu.com>
 <20190201145414.GA22199@localhost.localdomain>
 <20190205124757.GA28465@esprimo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205124757.GA28465@esprimo>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 09:56:05PM +0900, Takao Indoh wrote:
> On Fri, Feb 01, 2019 at 07:54:14AM -0700, Keith Busch wrote:
> > On Fri, Feb 01, 2019 at 09:46:15PM +0900, Takao Indoh wrote:
> > > From: Takao Indoh <indou.takao@fujitsu.com>
> > > 
> > > Fujitsu A64FX processor has a feature to accelerate data transfer of
> > > internal bus by relaxed ordering. It is enabled when the bit 56 of dma
> > > address is set to 1.
> > 
> > Wait, what? RO is a standard PCIe TLP attribute. Why would we need this?
> 
> I should have explained this patch more carefully.
> 
> Standard PCIe devices can use Relaxed Ordering (RO) by setting Attr
> field in the TLP header, however, this mechanism cannot be utilized if
> the device does not support RO feature. Fujitsu A64FX processor has an
> alternate feature to enable RO in its Root Port by setting the bit 56 of
> DMA address. This mechanism enables to utilize RO feature even if the
> device does not support standard PCIe RO.

I think you're better of just purchasing devices that support the
capability per spec rather than with a non-standard work around.
