Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63644C2F441
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E24E20870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbfAUPwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:52:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39400 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728950AbfAUPwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:52:10 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 63574C070E05;
        Mon, 21 Jan 2019 15:52:09 +0000 (UTC)
Received: from ovpn-116-130.ams2.redhat.com (ovpn-116-130.ams2.redhat.com [10.36.116.130])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 06E0F5D971;
        Mon, 21 Jan 2019 15:52:06 +0000 (UTC)
Message-ID: <47c97a0e4fc1a520d166b69d4ca19e36049f8eba.camel@redhat.com>
Subject: Re: [PATCH] net/ipv6: lower the level of "link is not ready"
 messages
From:   Thomas Haller <thaller@redhat.com>
To:     Lubomir Rintel <lkundrak@v3.sk>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 21 Jan 2019 16:52:04 +0100
In-Reply-To: <20190121135419.615989-1-lkundrak@v3.sk>
References: <20190121135419.615989-1-lkundrak@v3.sk>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 21 Jan 2019 15:52:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-01-21 at 14:54 +0100, Lubomir Rintel wrote:
> This message gets logged far too often for how interesting is it.
> 
> Most distributions nowadays configure NetworkManager to use randomly
> generated MAC addresses for Wi-Fi network scans. The interfaces end
> up
> being periodically brought down for the address change. When they're
> subsequently brought back up, the message is logged, eventually
> flooding
> the log.
> 
> Perhaps the message is not all that helpful: it seems to be more
> interesting to hear when the addrconf actually start, not when it
> does
> not. Let's lower its level.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>


Hi,

a NetworkManager maintainer here.

Acked-By: Thomas Haller <thaller@redhat.com>


> ---
>  net/ipv6/addrconf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 93d5ad2b1a69..ba155841dc15 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -3495,8 +3495,8 @@ static int addrconf_notify(struct
> notifier_block *this, unsigned long event,
>  
>  			if (!addrconf_link_ready(dev)) {
>  				/* device is not ready yet. */
> -				pr_info("ADDRCONF(NETDEV_UP): %s: link
> is not ready\n",
> -					dev->name);
> +				pr_debug("ADDRCONF(NETDEV_UP): %s: link
> is not ready\n",
> +					 dev->name);
>  				break;
>  			}




