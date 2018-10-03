Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88E6C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89EB02064A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89EB02064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbeJCSnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 14:43:46 -0400
Received: from mga09.intel.com ([134.134.136.24]:48578 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbeJCSnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 14:43:46 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2018 04:55:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,335,1534834800"; 
   d="scan'208";a="269126870"
Received: from raj-desk2.iind.intel.com ([10.223.107.30])
  by fmsmga006.fm.intel.com with ESMTP; 03 Oct 2018 04:55:38 -0700
Date:   Wed, 3 Oct 2018 17:15:50 +0530
From:   Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
To:     Joe Perches <joe@perches.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: Bad MAINTAINERS pattern in section 'INTEL PMC CORE DRIVER'
Message-ID: <20181003114549.GA11877@raj-desk2.iind.intel.com>
References: <20180928215339.29516-1-joe@perches.com>
 <CAHp75Ve-LfScEuYg6Luzy4Sekatm3qVbr3wsQAJVR-YUN-10Ww@mail.gmail.com>
 <c505fe842c58abd6f91e0dba3dd552ce01e4ea39.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c505fe842c58abd6f91e0dba3dd552ce01e4ea39.camel@perches.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 03:10:58AM -0700, Joe Perches wrote:
> On Wed, 2018-10-03 at 11:00 +0300, Andy Shevchenko wrote:
> > On Sat, Sep 29, 2018 at 12:54 AM Joe Perches <joe@perches.com> wrote:
> > > Please fix this defect appropriately.
> > > 
> > > linux-next MAINTAINERS section:
> > > 
> > >         7441    INTEL PMC CORE DRIVER
> > >         7442    M:      Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
> > >         7443    M:      Vishwanath Somayaji <vishwanath.somayaji@intel.com>
> > >         7444    L:      platform-driver-x86@vger.kernel.org
> > >         7445    S:      Maintained
> > > -->     7446    F:      arch/x86/include/asm/pmc_core.h
> > >         7447    F:      drivers/platform/x86/intel_pmc_core*
> > > 
> > > Commit that introduced this:
> > 
> > This is strange the shuffle of the MAINTAINERS based on the script is
> > a culprit of the above inconsistency.
> > 
> > Btw, I run parse-maintainers.pl against it and there are a lot more
> > "unsorted" lines.
> > What Linus or me or both did miss?
> 
> Nothing really.
> 
> The script used git-blame on the specific line, that's all.

Thanks for reporting this. I have sent the fix to the list.
https://lkml.org/lkml/2018/10/3/500.

> 
> There is no simple way to actually find a specific
> commit that adds a particular line to a file if there is
> any refactoring done to the file after it was added.
> 
> commit b740d2e9233cb33626d3b62210bcfc6a34baa839
> Author: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
> Date:   Thu May 26 14:41:19 2016 +0530
> 
>     platform/x86: Add PMC Driver for Intel Core SoC
> 
> Anyway, the real cause of the file pattern being unused
> was also written below:
> 
> > > Last commit with arch/x86/include/asm/pmc_core.h
> > > 
> > > commit 941691ef2197944a202d7870dcd7da3fb0391c65
> > > Author: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
> > > Date:   Wed Jan 31 11:50:22 2018 +0530
> > > 
> > >     platform/x86: intel_pmc_core: Remove unused header file
> > > 
> > >     Recently sent patch 'platform/x86: intel_pmc_core: Remove unused EXPORTED
> > >     API' missed to remove the header file 'arch/x86/include/asm/pmc_core.h'
> > >     which was solely used to declare the EXPORTED API
> > >     'intel_pmc_slp_s0_counter_read'. This patch provides the errata fix for the
> > >     same.
> > > 
> > >     Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
> > >     Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > 
> > >  arch/x86/include/asm/pmc_core.h       | 27 ---------------------------
> > >  drivers/platform/x86/intel_pmc_core.c |  1 -
> > >  2 files changed, 28 deletions(-)
> 
> 
> > 
> 

-- 
Best Regards,
Rajneesh
