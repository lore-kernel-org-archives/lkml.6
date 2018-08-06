Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD93AC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7071721A03
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:43:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7071721A03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732968AbeHFTxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 15:53:21 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:55142 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730922AbeHFTxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 15:53:21 -0400
Received: from localhost (c-24-20-22-31.hsd1.or.comcast.net [24.20.22.31])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4D08F1341DB10;
        Mon,  6 Aug 2018 10:43:13 -0700 (PDT)
Date:   Mon, 06 Aug 2018 10:43:12 -0700 (PDT)
Message-Id: <20180806.104312.1983555084983717056.davem@davemloft.net>
To:     laoar.shao@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: avoid unnecessary sock_flag() check when
 enable timestamp
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1533527822-3324-1-git-send-email-laoar.shao@gmail.com>
References: <1533527822-3324-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 06 Aug 2018 10:43:13 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon,  6 Aug 2018 11:57:02 +0800

> The sock_flag() check is alreay inside sock_enable_timestamp(), so it is
> unnecessary checking it in the caller.
> 
>     void sock_enable_timestamp(struct sock *sk, int flag)
>     {
>         if (!sock_flag(sk, flag)) {
>             ...
>         }
>     }
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Applied.
