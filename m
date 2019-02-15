Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9082CC10F02
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 06:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54ED421B1C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 06:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550213814;
	bh=L8j9uGobgUnjz9ZjH3LX8EsEuUmUuu+lqSJtfb+BDgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hkvJyebbJ/Rb4FTUv8lXBPFoklLWCSlM8zTEYOglEQqjsTQg0HffSkled7r+HOV9E
	 pPAB7hhdthvNB4cJFZnbS6fLL2jzqXRkm4HhSwq3n3kARJ75ufIsCjPOrODmiVrJnu
	 BDnoyOiL7lZVqPf++oN5p9RGBpkzjD3re7VlFj8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388838AbfBOG4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 01:56:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:43068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388737AbfBOG4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 01:56:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F9B421927;
        Fri, 15 Feb 2019 06:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550213794;
        bh=L8j9uGobgUnjz9ZjH3LX8EsEuUmUuu+lqSJtfb+BDgA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HO/IaO1M5wZ9LPymuQugi7dyg1Qt86mYUx8eayK49hxKd/heH8usL8FaYm+nhYDmw
         Y4M8lOngnk1GWx76ZCH7VX4r/6iyj+ZJ4gKO4wn5IphhA/u+gewmcqyHDePPjraQ1h
         i/vust8NKSd6nm4HgGxYMGjGUX0UOPFg6iKQPPFg=
Date:   Fri, 15 Feb 2019 07:56:22 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.20 00/50] 4.20.9-stable review
Message-ID: <20190215065622.GB14473@kroah.com>
References: <20190213183655.747168774@linuxfoundation.org>
 <20190214210226.GA23386@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214210226.GA23386@roeck-us.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 01:02:26PM -0800, Guenter Roeck wrote:
> On Wed, Feb 13, 2019 at 07:38:05PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.20.9 release.
> > There are 50 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Fri Feb 15 18:36:30 UTC 2019.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 159 pass: 159 fail: 0
> Qemu test results:
> 	total: 343 pass: 330 fail: 13
> Failed tests: 
> 	sh:rts7751r2dplus_defconfig:initrd 
> 	sh:rts7751r2dplus_defconfig:ata:rootfs 
> 	sh:rts7751r2dplus_defconfig:mmc:rootfs 
> 	sh:rts7751r2dplus_defconfig:usb:rootfs 
> 	sh:rts7751r2dplus_defconfig:usb-hub:rootfs 
> 	sh:rts7751r2dplus_defconfig:usb-ohci:rootfs 
> 	sh:rts7751r2dplus_defconfig:usb-ehci:rootfs 
> 	sh:rts7751r2dplus_defconfig:usb-xhci:rootfs 
> 	sh:rts7751r2dplus_defconfig:usb-uas-ehci:rootfs 
> 	sh:rts7751r2dplus_defconfig:usb-uas-xhci:rootfs 
> 	sh:rts7751r2dplus_defconfig:scsi[53C810]:rootfs 
> 	sh:rts7751r2dplus_defconfig:scsi[53C895A]:rootfs
> 	sh:rts7751r2dplus_defconfig:scsi[FUSION]:rootfs
> 
> This failure gave me a bit of trouble. It is similar to the failure observed
> earlier with v4.4.y, but changing the C compiler version did not help (I
> tried 8.2.0 and 5.5.0), and changing the qemu version did not help either.
> Bisect points to commit 31e8a058e1f ("Revert "ext4: use ext4_write_inode()
> when fsyncing w/o a journal") as the culprit. No idea why that would be
> the case, but I repeated the bisect twice with the same results, and
> reverting that revert indeed fixes the problem. This is weird since
> one of the failing tests doesn't even mount a file system but boots
> from initrd. Go figure. Bisect results are below.
> 
> Guenter
> 
> ---
> # bad: [f4a86d6d2a0bdead7cf98d552481367e6356ef28] Linux 4.20.9-rc1
> # good: [0788acb1a3ed1589da1768ba64b1e5c76e8cb661] Linux 4.20.8
> git bisect start 'HEAD' 'v4.20.8'
> # good: [df6033ca3341635d8f529d6cdb6d37257df6f783] MIPS: OCTEON: don't set octeon_dma_bar_type if PCI is disabled
> git bisect good df6033ca3341635d8f529d6cdb6d37257df6f783
> # good: [da33f30a55d08758a63de90038344f956252ea8f] drm/rockchip: rgb: update SPDX license identifier
> git bisect good da33f30a55d08758a63de90038344f956252ea8f
> # good: [3ef454cd518997a8447080fb01743aaa4d4de8ae] xfrm: Make set-mark default behavior backward compatible
> git bisect good 3ef454cd518997a8447080fb01743aaa4d4de8ae
> # bad: [b442f17368f050887aae5d525b4dd0e146440f94] libceph: avoid KEEPALIVE_PENDING races in ceph_con_keepalive()
> git bisect bad b442f17368f050887aae5d525b4dd0e146440f94
> # bad: [31e8a058e1f9aa32254f64a9643853062141895a] Revert "ext4: use ext4_write_inode() when fsyncing w/o a journal"
> git bisect bad 31e8a058e1f9aa32254f64a9643853062141895a
> # good: [0bc4dd12c3196b01d2123f95bb1c949e5eebe483] drm/i915: Try to sanitize bogus DPLL state left over by broken SNB BIOSen
> git bisect good 0bc4dd12c3196b01d2123f95bb1c949e5eebe483
> # first bad commit: [31e8a058e1f9aa32254f64a9643853062141895a] Revert "ext4: use ext4_write_inode() when fsyncing w/o a journal"

That's really odd, given that this is only showing up in sh and not in
any of the other releases.  I'll blame gcc for this one :(

Thanks for testing all of these and letting me know.

greg k-h
