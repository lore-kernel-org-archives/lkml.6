Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF79C6786F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 03:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F05F22081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 03:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F05F22081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbeKBMhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 08:37:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:10531 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbeKBMhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 08:37:24 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2018 20:31:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,454,1534834800"; 
   d="scan'208";a="82810956"
Received: from shbuild888.sh.intel.com (HELO localhost) ([10.239.146.239])
  by fmsmga007.fm.intel.com with ESMTP; 01 Nov 2018 20:31:45 -0700
Date:   Fri, 2 Nov 2018 11:38:13 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel test robot <rong.a.chen@intel.com>,
        H Peter Anvin <hpa@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Yinghai Lu <yinghai@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andy Lutomirsky <luto@kernel.org>
Subject: Re: [PATCH 4.9 23/35] x86/mm: Expand static page table for fixmap
 space
Message-ID: <20181102033813.mxauelisrform7ah@shbuild888>
References: <20181011152520.174949126@linuxfoundation.org>
 <20181011152521.098965859@linuxfoundation.org>
 <5d134c818828ddecf1ab9768b126c15c267c099e.camel@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d134c818828ddecf1ab9768b126c15c267c099e.camel@decadent.org.uk>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

On Thu, Nov 01, 2018 at 10:25:43PM +0000, Ben Hutchings wrote:
> On Thu, 2018-10-11 at 17:35 +0200, Greg Kroah-Hartman wrote:
> > 4.9-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Feng Tang <feng.tang@intel.com>
> > 
> > commit 05ab1d8a4b36ee912b7087c6da127439ed0a903e upstream.
> 
> This backport is incorrect.  The part that updated __startup_64() in
> arch/x86/kernel/head64.c was dropped, presumably because that function
> doesn't exist in 4.9.  However that seems to be an essential of the
> fix.  In 4.9 the startup_64 routine in arch/x86/kernel/head_64.S would
> need to be changed instead.
> 
> I also found that this introduces new boot-time warnings on some
> systems if CONFIG_DEBUG_WX is enabled.
> 
> So, unless someone provides fixes for those issues, I think this should
> be reverted for the 4.9 branch.

Thanks for the catch, I'm fine with the revert for now.

- Feng

