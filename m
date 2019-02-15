Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2BEC10F02
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D7B222DB
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550263974;
	bh=PrE4C7dvtBu0Le0yADCb4/YiX+Ps3Hx5geekh3jR/BA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RI1iBL6Kst7wUZQJn/KdpH0hPs6AIr8QvhyI3EYuMypS+PPH0eBoeuuryInvPc8Zi
	 n9ff0BnNsaXIG/0A27HxEsVYE/jzp+MuEpNboQymekk+w7kaGPModWeQINf9XByN7j
	 0qs/s+DhfwraP9s+HfjiZpTwWJFECM0ZER7tY3/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391585AbfBOUwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 15:52:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:42722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbfBOUww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 15:52:52 -0500
Received: from localhost (ip-188-118-48-1.reverse.destiny.be [188.118.48.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7345C222D9;
        Fri, 15 Feb 2019 20:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550263971;
        bh=PrE4C7dvtBu0Le0yADCb4/YiX+Ps3Hx5geekh3jR/BA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ifp6ZPvYgC4Nv/9XVIrEQrSWTt8p+NUhcTvOllRD6TueGYZUbyb9U27yQU05fsf3b
         aMIuv9fZKHvcoNT0LHWMyBHiH6RsoqnenYo8ZlAApYTu5R5H0bpc14G5NE388a3Cpv
         bCAEKtLRyEOQxk3NTcL5FtQ0s/rmnTjOonJhwyjk=
Date:   Fri, 15 Feb 2019 21:52:42 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.20 00/50] 4.20.9-stable review
Message-ID: <20190215205242.GA4254@kroah.com>
References: <20190213183655.747168774@linuxfoundation.org>
 <20190214210226.GA23386@roeck-us.net>
 <20190215065622.GB14473@kroah.com>
 <20190215172221.GA21472@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215172221.GA21472@roeck-us.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 09:22:21AM -0800, Guenter Roeck wrote:
> On Fri, Feb 15, 2019 at 07:56:22AM +0100, Greg Kroah-Hartman wrote:
> > On Thu, Feb 14, 2019 at 01:02:26PM -0800, Guenter Roeck wrote:
> > > On Wed, Feb 13, 2019 at 07:38:05PM +0100, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 4.20.9 release.
> > > > There are 50 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Fri Feb 15 18:36:30 UTC 2019.
> > > > Anything received after that time might be too late.
> > > > 
> > > 
> > > Build results:
> > > 	total: 159 pass: 159 fail: 0
> > > Qemu test results:
> > > 	total: 343 pass: 330 fail: 13
> > > Failed tests: 
> > > 	sh:rts7751r2dplus_defconfig:initrd 
> > > 	sh:rts7751r2dplus_defconfig:ata:rootfs 
> > > 	sh:rts7751r2dplus_defconfig:mmc:rootfs 
> > > 	sh:rts7751r2dplus_defconfig:usb:rootfs 
> > > 	sh:rts7751r2dplus_defconfig:usb-hub:rootfs 
> > > 	sh:rts7751r2dplus_defconfig:usb-ohci:rootfs 
> > > 	sh:rts7751r2dplus_defconfig:usb-ehci:rootfs 
> > > 	sh:rts7751r2dplus_defconfig:usb-xhci:rootfs 
> > > 	sh:rts7751r2dplus_defconfig:usb-uas-ehci:rootfs 
> > > 	sh:rts7751r2dplus_defconfig:usb-uas-xhci:rootfs 
> > > 	sh:rts7751r2dplus_defconfig:scsi[53C810]:rootfs 
> > > 	sh:rts7751r2dplus_defconfig:scsi[53C895A]:rootfs
> > > 	sh:rts7751r2dplus_defconfig:scsi[FUSION]:rootfs
> > > 
> > > This failure gave me a bit of trouble. It is similar to the failure observed
> > > earlier with v4.4.y, but changing the C compiler version did not help (I
> > > tried 8.2.0 and 5.5.0), and changing the qemu version did not help either.
> > > Bisect points to commit 31e8a058e1f ("Revert "ext4: use ext4_write_inode()
> > > when fsyncing w/o a journal") as the culprit. No idea why that would be
> > > the case, but I repeated the bisect twice with the same results, and
> > > reverting that revert indeed fixes the problem. This is weird since
> > > one of the failing tests doesn't even mount a file system but boots
> > > from initrd. Go figure. Bisect results are below.
> > > 
> > > Guenter
> > > 
> > > ---
> > > # bad: [f4a86d6d2a0bdead7cf98d552481367e6356ef28] Linux 4.20.9-rc1
> > > # good: [0788acb1a3ed1589da1768ba64b1e5c76e8cb661] Linux 4.20.8
> > > git bisect start 'HEAD' 'v4.20.8'
> > > # good: [df6033ca3341635d8f529d6cdb6d37257df6f783] MIPS: OCTEON: don't set octeon_dma_bar_type if PCI is disabled
> > > git bisect good df6033ca3341635d8f529d6cdb6d37257df6f783
> > > # good: [da33f30a55d08758a63de90038344f956252ea8f] drm/rockchip: rgb: update SPDX license identifier
> > > git bisect good da33f30a55d08758a63de90038344f956252ea8f
> > > # good: [3ef454cd518997a8447080fb01743aaa4d4de8ae] xfrm: Make set-mark default behavior backward compatible
> > > git bisect good 3ef454cd518997a8447080fb01743aaa4d4de8ae
> > > # bad: [b442f17368f050887aae5d525b4dd0e146440f94] libceph: avoid KEEPALIVE_PENDING races in ceph_con_keepalive()
> > > git bisect bad b442f17368f050887aae5d525b4dd0e146440f94
> > > # bad: [31e8a058e1f9aa32254f64a9643853062141895a] Revert "ext4: use ext4_write_inode() when fsyncing w/o a journal"
> > > git bisect bad 31e8a058e1f9aa32254f64a9643853062141895a
> > > # good: [0bc4dd12c3196b01d2123f95bb1c949e5eebe483] drm/i915: Try to sanitize bogus DPLL state left over by broken SNB BIOSen
> > > git bisect good 0bc4dd12c3196b01d2123f95bb1c949e5eebe483
> > > # first bad commit: [31e8a058e1f9aa32254f64a9643853062141895a] Revert "ext4: use ext4_write_inode() when fsyncing w/o a journal"
> > 
> > That's really odd, given that this is only showing up in sh and not in
> > any of the other releases.  I'll blame gcc for this one :(
> > 
> I suspect it may be a code alignment issue, but who knows. The problem
> is gone in v4.20.10, meaning the revert of "exec: load_script: don't
> blindly truncate shebang string" "fixed" the problem as well.

That's sad, and scary :(

Thanks for letting me know.

greg k-h
