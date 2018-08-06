Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EFBC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CDC421A53
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:35:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CDC421A53
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732864AbeHFRou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 13:44:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39914 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732548AbeHFRot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 13:44:49 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 49E3BD01;
        Mon,  6 Aug 2018 15:35:10 +0000 (UTC)
Date:   Mon, 6 Aug 2018 17:35:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Rue <dan.rue@linaro.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Subject: Re: [PATCH 4.4 000/124] 4.4.146-stable review
Message-ID: <20180806153508.GB20862@kroah.com>
References: <20180804082702.434482435@linuxfoundation.org>
 <CA+G9fYsZtw-OHh2cKC0VG5zwdKOMvnOx-cAVfp2qfY_drFQ4_Q@mail.gmail.com>
 <20180805134952.GA15972@kroah.com>
 <20180805151933.efzi3mawp22p3wex@linode.therub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180805151933.efzi3mawp22p3wex@linode.therub.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 05, 2018 at 03:19:33PM +0000, Dan Rue wrote:
> On Sun, Aug 05, 2018 at 03:49:52PM +0200, Greg Kroah-Hartman wrote:
> > On Sun, Aug 05, 2018 at 05:24:21PM +0530, Naresh Kamboju wrote:
> > > On 4 August 2018 at 14:29, Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > > This is the start of the stable review cycle for the 4.4.146 release.
> > > > There are 124 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > >
> > > > Responses should be made by Mon Aug  6 08:26:39 UTC 2018.
> > > > Anything received after that time might be too late.
> > > >
> > > > The whole patch series can be found in one patch at:
> > > >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.146-rc1.gz
> > > > or in the git tree and branch at:
> > > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> > > > and the diffstat can be found below.
> > > >
> > > > thanks,
> > > >
> > > > greg k-h
> > > 
> > > Results from Linaro’s test farm.
> > > No regressions on arm64, arm and x86_64.
> > 
> > Really?  How did you all miss the netfilter bug that was introduced by
> > this series?
> > 
> > Anyway, thanks for testing, but I'm worried...
> 
> I took a look through our test suites to see where we may have coverage for
> this. There is a netns series of tests in LTP [1], but we've had trouble
> getting them running successfully in the past and so they are being skipped. I
> don't know if it would have caught this particular issue, but I'll find out,
> and also see if we can get them working and running again.
> 
> We also run the net/ tests in kselftest, but there aren't that many, and of
> course running kselftest the way we do is not a well supported usecase (running
> all of 4.17 kselftest against 4.4 kernels, skipping tests that are broken).
> 
> So I would ask, how would net/ expect such things to be tested, and what can we
> do to help?

I don't know.  Somehow this was caught when running Android's userspace,
which seems to be a great stress test for networking.  What about
running the Android networking tests on kernels?  Those don't need to be
run on an android system to work properly last I checked.

thanks,

greg k-h
