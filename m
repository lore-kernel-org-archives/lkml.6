Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752155AbeEPSRl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 14:17:41 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:43404 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751155AbeEPSRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 14:17:39 -0400
Date: Wed, 16 May 2018 14:17:38 -0400 (EDT)
Message-Id: <20180516.141738.494765267490482500.davem@davemloft.net>
To: f.fainelli@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] net: Allow more drivers with COMPILE_TEST
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180516.141514.1102545495330180859.davem@davemloft.net>
References: <20180515234825.11240-1-f.fainelli@gmail.com>
        <20180516.141514.1102545495330180859.davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4GIHllG026059

From: David Miller <davem@davemloft.net>
Date: Wed, 16 May 2018 14:15:14 -0400 (EDT)

> From: Florian Fainelli <f.fainelli@gmail.com>
> Date: Tue, 15 May 2018 16:48:22 -0700
> 
>> This patch series includes more drivers to be build tested with COMPILE_TEST
>> enabled. This helps cover some of the issues I just ran into with missing
>> a driver *sigh*.
> 
> Thank you for doing this.
> 
> Series applied.

Actually, I have to revert.

The FEC driver cannot be built tested without the appropriate platform
specific register set defines and x86-64 for example won't provide that.

drivers/net/ethernet/freescale/fec_main.c: In function ¡fec_restart¢:
drivers/net/ethernet/freescale/fec_main.c:959:26: error: ¡FEC_RACC¢ undeclared (first use in this function); did you mean ¡FEC_RXIC0¢?
   val = readl(fep->hwp + FEC_RACC);
                          ^~~~~~~~
                          FEC_RXIC0
drivers/net/ethernet/freescale/fec_main.c:959:26: note: each undeclared identifier is reported only once for each function it appears in
drivers/net/ethernet/freescale/fec_main.c:968:38: error: ¡FEC_FTRL¢ undeclared (first use in this function); did you mean ¡FEC_ECNTRL¢?
   writel(PKT_MAXBUF_SIZE, fep->hwp + FEC_FTRL);
                                      ^~~~~~~~
                                      FEC_ECNTRL
 ...
