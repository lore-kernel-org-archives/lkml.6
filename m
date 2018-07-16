Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB252ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D532208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D532208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbeGPQ7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 12:59:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37144 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbeGPQ7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 12:59:49 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 35413C74;
        Mon, 16 Jul 2018 16:31:38 +0000 (UTC)
Date:   Mon, 16 Jul 2018 18:31:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/32] 4.9.113-stable review
Message-ID: <20180716163136.GA16264@kroah.com>
References: <20180716073504.433996952@linuxfoundation.org>
 <20180716162538.GB12065@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716162538.GB12065@roeck-us.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 09:25:38AM -0700, Guenter Roeck wrote:
> On Mon, Jul 16, 2018 at 09:36:08AM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.9.113 release.
> > There are 32 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Jul 18 07:34:43 UTC 2018.
> > Anything received after that time might be too late.
> >
> 
> Build results:
> 	total: 148 pass: 133 fail: 15
> Failed builds: 
> 	mips:defconfig 
> 	mips:allnoconfig 
> 	mips:defconfig 
> 	mips:allmodconfig 
> 	mips:allnoconfig 
> 	mips:bcm47xx_defconfig 
> 	mips:bcm63xx_defconfig 
> 	mips:nlm_xlp_defconfig 
> 	mips:ath79_defconfig 
> 	mips:ar7_defconfig 
> 	mips:e55_defconfig 
> 	mips:cavium_octeon_defconfig 
> 	mips:malta_defconfig 
> 	mips:rt305x_defconfig 
> 	mips:defconfig 
> Qemu test results:
> 	total: 166 pass: 154 fail: 12
> Failed tests: 
> 	mips:malta_defconfig:nosmp 
> 	mips:malta_defconfig:smp 
> 	mips64:malta_defconfig:nosmp 
> 	mips64:malta_defconfig:smp 
> 	mipsel:24Kf:malta_defconfig:nosmp:initrd 
> 	mipsel:24Kf:malta_defconfig:smp:initrd 
> 	mipsel:24Kf:malta_defconfig:smp:rootfs 
> 	mipsel:mips32r6-generic:malta_32r6_defconfig:smp:rootfs 
> 	mipsel64:malta_defconfig:nosmp:rootfs 
> 	mipsel64:malta_defconfig:smp:initrd 
> 	mipsel64:malta_defconfig:smp:rootfs 
> 	mipsel64:fuloong2e_defconfig:fulong2e:rootfs
> 
> Error is always the same.
> 
> arch/mips/kernel/process.c:637:8:
> 	error: 'call_single_data_t' undeclared here (not in a function)
> arch/mips/kernel/process.c: In function 'raise_backtrace':
> /opt/buildbot/slave/stable-queue-4.9/build/arch/mips/kernel/process.c:648:22:
> 	error: 'csd' undeclared (first use in this function)

mips should now be fixed with the updated tree I have pushed out.

thanks,

greg k-h
