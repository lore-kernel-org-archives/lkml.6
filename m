Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31768C04AB9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFB0921480
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:43:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFB0921480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=angband.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392096AbeHPSm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 14:42:28 -0400
Received: from tartarus.angband.pl ([89.206.35.136]:50784 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392064AbeHPSm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 14:42:27 -0400
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.89)
        (envelope-from <kilobyte@angband.pl>)
        id 1fqKQU-0000e8-6P; Thu, 16 Aug 2018 17:43:06 +0200
Date:   Thu, 16 Aug 2018 17:43:06 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Sven Joachim <svenjoac@gmx.de>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Linux 4.18.1
Message-ID: <20180816154306.nllzlknw6n3we4pg@angband.pl>
References: <20180816101429.GA10680@kroah.com>
 <20180816130540.eu4rs5rago6b5lzq@angband.pl>
 <878t56mmxt.fsf@turtle.gmx.de>
 <20180816151121.GB10648@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180816151121.GB10648@kroah.com>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 05:11:21PM +0200, Greg KH wrote:
> On Thu, Aug 16, 2018 at 03:59:58PM +0200, Sven Joachim wrote:
> > On 2018-08-16 15:05 +0200, Adam Borowski wrote:
> > > I'm afraid that I get a build failure; v4.18 is ok, v4.18.1 fails with:
> > >
> > > ld: arch/x86/kvm/x86.o: in function `kvm_get_arch_capabilities':
> > > (.text+0x43b2): undefined reference to `l1tf_vmx_mitigation'
> > 
> > Same here and also in 4.17.15, but not in Linus' tree.
> > 
> > > CONFIG_KVM=y
> > > # CONFIG_KVM_INTEL is not set
> > > CONFIG_KVM_AMD=y
> > 
> > I have CONFIG_KVM{,AMD}=m and CONFIG_KVM_INTEL is not set either.
> 
> This is fixed in my queue, if it really bothers you, apply commit
> 1eb46908b35d ("x86/l1tf: Fix build error seen if CONFIG_KVM_INTEL is
> disabled") to your tree, it will be in the next round of stable kernel
> releases.

Probably obvious, but: cherry-picking that commit fixes the problem, it
builds, boots and works ok.

Thanks!


Meow.
-- 
⢀⣴⠾⠻⢶⣦⠀ What Would Jesus Do, MUD/MMORPG edition:
⣾⠁⢰⠒⠀⣿⡁ • multiplay with an admin char to benefit your mortal [Mt3:16-17]
⢿⡄⠘⠷⠚⠋⠀ • abuse item cloning bugs [Mt14:17-20, Mt15:34-37]
⠈⠳⣄⠀⠀⠀⠀ • use glitches to walk on water [Mt14:25-26]
