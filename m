Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755079AbeENQat (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 12:30:49 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45708 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753661AbeENQaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 12:30:46 -0400
X-Google-Smtp-Source: AB8JxZobn4KSJTEGCnRrGwIoXT0/IFi4NGxLtQPRqcGS/eNacGyMcGKMqVeH9J80FvboQqH7vJ5Czw==
Date: Mon, 14 May 2018 18:30:44 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Vlad Buslov <vladbu@mellanox.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, pablo@netfilter.org,
        kadlec@blackhole.kfki.hu, fw@strlen.de, ast@kernel.org,
        daniel@iogearbox.net, edumazet@google.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, kliteyn@mellanox.com
Subject: Re: [PATCH 03/14] net: sched: add 'delete' function to action ops
Message-ID: <20180514163044.GE2134@nanopsycho.orion>
References: <1526308035-12484-1-git-send-email-vladbu@mellanox.com>
 <1526308035-12484-4-git-send-email-vladbu@mellanox.com>
 <20180514151222.GC1848@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514151222.GC1848@nanopsycho>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, May 14, 2018 at 05:12:22PM CEST, jiri@resnulli.us wrote:
>Mon, May 14, 2018 at 04:27:04PM CEST, vladbu@mellanox.com wrote:
>>Extend action ops with 'delete' function. Each action type to implement its
>>own delete function that doesn't depend on rtnl lock.
>>
>>Signed-off-by: Vlad Buslov <vladbu@mellanox.com>
>>---
>> include/net/act_api.h | 1 +
>> 1 file changed, 1 insertion(+)
>>
>>diff --git a/include/net/act_api.h b/include/net/act_api.h
>>index e634014..73175a3 100644
>>--- a/include/net/act_api.h
>>+++ b/include/net/act_api.h
>>@@ -100,6 +100,7 @@ struct tc_action_ops {
>> 	void	(*stats_update)(struct tc_action *, u64, u32, u64);
>> 	size_t  (*get_fill_size)(const struct tc_action *act);
>> 	struct net_device *(*get_dev)(const struct tc_action *a);
>>+	int     (*delete)(struct net *net, u32 index);
>
>Probably better to squash this to patch 14.

Oh, I see you call it in patch 6. Fine.
