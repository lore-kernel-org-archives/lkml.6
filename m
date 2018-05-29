Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934950AbeE2OEG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:04:06 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:55606 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751041AbeE2OEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:04:04 -0400
Date: Tue, 29 May 2018 10:04:02 -0400 (EDT)
Message-Id: <20180529.100402.330737400285261138.davem@davemloft.net>
To: arnd@arndb.de
Cc: saeedm@mellanox.com, leon@kernel.org, borisp@mellanox.com,
        ilant@mellanox.com, ogerlitz@mellanox.com, ilyal@mellanox.com,
        ferasda@mellanox.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH, net-next] net/mlx5e: fix TLS dependency
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180525213630.2119214-1-arnd@arndb.de>
References: <20180525213630.2119214-1-arnd@arndb.de>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 25 May 2018 23:36:06 +0200

> With CONFIG_TLS=m and MLX5_CORE_EN=y, we get a link failure:
> 
> drivers/net/ethernet/mellanox/mlx5/core/en_accel/tls_rxtx.o: In function `mlx5e_tls_handle_ooo':
> tls_rxtx.c:(.text+0x24c): undefined reference to `tls_get_record'
> drivers/net/ethernet/mellanox/mlx5/core/en_accel/tls_rxtx.o: In function `mlx5e_tls_handle_tx_skb':
> tls_rxtx.c:(.text+0x9a8): undefined reference to `tls_device_sk_destruct'
> 
> This narrows down the dependency to only allow the configurations
> that will actually work. The existing dependency on TLS_DEVICE is
> not sufficient here since MLX5_EN_TLS is a 'bool' symbol.
> 
> Fixes: c83294b9efa5 ("net/mlx5e: TLS, Add Innova TLS TX support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thank you.
