Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E074CC169C4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 02:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC6720880
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 02:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="VuabjD6C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TKQiwjOf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbfA3CHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 21:07:23 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:55709 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727558AbfA3CHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 21:07:22 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 81DA917BA;
        Tue, 29 Jan 2019 21:07:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 29 Jan 2019 21:07:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        yfTW4eZb1oyF14NllSamtvS5448NNG6QM44agwdZzeY=; b=VuabjD6CEoSb1KEO
        D8FsGMkxJp1rgGD7N3Yeosgr0LGU+xm8fI4IjMLYZJwsoDSA04yz40Wdnx4W4Jzo
        7RNI4ZnJcy1Z+4lsQlK3evjMWN8dS5k7QySW7NHXWDomXmklZSkC9Xd7DBRaX4Ui
        zkoErvR+s0WYH85+iC6P1rjpFvLgwFAKykpXpCcQEcvgvP3wHqmP+cuOYf62piDM
        9KXrVE6vrDYjpKFqttZDB3VI6lt9GPn18g8fTx7K5s3/BUr41ksIHdac+htX9Gzy
        UXnQQgcJ/NYUP4V2WGc7eXuAkWb6fy8WR0LoYWRobOibW7wdhJaoKGqiDcfSqP7l
        TswHWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=yfTW4eZb1oyF14NllSamtvS5448NNG6QM44agwdZz
        eY=; b=TKQiwjOfO+oH1JLB+95lsBxc6ZZ3xX7qi3Da1OvDkgaVyaNvwOkYuhbqT
        +LNcXbKB66wwoSo4iGuCwGakSWLVUBXZ6yM9jNIkkv8pi7q2EFPVxXJd3u0mHbnA
        B2y//AkIjlcrge+FguTIbDVfmkG0kcSaOJscB3hmdsgoBAz1K/iDx+usifyU2f7j
        UX6197vmPaezENf3sanvssugIdz4tJRJfZF1UnuKl1/c8yDBejVaOcxI6ErtYNcl
        XrgaYSXAs+ANpJTfwp+1Wuzt2/ysW5MQJEnOiC23iM8t1e7nu7/WR4/WckD3qu7j
        gHS/5DjJWlLGx6+8f5HFlV9Wx034Q==
X-ME-Sender: <xms:2AZRXEH80et61CMW7XaKFQ9tceu6eYvUD7GUO7-P7b7Xj2H6Sij-9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrjeefgdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
    tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfh
    gtofgggfesthejredtredtjeenucfhrhhomhepkfgrnhcumfgvnhhtuceorhgrvhgvnhes
    thhhvghmrgifrdhnvghtqeenucfkphepuddukedrvddtkedrudeijedrheeinecurfgrrh
    grmhepmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvthenucevlhhushht
    vghrufhiiigvpedt
X-ME-Proxy: <xmx:2AZRXFzFv5lqnmuLzwGaHHfEOiWahPA7itRuVp2d9Nbm6kfdNTVthg>
    <xmx:2AZRXDzaXAiNy91pF_VbaBJ4r4CpHtXecRTAzkrQnbJGmKO_TP6NBw>
    <xmx:2AZRXKL6Wja1A37vHTKc5jKzu795_ZQ73y4TYej0H4feRcRLNI9h8Q>
    <xmx:2QZRXGVF3i4qeWxAwXafD-IrGX5ywcVPOyJUXp4oyf4nvRFkfmk5uQ>
Received: from localhost (unknown [118.208.167.56])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9144EE41F3;
        Tue, 29 Jan 2019 21:07:18 -0500 (EST)
Message-ID: <553f4a0daf09407371193d7d4782a759561a626a.camel@themaw.net>
Subject: Re: [PATCH 3/3] autofs: add ignore mount option
From:   Ian Kent <raven@themaw.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pan Bian <bianpan2016@163.com>
Date:   Wed, 30 Jan 2019 10:07:15 +0800
In-Reply-To: <20190129171622.5b75f794d2b1e4d1055331eb@linux-foundation.org>
References: <154725122396.11260.16053424107144453867.stgit@pluto-themaw-net>
         <154725123970.11260.6113771566924907275.stgit@pluto-themaw-net>
         <20190129171622.5b75f794d2b1e4d1055331eb@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-29 at 17:16 -0800, Andrew Morton wrote:
> On Sat, 12 Jan 2019 08:00:40 +0800 Ian Kent <raven@themaw.net> wrote:
> 
> > Add an autofs file system mount option that can be used to provide
> > a generic indicator to applications that the mount entry should be
> > ignored when displaying mount information.
> 
> What is the reason for adding this feature?

In other OSes that provide autofs and that provide a mount list
to user space based on the kernel mount list a no-op mount option
("ignore" is the one use on the most common OS) is allowed so that
autofs file system users can optionally use it.

The idea is that it be used by user space programs to exclude
autofs mounts from consideration when reading the mounts list.

Prior to the change to link /etc/mtab to /proc/self/mounts all
I needed to do to achieve this was to use mount(2) and not update
the mtab but now that no longer works.

I know the symlinking happened a long time ago and I considered
doing this then but, at the time I couldn't remember the commonly
used option name and thought persuading the various utility
maintainers would be too hard.

But now I have a RHEL request to do this for compatibility for a
widely used product so I want to go ahead with it and try and
enlist the help of some utility package maintainers.

Clearly, without the option nothing can be done so it's at least
a start.

Ian

