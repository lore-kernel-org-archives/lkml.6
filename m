Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E109C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 676D72063F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfANPqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 10:46:21 -0500
Received: from mga17.intel.com ([192.55.52.151]:43641 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbfANPqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 10:46:20 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2019 07:46:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,478,1539673200"; 
   d="scan'208";a="311689298"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.154])
  by fmsmga005.fm.intel.com with ESMTP; 14 Jan 2019 07:46:20 -0800
Date:   Mon, 14 Jan 2019 07:46:20 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Adam Borowski <kilobyte@angband.pl>, kvm <kvm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 5.0-rc1 KVM inspired "BUG: Bad page state in process" spew
Message-ID: <20190114154619.GA5141@linux.intel.com>
References: <1547012338.4926.11.camel@gmx.de>
 <20190109144257.erwh52326ucgc5tw@angband.pl>
 <1547046196.31155.1.camel@gmx.de>
 <20190109192637.GA1697@linux.intel.com>
 <1547275382.26908.7.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547275382.26908.7.camel@gmx.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2019 at 07:43:02AM +0100, Mike Galbraith wrote:
> On Wed, 2019-01-09 at 11:26 -0800, Sean Christopherson wrote:
> > 
> > I'll try to bisect.
> 
> Good luck with that.  I gave it a go, but that apparently invalidated
> the warrantee of my vm image :)

This is fixed in v5.0-rc2 by commit ba422731316d ("mm/mmu_notifier:
mm/rmap.c: Fix a mmu_notifier range bug in try_to_unmap_one").

Nested VMs are great for bisecting KVM issues :)
