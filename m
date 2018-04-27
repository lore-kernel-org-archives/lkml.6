Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757873AbeD0Rw2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 13:52:28 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:55506 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757404AbeD0Rw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 13:52:26 -0400
Date: Fri, 27 Apr 2018 13:52:25 -0400 (EDT)
Message-Id: <20180427.135225.1468704958478892765.davem@davemloft.net>
To: tobias.regnery@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexey.kodanev@oracle.com
Subject: Re: [PATCH net-next] geneve: fix build with modular IPV6
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180426103636.16113-1-tobias.regnery@gmail.com>
References: <20180426103636.16113-1-tobias.regnery@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tobias Regnery <tobias.regnery@gmail.com>
Date: Thu, 26 Apr 2018 12:36:36 +0200

> Commit c40e89fd358e ("geneve: configure MTU based on a lower device") added
> an IS_ENABLED(CONFIG_IPV6) to geneve, leading to the following link error
> with CONFIG_GENEVE=y and CONFIG_IPV6=m:
> 
> drivers/net/geneve.o: In function `geneve_link_config':
> geneve.c:(.text+0x14c): undefined reference to `rt6_lookup'
> 
> Fix this by adding a Kconfig dependency and forcing GENEVE to be a module
> when IPV6 is a module.
> 
> Fixes: c40e89fd358e ("geneve: configure MTU based on a lower device")
> Signed-off-by: Tobias Regnery <tobias.regnery@gmail.com>

Applied, thank you.
