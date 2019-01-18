Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC2FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8E520823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="MmGZ6yBu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pfW1Pq3L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfARNGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 08:06:53 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:50571 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726952AbfARNGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 08:06:53 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 846AD28F4B;
        Fri, 18 Jan 2019 08:06:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 18 Jan 2019 08:06:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=7zPrEcHCUbuM7hhUe7azWpqIsHg
        d1XucZkVE/odsv18=; b=MmGZ6yBu0DwLneSivnkH5TKMjVXM3d8TEgz6XoYKeaI
        S5Ky7r3uJXVr9CXcbFis7Fw5tK2VgfHsMhzSrOFZSeZ19PN8q+h9CedQyBOGupLI
        lXS1OZZJ9z8AEj3oYs5YxGDsBewYx2hmhUq8zpZtsvGluNKcP41J+VypAvis93/l
        4f7Y8x9544EPIvvvnviUGjAz2DRLLvnKl2YPJoGbXX1uH+wnw2K/9FJzp/BpSO6Q
        hmhHKE0CojC7T0izkNNvsysQnRDN5dH1phRFsh5zlOKBOnRBoFmOBOWWgFf3qoRw
        zdZygjBn4YMuFbkfdK7U6TriNuQDP7IMxIePVtBkKUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=7zPrEc
        HCUbuM7hhUe7azWpqIsHgd1XucZkVE/odsv18=; b=pfW1Pq3L+byH/joLyW3o4I
        txrzVOEOIZge+W1I/uOYut+M59WSFKWQxYhorKIKOqDJtYuxas6Xe35RbDI+/jZD
        ApfebSO49fFq7oLhctkzma8d5eyMwV6REkZf6O5TNdCaYCbHB9qYvN5vFJM83es+
        DB8tCWf1R5wRSPttSva8EypmnKqTiiQ9J7t0L9iRBFj5xgy0vCGgzVFKFnYF8k3H
        jh3Gxh3G5KIWUiU5CovVk7iCeEDLfE5E03ugL3Z7lG9t2H/9eOWskK0c3n+fkOoS
        NfsGxSwjYOY1UDmJa7RP8fo2sIooxlW5LO71I0RQXUbza73CuDzlEHTkVPnKEZdQ
        ==
X-ME-Sender: <xms:as9BXO1uaRn-P1xiMo4kBH14hqMoKpb3M8SyjN_25xJFSFvZcvJ-Cg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrhedtgdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
    tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegoufhprghmkfhpucdlfedttd
    dmnecujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhr
    vghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecukfhppeekfedrkeeirdekle
    druddtjeenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
    necuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:as9BXKZaZ0V513yQcWsTNDRdtVSdGqDyt69C4gA6cKdbPCPkfqxQuQ>
    <xmx:as9BXO4lTDcnWnlhDeWvbtJRFFsiSIUWm1j0kA57h2aYAKJro1K3YA>
    <xmx:as9BXJhZ95SnhmgOndqdTsTsZtNWLGD-8FxHd6XjE2GHUHm1yQ0MRg>
    <xmx:a89BXAfNqWMmSrcq7ZWKOqu6mdE2X2PbZ5rtQdj6lTmQUXsnMH40Pg>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3535D1027C;
        Fri, 18 Jan 2019 08:06:50 -0500 (EST)
Date:   Fri, 18 Jan 2019 14:06:48 +0100
From:   Greg KH <greg@kroah.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Silvio Cesare <silvio.cesare@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Will Deacon <will.deacon@arm.com>, Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH 1/8] lkdtm: change snprintf to scnprintf for possible
 overflow
Message-ID: <20190118130648.GA27209@kroah.com>
References: <20190112152844.26550-1-w@1wt.eu>
 <CAGXu5jJvWC0=zym11noj7tOjkDFYvn+wNimwSjcmiWnrCoOVVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJvWC0=zym11noj7tOjkDFYvn+wNimwSjcmiWnrCoOVVA@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 12:47:34PM -0800, Kees Cook wrote:
> On Sat, Jan 12, 2019 at 7:28 AM Willy Tarreau <w@1wt.eu> wrote:
> >
> > From: Silvio Cesare <silvio.cesare@gmail.com>
> >
> > Change snprintf to scnprintf. There are generally two cases where using
> > snprintf causes problems.
> >
> > 1) Uses of size += snprintf(buf, SIZE - size, fmt, ...)
> > In this case, if snprintf would have written more characters than what the
> > buffer size (SIZE) is, then size will end up larger than SIZE. In later
> > uses of snprintf, SIZE - size will result in a negative number, leading
> > to problems. Note that size might already be too large by using
> > size = snprintf before the code reaches a case of size += snprintf.
> >
> > 2) If size is ultimately used as a length parameter for a copy back to user
> > space, then it will potentially allow for a buffer overflow and information
> > disclosure when size is greater than SIZE. When the size is used to index
> > the buffer directly, we can have memory corruption. This also means when
> > size = snprintf... is used, it may also cause problems since size may become
> > large.  Copying to userspace is mitigated by the HARDENED_USERCOPY kernel
> > configuration.
> >
> > The solution to these issues is to use scnprintf which returns the number of
> > characters actually written to the buffer, so the size variable will never
> > exceed SIZE.
> >
> > Signed-off-by: Silvio Cesare <silvio.cesare@gmail.com>
> > Cc: Dan Carpenter <dan.carpenter@oracle.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Greg KH <greg@kroah.com>
> > Signed-off-by: Willy Tarreau <w@1wt.eu>
> 
> It looks like these are going via individual trees. Greg, can you
> please take this into your drivers-misc tree for lkdtm?
> 
> Acked-by: Kees Cook <keescook@chromium.org>

Will do, thanks.

greg k-h
