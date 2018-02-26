Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbeBZQd1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 11:33:27 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:43852 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751724AbeBZQdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 11:33:25 -0500
Date: Mon, 26 Feb 2018 11:33:23 -0500 (EST)
Message-Id: <20180226.113323.393948046273779787.davem@davemloft.net>
To: arnd@arndb.de
Cc: arkadis@mellanox.com, jiri@mellanox.com, idosch@mellanox.com,
        weiyongjun1@huawei.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 1/2] mlxsw: spectrum_kvdl: use div_u64() for
 64-bit division
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180223131540.1065413-1-arnd@arndb.de>
References: <20180223131540.1065413-1-arnd@arndb.de>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 23 Feb 2018 14:15:31 +0100

> Calculating the number of entries now uses 64-bit arithmetic that
> causes a link error on 32-bit architectures:
> 
> drivers/net/ethernet/mellanox/mlxsw/spectrum_kvdl.o: In function `mlxsw_sp_kvdl_init':
> spectrum_kvdl.c:(.text+0x51c): undefined reference to `__aeabi_uldivmod'
> 
> We could probably use a 32-bit division here as before, but since this is
> not in a performance critical path, div_u64() seems cleaner here.
> 
> Fixes: 887839e6960d ("mlxsw: spectrum_kvdl: Add support for dynamic partition set")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.
