Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF6BC0044B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C75F620892
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="LpUlIYwt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C75F620892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731645AbeKIH5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:57:47 -0500
Received: from imap.thunk.org ([74.207.234.97]:57216 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728473AbeKIH5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:57:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=XKH6YiJaZqayXgHcy/bwtS0zJABlCqn/xMsfief3KdM=; b=LpUlIYwt2wPbxDmXOGTBYrVfOa
        2cfeAOQCByN5E15+/j5yVYt7uSjJ32BjEYQBZP5P2bh9gCMVbS0sKLifuma2Op9BLkd3mQWPBmrCO
        M8paFG3rXdEiw7qlveUjyzqtUTai377FZoshANBaHHTvcoDU0K6Bjz8dEE2h7OPK9BnA=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gKseS-0002Wq-M2; Thu, 08 Nov 2018 22:19:48 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 90C2A7A7D24; Thu,  8 Nov 2018 17:19:47 -0500 (EST)
Date:   Thu, 8 Nov 2018 17:19:47 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
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
Message-ID: <20181108221947.GJ1080@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>,
        John Stultz <john.stultz@linaro.org>, acme@redhat.com,
        frederic@kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Andy Lutomirski <luto@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>, Mark Brown <broonie@kernel.org>
References: <20181107171010.421878737@linutronix.de>
 <20181107171149.165693799@linutronix.de>
 <20181108074012.GD20032@gmail.com>
 <20181108091251.GL9761@hirez.programming.kicks-ass.net>
 <CAPcyv4iCc32VpHA2c8QMRTFy1wGRAmhFQV1xVUiAo2zYKOfJrQ@mail.gmail.com>
 <20181108201425.GF1080@thunk.org>
 <20181108210449.GB22691@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108210449.GB22691@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 01:04:49PM -0800, Greg KH wrote:
> > (Also note that even with fast SSD's and/or everything in page cache,
> > runnning "tag --contains <COMMITID>" will take a good 3-4 seconds, and
> > if the git packs are not in the page cache, and/or you're unfortunate
> > enough to have your git trees on an HDD.... it's not pretty.)
> 
> I recommend the "static cache" or whatever that thing is called, that
> helps out a _LOT_ with stuff like this.  For the kernel tree, which is
> never rebased, it speeds up this so much.

At the risk of asking a stupid question, which cache is this?  I don't
think it's the untrackedCache; is it the BitmapHashCache?

Thanks,

      	       		       	     - Ted
