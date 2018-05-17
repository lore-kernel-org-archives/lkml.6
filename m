Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751897AbeEQUbQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 16:31:16 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:34742 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbeEQUbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 16:31:15 -0400
Date: Thu, 17 May 2018 16:31:13 -0400 (EDT)
Message-Id: <20180517.163113.2110198960037727630.davem@davemloft.net>
To: andrea.greco.gapmilano@gmail.com
Cc: tobin@apporbit.com, a.greco@4sigma.it, m.grzeschik@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/4] arcnet: com20020: Add com20020 io mapped version
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180517130529.2684-1-andrea.greco.gapmilano@gmail.com>
References: <20180517130529.2684-1-andrea.greco.gapmilano@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Greco <andrea.greco.gapmilano@gmail.com>
Date: Thu, 17 May 2018 15:05:29 +0200

> +	/* Will be set by userspace during if setup */
> +	dev->dev_addr[0] = 0;

Hmmm... really?

Also, every error path from this point forward will leak 'dev'.
