Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B7DC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF0CF2075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Xvbef/y7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZKKEOsay"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF0CF2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbeIGRuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 13:50:32 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56139 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727653AbeIGRuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 13:50:32 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id A4D7E21193;
        Fri,  7 Sep 2018 09:09:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 07 Sep 2018 09:09:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=c7zs8QEZs8yzY7Wh48v4OFVbIUm5kW1s2juj1HdfhZU=; b=Xvbef/y7
        nvdQrqszHVkDxjJp7BzlLWomX70WKKsKVHp7c1wMh5WStmpyAjInIYzvZPson1Ki
        rxTamDdJrk800J3ovDDGZ4iEZ3d4rpUwAd18j94jxU1Uh0Y7TWAeg857SKWArUR0
        7bphmzJ3MP6hpFpIO8NcXC/YsIpu1Qqs2wc1odfisz45Di8BI+YsdBu6kZLL5UU6
        sVAbopluTtYO4WJcKGWcBTcM5eDwhtX/gLiBUb8iASX9WXGlDSgqdA/ANE/B2dMn
        I0OOLXVpU4f2+TZv29xE+lZV9hg1BEDXHZ8J3aqBpYDII4s04PP1vmt1cTQtjsga
        sk2xNLq5Ay7aNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=c7zs8QEZs8yzY7Wh48v4OFVbIUm5k
        W1s2juj1HdfhZU=; b=ZKKEOsaylp630W2oVYrLYnDQIy3nm3K1ldQ1/pzrJIbkQ
        ZhXIb03Wm8EOTGAV81jfvm+sbDoszqiC6H8cRgD9jeHtvTh6vgSl11f6x9J/q+ga
        hvdQZwJOifLzv8uBoi3Wn5sTQtXzNlb2g7UC2uemV9ZbVepXAx3px0cSrAsnQa27
        TmNdUJinM5rcvVSkS/A4NSBZ/PUvsR2hOGe6lb1yhbPGi4IeSetEqqBf8NcHi32d
        RIj/DzOjkPcTHILhTfZPUYUy+uhP50abmcFVVeeZYC0Uq3EhqQW5TVSNkA52vxzi
        +ORfjtS7zcRNpjA/MI5WuS2+sjDdUiowqB+X3TCsw==
X-ME-Proxy: <xmx:kHiSW6faqqJLzBmRbOVNmzI_U2oIzkUN_YT5v2Zx4n_nLirckOWALw>
    <xmx:kHiSW6pepmzhSlm4v8k8fm1Uc2UvUmTsTrXRB48bYcr1SGtXLWXxDA>
    <xmx:kHiSW0UdNVdTS1T-M0sJLwLceMV1sCMgDISpuDb2zPpgM4sKTORuVQ>
    <xmx:kHiSW61Z8a-f0ZCGKax8e1O_5ssrCf4HfzChr4DuX4p2TlGAFFuw6w>
    <xmx:kHiSW2D7NGFumnEpeXugGK4dsyPxvvWU9hdHR9H9jHEHOFwwIxzGMQ>
    <xmx:kXiSWxoMeNrNsBM5pGj2xOKxBtf1KCxgMuzQHgz2dVayGzkEvWH07Q>
X-ME-Sender: <xms:kHiSWypPB4WJwHkopWeQaWF1lquxqJDILQLSZkYgyN8XRa2mie_tlQ>
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.messagingengine.com (Postfix) with ESMTPA id E034810293;
        Fri,  7 Sep 2018 09:09:35 -0400 (EDT)
Date:   Fri, 7 Sep 2018 15:09:34 +0200
From:   Greg KH <greg@kroah.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andreas Dilger <andreas.dilger@intel.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] ext4 updates for 3.11
Message-ID: <20180907130934.GA22855@kroah.com>
References: <nsxbo6mxu38.fsf@lambda.thunk.org>
 <20130703094529.99444050e676467d281a3b51@canb.auug.org.au>
 <CA+55aFxdAHqEhnV-zKwExVfBAvw=k8+GprTGniNz=TpJM6obtQ@mail.gmail.com>
 <20130703005419.GA7744@kroah.com>
 <CA+55aFxdNVX9koH=GViv1Haj3kU07PD-CTKCNuWrm-c-BF3mQw@mail.gmail.com>
 <20130703010111.GA7986@kroah.com>
 <20130703032941.GH14996@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130703032941.GH14996@dastard>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Digging up an email thread from 2013...

On Wed, Jul 03, 2013 at 01:29:41PM +1000, Dave Chinner wrote:
> On Tue, Jul 02, 2013 at 06:01:11PM -0700, Greg KH wrote:
> > On Tue, Jul 02, 2013 at 05:58:15PM -0700, Linus Torvalds wrote:
> > > On Tue, Jul 2, 2013 at 5:54 PM, Greg KH <greg@kroah.com> wrote:
> > > > On Tue, Jul 02, 2013 at 05:02:21PM -0700, Linus Torvalds wrote:
> > > >>
> > > >> I'm really not convinced this whole Lustre thing was correctly
> > > >> handled. Merging it into stable and yet being in such bad shape that
> > > >> it isn't enabled even there? I just dunno. But I have the turd in my
> > > >> tree now, let's hope it gets fixed up.
> > > >
> > > > It's in "staging", not "stable" :)
> > > 
> > > Yes. But what was the reason to actually merge it even there? And once
> > > it gets merged, disabling it again rather than fixing the problems it
> > > has?
> > 
> > The problems turned out to be too big, too late in the merge cycle for
> > me to be able to take them (they still aren't even done, as I don't have
> > a working set of patches yet.)  So I just disabled it from the build to
> > give Andreas and team time to get it working properly.
> > 
> > I could have just removed it, but I thought I would give them a chance.
> > 
> > > This is a filesystem that Intel apparently wants to push. I think it
> > > would have been a better idea to push back a bit and say "at least
> > > clean it up a bit first". It's not like Intel is one of the clueless
> > > companies that couldn't have done so and need help from the community.
> > 
> > For this filesystem, it seems that they don't have any resources to do
> > this work and are relying on the community to help out.  Which is odd,
> > but big companies are strange some times...
> 
> Didn't we learn this lesson already with POHMELFS? i.e. that dumping
> filesystem code in staging on the assumption "the community" will
> fix it up when nobody in "the community" uses or can even test that
> filesystem is a broken development model....

Dave, and Linus, you were totally right here.  Sorry for not listening
to you before, my fault.  The lustre developers never got their act
together and probably by this being in staging, it only prolonged the
agony of everyone involved.

greg k-h
