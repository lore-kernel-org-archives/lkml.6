Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752212AbeBZQdd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 11:33:33 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:43866 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751761AbeBZQda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 11:33:30 -0500
Date: Mon, 26 Feb 2018 11:33:29 -0500 (EST)
Message-Id: <20180226.113329.1873010713546052461.davem@davemloft.net>
To: arnd@arndb.de
Cc: arkadis@mellanox.com, jiri@mellanox.com, idosch@mellanox.com,
        weiyongjun1@huawei.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 2/2] mlxsw: spectrum_kvdl: avoid uninitialized
 variable warning
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180223131540.1065413-2-arnd@arndb.de>
References: <20180223131540.1065413-1-arnd@arndb.de>
        <20180223131540.1065413-2-arnd@arndb.de>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 23 Feb 2018 14:15:32 +0100

> gcc warns that 'resource_id' is not initialized if we don't come though
> any of the three 'case' statements before:
> 
> drivers/net/ethernet/mellanox/mlxsw/spectrum_kvdl.c: In function 'mlxsw_sp_kvdl_part_init':
> drivers/net/ethernet/mellanox/mlxsw/spectrum_kvdl.c:275:8: error: 'resource_id' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> In the current code, that won't happen, but it's more robust to explicitly
> handle this by returning a failure from mlxsw_sp_kvdl_part_init.
> 
> Fixes: 887839e6960d ("mlxsw: spectrum_kvdl: Add support for dynamic partition set")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.
