Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26290C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D82482147A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:11:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D82482147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391868AbeHPSKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 14:10:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52640 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbeHPSKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 14:10:45 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4DBF825A;
        Thu, 16 Aug 2018 15:11:39 +0000 (UTC)
Date:   Thu, 16 Aug 2018 17:11:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sven Joachim <svenjoac@gmx.de>
Cc:     Adam Borowski <kilobyte@angband.pl>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Linux 4.18.1
Message-ID: <20180816151121.GB10648@kroah.com>
References: <20180816101429.GA10680@kroah.com>
 <20180816130540.eu4rs5rago6b5lzq@angband.pl>
 <878t56mmxt.fsf@turtle.gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878t56mmxt.fsf@turtle.gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 03:59:58PM +0200, Sven Joachim wrote:
> On 2018-08-16 15:05 +0200, Adam Borowski wrote:
> 
> > On Thu, Aug 16, 2018 at 12:14:29PM +0200, Greg KH wrote:
> >> I'm announcing the release of the 4.18.1 kernel.
> >
> > I'm afraid that I get a build failure; v4.18 is ok, v4.18.1 fails with:
> >
> > ld: arch/x86/kvm/x86.o: in function `kvm_get_arch_capabilities':
> > (.text+0x43b2): undefined reference to `l1tf_vmx_mitigation'
> 
> Same here and also in 4.17.15, but not in Linus' tree.
> 
> > .config attached.
> 
> Probably relevant:
> 
> > CONFIG_KVM=y
> > # CONFIG_KVM_INTEL is not set
> > CONFIG_KVM_AMD=y
> 
> I have CONFIG_KVM{,AMD}=m and CONFIG_KVM_INTEL is not set either.

This is fixed in my queue, if it really bothers you, apply commit
1eb46908b35d ("x86/l1tf: Fix build error seen if CONFIG_KVM_INTEL is
disabled") to your tree, it will be in the next round of stable kernel
releases.

thanks,

greg k-h
