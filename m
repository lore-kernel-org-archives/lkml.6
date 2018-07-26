Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638FAC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 04:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1821620685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 04:23:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1821620685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbeGZFhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 01:37:53 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:60780 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbeGZFhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 01:37:52 -0400
Received: from localhost (unknown [172.58.43.249])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4C615128F4EA7;
        Wed, 25 Jul 2018 21:22:59 -0700 (PDT)
Date:   Wed, 25 Jul 2018 21:22:58 -0700 (PDT)
Message-Id: <20180725.212258.182134114222639499.davem@davemloft.net>
To:     dima@arista.com
Cc:     linux-kernel@vger.kernel.org, herbert@gondor.apana.org.au,
        steffen.klassert@secunet.com, 0x7f454c46@gmail.com,
        netdev@vger.kernel.org
Subject: Re: [PATCH 06/18] netlink: Do not subscribe to non-existent groups
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180726023144.31066-7-dima@arista.com>
References: <20180726023144.31066-1-dima@arista.com>
        <20180726023144.31066-7-dima@arista.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 25 Jul 2018 21:22:59 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Safonov <dima@arista.com>
Date: Thu, 26 Jul 2018 03:31:32 +0100

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

This really has nothing to do with adding a compat layer for xfrm,
and is a bug fix that should be submitted separately in it's own
right.
