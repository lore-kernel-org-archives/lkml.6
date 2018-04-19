Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753352AbeDSUas (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 16:30:48 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:35062 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751876AbeDSUar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 16:30:47 -0400
Date: Thu, 19 Apr 2018 16:30:45 -0400 (EDT)
Message-Id: <20180419.163045.1214694926986226484.davem@davemloft.net>
To: dann.frazier@canonical.com
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linyunsheng@huawei.com
Subject: Re: [PATCH] net: hns: Avoid action name truncation
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180419035541.6318-1-dann.frazier@canonical.com>
References: <20180419035541.6318-1-dann.frazier@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dann frazier <dann.frazier@canonical.com>
Date: Wed, 18 Apr 2018 21:55:41 -0600

> When longer interface names are used, the action names exposed in
> /proc/interrupts and /proc/irq/* maybe truncated. For example, when
> using the predictable name algorithm in systemd on a HiSilicon D05,
> I see:
> 
>   ubuntu@d05-3:~$  grep enahisic2i0-tx /proc/interrupts | sed 's/.* //'
>   enahisic2i0-tx0
>   enahisic2i0-tx1
>   [...]
>   enahisic2i0-tx8
>   enahisic2i0-tx9
>   enahisic2i0-tx1
>   enahisic2i0-tx1
>   enahisic2i0-tx1
>   enahisic2i0-tx1
>   enahisic2i0-tx1
>   enahisic2i0-tx1
> 
> Increase the max ring name length to allow for an interface name
> of IFNAMSIZE. After this change, I now see:
> 
>   $ grep enahisic2i0-tx /proc/interrupts | sed 's/.* //'
>   enahisic2i0-tx0
>   enahisic2i0-tx1
>   enahisic2i0-tx2
>   [...]
>   enahisic2i0-tx8
>   enahisic2i0-tx9
>   enahisic2i0-tx10
>   enahisic2i0-tx11
>   enahisic2i0-tx12
>   enahisic2i0-tx13
>   enahisic2i0-tx14
>   enahisic2i0-tx15
> 
> Signed-off-by: dann frazier <dann.frazier@canonical.com>

Applied, thank you.
