Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F403ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F045420840
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:22:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F045420840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbeKIF76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 00:59:58 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:45196 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbeKIF76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 00:59:58 -0500
Received: from p4fea46ac.dip0.t-ipconnect.de ([79.234.70.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gKqpB-0000tv-Eo; Thu, 08 Nov 2018 21:22:45 +0100
Date:   Thu, 8 Nov 2018 21:22:44 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
cc:     Dan Williams <dan.j.williams@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        John Stultz <john.stultz@linaro.org>, acme@redhat.com,
        frederic@kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Andy Lutomirski <luto@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [patch 2/2] Documentation/process: Add tip tree handbook
In-Reply-To: <20181108201425.GF1080@thunk.org>
Message-ID: <alpine.DEB.2.21.1811082119500.1640@nanos.tec.linutronix.de>
References: <20181107171010.421878737@linutronix.de> <20181107171149.165693799@linutronix.de> <20181108074012.GD20032@gmail.com> <20181108091251.GL9761@hirez.programming.kicks-ass.net> <CAPcyv4iCc32VpHA2c8QMRTFy1wGRAmhFQV1xVUiAo2zYKOfJrQ@mail.gmail.com>
 <20181108201425.GF1080@thunk.org>
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

On Thu, 8 Nov 2018, Theodore Y. Ts'o wrote:

> On Thu, Nov 08, 2018 at 09:19:33AM -0800, Dan Williams wrote:
> > 
> > I know at least StGit mail does not grok that "#"notation. I've
> > stopped using it in favor of a "Fixes:" tag. I would think "Fixes:" is
> > preferred over "# <KVER>" if only because it can be used to track
> > fixes to commits that have been backported to stable. Is there any
> > reason for "# <KVER>" to continue in a world where we have "Fixes:"?
> 
> The main annoyance I have with Fixes is because it can be a pain to
> figure out what the "# <KVER>" would be.  Something like:
> 
> % tag --contains DEADBEEF | grep ^v | head
> 
> doesn't work because kernel version numbers don't sort obviously.  So
> v4.10 comes before v4.3 using a normal sort, and even sort -n doesn't
> do the right.
> 
> I suppose it wouldn't be that hard to write a perl/python script that
> correctly sorts kernel version numbers, but when the "# <KVER>" is
> present, I find it convenient.
> 
> (Also note that even with fast SSD's and/or everything in page cache,
> runnning "tag --contains <COMMITID>" will take a good 3-4 seconds, and
> if the git packs are not in the page cache, and/or you're unfortunate
> enough to have your git trees on an HDD.... it's not pretty.)

Fair enough. But as I said before we please let us have both the fixes tag
and a decicated backport-to one and make the latter mandatory.

It if's not there and the patch has a 'Cc: stable' tag it's easy enough to
reject it. The the submitter or the maintainer who decides that a patch
needs to be backported to stable has to wait the 4 seconds and add that
information.

Thanks,

	tglx


