Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB2DC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD04B222D3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550087557;
	bh=QPejU1nGrklF7jDizGBjyiGrwlYJaw0zDwsmtyviJMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kPdlz+buF2W2c45mRc8d5jxn9vWrIOoRwCdCK2rXa1wsR2Bm29LaZ0yJV8Oo/qAoi
	 LujDwAypq2tE5LXM2C1k3oGcaO9YrTnzxAARAkyoM98HcaJH07Gl0ruzDWBdPQKvHM
	 PCu80FwyxU1qgbWtpO8k9NPNVOLlpxJLZctHvfR0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436562AbfBMTwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 14:52:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:52362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbfBMTwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 14:52:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A3E2222D0;
        Wed, 13 Feb 2019 19:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550087555;
        bh=QPejU1nGrklF7jDizGBjyiGrwlYJaw0zDwsmtyviJMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wLQSK0O2xlZnT8wJXZOUBFdQqO7UePZ5A18ViCuRUzPEfsk9BViBVbFcu7TJYzAIP
         OYdioetc94BDZEXy7TG3isjRJz5nwKtj/8lsH2cZM2T7fyS1p7CNQJGt2BSEumDLhs
         wMLq7YZsaokSPjRFfREA6ZMUROGf6jlyXAi2K4+0=
Date:   Wed, 13 Feb 2019 20:52:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Steve French <smfrench@gmail.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [LSF/MM TOPIC] FS, MM, and stable trees
Message-ID: <20190213195232.GA10047@kroah.com>
References: <20190212170012.GF69686@sasha-vm>
 <CAH2r5mviqHxaXg5mtVe30s2OTiPW2ZYa9+wPajjzz3VOarAUfw@mail.gmail.com>
 <CAOQ4uxjMYWJPF8wFF_7J7yy7KCdGd8mZChfQc5GzNDcfqA7UAA@mail.gmail.com>
 <20190213073707.GA2875@kroah.com>
 <CAOQ4uxgQGCSbhppBfhHQmDDXS3TGmgB4m=Vp3nyyWTFiyv6z6g@mail.gmail.com>
 <20190213091803.GA2308@kroah.com>
 <20190213192512.GH69686@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213192512.GH69686@sasha-vm>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 02:25:12PM -0500, Sasha Levin wrote:
> On Wed, Feb 13, 2019 at 10:18:03AM +0100, Greg KH wrote:
> > On Wed, Feb 13, 2019 at 11:01:25AM +0200, Amir Goldstein wrote:
> > > Best effort testing in timely manner is good, but a good way to
> > > improve confidence in stable kernel releases is a publicly
> > > available list of tests that the release went through.
> > 
> > We have that, you aren't noticing them...
> 
> This is one of the biggest things I want to address: there is a
> disconnect between the stable kernel testing story and the tests the fs/
> and mm/ folks expect to see here.
> 
> On one had, the stable kernel folks see these kernels go through entire
> suites of testing by multiple individuals and organizations, receiving
> way more coverage than any of Linus's releases.
> 
> On the other hand, things like LTP and selftests tend to barely scratch
> the surface of our mm/ and fs/ code, and the maintainers of these
> subsystems do not see LTP-like suites as something that adds significant
> value and ignore them. Instead, they have a (convoluted) set of testing
> they do with different tools and configurations that qualifies their
> code as being "tested".
> 
> So really, it sounds like a low hanging fruit: we don't really need to
> write much more testing code code nor do we have to refactor existing
> test suites. We just need to make sure the right tests are running on
> stable kernels. I really want to clarify what each subsystem sees as
> "sufficient" (and have that documented somewhere).

kernel.ci and 0-day and Linaro are starting to add the fs and mm tests
to their test suites to address these issues (I think 0-day already has
many of them).  So this is happening, but not quite obvious.  I know I
keep asking Linaro about this :(

Anyway, just having a list of what tests each subsystem things is "good
to run" would be great to have somewhere.  Ideally in the kernel tree
itself, as that's what kselftests are for :)

thanks,

greg k-h
