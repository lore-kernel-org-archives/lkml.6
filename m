Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00C2C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 10:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8283920835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 10:11:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8283920835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbeJCQ6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 12:58:45 -0400
Received: from smtprelay0005.hostedemail.com ([216.40.44.5]:59451 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725951AbeJCQ6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 12:58:45 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 949B32C93;
        Wed,  3 Oct 2018 10:11:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: loss66_42fb5ca07bd18
X-Filterd-Recvd-Size: 3526
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Wed,  3 Oct 2018 10:11:00 +0000 (UTC)
Message-ID: <c505fe842c58abd6f91e0dba3dd552ce01e4ea39.camel@perches.com>
Subject: Re: Bad MAINTAINERS pattern in section 'INTEL PMC CORE DRIVER'
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Wed, 03 Oct 2018 03:10:58 -0700
In-Reply-To: <CAHp75Ve-LfScEuYg6Luzy4Sekatm3qVbr3wsQAJVR-YUN-10Ww@mail.gmail.com>
References: <20180928215339.29516-1-joe@perches.com>
         <CAHp75Ve-LfScEuYg6Luzy4Sekatm3qVbr3wsQAJVR-YUN-10Ww@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-10-03 at 11:00 +0300, Andy Shevchenko wrote:
> On Sat, Sep 29, 2018 at 12:54 AM Joe Perches <joe@perches.com> wrote:
> > Please fix this defect appropriately.
> > 
> > linux-next MAINTAINERS section:
> > 
> >         7441    INTEL PMC CORE DRIVER
> >         7442    M:      Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
> >         7443    M:      Vishwanath Somayaji <vishwanath.somayaji@intel.com>
> >         7444    L:      platform-driver-x86@vger.kernel.org
> >         7445    S:      Maintained
> > -->     7446    F:      arch/x86/include/asm/pmc_core.h
> >         7447    F:      drivers/platform/x86/intel_pmc_core*
> > 
> > Commit that introduced this:
> 
> This is strange the shuffle of the MAINTAINERS based on the script is
> a culprit of the above inconsistency.
> 
> Btw, I run parse-maintainers.pl against it and there are a lot more
> "unsorted" lines.
> What Linus or me or both did miss?

Nothing really.

The script used git-blame on the specific line, that's all.

There is no simple way to actually find a specific
commit that adds a particular line to a file if there is
any refactoring done to the file after it was added.

commit b740d2e9233cb33626d3b62210bcfc6a34baa839
Author: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
Date:   Thu May 26 14:41:19 2016 +0530

    platform/x86: Add PMC Driver for Intel Core SoC

Anyway, the real cause of the file pattern being unused
was also written below:

> > Last commit with arch/x86/include/asm/pmc_core.h
> > 
> > commit 941691ef2197944a202d7870dcd7da3fb0391c65
> > Author: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
> > Date:   Wed Jan 31 11:50:22 2018 +0530
> > 
> >     platform/x86: intel_pmc_core: Remove unused header file
> > 
> >     Recently sent patch 'platform/x86: intel_pmc_core: Remove unused EXPORTED
> >     API' missed to remove the header file 'arch/x86/include/asm/pmc_core.h'
> >     which was solely used to declare the EXPORTED API
> >     'intel_pmc_slp_s0_counter_read'. This patch provides the errata fix for the
> >     same.
> > 
> >     Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
> >     Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> >  arch/x86/include/asm/pmc_core.h       | 27 ---------------------------
> >  drivers/platform/x86/intel_pmc_core.c |  1 -
> >  2 files changed, 28 deletions(-)


> 

