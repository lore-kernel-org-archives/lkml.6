Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB39AC46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 19:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4F920882
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 19:51:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A4F920882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbeG2VWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 17:22:42 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:43976 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbeG2VWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 17:22:42 -0400
Received: from localhost (unknown [IPv6:2603:3004:61b:dd00::7bb])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id AFCB213E33738;
        Sun, 29 Jul 2018 12:51:07 -0700 (PDT)
Date:   Sun, 29 Jul 2018 12:51:06 -0700 (PDT)
Message-Id: <20180729.125106.426751224292004107.davem@davemloft.net>
To:     dima@arista.com
Cc:     linux-kernel@vger.kernel.org, herbert@gondor.apana.org.au,
        steffen.klassert@secunet.com, netdev@vger.kernel.org
Subject: Re: [PATCH] netlink: Do not subscribe to non-existent groups
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180727155444.17081-1-dima@arista.com>
References: <20180727155444.17081-1-dima@arista.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 29 Jul 2018 12:51:07 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Safonov <dima@arista.com>
Date: Fri, 27 Jul 2018 16:54:44 +0100

> Make ABI more strict about subscribing to group > ngroups.
> Code doesn't check for that and it looks bogus.
> (one can subscribe to non-existing group)
> Still, it's possible to bind() to all possible groups with (-1)
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Steffen Klassert <steffen.klassert@secunet.com>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Dmitry Safonov <dima@arista.com>

Applied and queued up for -stable, thanks.
