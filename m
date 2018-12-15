Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4166EC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 19:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D292084D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 19:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbeLOT1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 14:27:52 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:53876 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbeLOT1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 14:27:52 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D2CFB14E89C57;
        Sat, 15 Dec 2018 11:27:51 -0800 (PST)
Date:   Sat, 15 Dec 2018 11:27:51 -0800 (PST)
Message-Id: <20181215.112751.741520579999284155.davem@davemloft.net>
To:     eric.dumazet@gmail.com
Cc:     laoar.shao@gmail.com, edumazet@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] tcp: minor optimization for calculating
 packets_out in tcp connect
From:   David Miller <davem@davemloft.net>
In-Reply-To: <48971720-96e1-a48f-a1f5-3a96aa3fae7a@gmail.com>
References: <1544866389-11168-1-git-send-email-laoar.shao@gmail.com>
        <48971720-96e1-a48f-a1f5-3a96aa3fae7a@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 15 Dec 2018 11:27:52 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Sat, 15 Dec 2018 04:59:00 -0800

> 
> 
> On 12/15/2018 01:33 AM, Yafang Shao wrote:
>> When we building a syn packet, the tcp_skb_pcount(skb) is always 1,
>> which is set in tcp_init_nondata_skb().
>> Regarding the syn_data, it is set through
>> memcpy(syn_data->cb, syn->cb, sizeof(syn->cb)),
>> which is always 1 as well.
>> 
>> So we don't need to use tcp_skb_pcount(skb), that could give us a
>> little improvement.
>>
> 
> I dunno, I find current code more self-documented.
> 
> This is not fast path, so I would suggest we keep it.

I agree, I won't be applying this.
