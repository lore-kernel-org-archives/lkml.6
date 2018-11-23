Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF45FC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C5620861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcfB6vtV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88C5620861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439579AbeKWS2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 13:28:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:52226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731610AbeKWS2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 13:28:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67B5220685;
        Fri, 23 Nov 2018 07:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542959102;
        bh=Bxb5wPWn+tkcROoyBSntFU4Ls7NdMpntx6a62Z9+0eA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dcfB6vtVy2ifrf1MJfB8Fo+0kC3k2D0dK5KSUX14NQgSX8waZQWZ3kEV1zVbH5oqD
         XDnZ4P3hluGbd21PF+tNqsUvdJPFPxbd2V7fdQRmnaugH622qGn1bTrbxhh3B+f2bA
         Yz6Mp4xRupRPvyAn0iYPbeTQW4E0yecnkzOjXpfY=
Date:   Fri, 23 Nov 2018 08:45:00 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Thomas Voegtle <tv@lio96.de>, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH 4.19 00/42] 4.19.4-stable review
Message-ID: <20181123074500.GA31919@kroah.com>
References: <20181121183147.869199006@linuxfoundation.org>
 <alpine.LSU.2.21.1811222148260.12239@er-systems.de>
 <alpine.LSU.2.21.1811222259160.22493@er-systems.de>
 <259dad79-9bed-0b6b-3723-82bf4a0a9603@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <259dad79-9bed-0b6b-3723-82bf4a0a9603@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 02:30:58PM -0800, Guenter Roeck wrote:
> On 11/22/18 2:01 PM, Thomas Voegtle wrote:
> > On Thu, 22 Nov 2018, Thomas Voegtle wrote:
> > 
> > > 
> > > Doesn't compile for me on OpenSuSE 15.0 (gcc 7.3.1):
> > > 
> > >   CALL    scripts/checksyscalls.sh
> > >   DESCEND  objtool
> > >   CHK     include/generated/compile.h
> > >   CC [M]  drivers/gpu/drm/i915/i915_gem_gtt.o
> > > drivers/gpu/drm/i915/i915_gem_gtt.c: In function ‘gen6_dump_ppgtt’:
> > > drivers/gpu/drm/i915/i915_gem_gtt.c:1771:41: error: format ‘%llx’ expects
> > > argument of type ‘long long unsigned int’, but argument 5 has type ‘long
> > > unsigned int’ [-Werror=format=]
> > >    seq_printf(m, "\t\t(%03d, %04d) %08llx: ",
> > >                                    ~~~~~ ^
> > >                                    %08lx
> > > cc1: all warnings being treated as errors
> > > make[4]: *** [scripts/Makefile.build:306:
> > > drivers/gpu/drm/i915/i915_gem_gtt.o] Error 1
> > > make[3]: *** [scripts/Makefile.build:546: drivers/gpu/drm/i915] Error 2
> > > make[2]: *** [scripts/Makefile.build:546: drivers/gpu/drm] Error 2
> > > make[1]: *** [scripts/Makefile.build:546: drivers/gpu] Error 2
> > > make: *** [Makefile:1052: drivers] Error 2
> > > 
> > > 
> > > 
> > > 4.19.3 is broken for me, too. 4.19.2 is works.
> > > 4.20-rc tree works.
> > > 
> > > Config attached.
> > 
> > 
> > quick bisect shows problem is:
> > 
> > commit 1a25e1a1be71a49ee7f34fb14b5a26191e6cf501
> > Author: Chris Wilson <chris@chris-wilson.co.uk>
> > Date:   Thu Oct 25 10:18:22 2018 +0100
> > 
> >      drm/i915: Mark up GTT sizes as u64
> > 
> >      commit c58281056a8b26d5d9dc15c19859a7880835ef44 upstream.
> > 
> > 
> > reverted on 4.19.4-rc1 it compiles for me. I guess something is missing here?
> > 
> AFAICS someone was not careful with the backport. Upstream doesn't have %llx
> at that place.

Yes it does, unless I'm reading the code wrong?

It seems that this does not trigger on upstream due to f6e35cda6614
("drm/i915: Replace some PAGE_SIZE with I915_GTT_PAGE_SIZE") being
there, which changed the type of the variable being displayed here.

I've now backported that as well, as it should help out over time, and
the build warning seems to be gone.

thanks,

greg k-h
