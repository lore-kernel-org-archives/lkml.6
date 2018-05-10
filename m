Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752672AbeEJVyC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 17:54:02 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:37856 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752412AbeEJVyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 17:54:00 -0400
Date: Thu, 10 May 2018 17:53:58 -0400 (EDT)
Message-Id: <20180510.175358.1296757435086922873.davem@davemloft.net>
To: colin.king@canonical.com
Cc: igor.russkikh@aquantia.com, pavel.belous@aquantia.com,
        weiyongjun1@huawei.com, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] net: aquantia: fix unsigned numvecs comparison
 with less than zero
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180510125201.19707-1-colin.king@canonical.com>
References: <20180510125201.19707-1-colin.king@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Thu, 10 May 2018 13:52:01 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> The comparison of numvecs < 0 is always false because numvecs is a u32
> and hence the error return from a failed call to pci_alloc_irq_vectores
> is never detected.  Fix this by using the signed int ret to handle the
> error return and assign numvecs to err.
> 
> Detected by CoverityScan, CID#1468650 ("Unsigned compared against 0")
> 
> Fixes: a09bd81b5413 ("net: aquantia: Limit number of vectors to actually allocated irqs")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

This doesn't apply to net-next.
