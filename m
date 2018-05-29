Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032773AbeE2Cyx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 22:54:53 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:48860 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030894AbeE2Cyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 22:54:47 -0400
Date: Mon, 28 May 2018 22:54:45 -0400 (EDT)
Message-Id: <20180528.225445.996478506804495385.davem@davemloft.net>
To: thierry.reding@gmail.com
Cc: peppe.cavallaro@st.com, alexandre.torgue@st.com, jonathanh@nvidia.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: Use mutex instead of spinlock
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180524140907.24197-1-thierry.reding@gmail.com>
References: <20180524140907.24197-1-thierry.reding@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <thierry.reding@gmail.com>
Date: Thu, 24 May 2018 16:09:07 +0200

> From: Thierry Reding <treding@nvidia.com>
> 
> Some drivers, such as DWC EQOS on Tegra, need to perform operations that
> can sleep under this lock (clk_set_rate() in tegra_eqos_fix_speed()) for
> proper operation. Since there is no need for this lock to be a spinlock,
> convert it to a mutex instead.
> 
> Fixes: e6ea2d16fc61 ("net: stmmac: dwc-qos: Add Tegra186 support")
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> This applies on top of net-next.

Applied to net-next.
