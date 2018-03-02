Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936573AbeCBQeH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 11:34:07 -0500
Received: from mail.bootlin.com ([62.4.15.54]:38358 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936304AbeCBQeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 11:34:02 -0500
Date: Fri, 2 Mar 2018 17:11:17 +0100
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Antoine Tenart <antoine.tenart@bootlin.com>
Cc: davem@davemloft.net, Yan Markman <ymarkman@marvell.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next 3/5] net: mvpp2: use a data size of 10kB for Tx
 FIFO on port 0
Message-ID: <20180302171117.2344a893@windsurf.lan>
In-Reply-To: <20180302154044.25204-4-antoine.tenart@bootlin.com>
References: <20180302154044.25204-1-antoine.tenart@bootlin.com>
        <20180302154044.25204-4-antoine.tenart@bootlin.com>
Organization: Bootlin (formerly Free Electrons)
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri,  2 Mar 2018 16:40:42 +0100, Antoine Tenart wrote:

> -/* Initialize Tx FIFO's */
> +/* Initialize Tx FIFO's
> + * The CP110's total tx-fifo size is 19kB.
> + * Use large-size 10kB for fast port but 3kB for others.
> + */

Is there a reason to hardcode 10KB for port 0, and 3KB for the other
ports ? Would there be use cases where the user may want different
configurations ?

It's just that it feels very "hardcoded" to enforce specifically those
numbers.

Also, does it make sense to mention the CP110 here ? Is this 19 KB
limitation a limit of the PPv2.2 IP, or of the CP110 ?

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
