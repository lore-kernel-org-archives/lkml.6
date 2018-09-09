Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B749DC4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 18:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 628A820833
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 18:03:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 628A820833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbeIIWx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 18:53:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57856 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbeIIWx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 18:53:57 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 14499CB1;
        Sun,  9 Sep 2018 18:03:29 +0000 (UTC)
Date:   Sun, 9 Sep 2018 20:03:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/63] 4.9.126-stable review
Message-ID: <20180909180326.GA22151@kroah.com>
References: <20180907211012.965501324@linuxfoundation.org>
 <e1fa8fda-e277-3c83-5e35-826df83f3cd5@roeck-us.net>
 <20180909085530.GC14455@kroah.com>
 <1231d8c4-0788-6d02-308a-176666b4a71f@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1231d8c4-0788-6d02-308a-176666b4a71f@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 09, 2018 at 08:54:41AM -0700, Guenter Roeck wrote:
> On 09/09/2018 01:55 AM, Greg Kroah-Hartman wrote:
> > On Sat, Sep 08, 2018 at 02:14:53PM -0700, Guenter Roeck wrote:
> > > On 09/07/2018 02:09 PM, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 4.9.126 release.
> > > > There are 63 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Sun Sep  9 21:09:58 UTC 2018.
> > > > Anything received after that time might be too late.
> > > > 
> > > 
> > > Build results:
> > > 	total: 151 pass: 149 fail: 2
> > > Failed builds:
> > > 	powerpc:defconfig
> > > 	powerpc:allmodconfig
> > > Qemu test results:
> > > 	total: 301 pass: 285 fail: 16
> > > Failed tests:
> > > 	powerpc:mac99:ppc64_book3s_defconfig:nosmp:initrd
> > > 	powerpc:mac99:ppc64_book3s_defconfig:smp:cpu4:initrd
> > > 	powerpc:mac99:ppc64_book3s_defconfig:smp:cpu4:ide:rootfs
> > > 	powerpc:mac99:ppc64_book3s_defconfig:smp:cpu4:mmc:rootfs
> > > 	powerpc:mac99:ppc64_book3s_defconfig:smp:cpu4:scsi[DC395]:rootfs
> > > 	powerpc:pseries:pseries_defconfig:initrd
> > > 	powerpc:pseries:pseries_defconfig:scsi:rootfs
> > > 	powerpc:pseries:pseries_defconfig:mmc:rootfs
> > > 	powerpc:pseries:pseries_defconfig:nvme:rootfs
> > > 	powerpc:pseries:pseries_defconfig:little:initrd
> > > 	powerpc:pseries:pseries_defconfig:little:scsi:rootfs
> > > 	powerpc:pseries:pseries_defconfig:little:scsi[MEGASAS]:rootfs
> > > 	powerpc:pseries:pseries_defconfig:little:scsi[FUSION]:rootfs
> > > 	powerpc:pseries:pseries_defconfig:little:mmc:rootfs
> > > 	powerpc:pseries:pseries_defconfig:little:nvme:rootfs
> > > 	powerpc:powernv:powernv_defconfig:initrd
> > > 
> > > Details are available at https://kerneltests.org/builders/.
> > 
> > I've pushed out a -rc2 to fix this.  Hopefully.  There were a bunch of
> > warnings for power that I don't think were caused by these series, I
> > don't know if they have always been there or not.
> > 
> 
> For v4.9.125-65-g0f793f1ec4f3:
> 
> Build results:
> 	total: 151 pass: 150 fail: 1
> Failed builds:
> 	powerpc:allmodconfig
> Qemu test results:
> 	total: 301 pass: 301 fail: 0
> 
> arch/powerpc/kernel/fadump.c: In function 'free_crash_memory_ranges':
> arch/powerpc/kernel/fadump.c:738:2: error: implicit declaration of function 'kfree'
> 
> arch/powerpc/kernel/fadump.c: In function 'allocate_crash_memory_ranges':
> arch/powerpc/kernel/fadump.c:757:14: error: implicit declaration of function 'krealloc'

Oops, forgot to fix that one.  Shoould now be resolved.

greg k-h
