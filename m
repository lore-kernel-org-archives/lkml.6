Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E973C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 23:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C343214DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 23:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="tjW1ZUZl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TXHjnFR+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfBCXfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 18:35:06 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52241 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727237AbfBCXfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 18:35:05 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 4B6BD211EC;
        Sun,  3 Feb 2019 18:35:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 03 Feb 2019 18:35:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=aoP2mmLS0fFDf6FMYYWWgGtGUnp
        H6xQLxrW4GZ1ymV8=; b=tjW1ZUZlm8KjR6ekFNqiWeKR5CEbDh5ZFaO6Ax6QEQ3
        X2BZQgoXfnnwZM7N5+ksjVJLOu5r+16BjpoJbqJjfxuKVpKK4ipKYkJpbRlyAzS8
        IYsn0OwCQdsTjdOosjJ6Q5QF8ITAnXBf1U/b3Qfl2msC46kzkN7DbcjNZeEib4+U
        lkkbVeUYooz8F+F8BkMc5nUeCdnd3pJ+5k2T5Fnh7XVZTumYv2sKdtFSM0UbIFyo
        3fvVNmhPnVJJef5THh7tY2gea2bZJ/46FuKlaipBwHZRSBDxZ4oFj21ceB8jlF1q
        oMSIT2RuCJiPYo8BnYXbf0Htl1t3hUUHH0M9rCeu6ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=aoP2mm
        LS0fFDf6FMYYWWgGtGUnpH6xQLxrW4GZ1ymV8=; b=TXHjnFR+BCdxaGS6LY3rUl
        iRVQXI4U+mcXoME0gcYdJa8zMwyHU+sDywLpQkftICc/ZBOxducYWTVOsQEx7LZ8
        JpqTjcs3sLsp2rqOmjImYIRLeZ9TshhBt/ef9WsicMdji72mRDsCFAAYx8sfvy1p
        SJxABSf4UxNE62v/8NEHi/AhMMYTzdm+hYyPOdexxAyvoogCOPRFA5WwJTO9kzBS
        vBa01nWpSV0M+lCWKlEGbg+E2lwMzSlnikdS8fDUJWTcJvhVBewb8C03ozOIhP++
        vVEoVqb69hfT+x6ajBULuhJa0L3Ka+BKlTicVbSoMVG8w55/iOmuJ4mHecsWigkw
        ==
X-ME-Sender: <xms:pnpXXC35hBDjlvIt-_Wo8D8SgW70ZdnhpqccpQhT2Ji9wVkdjeHD9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrkeefgdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
    tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrhhlucfvnfffucdlfedtmd
    enucfjughrpeffhffvuffkfhggtggujgfofgesthdtredtofervdenucfhrhhomhepfdfv
    ohgsihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtohgsihhnrdgttgeqnecukfhppe
    duvddurdeggedrvddvjedrudehjeenucfrrghrrghmpehmrghilhhfrhhomhepmhgvseht
    ohgsihhnrdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:pnpXXPVckP-yFUnf1l4PLp9Erc4Wx6h_bNvnSfNu093BZ3WIhdqZCw>
    <xmx:pnpXXENVGUUcAvBGbb85DD07GRINm6ZjpKFtneo1RXsJRLlt5BAzIw>
    <xmx:pnpXXHJtItG9u_6k4HgK_PQIK3mFuLR6Q7o5IZOjasjbQblzmUFp-w>
    <xmx:qHpXXIOs6rPNqgublhJcaf6SaRo_zXrew4lFCpqiDUNX94Icf_i7ag>
Received: from localhost (ppp121-44-227-157.bras2.syd2.internode.on.net [121.44.227.157])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5A94DE44A8;
        Sun,  3 Feb 2019 18:35:01 -0500 (EST)
Date:   Mon, 4 Feb 2019 10:34:54 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Joe Perches <joe@perches.com>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slab: Increase width of first /proc/slabinfo column
Message-ID: <20190203233454.GB4235@eros.localdomain>
References: <20190201004242.7659-1-tobin@kernel.org>
 <089b1025c5e81410b6b608290becd6f609ca03b4.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <089b1025c5e81410b6b608290becd6f609ca03b4.camel@perches.com>
X-Mailer: Mutt 1.11.2 (2019-01-07)
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 07:27:24PM -0800, Joe Perches wrote:
> On Fri, 2019-02-01 at 11:42 +1100, Tobin C. Harding wrote:
> > Increase the width of the first column (cache name) in the output of
> > /proc/slabinfo from 17 to 30 characters.
> 
> Do you care if this breaks any parsing of /proc/slabinfo?
> 
> I don't but someone might.

Thanks for looking at the patch Joe, Christoph pointed this out also.
Solution is going to take a different approach and not touch the column
width in /proc/slabinfo for the record, although it does not really
matter now, I think that anyone parsing /proc/slabinfo would be using
whitespace because the name field is already variable length.

Anyways, new patch to come.

thanks,
Tobin.
