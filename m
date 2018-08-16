Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B3BC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 08:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F8E521480
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 08:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F8E521480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389936AbeHPLRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 07:17:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34778 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388202AbeHPLRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 07:17:30 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 914569D2;
        Thu, 16 Aug 2018 08:20:37 +0000 (UTC)
Date:   Thu, 16 Aug 2018 10:20:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dave Young <dyoung@redhat.com>
Cc:     Yannik Sembritzki <yannik@sembritzki.me>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Baoquan He <bhe@redhat.com>,
        Justin Forbes <jforbes@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Matthew Garrett <mjg59@google.com>,
        Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 2/2] [FIXED v2] Replace magic for trusting the secondary
 keyring with #define
Message-ID: <20180816082035.GA4905@kroah.com>
References: <20180815194244.29564-3-yannik@sembritzki.me>
 <201808160443.5h16PxVs%fengguang.wu@intel.com>
 <1bfa03ed-c9f8-d0f2-700c-c93e96d5b99c@sembritzki.me>
 <CA+55aFw1oaRiqAU_61BwqS5QWS2VtZ6o9cAF3YEVx2NfMkmHpQ@mail.gmail.com>
 <fcc28be0-f066-9c7a-7a4e-05d0cc1c0967@sembritzki.me>
 <20180816011106.GC5915@dhcp-128-65.nay.redhat.com>
 <7834c175-7480-d5bd-d964-a4dd783af1f3@sembritzki.me>
 <20180816080259.GA6241@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816080259.GA6241@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 04:02:59PM +0800, Dave Young wrote:
> On 08/16/18 at 09:43am, Yannik Sembritzki wrote:
> > On 16.08.2018 03:11, Dave Young wrote:
> > > Instead of fix your 1st patch in 2nd patch, I would suggest to
> > > switch the patch order.  In 1st patch change the common code to use
> > > the new macro and in 2nd patch you can directly fix the kexec code
> > > with TRUST_SECONDARY_KEYRING.
> > My reasoning for doing it in this order was that the first patch which
> > fixes the bug itself should be merged into stable, while the refactoring
> > doesn't necessarily have to. I'm not familiar with the linux development
> > process, so please correct me if this should be done in another fashion.
> 
> Frankly I'm not sure about the stable process.  But personally I do not 
> like the order.
> 
> Cced Greg for opinions about stable concern.

It's up to what the maintainer of the subsystem wants to do here.  I
will take what they recommend.

thanks,

greg k-h
