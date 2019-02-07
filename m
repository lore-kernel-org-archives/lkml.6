Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227E2C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E72E12173B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfBGSBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 13:01:12 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:50194 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfBGSBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 13:01:12 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DF2C710433ACA;
        Thu,  7 Feb 2019 10:01:10 -0800 (PST)
Date:   Thu, 07 Feb 2019 10:01:10 -0800 (PST)
Message-Id: <20190207.100110.1557913033627638063.davem@davemloft.net>
To:     eli@mellanox.com
Cc:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        simon.horman@netronome.com, jakub.kicinski@netronome.com,
        dirk.vandermerwe@netronome.com, francois.theron@netronome.com,
        quentin.monnet@netronome.com, john.hurley@netronome.com,
        edwin.peer@netronome.com
Subject: Re: [PATCH net-next 2/2] net: Change TCA_ACT_* to TCA_ID_* to
 match that of TCA_ID_POLICE
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190207074549.29861-3-eli@mellanox.com>
References: <20190207074549.29861-1-eli@mellanox.com>
        <20190207074549.29861-3-eli@mellanox.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 07 Feb 2019 10:01:11 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eli Cohen <eli@mellanox.com>
Date: Thu,  7 Feb 2019 09:45:49 +0200

> diff --git a/net/sched/act_simple.c b/net/sched/act_simple.c
> index 902957beceb3..d54cb608dbaf 100644
> --- a/net/sched/act_simple.c
> +++ b/net/sched/act_simple.c
> @@ -19,8 +19,6 @@
>  #include <net/netlink.h>
>  #include <net/pkt_sched.h>
>  
> -#define TCA_ACT_SIMP 22
> -
>  #include <linux/tc_act/tc_defact.h>
>  #include <net/tc_act/tc_defact.h>
>  

I would do this in patch #1.

Actually, because you didn't, after patch #1 there are two #defines
evaluated for this macro.  One in pkt_cls.h and one here.

The only reason the compiler doesn't warn and complain is because the
definitions are identical.

Thank you.
