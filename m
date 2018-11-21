Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08F8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D5D82147D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGG0xdb1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D5D82147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbeKUVL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 16:11:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:59174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728114AbeKUVL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 16:11:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75E142146F;
        Wed, 21 Nov 2018 10:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542796655;
        bh=oumi7sfKVXMCPUZteositE2Ud7vFshSVZX7uS9iIn5I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GGG0xdb16UqKn+tn0OMBE/qa5vczkKaV0Y2LCf0c4Wyzi5maSY+q/fzzqV/FWZJwm
         wjPucG7mT9ZsTZ6jl7tqf+Yr2OxQWprWJYOL/YWSvSCYCMEy6FrL4B7f8Bc+rg/PMC
         YPaqxGMNG+WqslCOzdKfVUB5HSI3CF9Uy2CXzxqk=
Date:   Wed, 21 Nov 2018 11:37:33 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/90] 3.18.126-stable review
Message-ID: <20181121103733.GA9476@kroah.com>
References: <20181119162620.585061184@linuxfoundation.org>
 <20181120203829.GA19385@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120203829.GA19385@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 12:38:29PM -0800, Guenter Roeck wrote:
> On Mon, Nov 19, 2018 at 05:28:42PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 3.18.126 release.
> > There are 90 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Nov 21 16:25:28 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 138 pass: 134 fail: 4
> Failed builds: 
> 	i386:allyesconfig 
> 	i386:allmodconfig 
> 	sparc64:allmodconfig 
> 	sparc64:defconfig 
> Qemu test results:
> 	total: 221 pass: 209 fail: 12
> Failed tests: 
> 	sparc64:sun4u:smp:initrd 
> 	sparc64:sun4u:smp:ata:rootfs 
> 	sparc64:sun4u:smp:mmc:rootfs 
> 	sparc64:sun4u:smp:nvme:rootfs 
> 	sparc64:sun4u:smp:scsi[MEGASAS]:rootfs
> 	sparc64:sun4u:smp:usb-xhci:rootfs 
> 	sparc64:sun4u:smp:usb-uas-xhci:rootfs 
> 	sparc64:sun4u:smp:virtio-pci:rootfs 
> 	sparc64:sun4v:smp:ata:rootfs 
> 	sparc64:sun4v:smp:nvme:rootfs 
> 	sparc64:sun4u:nosmp:ata:rootfs 
> 	sparc64:sun4v:nosmp:ata:rootfs
> 
> Details are available at https://kerneltests.org/builders/.

Ok, sorry about that, I think these should now all be fixed.  I've
pushed out a -rc2 with some changes.

thanks,

greg k-h
