Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CAFC43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E1720857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:38:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E1720857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbeKIIQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:16:28 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:45448 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbeKIIQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 03:16:27 -0500
Received: from p4fea46ac.dip0.t-ipconnect.de ([79.234.70.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gKswd-0006n5-38; Thu, 08 Nov 2018 23:38:35 +0100
Date:   Thu, 8 Nov 2018 23:38:33 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, John Stultz <john.stultz@linaro.org>,
        acme@redhat.com, frederic@kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Lutomirski <luto@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [patch 2/2] Documentation/process: Add tip tree handbook
In-Reply-To: <20181108210615.GC22691@kroah.com>
Message-ID: <alpine.DEB.2.21.1811082213300.1640@nanos.tec.linutronix.de>
References: <20181107171010.421878737@linutronix.de> <20181107171149.165693799@linutronix.de> <20181108074012.GD20032@gmail.com> <20181108091251.GL9761@hirez.programming.kicks-ass.net> <CAPcyv4iCc32VpHA2c8QMRTFy1wGRAmhFQV1xVUiAo2zYKOfJrQ@mail.gmail.com>
 <20181108174006.GP4170@linux.ibm.com> <alpine.DEB.2.21.1811082042001.1640@nanos.tec.linutronix.de> <20181108210615.GC22691@kroah.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Nov 2018, Greg KH wrote:
> On Thu, Nov 08, 2018 at 08:58:32PM +0100, Thomas Gleixner wrote:
> >     Fixes: 1234567890AB ("subsys/comp: Short summary")
> >     Backport-to: 4.14
> 
> Ick, no.  Just stick to the "Fixes:" tag.  My scripts can now track when
> a patch is backported to a stable tree so that I know to apply it to
> older ones despite the original patch showing up in a newer release.

Fine with me.

I just did a few stats.

commits between 4.19-rc1 and 4.19-final:

Total commits:				2098

Total Cc: stable		         334
Cc: stable             			 119	35%
Cc: stable       #kver 		 	  10     3%
Cc: stable	       Revert		   0	 0%
Cc: stable Fixes       		   	 123    37%
Cc: stable Fixes #kver		 	  81    24%

Total      Fixes only  	       		 584
	   Fixes only >  4.18	   	 227    39%
	   Fixes only <= 4.18		 357    61%

and between 4.19 and todays top of tree:

Total commits:			       12947

Total Cc: stable		         251
Cc: stable             			  85    34%
Cc: stable       #kver 		 	  28    11%
Cc: stable	       reverts		   2     1%
Cc: stable Fixes       		   	  79    31%
Cc: stable Fixes #kver		 	  55    22%

Total      Fixes only  	       		 835
	   Fixes only >  4.19	   	 830    99%
	   Fixes only <= 4.19		   5     1%

Not much change in the 'cc stable' ratio for those without any information
and for those with Fixes tag and #kver.

The cc stable + kver and the cc stable + Fixes differ, but their sum is
roughly the same.

But the real interesting change is that between 4.19-rc1 and 4.19-final the
number of Fixes only (no CC stable) commits which fix a commit in 4.18 or
earlier is rather high, while the same category on post 4.19 is minimal.

I'll run a larger and more detailed scan to figure out whether there is a
trend or this is just random.

Thanks,

	tglx


