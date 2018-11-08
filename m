Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214A7C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C399D2086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlbdtrCr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C399D2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729998AbeKIILO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:11:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:52882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727203AbeKIILO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 03:11:14 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A35FA20857;
        Thu,  8 Nov 2018 22:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541716414;
        bh=kCYZwCqJkPdxnt5etTeQuXhyYihj0xiOK0Qlsn/PAic=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=WlbdtrCr066REe9EpERoiFz8blYIm2ZwDphnl6i3hvY2pcuPo8Z574dvRSrJqDgxJ
         q04kDWnhNw0lpCr9N/j04s7+d1cM+TiTEqyMkFkF1mWQhGnHvzOyPjuojJ9tLk9W7U
         tsQsR/fHgnJh7L7S0o85QkpR7MWexxSIBcalVrTM=
Date:   Thu, 8 Nov 2018 14:33:29 -0800
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
Message-ID: <20181108223329.GA19357@kroah.com>
References: <20181107171010.421878737@linutronix.de>
 <20181107171149.165693799@linutronix.de>
 <20181108074012.GD20032@gmail.com>
 <20181108091251.GL9761@hirez.programming.kicks-ass.net>
 <CAPcyv4iCc32VpHA2c8QMRTFy1wGRAmhFQV1xVUiAo2zYKOfJrQ@mail.gmail.com>
 <20181108201425.GF1080@thunk.org>
 <20181108210449.GB22691@kroah.com>
 <20181108221947.GJ1080@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108221947.GJ1080@thunk.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 05:19:47PM -0500, Theodore Y. Ts'o wrote:
> On Thu, Nov 08, 2018 at 01:04:49PM -0800, Greg KH wrote:
> > > (Also note that even with fast SSD's and/or everything in page cache,
> > > runnning "tag --contains <COMMITID>" will take a good 3-4 seconds, and
> > > if the git packs are not in the page cache, and/or you're unfortunate
> > > enough to have your git trees on an HDD.... it's not pretty.)
> > 
> > I recommend the "static cache" or whatever that thing is called, that
> > helps out a _LOT_ with stuff like this.  For the kernel tree, which is
> > never rebased, it speeds up this so much.
> 
> At the risk of asking a stupid question, which cache is this?  I don't
> think it's the untrackedCache; is it the BitmapHashCache?

It's the 'commitGraph', here's the article I was trying to remember I
learned this from:
	https://blogs.msdn.microsoft.com/devops/2018/06/25/supercharging-the-git-commit-graph/

greg k-h
