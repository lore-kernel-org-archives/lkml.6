Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7D867C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33175208B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nh2rvWSZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33175208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935856AbeFMOKW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:10:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:37434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935765AbeFMOKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:10:20 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DC42208B0;
        Wed, 13 Jun 2018 14:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528899019;
        bh=xX1OGik/Tziv/0lvTJG2pYC4S00eWNY3THJsQcJVsHM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nh2rvWSZ778R7vVbQbV/YUj2wW6wA5F5UELyczbTZ1VWmhbKtQDMzjWQpTU1j6vkr
         a+/uu0ANBZJ8zCk2+P13hSI9hjOmmvE40m8nrI0sfoCwaOwCQv1zr8HlHo6oHRYHas
         S+qV2sibz7gAH9EtN68WXC+sNiNhfvSVA/s2gHXA=
Date:   Wed, 13 Jun 2018 16:09:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/21] 3.18.113-stable review
Message-ID: <20180613140957.GB5117@kroah.com>
References: <20180612164825.401145490@linuxfoundation.org>
 <bc0f332d-bb9f-35c6-18b0-8dfd282bbf1c@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc0f332d-bb9f-35c6-18b0-8dfd282bbf1c@roeck-us.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 06:48:05AM -0700, Guenter Roeck wrote:
> On 06/12/2018 09:51 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 3.18.113 release.
> > There are 21 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu Jun 14 16:48:15 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 138 pass: 136 fail: 2
> Failed builds:
> 	i386:tools/perf
> 	x86_64:tools/perf
> Qemu test results:
> 	total: 127 pass: 127 fail: 0
> 
> The perf test only fails because I run "make tools/perf" instead of
> "(cd tools/perf; make)". Fixing this requires the following two patches.
> 
> 379a9a28a1b4 tools build: No need to make libapi for perf explicitly
> 16671c1e1cac tools build: Fix Makefile(s) to properly invoke tools build

Thanks for this, and the other 3 results.  I'll just add these commits
to the next kernel as this is not a new failure.

greg k-h
