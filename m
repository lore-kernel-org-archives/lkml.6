Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753910AbeE3RTG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 13:19:06 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:44802 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753828AbeE3RTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 13:19:03 -0400
Date: Wed, 30 May 2018 13:18:59 -0400 (EDT)
Message-Id: <20180530.131859.1905291199897432856.davem@davemloft.net>
To: arnd@arndb.de
Cc: fugang.duan@nxp.com, fabio.estevam@nxp.com, andrew@lunn.ch,
        troy.kisky@boundarydevices.com, f.fainelli@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH, net-next] net: ethernet: freescale: fix false-positive
 string overflow warning
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180528154958.2684086-1-arnd@arndb.de>
References: <20180528154958.2684086-1-arnd@arndb.de>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 28 May 2018 17:49:46 +0200

> While compile-testing on arm64 with gcc-8.1, I ran into a build diagnostic:
 ...
> It appears this has never shown on ppc32 or arm32 for an unknown reason, but
> now gcc fails to identify that the 'irq_cnt' loop index has an upper bound
> of 3, and instead uses a bogus range.
> 
> To work around the warning, this changes the sprintf to snprintf with the
> correct buffer length.
> 
> Fixes: 78cc6e7ef957 ("net: ethernet: freescale: Allow FEC with COMPILE_TEST")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks Arnd.
