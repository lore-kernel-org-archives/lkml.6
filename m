Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F92C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 08:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F236A2084D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 08:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544861254;
	bh=MM0kWnK8+5P9DTp+8yESRjFpJUxEk5mIuXSPvN24ctM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dhDVK2tfX7EeS2QD04bNYZfZ46wlop/0NJEMuu0KSJrNZUXeDs2da3ZL7uz5DR7yE
	 ynt2FB1PerqtxeqjKAGsKaLQ6lyycJOIDGjDaCpYZTw6nBlxLD8iaKiUgoV7rlELo4
	 7zzNFoB/Nb2evQxex66pAmnbQ8mCk/fnVHzWRAdI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbeLOIHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 03:07:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:53446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729029AbeLOIHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 03:07:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BD9C2080F;
        Sat, 15 Dec 2018 08:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544861252;
        bh=MM0kWnK8+5P9DTp+8yESRjFpJUxEk5mIuXSPvN24ctM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Slmey+bfpD3GiLbhQ9XXSnS7jjFF1wWj/++kaALkxm/KYItCfbz1/qONphu+3fiDv
         ujFIRkWNCaLbDMjdgIIUo2e6YQJjeC3ieAjgaxH5hzNymB+iQQGpLxw5sBNSDVMtxo
         tLKbpyK9nT/H7fYYV4AXVb8GetReCk2IAHS6lKRU=
Date:   Sat, 15 Dec 2018 09:07:29 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/88] 4.4.168-stable review
Message-ID: <20181215080729.GG10074@kroah.com>
References: <20181214115702.151309521@linuxfoundation.org>
 <dfd49bfd-359a-7f5e-8332-5e6ad6da21cd@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfd49bfd-359a-7f5e-8332-5e6ad6da21cd@roeck-us.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 06:10:29PM -0800, Guenter Roeck wrote:
> On 12/14/18 3:59 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.4.168 release.
> > There are 88 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun Dec 16 11:56:41 UTC 2018.
> > Anything received after that time might be too late.
> 
> Build results:
> 	total: 170 pass: 145 fail: 25
> Failed builds:
> 	arm:allnoconfig
> 	arm:tinyconfig
> 	arm:efm32_defconfig
> 	blackfin:defconfig
> 	blackfin:BF561-EZKIT-SMP_defconfig
> 	c6x:dsk6455_defconfig
> 	c6x:evmc6457_defconfig
> 	c6x:evmc6678_defconfig
> 	h8300:allnoconfig
> 	h8300:tinyconfig
> 	h8300:edosk2674_defconfig
> 	h8300:h8300h-sim_defconfig
> 	h8300:h8s-sim_defconfig
> 	m68k:allnoconfig
> 	m68k:tinyconfig
> 	m68k:m5272c3_defconfig
> 	m68k:m5307c3_defconfig
> 	m68k:m5249evb_defconfig
> 	m68k:m5407c3_defconfig
> 	microblaze:nommu_defconfig
> 	microblaze:allnoconfig
> 	microblaze:tinyconfig
> 	sh:defconfig
> 	sh:allnoconfig
> 	sh:tinyconfig
> Qemu test results:
> 	total: 288 pass: 288 fail: 0
> 
> mm/nommu.c: In function '__get_user_pages_unlocked':
> mm/nommu.c:211:49: error: 'write' undeclared (first use in this function)
> mm/nommu.c:211:56: error: 'force' undeclared (first use in this function)
> mm/nommu.c:212:9: warning: passing argument 7 of 'get_user_pages' from incompatible pointer type [enabled by default]
> mm/nommu.c:185:6: note: expected 'struct vm_area_struct **' but argument is of type 'struct page **'
> mm/nommu.c:212:9: error: too many arguments to function 'get_user_pages'
> mm/nommu.c:185:6: note: declared here
> 
> Details are available at https://kerneltests.org/builders/.

Ugh, I'll dig through this later on today, we must be missing something
with those backports that Ben did...

greg k-h
