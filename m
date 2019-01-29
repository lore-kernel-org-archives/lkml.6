Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45054C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17BA920881
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbfA2Xq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 18:46:28 -0500
Received: from mga04.intel.com ([192.55.52.120]:21223 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727342AbfA2Xq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 18:46:28 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 15:46:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,538,1539673200"; 
   d="scan'208";a="129970889"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by orsmga002.jf.intel.com with ESMTP; 29 Jan 2019 15:46:26 -0800
Date:   Tue, 29 Jan 2019 15:46:26 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@suse.de>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Babu Moger <babu.moger@amd.com>, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH] x86: avoid confusion over the new RESCTRL config prompt
Message-ID: <20190129234625.GA29438@agluck-desk>
References: <20190129225218.15441-1-hannes@cmpxchg.org>
 <20190129230845.GG28773@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129230845.GG28773@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 12:08:45AM +0100, Borislav Petkov wrote:
> On Tue, Jan 29, 2019 at 05:52:18PM -0500, Johannes Weiner wrote:
> >  config X86_RESCTRL
> > -	bool "Resource Control support"
> > +	bool "x86 cache control support"
> 
> Except that it is not only cache but memory (bandwidth) control too. So I guess
> 
> 	bool "CPU Resource Control support"
> 
> or so.
> 
> Let the bikeshedding begin!

I'll just jump on the bandwagon and vote for "CPU Resource Control support".

You are exactly right that this isn't just about cache.

-Tony
