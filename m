Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D83C282CD
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 04:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2169F20881
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 04:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="Tpfu72H/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jIIcfl8C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbfA3Epc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 23:45:32 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:50719 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728101AbfA3Epc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 23:45:32 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id E8220126C;
        Tue, 29 Jan 2019 23:45:30 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 29 Jan 2019 23:45:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        TRqi3YjCcZMqCQhIuENB8coPNnKiDQuW4r+yfgLZhm8=; b=Tpfu72H/vPCstQih
        UWR7Z8dw4hLIr2XvnjeUM+8aOmY5tJOlmc+QEMzpASNnkV5cDvTD0oHGp9FV6Xuc
        pKxoRxHrZEZeMbtIS8em6FkvdUhNotYRMAkOj+5YauPIwdMMSA8XViL09j4uYk6M
        lGiUlsqIvO91/5K2OBiAnjUNOIU84EBLanw72je5xECgnuzRB10BhHssFByF3Bkk
        krfZRPTmBuexqkSaICDzTLXUh2MLcQgMdOxQAWCERsD8AnSUQobpqNF8xUqinlGK
        DCoAKtpbjekfDWtroALzjr001UAIZqpeF9Z5ErWHVpBTicyFCbD31DimXrgceN4o
        nIo8zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=TRqi3YjCcZMqCQhIuENB8coPNnKiDQuW4r+yfgLZh
        m8=; b=jIIcfl8CQy1tkz2vc0My9dtpKEHCG7GhtUDuGqOcHAr2aCua656b9cknC
        1cOUICiDSW/70Ug7kGHgFft5DvX6dkakE3Gx5KCHLyFeuAg3eFCNf7zrLqk70rod
        iw0XtIn12/2t4vYaKD4gwsoV97SBYadgihN22O4vWwdbKH34bxwMZ9cdYPiqY7HG
        PmYI67dukQbC6xq9QtNKCeEVWADXZX9dP6qGEFqnE4NzAMrrDQcZ/TpJRLTZO81U
        hqYmXfNn2zGIs35xNF2ZxCHjew82atxJf331Wtjg8TuTkSCkeDyffcLD9Yt62SjS
        uboxFVcm5fsyCpH0bv6BPZsJuts7w==
X-ME-Sender: <xms:6StRXN-Rnan2N57D0DoN9XMAvUD4bcONM5UHFb_9EssE2u0yKQHjsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrjeefgdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
    tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfh
    gtofgggfesthejredtredtjeenucfhrhhomhepkfgrnhcumfgvnhhtuceorhgrvhgvnhes
    thhhvghmrgifrdhnvghtqeenucfkphepuddukedrvddtkedrudeijedrheeinecurfgrrh
    grmhepmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvthenucevlhhushht
    vghrufhiiigvpedt
X-ME-Proxy: <xmx:6itRXOBiZGamcl6yNdexEIoiMG6U2KgYAD2fGM5OZxZz9W3tJABG8A>
    <xmx:6itRXNxiEj_Q0MmcIt2BPBF-KBFteiyfW2NKcCfwjJd98S4NKJKGUg>
    <xmx:6itRXDRfCSMbzlkp-SC8BO4M5HjOHoUH364xJsqzUMAUtRWeKw2u5g>
    <xmx:6itRXFtcDtjQWkGTbGbIPFLYeaCJjkd1Nc1UxODuY-F_nhRJ9fkd0Q>
Received: from localhost (unknown [118.208.167.56])
        by mail.messagingengine.com (Postfix) with ESMTPA id E5B8EE4016;
        Tue, 29 Jan 2019 23:45:27 -0500 (EST)
Message-ID: <052b4fbe375f09a7e8b55eef4a6b9451e056fb0f.camel@themaw.net>
Subject: Re: [PATCH 3/3] autofs: add ignore mount option
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Wed, 30 Jan 2019 12:45:24 +0800
In-Reply-To: <20190130041827.GI2217@ZenIV.linux.org.uk>
References: <154725122396.11260.16053424107144453867.stgit@pluto-themaw-net>
         <154725123970.11260.6113771566924907275.stgit@pluto-themaw-net>
         <20190129171622.5b75f794d2b1e4d1055331eb@linux-foundation.org>
         <553f4a0daf09407371193d7d4782a759561a626a.camel@themaw.net>
         <804b86df6fd678147da816be038b11c87333b23f.camel@themaw.net>
         <20190130041827.GI2217@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-01-30 at 04:18 +0000, Al Viro wrote:
> On Wed, Jan 30, 2019 at 10:44:15AM +0800, Ian Kent wrote:
> 
> > Al,
> > 
> > On a different note the above request also raised another
> > question about statvfs(3) automount behaviour.
> > 
> > In glibc statvfs(3) uses statfs(2) and translates the return
> > to a statvfs structure.
> > 
> > I wasn't aware but apparently statvfs(3) (and presumably statfs(2))
> > doesn't trigger an automount on Solaris whereas we do. I think
> > statfs() is probably the only exception to the convention that
> > stat family system calls don't trigger an automount.
> > 
> > So far I've said that this is a long standing behaviour in the
> > Linux kernel and changing it could lead to unpleasant surprises
> > for those that have come to expect this behaviour so such a change
> > would not be well received.
> > 
> > But I do need to ask your opinion, so what are your thoughts about
> > changing this?
> 
> Probably should've done it that way, but I'm afraid it's much too
> late by now...

Yeah, thought you'd say that.
Thanks for confirming.

Ian

