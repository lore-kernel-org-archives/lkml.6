Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDA1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 06:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5933520865
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 06:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vs/rhObz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5933520865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404679AbeKVRIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:08:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:39420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732806AbeKVRIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:08:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BF2820685;
        Thu, 22 Nov 2018 06:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542868254;
        bh=0blr70El/3tw6kZzq9RgDjkVQ3XtQOnLMHYTCgrGem8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vs/rhObzBgc7NMMz9AB+UWwWF+9pCz6hEbFUZeF0ZRPJSGHPDfi8FsPD8nz9DbPQv
         GDvNrs1FqbCVdsKBfmuGed6ewMXiUvvVGYMyvUz+BKsv+8FIeb5dmilgoGN9Wlu/Ft
         dP/ctAypSHy+TTYcp6F8NV0F4zQla+Sc1Ldbdlx4=
Date:   Thu, 22 Nov 2018 07:30:51 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/90] 3.18.126-stable review
Message-ID: <20181122063051.GA28870@kroah.com>
References: <20181119162620.585061184@linuxfoundation.org>
 <20181120203829.GA19385@roeck-us.net>
 <20181121103733.GA9476@kroah.com>
 <20181121234012.GA4451@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121234012.GA4451@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 03:40:12PM -0800, Guenter Roeck wrote:
> On Wed, Nov 21, 2018 at 11:37:33AM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Nov 20, 2018 at 12:38:29PM -0800, Guenter Roeck wrote:
> > > On Mon, Nov 19, 2018 at 05:28:42PM +0100, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 3.18.126 release.
> > > > There are 90 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Wed Nov 21 16:25:28 UTC 2018.
> > > > Anything received after that time might be too late.
> > > > 
> > > 
> > > Build results:
> > > 	total: 138 pass: 134 fail: 4
> > > Failed builds: 
> > > 	i386:allyesconfig 
> > > 	i386:allmodconfig 
> > > 	sparc64:allmodconfig 
> > > 	sparc64:defconfig 
> > > Qemu test results:
> > > 	total: 221 pass: 209 fail: 12
> > > Failed tests: 
> > > 	sparc64:sun4u:smp:initrd 
> > > 	sparc64:sun4u:smp:ata:rootfs 
> > > 	sparc64:sun4u:smp:mmc:rootfs 
> > > 	sparc64:sun4u:smp:nvme:rootfs 
> > > 	sparc64:sun4u:smp:scsi[MEGASAS]:rootfs
> > > 	sparc64:sun4u:smp:usb-xhci:rootfs 
> > > 	sparc64:sun4u:smp:usb-uas-xhci:rootfs 
> > > 	sparc64:sun4u:smp:virtio-pci:rootfs 
> > > 	sparc64:sun4v:smp:ata:rootfs 
> > > 	sparc64:sun4v:smp:nvme:rootfs 
> > > 	sparc64:sun4u:nosmp:ata:rootfs 
> > > 	sparc64:sun4v:nosmp:ata:rootfs
> > > 
> > > Details are available at https://kerneltests.org/builders/.
> > 
> > Ok, sorry about that, I think these should now all be fixed.  I've
> > pushed out a -rc2 with some changes.
> > 
> 
> For v3.18.125-88-ge2a8617f7c3c:
> 
> Build results:
> 	total: 138 pass: 138 fail: 0
> Qemu test results:
> 	total: 221 pass: 221 fail: 0

Wonderful, thanks for letting me know!

greg k-h
