Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D7DC43444
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED44C218A1
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546933523;
	bh=sA8MpU49FbkuC1JC/5E01BiA787zN+8NxSDNLsZ6AHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aOsz+niQSD+zHq/ZFA4mlCeYQU/+GUKHDgfKeNPss/CC52yBV3hKK0MWV41en6LgM
	 7Isi+X9Oemq7cRJqa1kxbFL98lQuv5An9m4aadWQaPC+nvHb/V2tQ6cqaqqmg3B0+k
	 GAtPVBbdtChEqARi5fD+Aoo4n0x6JaEBdCWr/F+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbfAHHpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 02:45:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:45788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbfAHHpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 02:45:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C75F20700;
        Tue,  8 Jan 2019 07:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546933521;
        bh=sA8MpU49FbkuC1JC/5E01BiA787zN+8NxSDNLsZ6AHk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eB8heWSnCYqH3CfDdy0BQ9nRKBCgmaPcy79hk1+ubTvMbU6/+qas/O5eAwU+213qv
         182cfVcOKZ2Tx9bW197sY1u/JPp2sDajGmF4iwGxuuN2w3xuKWF2ZMmZjOkImymMUZ
         xjMP5XG0fX2tQKYBlaBjEZ/Kw3qrbf923HipzKD0=
Date:   Tue, 8 Jan 2019 08:45:18 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.20 000/145] 4.20.1-stable review
Message-ID: <20190108074518.GF2102@kroah.com>
References: <20190107104437.308206189@linuxfoundation.org>
 <20190107211749.GA12835@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107211749.GA12835@roeck-us.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 01:17:49PM -0800, Guenter Roeck wrote:
> On Mon, Jan 07, 2019 at 01:30:37PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.20.1 release.
> > There are 145 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Jan  9 10:43:39 UTC 2019.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 158 pass: 154 fail: 4
> Failed builds: 
> 	arm:allmodconfig 
> 	mips:allmodconfig 
> 	parisc:allmodconfig 
> 	xtensa:allmodconfig 
> Qemu test results:
> 	total: 332 pass: 327 fail: 5
> Failed tests: 
> 	mipsel64:fuloong2e_defconfig:fulong2e:rootfs
> 	sh:rts7751r2dplus_defconfig:nvme:rootfs 
> 	sh:rts7751r2dplus_defconfig:usb:rootfs 
> 	sh:rts7751r2dplus_defconfig:usb-hub:rootfs 
> 	sh:rts7751r2dplus_defconfig:usb-ohci:rootfs
> 
> ---
> Build errors:
> 
> ERROR: "__bad_cmpxchg" [drivers/spi/spi-bcm2835.ko] undefined!

Found the fix for this thanks.

> Qemu errors:
> 
> Building mipsel64:fuloong2e_defconfig:fulong2e:rootfs ... failed
> ------------
> Error log:
> In file included from ./arch/mips/include/asm/mmzone.h:10:0,
>                  from ./arch/mips/include/asm/r4kcache.h:23,
> 		 from arch/mips/mm/c-r4k.c:33:
> ./arch/mips/include/asm/mach-loongson64/mmzone.h:48:0: error: "NODE_DATA" redefined

This one is odd, let me dig...

thanks,

greg k-h
