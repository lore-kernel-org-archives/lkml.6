Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58ABC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 18:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F3BE2084E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 18:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F3BE2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbeKZFLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 00:11:33 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:44422 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbeKZFLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 00:11:33 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 73BDF14C876AE;
        Sun, 25 Nov 2018 10:19:54 -0800 (PST)
Date:   Sun, 25 Nov 2018 10:19:53 -0800 (PST)
Message-Id: <20181125.101953.2072129230580561127.davem@davemloft.net>
To:     willemdebruijn.kernel@gmail.com
Cc:     deepa.kernel@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, viro@zeniv.linux.org.uk, arnd@arndb.de,
        y2038@lists.linaro.org
Subject: Re: [PATCH 3/8] socket: Disentangle SOCK_RCVTSTAMPNS from
 SOCK_RCVTSTAMP
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAF=yD-LjfVKSr=KhknZHhN-M2-ZdLE9g0XR8Ta4rokx24arkBg@mail.gmail.com>
References: <CAF=yD-JGh23sA_6eUtBq8=wSZ5g=nipmhdr1WwjP5th51qEtiQ@mail.gmail.com>
        <CABeXuvqgPE_Cft+T0fSw8zT09uCKWQGUB+bVNqQDk6fOinn8rA@mail.gmail.com>
        <CAF=yD-LjfVKSr=KhknZHhN-M2-ZdLE9g0XR8Ta4rokx24arkBg@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 25 Nov 2018 10:19:54 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Sun, 25 Nov 2018 09:18:55 -0500

> The existing logic is as is for a reason. There is no need to change
> it to satisfy the main purpose of your patchset?
> 
> It is structured as one bit to test whether a timestamp is requested
> and another to select among two variants usec/nsec. Just add another
> layer of branching between new/old in cases where this distinction is
> needed.
> 
> Please avoid code churn unless needed.

+1
