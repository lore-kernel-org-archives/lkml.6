Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8258C46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 919DD20685
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UT4rQyZq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 919DD20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbeKHSrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 13:47:47 -0500
Received: from merlin.infradead.org ([205.233.59.134]:56586 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbeKHSrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 13:47:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6h+8RgNY/o477uuCGdmzJNW3WcfxeZ5zp4rR7BEDOvE=; b=UT4rQyZqXkaFA3xxS4mwT4Vs9
        MFjbELyP11Y3TUO55iecryW2zxJfxcylj+MVWD10pia2MY3HHFGKHZDYm/Kf0v1DNc5yIYsdZhcv6
        5jwQE/y/YZltL9kr0BKGxjdtNazJ6GA4sXRUBJEMJiOpL7O0e/f/JP+iMj/27ITg0HykVPWc2mEYq
        rXCv0MRbUhRYCPgBH0lpKUcl5mmarfZMcbnCoED63J2lh//CUU/oERI0IRM0iCOKLolCCBn3lQNIt
        hlaqA5PqY4SjtRyb0C28PV+bN4zYeYnYgxyLfbdEK8BzPqW177licOGEY8EAD83ZG/SoIH6GQT7X1
        NhZR5wADQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gKgMx-0007lD-2Q; Thu, 08 Nov 2018 09:12:55 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6B21A20284F98; Thu,  8 Nov 2018 10:12:51 +0100 (CET)
Date:   Thu, 8 Nov 2018 10:12:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [patch 2/2] Documentation/process: Add tip tree handbook
Message-ID: <20181108091251.GL9761@hirez.programming.kicks-ass.net>
References: <20181107171010.421878737@linutronix.de>
 <20181107171149.165693799@linutronix.de>
 <20181108074012.GD20032@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108074012.GD20032@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 08:40:12AM +0100, Ingo Molnar wrote:
> > + - Cc: ``cc-ed-person <person@mail>``
> > +
> > +   If the patch should be backported to stable, then please add a '``Cc:
> > +   stable@vger.kernel.org``' tag, but do not Cc stable when sending your
> > +   mail.
> 
> Can I suggest a more canonical form:
> 
> 	Cc: <stable@vger.kernel.org> # v4.18 and later kernels
> 
> It would be nice if people adding Cc: stable lines would actually try to 
> figure out which exact kernel versions are affected.

I think Greg actually prefers we use stable@kernel.org, which is a
/dev/null target. His bot will then pick up on the tag once it hits
Linus' tree.
