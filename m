Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF6DC43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E59E820827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546939995;
	bh=LBUCMAYvd9Mrh5sqoMRhp39vVEwDTYoxj4mjVGM4LCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=U78/mcuLzH4OfpNd5A4U2pSw3gf+Mq00IzYqNi0BUrDmzd+f/795aJGYavcIDVLO5
	 kHz0do7uCy9FzcJ0Xpn8+mfkECKrBPq1mfZdSotkmy3tlA5Gmng6VChQ3UZYCq8eSp
	 oOeOtFEzYfIWuWicnIr/N6ntcknouTCPG/l40LHk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbfAHJdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:33:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:52776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727689AbfAHJdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:33:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3647206B7;
        Tue,  8 Jan 2019 09:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546939993;
        bh=LBUCMAYvd9Mrh5sqoMRhp39vVEwDTYoxj4mjVGM4LCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QcqoVDtn2JYlxGdZiSq+qzhUeSQB95JYsFm/azYZ0mC9zVHLpa+cb6XdooKcELZee
         46teS+DRBxznAvHDCzeSI2ZPexOEj4YaCwvBbmyX6ZK8e3bOYPtdGbwJB/ulLIga/b
         s6/0DDI/P4qTFeYWVm4tYku1dwv2QEc8yJ26llRc=
Date:   Tue, 8 Jan 2019 10:33:10 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>,
        Paul Burton <paul.burton@mips.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.20 000/145] 4.20.1-stable review
Message-ID: <20190108093310.GA18042@kroah.com>
References: <20190107104437.308206189@linuxfoundation.org>
 <20190107211749.GA12835@roeck-us.net>
 <20190108074518.GF2102@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108074518.GF2102@kroah.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 08:45:18AM +0100, Greg Kroah-Hartman wrote:
> On Mon, Jan 07, 2019 at 01:17:49PM -0800, Guenter Roeck wrote:
> > On Mon, Jan 07, 2019 at 01:30:37PM +0100, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 4.20.1 release.
> > > There are 145 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Wed Jan  9 10:43:39 UTC 2019.
> > > Anything received after that time might be too late.
> > > 
> > Building mipsel64:fuloong2e_defconfig:fulong2e:rootfs ... failed
> > ------------
> > Error log:
> > In file included from ./arch/mips/include/asm/mmzone.h:10:0,
> >                  from ./arch/mips/include/asm/r4kcache.h:23,
> > 		 from arch/mips/mm/c-r4k.c:33:
> > ./arch/mips/include/asm/mach-loongson64/mmzone.h:48:0: error: "NODE_DATA" redefined
> 
> This one is odd, let me dig...

Ok, commit 66a4059ba72c ("MIPS: Only include mmzone.h when CONFIG_NEED_MULTIPLE_NODES=y")
is supposed to fix this issue, but that is included here already.

So I don't know what to suggest, does this issue also show up in Linus's
tree?

Paul, any ideas what is happening here?

thanks,

greg k-h
