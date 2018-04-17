Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753707AbeDQNxg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 09:53:36 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:55380 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753636AbeDQNxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 09:53:34 -0400
Date: Tue, 17 Apr 2018 09:53:32 -0400 (EDT)
Message-Id: <20180417.095332.47355231483878538.davem@davemloft.net>
To: rafalo@cadence.com
Cc: nicolas.ferre@microchip.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, piotrs@cadence.com, ltyrala@cadence.com
Subject: Re: [PATCH 0/3] Receive Side Coalescing for macb driver
From: David Miller <davem@davemloft.net>
In-Reply-To: <BN3PR0701MB1122B2FF2A1C54CD363B16A7C9B70@BN3PR0701MB1122.namprd07.prod.outlook.com>
References: <1523739187-20077-1-git-send-email-rafalo@cadence.com>
        <20180416.110855.61732218036810337.davem@davemloft.net>
        <BN3PR0701MB1122B2FF2A1C54CD363B16A7C9B70@BN3PR0701MB1122.namprd07.prod.outlook.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafal Ozieblo <rafalo@cadence.com>
Date: Tue, 17 Apr 2018 08:59:35 +0000

> If IP supports RSC and skb has 2B reserved for alignment we end up
> with none packets receive correctly (2B missing in the each skb).
> We can either leave few customers without support in Linux driver or
> let them use the driver with decrease performance.

You probably want to find a way to memmove() the headers to be aligned
in this case, and then point the data afterwards into SKB page frags.
