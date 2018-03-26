Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752624AbeCZQ6U (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 12:58:20 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:53274 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752523AbeCZQ6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 12:58:18 -0400
Date: Mon, 26 Mar 2018 12:58:16 -0400 (EDT)
Message-Id: <20180326.125816.1498152294570222508.davem@davemloft.net>
To: mike.looijmans@topic.nl
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
        robh+dt@kernel.org, frowand.list@gmail.com
Subject: Re: [PATCH v2] of_net: Implement of_get_nvmem_mac_address helper
From: David Miller <davem@davemloft.net>
In-Reply-To: <1522046489-19652-1-git-send-email-mike.looijmans@topic.nl>
References: <1521815074-30424-1-git-send-email-mike.looijmans@topic.nl>
        <20180323151101.GB24361@lunn.ch>
        <1522046489-19652-1-git-send-email-mike.looijmans@topic.nl>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Looijmans <mike.looijmans@topic.nl>
Date: Mon, 26 Mar 2018 08:41:29 +0200

> It's common practice to store MAC addresses for network interfaces into
> nvmem devices. However the code to actually do this in the kernel lacks,
> so this patch adds of_get_nvmem_mac_address() for drivers to obtain the
> address from an nvmem cell provider.
> 
> This is particulary useful on devices where the ethernet interface cannot
> be configured by the bootloader, for example because it's in an FPGA.
> 
> Tested by adapting the cadence macb driver to call this instead of
> of_get_mac_address().
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
> v2: Use of_nvmem_cell_get to avoid needing the assiciated device
>     Use void* instead of char*
>     Add devicetree binding doc

Like Andrew, I think you should add a new interface for getting the MAC
address from nvmem.

And drivers can call both of them if they want OF device tree and
NVMEM probing for MAC addresses.

Later you can add a consolidated interface, if necessary, which does
both and also take a reference to the MAC address buffer of the driver
in order to deal with the resource allocation issues.

Thanks.
