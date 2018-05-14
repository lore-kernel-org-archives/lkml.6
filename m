Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752150AbeENU3s (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 16:29:48 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:41410 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751962AbeENU3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 16:29:46 -0400
Date: Mon, 14 May 2018 16:29:45 -0400 (EDT)
Message-Id: <20180514.162945.673218440357756147.davem@davemloft.net>
To: tarick@google.com
Cc: tariqt@mellanox.com, gthelen@google.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net/mlx4_core: Fix error handling in
 mlx4_init_port_info.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180513233845.135290-1-tarick@google.com>
References: <20180513233845.135290-1-tarick@google.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tarick Bedeir <tarick@google.com>
Date: Sun, 13 May 2018 16:38:45 -0700

> Avoid exiting the function with a lingering sysfs file (if the first
> call to device_create_file() fails while the second succeeds), and avoid
> calling devlink_port_unregister() twice.
> 
> In other words, either mlx4_init_port_info() succeeds and returns zero, or
> it fails, returns non-zero, and requires no cleanup.
> 
> Fixes: 096335b3f983 ("mlx4_core: Allow dynamic MTU configuration for IB
> ports")
> Signed-off-by: Tarick Bedeir <tarick@google.com>
> ---
> v1 -> v2: Added "Fixes" tag.

Applied and queued up for -stable.
