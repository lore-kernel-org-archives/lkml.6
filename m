Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4329BC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 15:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E85EC208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 15:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.b="hhKOwioM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E85EC208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755364AbeFNPve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 11:51:34 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:58073 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755072AbeFNPvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 11:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kMXXc3CH88dMWARCrTUV+Xq3PBFh8amPyd28dflAd88=; b=hhKOwioMKpga+N61WhcZXqfFE6
        66gGI91IOEWM7HM5eoX7TISM4lRxS/zDQpRsHleSIR+quJKIt6VoXKylPOB6OnSa+xFn52VgbprRw
        EoHTbOH3hP0CFTcdE7d3REUl0Lp69La9ijyhsr3CyRlRhgjuPD/002m2Oyu0wGFKLvN1iBpfjKrPr
        Iz/o4f74r3wpTv2Js5tSSlqu4qs9PAISKO1kOuLz/N0lSBt9qszQXEAgrdQxTDHLBEaYc3UrCWJJO
        L5Kk6rJAWR29oq6VnFLI+c/w3JmgSC1T9vWHMIHGpvL3DKtT9fQ+Ain/7XtIDUKVWi9LT8x4mQGpy
        R3ZQGNwQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:39136 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1fTUX2-00BIrF-3O; Thu, 14 Jun 2018 15:51:30 +0000
Date:   Thu, 14 Jun 2018 08:51:27 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "kernelci.org bot" <bot@kernelci.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/21] 3.18.113-stable review
Message-ID: <20180614155127.GA9178@roeck-us.net>
References: <20180612164825.401145490@linuxfoundation.org>
 <5b20444c.1c69fb81.cb5e6.5a8d@mx.google.com>
 <20180613044055.GA32451@kroah.com>
 <7hfu1qw7o8.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7hfu1qw7o8.fsf@baylibre.com>
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

On Wed, Jun 13, 2018 at 05:09:11PM -0700, Kevin Hilman wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> > On Tue, Jun 12, 2018 at 03:08:12PM -0700, kernelci.org bot wrote:
> >> stable-rc/linux-3.18.y boot: 52 boots: 28 failed, 18 passed with 1 offline, 5 conflicts (v3.18.112-22-gb0582263e3c9)
> >> 
> >> Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux-3.18.y/kernel/v3.18.112-22-gb0582263e3c9/
> >> Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-3.18.y/kernel/v3.18.112-22-gb0582263e3c9/
> >> 
> >> Tree: stable-rc
> >> Branch: linux-3.18.y
> >> Git Describe: v3.18.112-22-gb0582263e3c9
> >> Git Commit: b0582263e3c9810fd887ca92d19cb9ff30a4d9f6
> >> Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> >> Tested: 24 unique boards, 12 SoC families, 13 builds out of 183
> 
> [...]
> 
> >
> > That is a lot of new failures, did the whole lab fail, or is this really
> > a problem in v3.18.112 here?
> 
> Whole lab failure (more precisely, lab operator failure)  ;)
> 
> gak, I updated the rootfs images to the latest buildroot, which forced
> me to upgrade the kernel headers used to build the rootfs from v3.10 to
> v4.4.  So I guess it's no surprise that every single board panic'd as
> soon as it hit userspace.
> 
I build my root file systems with buildroot, and had a similar problem. My fix
was to patch buildroot to let me use older linux headers.

Guenter

> I downgraded the rootfs, and re-ran all those boot tests, and now things
> are 100% passing in my lab.
> 
> Sorry for the noise,
> 
> Kevin
