Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D4DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 06:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F64D21773
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 06:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="W2CVrHDl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yDU+OHdg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730548AbeLTGca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 01:32:30 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:49011 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727943AbeLTGca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 01:32:30 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 14D0A21FC2;
        Thu, 20 Dec 2018 01:32:29 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 20 Dec 2018 01:32:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=7u5EzNPCA/Ze27fZk9F5VKaIupf
        hKjKzQDvwENQmgzg=; b=W2CVrHDlprBoVPx+lYdHBOAtLJ7lMVwxvBNmNh5q7UU
        8e84AYQHhqKIPll7pUrRghdSwgSqy/eep50RfJnbFR7DsbX4G4+DZ45rk15WjZQ8
        UOKu5mbqCSl99a8mfL4pAiDxz7cCqNcC4KtsRo/osCT119xvzzu7XpZZZFmBCE1m
        IyI9tr2P9qbeReey+1FNOVipAqlR2FpGVLAKAZxogrnBOa2iyTnHbj7lXaJeg+Ea
        vw88ta3FagWJQ/jHpi2O6rSAdKmAuLpUjrY/8DbxitdeoHXpeMoAyzLrf8aJzC0L
        fgaO/B6hZ0rPxKVFa5lkli2K7MNziNtUQJLzy0zo7Ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=7u5EzN
        PCA/Ze27fZk9F5VKaIupfhKjKzQDvwENQmgzg=; b=yDU+OHdgPRP5zpL+vLv/Kv
        M+cKN8vBCKNZ6TWgfIdZ1x2ev/14MYJ9kOQm4o75vcF/3xmxcFWJ3pd89G2LhleJ
        fM2CT0anBR29VePZr5yu+wsUJa+LsK5SUf8Ve0Bmv82OgC0iYiJlBsyYWZITF71h
        uGQYkHUyvRtvAx+fCFkiQRMzCKctL8RJQ0d7Mp4HHnBKQnxbFa/+Tiyr/4A6kaqL
        3I0RcCkqrVWJUPQyAgQ08RY8SH3VdRPs9Ka6uElbUBiKihVb83kKME/9wG/kbvhg
        vAFcSyx9nYiZ+9XfhOQBhiFSYc4qYYUwQwX5ncIcIOns1rRsFag4R9o0VveKiLkQ
        ==
X-ME-Sender: <xms:fDcbXMxWHoLy06ahQUAIqCDKFszQIXCfDdJv_ItpuXuu7VLJ89V7Gg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtkedrudejvddgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhhtnecuuegrihhlohhuthemucef
    tddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfh
    ggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehk
    rhhorghhrdgtohhmqeenucfkphepkeefrdekiedrkeelrddutdejnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhenucevlhhushhtvghrufhiiigv
    pedt
X-ME-Proxy: <xmx:fDcbXCTS-YSXTv9LtN8pW-v_HgKaqvIMMyyr_auomVnTvwKdR-sAbw>
    <xmx:fDcbXCm8vaTPd1tDCl4klBAwINQtxbpFN4BI-Dd8ROSjDWmmhxDnTw>
    <xmx:fDcbXFe5IzETwUVXUKeUIz3udhilgl-sa6Uv6j4wytZQ4PPvfhMkeg>
    <xmx:fTcbXJiA9uWNlH1PauZWWW3OM-gYt3pDtQAPF3dfR4UjH7Ny7nygEw>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 93C60E459A;
        Thu, 20 Dec 2018 01:32:27 -0500 (EST)
Date:   Thu, 20 Dec 2018 07:32:25 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>, David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: Re: linux-next: manual merge of the char-misc tree with the net-next
 tree
Message-ID: <20181220063225.GA2294@kroah.com>
References: <20181220170253.011d0b10@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220170253.011d0b10@canb.auug.org.au>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 05:02:53PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the char-misc tree got a conflict in:
> 
>   drivers/ptp/ptp_clock.c
> 
> between commit:
> 
>   aea0a897af9e ("ptp: Fix pass zero to ERR_PTR() in ptp_clock_register")
> 
> from the net-next tree and commit:
> 
>   b9d93594c767 ("ptp: fix an IS_ERR() vs NULL check")
> 
> from the char-misc tree.
> 
> I fixed it up (I just used the latter version) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

Thanks for the merge fix, that is correct.

greg k-h
