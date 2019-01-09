Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E491FC43612
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A54DD20883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547044695;
	bh=BW6VAvslvmahF3XXqvO5ycEHK40MHoFnYjDaot0ePJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VTN0iMztDQ5lhDGB7qcJsPHVaRfCz3dpN6mCfUoBmfC9r1s29Boy1LeiiDJhcTG2/
	 bHjc7wcJn1e9dqh6bNv/t3QYPuOamThtwKY14ysCquL2hpRsFxoqy35zu8cvfnTrtF
	 DFymqOahzlTf0Yrg60nmMK/o+ZvnRF5R9PHm5G9k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731487AbfAIOiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:38:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:46154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730970AbfAIOiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:38:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAF13206BA;
        Wed,  9 Jan 2019 14:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547044694;
        bh=BW6VAvslvmahF3XXqvO5ycEHK40MHoFnYjDaot0ePJI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AfAJP95xvT7M/MxbjNLl3mL++xFAQU7JzAs16T3mCsZgEcWxuwWHDIgHk+3Q5TJce
         y8UvP/9o0KdMY14MOnO+kbTYoSP2WEsGf5loydi7z01cBohO4mFBe9pmVGQD29OSHX
         b/hAQW8uBcN9dB7xuB9oXK/Hb6PboKL3UtId3tro=
Date:   Wed, 9 Jan 2019 15:38:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/170] 4.19.14-stable review
Message-ID: <20190109143811.GB29274@kroah.com>
References: <20190107104452.953560660@linuxfoundation.org>
 <20190108230731.GC20519@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108230731.GC20519@roeck-us.net>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 03:07:31PM -0800, Guenter Roeck wrote:
> On Mon, Jan 07, 2019 at 01:30:27PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.19.14 release.
> > There are 170 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Jan  9 10:43:54 UTC 2019.
> > Anything received after that time might be too late.
> > 
> 
> For v4.19.13-171-gc68ce175c3b8:
> 
> Build results:
> 	total: 155 pass: 152 fail: 3
> Failed builds: 
> 	powerpc:ppc64e_defconfig 
> 	powerpc:cell_defconfig 
> 	powerpc:maple_defconfig 
> Qemu test results:
> 	total: 332 pass: 319 fail: 13
> Failed tests: 
> 	ppc64:mac99:ppc64_book3s_defconfig:nosmp:initrd 
> 	ppc64:mac99:ppc64_book3s_defconfig:smp:initrd 
> 	ppc64:mac99:ppc64_book3s_defconfig:smp:ide:rootfs 
> 	ppc64:mac99:ppc64_book3s_defconfig:smp:mmc:rootfs 
> 	ppc64:mac99:ppc64_book3s_defconfig:smp:nvme:rootfs 
> 	ppc64:mac99:ppc64_book3s_defconfig:smp:scsi[DC395]:rootfs 
> 	ppc64:mpc8544ds:ppc64_e5500_defconfig:nosmp:initrd 
> 	ppc64:mpc8544ds:ppc64_e5500_defconfig:smp:initrd 
> 	ppc64:ppce500:corenet64_smp_defconfig:e5500:initrd 
> 	ppc64:ppce500:corenet64_smp_defconfig:e5500:nvme:rootfs 
> 	ppc64:ppce500:corenet64_smp_defconfig:e5500:mmc:rootfs 
> 	ppc64:ppce500:corenet64_smp_defconfig:e5500:scsi[53C895A]:rootfs
> 	ppc64:ppce500:corenet64_smp_defconfig:e5500:sata-sii3112:rootfs

Ugh, I thought this was just the cell build, didn't realize it hit more.

Ok, I've dropped the patch from all queues.  Odd that it only causes
problems on 4.19.y :(

thanks,

greg k-h
