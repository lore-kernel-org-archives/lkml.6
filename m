Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754544AbeENPM0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 11:12:26 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37989 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753490AbeENPMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 11:12:24 -0400
X-Google-Smtp-Source: AB8JxZoqHhl/e9puSA2ON2ZNSdQQKoeXnQ+r0V32qhknLWh+mLCdgDZ70WLLnv5S4RBc9NmqhJR8hA==
Date: Mon, 14 May 2018 17:12:22 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Vlad Buslov <vladbu@mellanox.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, pablo@netfilter.org,
        kadlec@blackhole.kfki.hu, fw@strlen.de, ast@kernel.org,
        daniel@iogearbox.net, edumazet@google.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, kliteyn@mellanox.com
Subject: Re: [PATCH 03/14] net: sched: add 'delete' function to action ops
Message-ID: <20180514151222.GC1848@nanopsycho>
References: <1526308035-12484-1-git-send-email-vladbu@mellanox.com>
 <1526308035-12484-4-git-send-email-vladbu@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526308035-12484-4-git-send-email-vladbu@mellanox.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, May 14, 2018 at 04:27:04PM CEST, vladbu@mellanox.com wrote:
>Extend action ops with 'delete' function. Each action type to implement its
>own delete function that doesn't depend on rtnl lock.
>
>Signed-off-by: Vlad Buslov <vladbu@mellanox.com>
>---
> include/net/act_api.h | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/include/net/act_api.h b/include/net/act_api.h
>index e634014..73175a3 100644
>--- a/include/net/act_api.h
>+++ b/include/net/act_api.h
>@@ -100,6 +100,7 @@ struct tc_action_ops {
> 	void	(*stats_update)(struct tc_action *, u64, u32, u64);
> 	size_t  (*get_fill_size)(const struct tc_action *act);
> 	struct net_device *(*get_dev)(const struct tc_action *a);
>+	int     (*delete)(struct net *net, u32 index);

Probably better to squash this to patch 14.
