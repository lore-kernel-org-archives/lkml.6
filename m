Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D63C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B42CF20874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732446AbeLQOZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 09:25:29 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:60108 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbeLQOZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 09:25:29 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1gYtpc-0007pF-BV; Mon, 17 Dec 2018 22:25:16 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1gYtpQ-0004cL-0d; Mon, 17 Dec 2018 22:25:04 +0800
Date:   Mon, 17 Dec 2018 22:25:04 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     netdev@vger.kernel.org, "Acked-by : Phil Sutter" <phil@nwl.cc>,
        Thomas Graf <tgraf@suug.ch>,
        "David S. Miller" <davem@davemloft.net>,
        NeilBrown <neilb@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] test_rhashtable: remove semaphore usage
Message-ID: <20181217142503.tylhv4l5rbtthc2g@gondor.apana.org.au>
References: <20181216194836.1310998-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181216194836.1310998-1-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2018 at 08:48:21PM +0100, Arnd Bergmann wrote:
> This is one of only two files that initialize a semaphore to a negative
> value. We don't really need the two semaphores here at all, but can do
> the same thing in more conventional and more effient way, by using a
> single waitqueue and an atomic thread counter.
> 
> This gets us a little bit closer to eliminating classic semaphores from
> the kernel. It also fixes a corner case where we fail to continue after
> one of the threads fails to start up.
> 
> An alternative would be to use a split kthread_create()+wake_up_process()
> and completely eliminate the separate synchronization.
> 
> Acked-by: Phil Sutter <phil@nwl.cc>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
