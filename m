Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751379AbeEPTHD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 15:07:03 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:44198 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750799AbeEPTHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 15:07:01 -0400
Date: Wed, 16 May 2018 15:06:59 -0400 (EDT)
Message-Id: <20180516.150659.104496510409110952.davem@davemloft.net>
To: f.fainelli@gmail.com
Cc: netdev@vger.kernel.org, fugang.duan@nxp.com, andrew@lunn.ch,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/3] net: Allow more drivers with
 COMPILE_TEST
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180516185258.20508-1-f.fainelli@gmail.com>
References: <20180516185258.20508-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4GJ78jM029802

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Wed, 16 May 2018 11:52:55 -0700

> This patch series includes more drivers to be build tested with COMPILE_TEST
> enabled. This helps cover some of the issues I just ran into with missing
> a driver *sigh*.
> 
> Changes in v2:
> 
> - allow FEC to build outside of CONFIG_ARM/ARM64 by defining a layout of
>   registers, this is not meant to run, so this is not a real issue if we
>   are not matching the correct register layout

Ok, this is a lot better.

But man, some of these drivers...

drivers/net/ethernet/ti/davinci_cpdma.c: In function ¡cpdma_desc_pool_destroy¢:
drivers/net/ethernet/ti/davinci_cpdma.c:194:7: warning: format ¡%d¢ expects argument of type ¡int¢, but argument 2 has type ¡size_t {aka long unsigned int}¢ [-Wformat=]
       "cpdma_desc_pool size %d != avail %d",
       ^
       gen_pool_size(pool->gen_pool),
       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

and on and on and on...

But I'm really happy to see FEC and others at least being build tested
in more scenerios.

So applied, thanks.
