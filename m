Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754371AbeEWHcy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 03:32:54 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37010 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754184AbeEWHcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 03:32:51 -0400
X-Google-Smtp-Source: AB8JxZoPrqUjxtv3Ad0//SYMQvYTKACLfj3Yozde5Yvospy6FxUJXaR3xzzQ+Z/hLdPezXKIhFNfHA==
Date: Wed, 23 May 2018 09:32:39 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Vlad Buslov <vladbu@mellanox.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: sched: don't disable bh when accessing
 action idr
Message-ID: <20180523073239.GC3155@nanopsycho>
References: <20180519.230258.1374885458106197707.davem@davemloft.net>
 <1526932984-11544-1-git-send-email-vladbu@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526932984-11544-1-git-send-email-vladbu@mellanox.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, May 21, 2018 at 10:03:04PM CEST, vladbu@mellanox.com wrote:
>Initial net_device implementation used ingress_lock spinlock to synchronize
>ingress path of device. This lock was used in both process and bh context.
>In some code paths action map lock was obtained while holding ingress_lock.
>Commit e1e992e52faa ("[NET_SCHED] protect action config/dump from irqs")
>modified actions to always disable bh, while using action map lock, in
>order to prevent deadlock on ingress_lock in softirq. This lock was removed
>from net_device, so disabling bh, while accessing action map, is no longer
>necessary.
>
>Replace all action idr spinlock usage with regular calls that do not
>disable bh.
>
>Signed-off-by: Vlad Buslov <vladbu@mellanox.com>

Please add my tag to v3, with the description changes requested by Cong.
Acked-by: Jiri Pirko <jiri@mellanox.com>

Thanks!
