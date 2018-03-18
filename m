Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753481AbeCRAFT (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 20:05:19 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:50088 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753301AbeCRAFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 20:05:14 -0400
Date: Sat, 17 Mar 2018 20:05:13 -0400 (EDT)
Message-Id: <20180317.200513.1916546646223366804.davem@davemloft.net>
To: doshir@vmware.com
Cc: netdev@vger.kernel.org, rachel_lunnon@stormagic.com, skhare@vmware.com,
        pv-drivers@vmware.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net 2/2] vmxnet3: use correct flag to indicate LRO
 feature
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180316214919.20716-1-doshir@vmware.com>
References: <20180316214919.20716-1-doshir@vmware.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ronak Doshi <doshir@vmware.com>
Date: Fri, 16 Mar 2018 14:49:19 -0700

> 'Commit 45dac1d6ea04 ("vmxnet3: Changes for vmxnet3 adapter version 2
> (fwd)")' introduced a flag "lro" in structure vmxnet3_adapter which is
> used to indicate whether LRO is enabled or not. However, the patch
> did not set the flag and hence it was never exercised.
> 
> So, when LRO is enabled, it resulted in poor TCP performance due to
> delayed acks. This issue is seen with packets which are larger than
> the mss getting a delayed ack rather than an immediate ack, thus
> resulting in high latency.
> 
> This patch removes the lro flag and directly uses device features
> against NETIF_F_LRO to check if lro is enabled.
> 
> Fixes: 45dac1d6ea04 ("vmxnet3: Changes for vmxnet3 adapter version 2 (fwd)")
> Reported-by: Rachel Lunnon <rachel_lunnon@stormagic.com>
> Signed-off-by: Ronak Doshi <doshir@vmware.com>
> Acked-by: Shrikrishna Khare <skhare@vmware.com>

Applied.
