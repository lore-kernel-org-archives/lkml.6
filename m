Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D72C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9016208A3
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2Mm19Tf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9016208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbeKHUk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 15:40:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:39902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbeKHUk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 15:40:29 -0500
Received: from localhost (71-6-98-120.static-ip.telepacific.net [71.6.98.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CA8A2089F;
        Thu,  8 Nov 2018 11:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541675132;
        bh=Znp/LEmgA3/s9B3uvNp4K/yYGJcCHNlI1cYAJPqfK0s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X2Mm19TfvqOQmNRqXCEeGPfcMZdkQboMcaZW7wnSFUy0t0Tcwk/m746xRlO9bhzHt
         eaX/5pSerfAx9gCrKO6bf1+DPIpU63Ka00a/K1Otz8gbcBoi8pNhpeJV4WCfozSG+h
         yA7aiJk24BFuiDcxByq8dZy2getix1Gd2Rx+ly6Q=
Date:   Thu, 8 Nov 2018 03:05:32 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        John Stultz <john.stultz@linaro.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Lutomirski <luto@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [patch 2/2] Documentation/process: Add tip tree handbook
Message-ID: <20181108110532.GA30851@kroah.com>
References: <20181107171010.421878737@linutronix.de>
 <20181107171149.165693799@linutronix.de>
 <20181108074012.GD20032@gmail.com>
 <20181108091251.GL9761@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108091251.GL9761@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 10:12:51AM +0100, Peter Zijlstra wrote:
> On Thu, Nov 08, 2018 at 08:40:12AM +0100, Ingo Molnar wrote:
> > > + - Cc: ``cc-ed-person <person@mail>``
> > > +
> > > +   If the patch should be backported to stable, then please add a '``Cc:
> > > +   stable@vger.kernel.org``' tag, but do not Cc stable when sending your
> > > +   mail.
> > 
> > Can I suggest a more canonical form:
> > 
> > 	Cc: <stable@vger.kernel.org> # v4.18 and later kernels
> > 
> > It would be nice if people adding Cc: stable lines would actually try to 
> > figure out which exact kernel versions are affected.
> 
> I think Greg actually prefers we use stable@kernel.org, which is a
> /dev/null target. His bot will then pick up on the tag once it hits
> Linus' tree.

I really do not care either way what address is used.  Both work fine.

thanks,

greg k-h
