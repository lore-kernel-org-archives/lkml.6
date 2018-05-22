Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751425AbeEVMuN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 08:50:13 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:46271 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751199AbeEVMuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 08:50:08 -0400
X-Google-Smtp-Source: AB8JxZoXpcrJV0JFAlfBf79lCsUFAyoI8szaW0G6tc0sqAdszu356kUdIzXXvdbGsbYz1Dq4CIjdCw==
Subject: Re: [PATCH net-next v2] net: sched: don't disable bh when accessing
 action idr
To: Vlad Buslov <vladbu@mellanox.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        linux-kernel@vger.kernel.org
References: <20180519.230258.1374885458106197707.davem@davemloft.net>
 <1526932984-11544-1-git-send-email-vladbu@mellanox.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Message-ID: <1719721d-35ed-7baa-6dec-c3f7f6fc79ff@mojatatu.com>
Date: Tue, 22 May 2018 08:50:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1526932984-11544-1-git-send-email-vladbu@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/18 04:03 PM, Vlad Buslov wrote:
> Initial net_device implementation used ingress_lock spinlock to synchronize
> ingress path of device. This lock was used in both process and bh context.
> In some code paths action map lock was obtained while holding ingress_lock.
> Commit e1e992e52faa ("[NET_SCHED] protect action config/dump from irqs")
> modified actions to always disable bh, while using action map lock, in
> order to prevent deadlock on ingress_lock in softirq. This lock was removed
> from net_device, so disabling bh, while accessing action map, is no longer
> necessary.
> 
> Replace all action idr spinlock usage with regular calls that do not
> disable bh.
> 
> Signed-off-by: Vlad Buslov <vladbu@mellanox.com>

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal
