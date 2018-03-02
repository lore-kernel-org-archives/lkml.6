Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946707AbeCBQCE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 11:02:04 -0500
Received: from mail.bootlin.com ([62.4.15.54]:37188 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1946678AbeCBQCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 11:02:01 -0500
Date: Fri, 2 Mar 2018 17:01:59 +0100
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Antoine Tenart <antoine.tenart@bootlin.com>
Cc: davem@davemloft.net, Stefan Chulski <stefanc@marvell.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next 1/5] net: mvpp2: use the same buffer pool for
 all ports
Message-ID: <20180302170159.258bcdbc@windsurf.lan>
In-Reply-To: <20180302154044.25204-2-antoine.tenart@bootlin.com>
References: <20180302154044.25204-1-antoine.tenart@bootlin.com>
        <20180302154044.25204-2-antoine.tenart@bootlin.com>
Organization: Bootlin (formerly Free Electrons)
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri,  2 Mar 2018 16:40:40 +0100, Antoine Tenart wrote:
> +static struct {
> +	int pkt_size;
> +	int buf_num;
> +} mvpp2_pools[MVPP2_BM_POOLS_NUM];

Any reason for not doing:

} mvpp2_pools[MVPP2_BM_POOLS_NUM] = {
	[MVPP2_BM_SHORT] = {
		.pkt_size = MVPP2_BM_SHORT_PKT_SIZE,
		.buf_num = MVPP2_BM_SHORT_BUF_NUM
	},
	[MVPP2_BM_LONG] = {
		.pkt_size = MVPP2_BM_LONG_PKT_SIZE,
		.buf_num = MVPP2_BM_LONG_BUF_NUM,
	},
};

And get rid of:

> +static void mvpp2_setup_bm_pool(void)
> +{
> +	/* Short pool */
> +	mvpp2_pools[MVPP2_BM_SHORT].buf_num  = MVPP2_BM_SHORT_BUF_NUM;
> +	mvpp2_pools[MVPP2_BM_SHORT].pkt_size = MVPP2_BM_SHORT_PKT_SIZE;
> +
> +	/* Long pool */
> +	mvpp2_pools[MVPP2_BM_LONG].buf_num  = MVPP2_BM_LONG_BUF_NUM;
> +	mvpp2_pools[MVPP2_BM_LONG].pkt_size = MVPP2_BM_LONG_PKT_SIZE;
> +}

 ?

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
