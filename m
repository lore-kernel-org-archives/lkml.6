Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D439ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42F6520827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="ppCDR9l2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42F6520827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbeKIFvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 00:51:48 -0500
Received: from imap.thunk.org ([74.207.234.97]:56020 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbeKIFvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 00:51:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=5Be86NfBtN3/IbrIVSh8nLs7qpAwiNwYTp6Mp36nmXc=; b=ppCDR9l20iI43JOpCvEpzLu0Ug
        N7GNTeyIALFTQIkqAzkXwGBXpMOJaqwTPhmsLp2tRZ4haJBzG0bABbFsK/vobXduOXPWDbXhbOno+
        muuHF1RZw+CNdUkAjpYrI8ec8MQ9kiaTc4ma9ZZlJhc/rE4RLprUNi6IPV1VG9QTTmQg=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gKqh8-000156-2N; Thu, 08 Nov 2018 20:14:26 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 1702C7A7D24; Thu,  8 Nov 2018 15:14:25 -0500 (EST)
Date:   Thu, 8 Nov 2018 15:14:25 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
        Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [patch 2/2] Documentation/process: Add tip tree handbook
Message-ID: <20181108201425.GF1080@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
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
        Will Deacon <will.deacon@arm.com>, Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
References: <20181107171010.421878737@linutronix.de>
 <20181107171149.165693799@linutronix.de>
 <20181108074012.GD20032@gmail.com>
 <20181108091251.GL9761@hirez.programming.kicks-ass.net>
 <CAPcyv4iCc32VpHA2c8QMRTFy1wGRAmhFQV1xVUiAo2zYKOfJrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iCc32VpHA2c8QMRTFy1wGRAmhFQV1xVUiAo2zYKOfJrQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 09:19:33AM -0800, Dan Williams wrote:
> 
> I know at least StGit mail does not grok that "#"notation. I've
> stopped using it in favor of a "Fixes:" tag. I would think "Fixes:" is
> preferred over "# <KVER>" if only because it can be used to track
> fixes to commits that have been backported to stable. Is there any
> reason for "# <KVER>" to continue in a world where we have "Fixes:"?

The main annoyance I have with Fixes is because it can be a pain to
figure out what the "# <KVER>" would be.  Something like:

% tag --contains DEADBEEF | grep ^v | head

doesn't work because kernel version numbers don't sort obviously.  So
v4.10 comes before v4.3 using a normal sort, and even sort -n doesn't
do the right.

I suppose it wouldn't be that hard to write a perl/python script that
correctly sorts kernel version numbers, but when the "# <KVER>" is
present, I find it convenient.

(Also note that even with fast SSD's and/or everything in page cache,
runnning "tag --contains <COMMITID>" will take a good 3-4 seconds, and
if the git packs are not in the page cache, and/or you're unfortunate
enough to have your git trees on an HDD.... it's not pretty.)

      	       	    			    	     - Ted
