Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44C2C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8668720675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730794AbfAPVh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:37:27 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:45030 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730414AbfAPVh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 16:37:27 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7111112665E49;
        Wed, 16 Jan 2019 13:37:26 -0800 (PST)
Date:   Wed, 16 Jan 2019 13:37:26 -0800 (PST)
Message-Id: <20190116.133726.2036063241420588039.davem@davemloft.net>
To:     lucien.xin@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        u9012063@gmail.com
Subject: Re: [PATCH net] erspan: build the header with the right proto
 according to erspan_ver
From:   David Miller <davem@davemloft.net>
In-Reply-To: <ae6a0efc813739ab1f9179f2ec8036285193dba9.1547460606.git.lucien.xin@gmail.com>
References: <ae6a0efc813739ab1f9179f2ec8036285193dba9.1547460606.git.lucien.xin@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 16 Jan 2019 13:37:26 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 14 Jan 2019 18:10:06 +0800

> As said in draft-foschiano-erspan-03#section4:
> 
>    Different frame variants known as "ERSPAN Types" can be
>    distinguished based on the GRE "Protocol Type" field value: Type I
>    and II's value is 0x88BE while Type III's is 0x22EB [ETYPES].
> 
> So set it properly in erspan_xmit() according to erspan_ver. While at
> it, also remove the unused parameter 'proto' in erspan_fb_xmit().
> 
> Fixes: 94d7d8f29287 ("ip6_gre: add erspan v2 support")
> Reported-by: Jianlin Shi <jishi@redhat.com>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>

Applied and queued up for -stable.
