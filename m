Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751953AbeB0Tes (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 14:34:48 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:33246 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbeB0Ter (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 14:34:47 -0500
Date: Tue, 27 Feb 2018 14:34:45 -0500 (EST)
Message-Id: <20180227.143445.158717432104110215.davem@davemloft.net>
To: maxime.chevallier@bootlin.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        antoine.tenart@bootlin.com, thomas.petazzoni@free-electrons.com,
        gregory.clement@free-electrons.com, miquel.raynal@free-electrons.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next] net: mvpp2: Add hardware offloading for VLAN
 filtering
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180227091143.10696-1-maxime.chevallier@bootlin.com>
References: <20180227091143.10696-1-maxime.chevallier@bootlin.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date: Tue, 27 Feb 2018 10:11:43 +0100

> +/* Find tcam entry with matched pair <vid,port> */
> +static int mvpp2_prs_vid_range_find(struct mvpp2 *priv, int pmap, u16 vid,
> +				    u16 mask)
> +{
> +	struct mvpp2_prs_entry pe;
> +	unsigned char byte[2], enable[2];
> +	u16 rvid, rmask;
> +	int tid;

Please use reverse christmas tree ordering for local variables
(longest to shortest line).

> +/* Write parser entry for VID filtering */
> +static int mvpp2_prs_vid_entry_add(struct mvpp2_port *port, u16 vid)
> +{
> +	struct mvpp2 *priv = port->priv;
> +	struct mvpp2_prs_entry pe;
> +	int tid;
> +	unsigned int mask = 0xfff, reg_val, shift;
> +	unsigned int vid_start = MVPP2_PE_VID_FILT_RANGE_START +
> +				 port->id * MVPP2_PRS_VLAN_FILT_MAX;

Likewise.

> +/* Remove VID filering entry for this port */
> +static void mvpp2_prs_vid_disable_filtering(struct mvpp2_port *port)
> +{
> +	struct mvpp2 *priv = port->priv;
> +	unsigned int tid = MVPP2_PRS_VID_PORT_DFLT(port->id);

Likewise.

> +/* Add guard entry that drops packets when no VID is matched on this port */
> +static void mvpp2_prs_vid_enable_filtering(struct mvpp2_port *port)
> +{
> +	struct mvpp2_prs_entry pe;
> +	struct mvpp2 *priv = port->priv;
> +	unsigned int tid = MVPP2_PRS_VID_PORT_DFLT(port->id);
> +	unsigned int reg_val, shift;

Likewise.

> +static int mvpp2_vlan_rx_add_vid(struct net_device *dev, __be16 proto, u16 vid)
> +{
> +	int ret;
> +	struct mvpp2_port *port = netdev_priv(dev);

Likewise.

> +static int mvpp2_set_features(struct net_device *dev,
> +			      netdev_features_t features)
> +{
> +	struct mvpp2_port *port = netdev_priv(dev);
> +	netdev_features_t changed = dev->features ^ features;

Likewise.
