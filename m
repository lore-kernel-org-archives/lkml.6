Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8CAC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3E6320882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548791008;
	bh=hyDIp/xwa3RwGkibjZjjbZD9HI8IuPs6FN9MTVhyp8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C3tKx/x+N2TZr1gDP5REQw0qOrSQdduoxRRhGeVZbdG8byNIAgG6eiPLzOtRB1xC+
	 Bps2dSwizh5C+rquWtQf8fdhovl7+kcLZfr6b7Y9nBXRmtFfOUS7n5/iwi9bTjiJKI
	 Nr8hoq6w72JJYsAU81OOTxTRYALhfCI7+M5GMrKI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbfA2Tn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:43:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:42270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbfA2Tn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 14:43:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7019820869;
        Tue, 29 Jan 2019 19:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548791005;
        bh=hyDIp/xwa3RwGkibjZjjbZD9HI8IuPs6FN9MTVhyp8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TnzOVT1Khaa1hg4v37R5Sx+/m2z4RkPhVVBt97wHY/i69Vg2yrtyAlKc979iOrgHB
         1Iby69EcBu7MV+gWDU/y/lIHydDyBYBu/SrDnilw3XDPyu+cPEt+2TqxPQhaiEhFAw
         cRFJAeow617pAUvltHEe+xG23/Lwz2Co8/z+PRsc=
Date:   Tue, 29 Jan 2019 20:43:23 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/44] 4.9.154-stable review
Message-ID: <20190129194323.GA32069@kroah.com>
References: <20190129113139.826927690@linuxfoundation.org>
 <20190129190220.GA6116@roeck-us.net>
 <20190129192624.GA21847@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129192624.GA21847@kroah.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 08:26:24PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Jan 29, 2019 at 11:02:20AM -0800, Guenter Roeck wrote:
> > On Tue, Jan 29, 2019 at 12:35:55PM +0100, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 4.9.154 release.
> > > There are 44 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Thu Jan 31 11:31:22 UTC 2019.
> > > Anything received after that time might be too late.
> > > 
> > 
> > fs/cifs/connect.c: In function 'zero_credits':
> > fs/cifs/connect.c:527:34: error: 'struct TCP_Server_Info' has no member named 'echo_credits'
> > fs/cifs/connect.c:527:57: error: 'struct TCP_Server_Info' has no member named 'oplock_credits'
> > 
> > Seen with:
> > 
> > arm:s3c2410_defconfig 
> > arm:nhk8815_defconfig 
> > arm:cm_x2xx_defconfig 
> > ia64:defconfig 
> > m68k:defconfig 
> > m68k:sun3_defconfig 
> > microblaze:mmu_defconfig 
> > mips:defconfig 
> > mips:nlm_xlp_defconfig 
> > parisc:defconfig 
> > parisc:generic-32bit_defconfig 
> > parisc:a500_defconfig 
> > powerpc:defconfig 
> > powerpc:ppc64e_defconfig 
> > powerpc:ppc6xx_defconfig 
> > s390:performance_defconfig
> > tile:tilegx_defconfig 
> 
> Ugh, this is due to CONFIG_CIFS_SMB2 not being enabled there.  But it's
> removed in newer kernels.  Let me see if I should just drop the
> offending patch, give me a bit...

I've just dropped the patch now and pushed out a -rc2.

thanks,

greg k-h
