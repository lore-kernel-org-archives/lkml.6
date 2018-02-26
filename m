Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751812AbeBZSuO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 13:50:14 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:45628 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751746AbeBZSuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 13:50:11 -0500
Date: Mon, 26 Feb 2018 13:50:10 -0500 (EST)
Message-Id: <20180226.135010.66707697236959796.davem@davemloft.net>
To: jasowang@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, mst@redhat.com,
        sergei.shtylyov@cogentembedded.com, christoffer.dall@linaro.org,
        brouer@redhat.com
Subject: Re: [PATCH V4 net 2/3] tuntap: disable preemption during XDP
 processing
From: David Miller <davem@davemloft.net>
In-Reply-To: <1519443146-9089-2-git-send-email-jasowang@redhat.com>
References: <1519443146-9089-1-git-send-email-jasowang@redhat.com>
        <1519443146-9089-2-git-send-email-jasowang@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wang <jasowang@redhat.com>
Date: Sat, 24 Feb 2018 11:32:25 +0800

> Except for tuntap, all other drivers' XDP was implemented at NAPI
> poll() routine in a bh. This guarantees all XDP operation were done at
> the same CPU which is required by e.g BFP_MAP_TYPE_PERCPU_ARRAY. But
> for tuntap, we do it in process context and we try to protect XDP
> processing by RCU reader lock. This is insufficient since
> CONFIG_PREEMPT_RCU can preempt the RCU reader critical section which
> breaks the assumption that all XDP were processed in the same CPU.
> 
> Fixing this by simply disabling preemption during XDP processing.
> 
> Fixes: 761876c857cb ("tap: XDP support")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Applied.
