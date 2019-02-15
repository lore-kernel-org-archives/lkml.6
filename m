Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E67C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 01:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A1D2229F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 01:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550195424;
	bh=SrpytnwARM1mJLTjr4gqtS19qJrRqNK0e1rIS0pu3BU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dJWoEvVPEfOYqkoB/ogNkivUk+JLNGLiLO0gTMnOHBs9Skxx1Xv1MDwWsWAlURBpH
	 iEIS36wOojFxNCFyAQulyb34dL6zQpcL2+wNgkJTwDV7o18hN9hKoJyi+PQMTJq3cR
	 IBf29mndhFO24adJamj9bUCuWAXpuwFYuI9Hm0bo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731017AbfBOBuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 20:50:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:39102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730852AbfBOBuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 20:50:23 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7797A21934;
        Fri, 15 Feb 2019 01:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550195421;
        bh=SrpytnwARM1mJLTjr4gqtS19qJrRqNK0e1rIS0pu3BU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BHXRGPVIG6SLeXma4mzXznz5vji0QPOy5UceOKsYtVWtT9PxZajJbK0XZITkLVJSs
         7r8U4V69QHZgqfaviUfdqKugSr3hWHgnOhzz6N6LxLbhYgwe/hFHKW2ssPG4Q/qHbO
         5ffC9IjvkA9uzJI27P0vh9+jws0vmZr/zCbeNlwY=
Date:   Thu, 14 Feb 2019 20:50:20 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Steve French <smfrench@gmail.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [LSF/MM TOPIC] FS, MM, and stable trees
Message-ID: <20190215015020.GJ69686@sasha-vm>
References: <20190212170012.GF69686@sasha-vm>
 <CAH2r5mviqHxaXg5mtVe30s2OTiPW2ZYa9+wPajjzz3VOarAUfw@mail.gmail.com>
 <CAOQ4uxjMYWJPF8wFF_7J7yy7KCdGd8mZChfQc5GzNDcfqA7UAA@mail.gmail.com>
 <20190213073707.GA2875@kroah.com>
 <CAOQ4uxgQGCSbhppBfhHQmDDXS3TGmgB4m=Vp3nyyWTFiyv6z6g@mail.gmail.com>
 <20190213091803.GA2308@kroah.com>
 <20190213192512.GH69686@sasha-vm>
 <20190213195232.GA10047@kroah.com>
 <1550088875.2871.21.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1550088875.2871.21.camel@HansenPartnership.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 12:14:35PM -0800, James Bottomley wrote:
>On Wed, 2019-02-13 at 20:52 +0100, Greg KH wrote:
>> On Wed, Feb 13, 2019 at 02:25:12PM -0500, Sasha Levin wrote:
>> > On Wed, Feb 13, 2019 at 10:18:03AM +0100, Greg KH wrote:
>> > > On Wed, Feb 13, 2019 at 11:01:25AM +0200, Amir Goldstein wrote:
>> > > > Best effort testing in timely manner is good, but a good way to
>> > > > improve confidence in stable kernel releases is a publicly
>> > > > available list of tests that the release went through.
>> > >
>> > > We have that, you aren't noticing them...
>> >
>> > This is one of the biggest things I want to address: there is a
>> > disconnect between the stable kernel testing story and the tests
>> > the fs/ and mm/ folks expect to see here.
>> >
>> > On one had, the stable kernel folks see these kernels go through
>> > entire suites of testing by multiple individuals and organizations,
>> > receiving way more coverage than any of Linus's releases.
>> >
>> > On the other hand, things like LTP and selftests tend to barely
>> > scratch the surface of our mm/ and fs/ code, and the maintainers of
>> > these subsystems do not see LTP-like suites as something that adds
>> > significant value and ignore them. Instead, they have a
>> > (convoluted) set of testing they do with different tools and
>> > configurations that qualifies their code as being "tested".
>> >
>> > So really, it sounds like a low hanging fruit: we don't really need
>> > to write much more testing code code nor do we have to refactor
>> > existing test suites. We just need to make sure the right tests are
>> > running on stable kernels. I really want to clarify what each
>> > subsystem sees as "sufficient" (and have that documented
>> > somewhere).
>>
>> kernel.ci and 0-day and Linaro are starting to add the fs and mm
>> tests to their test suites to address these issues (I think 0-day
>> already has many of them).  So this is happening, but not quite
>> obvious.  I know I keep asking Linaro about this :(
>
>0day has xfstests at least, but it's opt-in only (you have to request
>that it be run on your trees).  When I did it for the SCSI tree, I had
>to email Fenguangg directly, there wasn't any other way of getting it.

It's very tricky to do even if someone would just run it. I worked with
the xfs folks for quite a while to gather the various configs they want
to use, and to establish the baseline for a few of the stable trees
(some tests are know to fail, etc).

So just running xfstests "blindly" doesn't add much value beyond ltp I
think.

--
Thanks,
Sasha
