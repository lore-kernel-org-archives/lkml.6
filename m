Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C713ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E2B220844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiHUzB34"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E2B220844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbeKIGmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 01:42:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:57934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbeKIGmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 01:42:05 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 907A320825;
        Thu,  8 Nov 2018 21:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541711089;
        bh=/SKuWQsx5bGeGWNiguxCR13ecwgZzPntnsKGljmEqTA=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=kiHUzB344ao0U6/5g2urmYWoYMDFt9eHwWAEWyAGIuxLEp+bpFyHU+fgQ9Q6vHrks
         V1Oj5zz1sFOBUsjAqN6b7jk1shOljWkqyOqKXTyZHennQxjgE7wrWxcsDE8p7XZ5+d
         9SwP+3GYbV8Yhpftu7+HtSz2XFNif39C0A9p9MEY=
Date:   Thu, 8 Nov 2018 13:04:49 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Dan Williams <dan.j.williams@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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
        Mark Brown <broonie@kernel.org>
Subject: Re: [patch 2/2] Documentation/process: Add tip tree handbook
Message-ID: <20181108210449.GB22691@kroah.com>
References: <20181107171010.421878737@linutronix.de>
 <20181107171149.165693799@linutronix.de>
 <20181108074012.GD20032@gmail.com>
 <20181108091251.GL9761@hirez.programming.kicks-ass.net>
 <CAPcyv4iCc32VpHA2c8QMRTFy1wGRAmhFQV1xVUiAo2zYKOfJrQ@mail.gmail.com>
 <20181108201425.GF1080@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108201425.GF1080@thunk.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 03:14:25PM -0500, Theodore Y. Ts'o wrote:
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

'sort -V' should help you out here, no need to write anything new :)

> (Also note that even with fast SSD's and/or everything in page cache,
> runnning "tag --contains <COMMITID>" will take a good 3-4 seconds, and
> if the git packs are not in the page cache, and/or you're unfortunate
> enough to have your git trees on an HDD.... it's not pretty.)

I recommend the "static cache" or whatever that thing is called, that
helps out a _LOT_ with stuff like this.  For the kernel tree, which is
never rebased, it speeds up this so much.

thanks,

greg k-h
