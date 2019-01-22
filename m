Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE6FC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 053FE20844
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548153937;
	bh=Hu9DU1QjlvUfwjW5o2xL7AQLNTyJunNnPx4NIYzaS08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zCzwtN0feJTizdcVt8pDGBDLn5KGI47aePXj9rAL8IK2aDicCVbvwgeaK/6y66k7P
	 eg5GEOj696nfbX1wN/JUrohmDsUFa58MjjwScV/cqidH6/Obg2jJ2W5FXDP2jkjiPf
	 SzCK8KnZ4jsWTN4uUomS2QIFgXZkzbfeI84UtPoI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbfAVKpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:45:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:48272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbfAVKpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:45:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0969820844;
        Tue, 22 Jan 2019 10:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548153934;
        bh=Hu9DU1QjlvUfwjW5o2xL7AQLNTyJunNnPx4NIYzaS08=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o26ix7VfbAD/u8TcmlkzX0PqZGOL2noFHaYFMoFzwkieepzC72qX7t/4YHXfBpWKT
         yxy6faI0F+Y4FJEjzYZffce+JGH/FbUJj9mscquKWdW13sgZ/lGlDtt9AxQchraOIY
         yvzpJhBgh/OMkZdoKTjes6HhVjI0tNPJJBMniXew=
Date:   Tue, 22 Jan 2019 11:45:24 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, Vincent Whitchurch <rabinv@axis.com>
Subject: Re: [PATCH 0/8] Virtio-over-PCIe on non-MIC
Message-ID: <20190122104524.GB29081@kroah.com>
References: <20190116163253.23780-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116163253.23780-1-vincent.whitchurch@axis.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 05:32:45PM +0100, Vincent Whitchurch wrote:
> The Virtio-over-PCIe framework living under drivers/misc/mic/vop implements a
> generic framework to use virtio between two Linux systems, given shared memory
> and a couple of interrupts.  It does not actually require the Intel MIC
> hardware, x86-64, or even PCIe for that matter.  This patch series makes it
> buildable on more systems and adds a loopback driver to test it without special
> hardware.
> 
> Note that I don't have access to Intel MIC hardware so some testing of the
> patchset (especially the patch "vop: Use consistent DMA") on that platform
> would be appreciated, to ensure that the series does not break anything there.
> 
> Vincent Whitchurch (8):
>   vop: Use %z for size_t
>   vop: Cast pointers to uintptr_t
>   vop: Add definition of readq/writeq if missing
>   vop: Allow building on more systems
>   vop: vringh: Do not crash if no DMA channel
>   vop: Fix handling of >32 feature bits
>   vop: Use consistent DMA
>   vop: Add loopback

I applied a few of these to my tree.  Feel free to rebase and fix up
patch 2 and resend.

thanks,

greg k-h
