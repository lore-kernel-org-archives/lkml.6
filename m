Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED1BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 262F42080F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfBVAYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 19:24:12 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:45250 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfBVAYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 19:24:11 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C349E146A0D07;
        Thu, 21 Feb 2019 16:24:10 -0800 (PST)
Date:   Thu, 21 Feb 2019 16:24:10 -0800 (PST)
Message-Id: <20190221.162410.1126816126933565769.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     courmisch@gmail.com, natechancellor@gmail.com, remi@remlab.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phonet: fix building with clang
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190219215359.391543-1-arnd@arndb.de>
References: <20190219215359.391543-1-arnd@arndb.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 21 Feb 2019 16:24:11 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 19 Feb 2019 22:53:50 +0100

> clang warns about overflowing the data[] member in the struct pnpipehdr:
> 
> net/phonet/pep.c:295:8: warning: array index 4 is past the end of the array (which contains 1 element) [-Warray-bounds]
>                         if (hdr->data[4] == PEP_IND_READY)
>                             ^         ~
> include/net/phonet/pep.h:66:3: note: array 'data' declared here
>                 u8              data[1];
> 
> Using a flexible array member at the end of the struct avoids the
> warning, but since we cannot have a flexible array member inside
> of the union, each index now has to be moved back by one, which
> makes it a little uglier.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thank you.
