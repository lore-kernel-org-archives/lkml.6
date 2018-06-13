Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 885CFC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CD16208D6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.b="reDG/uox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CD16208D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964787AbeFMRjs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 13:39:48 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:60114 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935352AbeFMRjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 13:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FMwvdSdWgj9WJ/qxTnsiUl1jnZgIp2V9AAF/TZxbC/A=; b=reDG/uoxjcMcodS6YXT7iTM7MR
        lHSDKUBqh7HRPqxkI/dLcG10TQ1Jg+ng+UIdAspzb9QQ8twf5yuvCLddqK5ZN4iCwNmQRIh/AE5cU
        A2SPNdRUjwvu3A4cTlkjlSfClBNxcmGhuskqUdQvqHj76RFckEYFYdN2d14LlDG7TZt+qDb+uxFD3
        XAF/ZOBG/crMp+WKeMtr2fLFOb0XxNpfvM1g0IiyxhnpoihA799fGvRXfUlid+ua+cHc+eM/OZlXL
        9W204tcuTpjMFzHCCI3J7Bkt63DvQJgPg5RL9xtGuS/NafXt+1KGQCH28VC6BcKo+y3G1c8CzlHsE
        B02NF1wA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:58668 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1fT9kH-0069bn-Mz; Wed, 13 Jun 2018 17:39:46 +0000
Date:   Wed, 13 Jun 2018 10:39:44 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/21] 3.18.113-stable review
Message-ID: <20180613173944.GA12017@roeck-us.net>
References: <20180612164825.401145490@linuxfoundation.org>
 <bc0f332d-bb9f-35c6-18b0-8dfd282bbf1c@roeck-us.net>
 <20180613140957.GB5117@kroah.com>
 <20180613145815.GA21781@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613145815.GA21781@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 04:58:15PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jun 13, 2018 at 04:09:57PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Jun 13, 2018 at 06:48:05AM -0700, Guenter Roeck wrote:
> > > On 06/12/2018 09:51 AM, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 3.18.113 release.
> > > > There are 21 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Thu Jun 14 16:48:15 UTC 2018.
> > > > Anything received after that time might be too late.
> > > > 
> > > 
> > > Build results:
> > > 	total: 138 pass: 136 fail: 2
> > > Failed builds:
> > > 	i386:tools/perf
> > > 	x86_64:tools/perf
> > > Qemu test results:
> > > 	total: 127 pass: 127 fail: 0
> > > 
> > > The perf test only fails because I run "make tools/perf" instead of
> > > "(cd tools/perf; make)". Fixing this requires the following two patches.
> > > 
> > > 379a9a28a1b4 tools build: No need to make libapi for perf explicitly
> > > 16671c1e1cac tools build: Fix Makefile(s) to properly invoke tools build
> > 
> > Thanks for this, and the other 3 results.  I'll just add these commits
> > to the next kernel as this is not a new failure.
> 
> I've queued these up now, but I still can't build perf for 3.18.  Given
> that no one has reported a problem with it so far, I'm guessing that no
> one cares, so I'll just leave it as-is for now.
> 
Ah, I should have waited for the test build to complete after applying the
patches. Sorry for that. Apparently there are additional dependencies.
(cd tools/perf; make) does work. I'll switch to use that for v3.16
(which has the same problem) and v3.18.

Guenter
