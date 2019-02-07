Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563B7C282CC
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2454521872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="A1P3i/9b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gi92Kxqj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfBGL2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:28:13 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:51145 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726691AbfBGL2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:28:13 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id C808621C1B;
        Thu,  7 Feb 2019 06:28:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 07 Feb 2019 06:28:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=8d70nJINauXKQ64kXl64/bRBuTm
        k/TI6qspVL3A5JjI=; b=A1P3i/9btDSbAl6EcB8GSUcaezdMV5l1qmZYkkCEDlF
        bARK10Kp+PQDimKLKIuZ15/ZM8I1fuaqNp9skV5qXKK9jU20TmHtENLhWHt2gn29
        fTDozZBPwsGfKy16gbInrPb+pKWQkoMejPBVuz3bQZVdLuqlRk+erBz9QbiLDQvS
        fJjJJbu18/tthKUktHJ7oixnsBCLFuc6d5jWZW2oRl6ijU7HBXbenkTY9xNHc+bV
        EcSFwAheNVJAPfrUfExneuz2MNbKsTyKEWiXLBAm0016dJVgjYG/hm+Xgsd3fs0g
        rm5Al9ZqnIteHelXQ43PGoHXaHn2AVSSb4wORY3U1xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=8d70nJ
        INauXKQ64kXl64/bRBuTmk/TI6qspVL3A5JjI=; b=Gi92KxqjlDLfhWvEE+5GE/
        037NAXI0qYycpR0aHq5LGZg7DLoP1OT1Rb9GLAZ0or0e2xx0g8oGwguM7cEAmGuP
        /8vOetSkzu/Ag4B26uGufaAtbD4wzX6CtxzuIQI5oY6xFKdpsNKCHp6RwF3tv1ph
        pN/tRkO4UF35bf3L+UjVamqwxdIvEw4GVKXQXZYnPXCZ+I881TX94TCF9l81xgxT
        CPj/m4K+SJ/Hpr4qgmnxLlpjC/wLvUsawR3wF9gEPnYw1Bn+Hy5Q5fGgsuOGSKHL
        UXTwUAk1Js0EAMYEtQteoRleBPvqlQxqNgJlkUM5K44jp28rfS4Y5C7zBPRqR64A
        ==
X-ME-Sender: <xms:SxZcXPu3sWrI4HNt9CwYLc7HlpDiUFwBNi8AJPzYh4oqpw3kRM9Fsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrledtgddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
    tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgg
    gtuggjfgesthdtredttdervdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhr
    ohgrhhdrtghomheqnecukfhppeekfedrkeeirdekledruddtjeenucfrrghrrghmpehmrg
    hilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmnecuvehluhhsthgvrhfuihiivgep
    td
X-ME-Proxy: <xmx:SxZcXHvhOXZSXYAgibnXfb-7PfmmvTew5TGRoveFA4YTchG0bFfOrA>
    <xmx:SxZcXHcCpbTvlye279ddUs3B1BF5YZbQ9xMjtB0G782yMeT9enj0wg>
    <xmx:SxZcXK7WiEttSeTfn_4es_tuoQ4VfP379AgLLMcYu2w1wP0JSCxqpg>
    <xmx:SxZcXLB6h29MBqRz_Ebgv07fdc-4tDWmm65HKAM_T8VHeBw2uBAhAg>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 888BBE4314;
        Thu,  7 Feb 2019 06:28:10 -0500 (EST)
Date:   Thu, 7 Feb 2019 12:28:09 +0100
From:   Greg KH <greg@kroah.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>
Subject: Re: 4.14 "random: add a config option to trust the CPU's hwrng"
Message-ID: <20190207112809.GC3120@kroah.com>
References: <b6532199f855e48fa53b8c3725a2eb93f949b32a.camel@nokia.com>
 <20190206192613.GB4119@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206192613.GB4119@sasha-vm>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 02:26:13PM -0500, Sasha Levin wrote:
> On Wed, Feb 06, 2019 at 11:44:36AM +0000, Rantala, Tommi T. (Nokia - FI/Espoo) wrote:
> > Hi stable maintainers,
> > 
> > Can you consider including these "random" patches in 4.14.y?
> > 
> > These are very useful in fixing esp. first-bootup delays of VMs due to
> > entropy starvation.
> > 
> > 
> > commit 39a8883a2b989d1d21bd8dd99f5557f0c5e89694
> > Author: Theodore Ts'o <tytso@mit.edu>
> > Date:   Tue Jul 17 18:24:27 2018 -0400
> > 
> >    random: add a config option to trust the CPU's hwrng
> > 
> > commit 9b25436662d5fb4c66eb527ead53cab15f596ee0
> > Author: Kees Cook <keescook@chromium.org>
> > Date:   Mon Aug 27 14:51:54 2018 -0700
> > 
> >    random: make CPU trust a boot parameter
> 
> This really looks like a new feature to me. The "old" behaviour of not
> trusting RDRAND-like randomness was by-design rather than an oversight.

I agree with Sasha, this looks like a new feature.  If you really want
this new functionality, just use 4.19 or newer, right?

thanks,

greg k-h
