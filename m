Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA56C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC7A21B68
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="SpFC1bFl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730357AbfBOCs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:48:27 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:42624 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727103AbfBOCs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:48:26 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id AE46F8EE23E;
        Thu, 14 Feb 2019 18:48:25 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NfGbFDjpEDAs; Thu, 14 Feb 2019 18:48:25 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id E51118EE15F;
        Thu, 14 Feb 2019 18:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1550198905;
        bh=Hdt5XqqSkBX1Pp/GVYTeN07WE45/gKKk88sNDiiMCbo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SpFC1bFlZbQaa6sggFEA2tXgWD2xOZyDuweLFKBKXQchgqCBqxBWwsqozGYcUxGRt
         jMK0Hfy390lHbfHrXbt2c41ANfGSHXqxcUrkwnHF/GL+zciae68S1FhYwya2P6vCDP
         KhYsEUucEmjYurFcGWZ3qW7bRXY7uJsXVydw/d8E=
Message-ID: <1550198902.2802.12.camel@HansenPartnership.com>
Subject: Re: [LSF/MM TOPIC] FS, MM, and stable trees
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Steve French <smfrench@gmail.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
Date:   Thu, 14 Feb 2019 18:48:22 -0800
In-Reply-To: <20190215015020.GJ69686@sasha-vm>
References: <20190212170012.GF69686@sasha-vm>
         <CAH2r5mviqHxaXg5mtVe30s2OTiPW2ZYa9+wPajjzz3VOarAUfw@mail.gmail.com>
         <CAOQ4uxjMYWJPF8wFF_7J7yy7KCdGd8mZChfQc5GzNDcfqA7UAA@mail.gmail.com>
         <20190213073707.GA2875@kroah.com>
         <CAOQ4uxgQGCSbhppBfhHQmDDXS3TGmgB4m=Vp3nyyWTFiyv6z6g@mail.gmail.com>
         <20190213091803.GA2308@kroah.com> <20190213192512.GH69686@sasha-vm>
         <20190213195232.GA10047@kroah.com>
         <1550088875.2871.21.camel@HansenPartnership.com>
         <20190215015020.GJ69686@sasha-vm>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-02-14 at 20:50 -0500, Sasha Levin wrote:
> On Wed, Feb 13, 2019 at 12:14:35PM -0800, James Bottomley wrote:
> > On Wed, 2019-02-13 at 20:52 +0100, Greg KH wrote:
> > > On Wed, Feb 13, 2019 at 02:25:12PM -0500, Sasha Levin wrote:
> > > > On Wed, Feb 13, 2019 at 10:18:03AM +0100, Greg KH wrote:
> > > > > On Wed, Feb 13, 2019 at 11:01:25AM +0200, Amir Goldstein
> > > > > wrote:
> > > > > > Best effort testing in timely manner is good, but a good
> > > > > > way to improve confidence in stable kernel releases is a
> > > > > > publicly available list of tests that the release went
> > > > > > through.
> > > > > 
> > > > > We have that, you aren't noticing them...
> > > > 
> > > > This is one of the biggest things I want to address: there is a
> > > > disconnect between the stable kernel testing story and the
> > > > tests the fs/ and mm/ folks expect to see here.
> > > > 
> > > > On one had, the stable kernel folks see these kernels go
> > > > through entire suites of testing by multiple individuals and
> > > > organizations, receiving way more coverage than any of Linus's
> > > > releases.
> > > > 
> > > > On the other hand, things like LTP and selftests tend to barely
> > > > scratch the surface of our mm/ and fs/ code, and the
> > > > maintainers of these subsystems do not see LTP-like suites as
> > > > something that adds significant value and ignore them. Instead,
> > > > they have a (convoluted) set of testing they do with different
> > > > tools and configurations that qualifies their code as being
> > > > "tested".
> > > > 
> > > > So really, it sounds like a low hanging fruit: we don't really
> > > > need to write much more testing code code nor do we have to
> > > > refactor existing test suites. We just need to make sure the
> > > > right tests are running on stable kernels. I really want to
> > > > clarify what each subsystem sees as "sufficient" (and have that
> > > > documented somewhere).
> > > 
> > > kernel.ci and 0-day and Linaro are starting to add the fs and mm
> > > tests to their test suites to address these issues (I think 0-day
> > > already has many of them).  So this is happening, but not quite
> > > obvious.  I know I keep asking Linaro about this :(
> > 
> > 0day has xfstests at least, but it's opt-in only (you have to
> > request that it be run on your trees).  When I did it for the SCSI
> > tree, I had to email Fenguangg directly, there wasn't any other way
> > of getting it.
> 
> It's very tricky to do even if someone would just run it.

It is?  It's a test suite, so you just run it and it exercises standard
and growing set of regression tests.

>  I worked with the xfs folks for quite a while to gather the various
> configs they want to use, and to establish the baseline for a few of
> the stable trees (some tests are know to fail, etc).

The only real config issue is per-fs non-standard tests (features
specific to a given filesystem).  I just want it to exercise the
storage underneath, so the SCSI tree is configured for the default set
on xfs.

> So just running xfstests "blindly" doesn't add much value beyond ltp
> I think.

Well, we differ on the value of running regression tests, then.  The
whole point of a test infrastructure is that it's simple to run 'make
check' in autoconf parlance.  xfstests does provide a useful baseline
set of regression tests.  However, since my goal is primarily to detect
problems in the storage path rather than the filesystem, the utility is
exercising that path, although I fully appreciate that filesystem
regression tests aren't going to catch every SCSI issue, they do
provide some level of assurance against bugs.

Hopefully we can switch over to blktests when it's ready, but in the
meantime xfstests is way better than nothing.

James

