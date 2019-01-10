Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A156C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 496112173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547126268;
	bh=D58ZEQ9Lp9/4Hc8u5UvejOsVV9ItIpzTDNavmJxg8LQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H9+PIBkXHU9DM/q83ljIf6ti2oa+RDNmIJCUILZuykbg/7QB54Dzj5HeIKc2IZcDH
	 z39J8fmGMpcg5OP8S7M92qoPjTJ82XYJZKY1hANSh+N2ieRuhUDEPPNhTK7rs8F8rh
	 0xDkd68ORovq83uUtIDaI9d/EX26lQfAIekVOkqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbfAJNRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 08:17:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:38124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727704AbfAJNRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 08:17:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8742F214DA;
        Thu, 10 Jan 2019 13:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547126266;
        bh=D58ZEQ9Lp9/4Hc8u5UvejOsVV9ItIpzTDNavmJxg8LQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RFmIN/RmZd3IW8JaJgSJYJ6Cq+k2o+wzWRmXcfKGhXrc3PDoiiS92Sa7RPs0tLG96
         F+CuOhIUzBXO5JUjsZwusncdkV6552lE7n0c29Bz+wSiFzSkHkgdZxZY8es79J+9rb
         b238ozyI8c+md83/w7actH63UubjwCpQPjfBLCTw=
Date:   Thu, 10 Jan 2019 14:17:43 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>,
        Breno Leitao <leitao@debian.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/170] 4.19.14-stable review
Message-ID: <20190110131743.GE20217@kroah.com>
References: <20190107104452.953560660@linuxfoundation.org>
 <20190108230731.GC20519@roeck-us.net>
 <20190109143811.GB29274@kroah.com>
 <20190109194048.GA11505@roeck-us.net>
 <20190110065207.GA17195@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110065207.GA17195@kroah.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 07:52:07AM +0100, Greg Kroah-Hartman wrote:
> On Wed, Jan 09, 2019 at 11:40:48AM -0800, Guenter Roeck wrote:
> > On Wed, Jan 09, 2019 at 03:38:11PM +0100, Greg Kroah-Hartman wrote:
> > > On Tue, Jan 08, 2019 at 03:07:31PM -0800, Guenter Roeck wrote:
> > > > On Mon, Jan 07, 2019 at 01:30:27PM +0100, Greg Kroah-Hartman wrote:
> > > > > This is the start of the stable review cycle for the 4.19.14 release.
> > > > > There are 170 patches in this series, all will be posted as a response
> > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > let me know.
> > > > > 
> > > > > Responses should be made by Wed Jan  9 10:43:54 UTC 2019.
> > > > > Anything received after that time might be too late.
> > > > > 
> > > > 
> > > > For v4.19.13-171-gc68ce175c3b8:
> > > > 
> > > > Build results:
> > > > 	total: 155 pass: 152 fail: 3
> > > > Failed builds: 
> > > > 	powerpc:ppc64e_defconfig 
> > > > 	powerpc:cell_defconfig 
> > > > 	powerpc:maple_defconfig 
> > > > Qemu test results:
> > > > 	total: 332 pass: 319 fail: 13
> > > > Failed tests: 
> > > > 	ppc64:mac99:ppc64_book3s_defconfig:nosmp:initrd 
> > > > 	ppc64:mac99:ppc64_book3s_defconfig:smp:initrd 
> > > > 	ppc64:mac99:ppc64_book3s_defconfig:smp:ide:rootfs 
> > > > 	ppc64:mac99:ppc64_book3s_defconfig:smp:mmc:rootfs 
> > > > 	ppc64:mac99:ppc64_book3s_defconfig:smp:nvme:rootfs 
> > > > 	ppc64:mac99:ppc64_book3s_defconfig:smp:scsi[DC395]:rootfs 
> > > > 	ppc64:mpc8544ds:ppc64_e5500_defconfig:nosmp:initrd 
> > > > 	ppc64:mpc8544ds:ppc64_e5500_defconfig:smp:initrd 
> > > > 	ppc64:ppce500:corenet64_smp_defconfig:e5500:initrd 
> > > > 	ppc64:ppce500:corenet64_smp_defconfig:e5500:nvme:rootfs 
> > > > 	ppc64:ppce500:corenet64_smp_defconfig:e5500:mmc:rootfs 
> > > > 	ppc64:ppce500:corenet64_smp_defconfig:e5500:scsi[53C895A]:rootfs
> > > > 	ppc64:ppce500:corenet64_smp_defconfig:e5500:sata-sii3112:rootfs
> > > 
> > > Ugh, I thought this was just the cell build, didn't realize it hit more.
> > > 
> > > Ok, I've dropped the patch from all queues.  Odd that it only causes
> > > problems on 4.19.y :(
> > > 
> > I don't know what you dropped, but v4.19.14 fails to build with 
> > the same error. Did you drop it after the release ?
> 
> No, I should have dropped it before the release.  Let me go see what I
> messed up...

I dropped e1c3743e1a20 ("powerpc/tm: Set MSR[TS] just prior to recheckpoint")
from the stable trees, which is what I was told was the commit that was
causing the problems by Christoph and Breno (on to: now).

Was that not the offending commit?  If so, what one was?

totally confused,

greg k-h
