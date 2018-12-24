Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20E2C64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 17:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4511217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 17:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbeLXR6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 12:58:48 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:34914 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbeLXR6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 12:58:47 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 03BBE13408331;
        Mon, 24 Dec 2018 09:58:46 -0800 (PST)
Date:   Mon, 24 Dec 2018 09:58:46 -0800 (PST)
Message-Id: <20181224.095846.1987517984305782151.davem@davemloft.net>
To:     fw@strlen.de
Cc:     netdev@vger.kernel.org, linux@roeck-us.net,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH net-next] staging: octeon: fix build failure with XFRM
 enabled
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181221205726.2924-1-fw@strlen.de>
References: <20181221205726.2924-1-fw@strlen.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 24 Dec 2018 09:58:47 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>
Date: Fri, 21 Dec 2018 21:57:26 +0100

> skb->sp doesn't exist anymore in the next-next tree, so mips defconfig
> no longer builds.  Use helper instead to reset the secpath.
> 
> Not even compile tested.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Fixes: 4165079ba328d ("net: switch secpath to use skb extension infrastructure")
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  Greg, David:
> 
>  The patch will not break build for a tree that lacks the 'Fixes'
>  commit, so this can also go in via staging tree.
>  OTOH, net-next build is broken for mips/octeon, so I think in
>  this case net-next might make more sense?

Yeah I agree, that net-next is probably the best place for this.

Because I know that Linus is sensitive to situations where he is
sent a pull request, and then what he pulls doesn't match the pull
request shortlog etc.  I have asked him how he would let me handle
this.

That's the only reason I haven't integrated this yet.

Just FYI!

