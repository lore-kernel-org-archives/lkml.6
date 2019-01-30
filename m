Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACB9C282C7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 02:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 659F720870
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 02:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="cjkx6i/t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cK5Zx94N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbfA3CoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 21:44:23 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:36819 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729718AbfA3CoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 21:44:23 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id AD6661719;
        Tue, 29 Jan 2019 21:44:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 29 Jan 2019 21:44:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        Gc6FHnmci9DMdKktV5Xl7cyp+gzcAF5J3MrudSjp00c=; b=cjkx6i/tn2+/LNgN
        oTWKlrBmSdZbUbsT8CQIaZ3z7O/TNfcINaCjAfGOFWVKVxxTZWYG1QPQh0M7xQZv
        5gbYo+jpu36+zYFYo1IKadWsRlo+dKvyXmxRf844vYukcv112QGw2QVbyYk7Qqgl
        pF2XILyom2W2fjRjunCD7Ri2s8AKi3GktSBeuCRTlKkOeAGoT2bVrxlaK5fmsTHn
        bjF4Fq8M576YuLyGj+kQof4kmPDgKBT5rgjub4ZA1hFGritPvVyTEg48BBjOwVd0
        Z9KzovBULNGE+tN1YKNvFB3Lpzu4mLp0PjUd8Q04WnCMAOjwiYKU7aF4hn1GcwVV
        vAIchw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=Gc6FHnmci9DMdKktV5Xl7cyp+gzcAF5J3MrudSjp0
        0c=; b=cK5Zx94NYH5L5QtVUGUQBmnXqEkXJmNXpXp6N4rKgX6FS9Bq2POZdEFLE
        wf0BraNJssbHycx6lhLSScVGetMnDung+SaV4ngEt8GY3GndvVoKt07PYYyD5urG
        26tjoRkUTuOk8nQyHK4zXxlsgi1uue5cA+5LEoiRCYfOMKh4O45hEX9ImkK34g9d
        UUfY5rVUrFpJRByNZyk8Xe4nBLP8RzbQjyDwoRr8NZljbDnrTz+1v4hsGReARWvl
        ozK8oy9J0pRTVtR1N2EobD4DTrotVH7gnmbbQWTKsldG3WW7Tw4HUXuV1UW6lubB
        OIDmv8WXKzM7XsfAe8wfkxkSMlJaw==
X-ME-Sender: <xms:hA9RXE_feBtCHRfpvKhdLN-r6_ckyA1bPuJYGIXIjl0lFuVRXi9xpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrjeefgdehvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
    tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfh
    gtofgggfesthejredtredtjeenucfhrhhomhepkfgrnhcumfgvnhhtuceorhgrvhgvnhes
    thhhvghmrgifrdhnvghtqeenucfkphepuddukedrvddtkedrudeijedrheeinecurfgrrh
    grmhepmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvthenucevlhhushht
    vghrufhiiigvpedt
X-ME-Proxy: <xmx:hQ9RXC0TG0UalWkjTOvmrgRZBMFBKPAk34VU0T1aFLm4nSpVnbnK_A>
    <xmx:hQ9RXPk_-R1tFg79KSturUCixxu74VvkxEmhMXLEjij8WO6zHzXZOg>
    <xmx:hQ9RXH2QS-BsJwLzg8LLHhty4IxlwLPkgDMh2RkCP_xMPbt73uTZSw>
    <xmx:hQ9RXMk83I2CP8dhANffeolsIRUZwZ6NJ2S1KxOPoVkowysvOCVuwA>
Received: from localhost (unknown [118.208.167.56])
        by mail.messagingengine.com (Postfix) with ESMTPA id DB483E41F3;
        Tue, 29 Jan 2019 21:44:18 -0500 (EST)
Message-ID: <804b86df6fd678147da816be038b11c87333b23f.camel@themaw.net>
Subject: Re: [PATCH 3/3] autofs: add ignore mount option
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Wed, 30 Jan 2019 10:44:15 +0800
In-Reply-To: <553f4a0daf09407371193d7d4782a759561a626a.camel@themaw.net>
References: <154725122396.11260.16053424107144453867.stgit@pluto-themaw-net>
         <154725123970.11260.6113771566924907275.stgit@pluto-themaw-net>
         <20190129171622.5b75f794d2b1e4d1055331eb@linux-foundation.org>
         <553f4a0daf09407371193d7d4782a759561a626a.camel@themaw.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-01-30 at 10:07 +0800, Ian Kent wrote:
> On Tue, 2019-01-29 at 17:16 -0800, Andrew Morton wrote:
> > On Sat, 12 Jan 2019 08:00:40 +0800 Ian Kent <raven@themaw.net> wrote:
> > 
> > > Add an autofs file system mount option that can be used to provide
> > > a generic indicator to applications that the mount entry should be
> > > ignored when displaying mount information.
> > 
> > What is the reason for adding this feature?
> 
> In other OSes that provide autofs and that provide a mount list
> to user space based on the kernel mount list a no-op mount option
> ("ignore" is the one use on the most common OS) is allowed so that
> autofs file system users can optionally use it.
> 
> The idea is that it be used by user space programs to exclude
> autofs mounts from consideration when reading the mounts list.
> 
> Prior to the change to link /etc/mtab to /proc/self/mounts all
> I needed to do to achieve this was to use mount(2) and not update
> the mtab but now that no longer works.
> 
> I know the symlinking happened a long time ago and I considered
> doing this then but, at the time I couldn't remember the commonly
> used option name and thought persuading the various utility
> maintainers would be too hard.
> 
> But now I have a RHEL request to do this for compatibility for a
> widely used product so I want to go ahead with it and try and
> enlist the help of some utility package maintainers.

Al,

On a different note the above request also raised another
question about statvfs(3) automount behaviour.

In glibc statvfs(3) uses statfs(2) and translates the return
to a statvfs structure.

I wasn't aware but apparently statvfs(3) (and presumably statfs(2))
doesn't trigger an automount on Solaris whereas we do. I think
statfs() is probably the only exception to the convention that
stat family system calls don't trigger an automount.

So far I've said that this is a long standing behaviour in the
Linux kernel and changing it could lead to unpleasant surprises
for those that have come to expect this behaviour so such a change
would not be well received.

But I do need to ask your opinion, so what are your thoughts about
changing this?

Ian

