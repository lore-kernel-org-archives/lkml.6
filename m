Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1061ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D81208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:08:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2D81208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbeGPVhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 17:37:33 -0400
Received: from mga02.intel.com ([134.134.136.20]:60394 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728412AbeGPVhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 17:37:32 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2018 14:08:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,363,1526367600"; 
   d="scan'208";a="75274995"
Received: from theros.lm.intel.com (HELO linux.intel.com) ([10.232.112.164])
  by orsmga002.jf.intel.com with ESMTP; 16 Jul 2018 14:08:20 -0700
Date:   Mon, 16 Jul 2018 15:08:20 -0600
From:   Ross Zwisler <ross.zwisler@linux.intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ross Zwisler <ross.zwisler@linux.intel.com>,
        kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        linux-nvdimm@lists.01.org
Subject: Re: [PATCH 1/5] radix tree test suite: fix mapshift build target
Message-ID: <20180716210820.GA17164@linux.intel.com>
References: <20180503192430.7582-1-ross.zwisler@linux.intel.com>
 <20180503192430.7582-2-ross.zwisler@linux.intel.com>
 <20180715230052.GA6486@bombadil.infradead.org>
 <20180716160710.GA2287@linux.intel.com>
 <20180716195249.GA14380@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716195249.GA14380@bombadil.infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 12:52:49PM -0700, Matthew Wilcox wrote:
> On Mon, Jul 16, 2018 at 10:07:10AM -0600, Ross Zwisler wrote:
<>
> OK ... what version of make are you using?  Because this works fine for me:
> 
> $ git clone linux clean
> $ cd clean
> $ git checkout v4.17
> $ cd tools/testing/radix-tree/ 
> $ git revert 8d9fa88edd5e360b71765feeadb915d4066c9684
> $ make
> 
> $ make --version
> GNU Make 4.1
> Built for x86_64-pc-linux-gnu
> 
> It's Debian's Version: 4.1-9.1

$ make --version
GNU Make 4.2.1
Built for x86_64-redhat-linux-gnu

The one from Fedora 27.

> > If you want generated/map-shift.h to be rebuilt each time you run 'make' so
> > that it can take a new SHIFT argument, that's fine, but let's not make users
> > run 'make mapshift' before an actual 'make' will work, which is where we're at
> > with v4.17 with my commit reverted.
> 
> I don't want it to be rebuilt, I want it to be checked before each
> build, regenerated if SHIFT has changed, and everything to rebuild if
> it has changed.

Sure, sounds good.
