Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD551C65C1B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 18:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DDA820834
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 18:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cESsrvFN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DDA820834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbeJHBvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 21:51:03 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:56303 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbeJHBvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 21:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=75kpKEQdXhp/7ugN/toc11OtjZh8VAPkFvK85vB9bu0=;
        b=cESsrvFNoGS7h+eLvLKCuV+Nbx/GBSGG5FIx2VAqgcvVXeRwTVQ4dNS8o5KPl7p4ZNIrFiba9s3nsOLFMDPIE+nm6OLpjRR8X9gRJx0wU/XjEQYQFn5vqE+5/z4i8w3W6Gl/7RSbd67gKBKUCX8ghFuQ+6uqY5AjT/d0jEO4Wn0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1g9E0s-0006T8-HS; Sun, 07 Oct 2018 20:42:46 +0200
Date:   Sun, 7 Oct 2018 20:42:46 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        =?iso-8859-1?B?Smk/P+0gUO1ya28=?= <jiri@resnulli.us>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH net-next v7 28/28] net: WireGuard secure network tunnel
Message-ID: <20181007184246.GD22794@lunn.ch>
References: <20181006025709.4019-1-Jason@zx2c4.com>
 <20181006025709.4019-29-Jason@zx2c4.com>
 <20181006065819.GD3061@nanopsycho.orion>
 <CAHmME9pKvUOaAHhe7gb3yH4jdkdTtLv+gUqdnh3bJZcN776UWQ@mail.gmail.com>
 <20181007181444.wohudtigexv56b77@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181007181444.wohudtigexv56b77@wunner.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Apart from Dan's clarity argument, what if you need to insert another
> step to create the interface, thereby necessitating another step in
> the error path?  Are you going to call it 4a, 4b, ...?  Because you
> don't want to inflate that future patch by renaming every single
> label.

Hi Lukas

You beat me to it.

Jason, the things to understand is, Wireguard is not finished. It has
only just started. The code will develop further, changes will be
made. We need the code to be easy to make changes to. As Lukas just
pointed out, this number construct is hard to change in a minimal way,
making a patch small, and obviously correct.

       Andrew
