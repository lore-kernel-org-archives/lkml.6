Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CACC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA05205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbfAQQs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:48:56 -0500
Received: from mga17.intel.com ([192.55.52.151]:11152 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728980AbfAQQsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:48:51 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2019 08:48:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,489,1539673200"; 
   d="scan'208";a="119296606"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga003.jf.intel.com with ESMTP; 17 Jan 2019 08:48:49 -0800
Date:   Thu, 17 Jan 2019 09:47:37 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, thomas.lendacky@amd.com,
        fengguang.wu@intel.com, dave@sr71.net, linux-nvdimm@lists.01.org,
        tiwai@suse.de, zwisler@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhocko@suse.com,
        baiyaowei@cmss.chinamobile.com, ying.huang@intel.com,
        bhelgaas@google.com, akpm@linux-foundation.org, bp@suse.de
Subject: Re: [PATCH 0/4] Allow persistent memory to be used like normal RAM
Message-ID: <20190117164736.GC31543@localhost.localdomain>
References: <20190116181859.D1504459@viggo.jf.intel.com>
 <x49sgxr9rjd.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x49sgxr9rjd.fsf@segfault.boston.devel.redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 11:29:10AM -0500, Jeff Moyer wrote:
> Dave Hansen <dave.hansen@linux.intel.com> writes:
> > Persistent memory is cool.  But, currently, you have to rewrite
> > your applications to use it.  Wouldn't it be cool if you could
> > just have it show up in your system like normal RAM and get to
> > it like a slow blob of memory?  Well... have I got the patch
> > series for you!
> 
> So, isn't that what memory mode is for?
>   https://itpeernetwork.intel.com/intel-optane-dc-persistent-memory-operating-modes/
> 
> Why do we need this code in the kernel?

I don't think those are the same thing. The "memory mode" in the link
refers to platforms that sequester DRAM to side cache memory access, where
this series doesn't have that platform dependency nor hides faster DRAM.
