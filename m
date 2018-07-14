Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C893FECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 18:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6378520871
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 18:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6378520871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731402AbeGNSl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 14:41:59 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52722 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbeGNSl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 14:41:59 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B0DEE13F44151;
        Sat, 14 Jul 2018 11:22:06 -0700 (PDT)
Date:   Sat, 14 Jul 2018 11:22:04 -0700 (PDT)
Message-Id: <20180714.112204.1831168896985469983.davem@davemloft.net>
To:     laoar.shao@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        shaoyafang@didichuxing.com, edumazet@google.com
Subject: Re: [PATCH net-next] tcp: remove redundant rcv_nxt update
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1531557390-12592-1-git-send-email-laoar.shao@gmail.com>
References: <1531557390-12592-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 14 Jul 2018 11:22:06 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yafang Shao <laoar.shao@gmail.com>
Date: Sat, 14 Jul 2018 16:36:29 +0800

> tcp_rcv_nxt_update() is already executed in tcp_data_queue().
> This line is redundant.
> 
> See bellow,
> 	tcp_queue_rcv
> 		tcp_rcv_nxt_update(tcp_sk(sk), TCP_SKB_CB(skb)->end_seq);
> 	tcp_rcv_nxt_update(tp, TCP_SKB_CB(skb)->end_seq); <<<< redundant
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Applied.
