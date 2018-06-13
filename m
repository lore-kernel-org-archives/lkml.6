Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 59930C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED74208B5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMnYIEef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EED74208B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935992AbeFMO6l (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:58:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:48824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935498AbeFMO6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:58:38 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18B0F208AF;
        Wed, 13 Jun 2018 14:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528901917;
        bh=xm9/+8/fdhhXSn5N+R2izh5lD7/+K9XyPtocoXqlxX0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SMnYIEefohKAqy4EvXw1zGf+mjw+cbGT3xdCKyxQ+ma/VfHbd39zdl0DW5XR5s3YU
         pGgokg9YAhaUxpfPew73w+H+dBVK51ocfqK147N4jcaH/1t3EdPpzHeZupj95rFZLt
         J/uFKqPMxkfcNzN28Njwe7T+/ePcPRcH3RD8wq90=
Date:   Wed, 13 Jun 2018 16:58:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/21] 3.18.113-stable review
Message-ID: <20180613145815.GA21781@kroah.com>
References: <20180612164825.401145490@linuxfoundation.org>
 <bc0f332d-bb9f-35c6-18b0-8dfd282bbf1c@roeck-us.net>
 <20180613140957.GB5117@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613140957.GB5117@kroah.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 04:09:57PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jun 13, 2018 at 06:48:05AM -0700, Guenter Roeck wrote:
> > On 06/12/2018 09:51 AM, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 3.18.113 release.
> > > There are 21 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Thu Jun 14 16:48:15 UTC 2018.
> > > Anything received after that time might be too late.
> > > 
> > 
> > Build results:
> > 	total: 138 pass: 136 fail: 2
> > Failed builds:
> > 	i386:tools/perf
> > 	x86_64:tools/perf
> > Qemu test results:
> > 	total: 127 pass: 127 fail: 0
> > 
> > The perf test only fails because I run "make tools/perf" instead of
> > "(cd tools/perf; make)". Fixing this requires the following two patches.
> > 
> > 379a9a28a1b4 tools build: No need to make libapi for perf explicitly
> > 16671c1e1cac tools build: Fix Makefile(s) to properly invoke tools build
> 
> Thanks for this, and the other 3 results.  I'll just add these commits
> to the next kernel as this is not a new failure.

I've queued these up now, but I still can't build perf for 3.18.  Given
that no one has reported a problem with it so far, I'm guessing that no
one cares, so I'll just leave it as-is for now.

thanks,

greg k-h
