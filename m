Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751164AbeCICu4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 21:50:56 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:46414 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750878AbeCICuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 21:50:54 -0500
Date: Thu, 08 Mar 2018 21:50:53 -0500 (EST)
Message-Id: <20180308.215053.1594215295032419362.davem@davemloft.net>
To: niklas.cassel@axis.com
Cc: peppe.cavallaro@st.com, alexandre.torgue@st.com,
        Jose.Abreu@synopsys.com, pavel@ucw.cz, niklass@axis.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: stmmac: remove superfluous wmb() memory
 barriers
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180308103006.1197-1-niklas.cassel@axis.com>
References: <20180308103006.1197-1-niklas.cassel@axis.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niklas Cassel <niklas.cassel@axis.com>
Date: Thu,  8 Mar 2018 11:30:05 +0100

> These wmb() memory barriers are performed after the last descriptor write,
> and they are followed by enable_dma_transmission()/set_tx_tail_ptr(),
> i.e. a writel() to MMIO register space.
> Since writel() itself performs the equivalent of a wmb() before doing the
> actual write, these barriers are superfluous, and removing them should
> thus not change any existing behavior.
> 
> Ordering within the descriptor writes is already ensured with dma_wmb()
> barriers inside prepare_tx_desc(first, ..)/prepare_tso_tx_desc(first, ..).
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>

Please allow me some time to consider this issue a little bit more
before applying this patch.

Thank you Niklas.
