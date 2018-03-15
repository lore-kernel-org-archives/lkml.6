Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752605AbeCOSa2 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 14:30:28 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:42942 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751492AbeCOSa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 14:30:26 -0400
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] [v2] Bluetooth: btrsi: rework dependencies
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180315165050.2211236-1-arnd@arndb.de>
Date: Thu, 15 Mar 2018 19:30:23 +0100
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>, Sebastian Reichel <sre@kernel.org>,
        Amitkumar Karwar <amit.karwar@redpinesignals.com>,
        Siva Rebbagondla <siva.rebbagondla@redpinesignals.com>,
        Linux Bluetooth mailing list
        <linux-bluetooth@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        netdev@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <988BDE3E-B2D2-4ABF-B644-4BFF41AF4157@holtmann.org>
References: <20180315165050.2211236-1-arnd@arndb.de>
To: Arnd Bergmann <arnd@arndb.de>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

> The linkage between the bluetooth driver and the wireless
> driver is not defined properly, leading to build problems
> such as:
> 
> warning: (BT_HCIRSI) selects RSI_COEX which has unmet direct dependencies (NETDEVICES && WLAN && WLAN_VENDOR_RSI && BT_HCIRSI && RSI_91X)
> drivers/net/wireless/rsi/rsi_91x_main.o: In function `rsi_read_pkt':
> (.text+0x205): undefined reference to `rsi_bt_ops'
> 
> As the dependency is actually the reverse (RSI_91X uses
> the BT_RSI driver, not the other way round), this changes
> the dependency to match, and enables the bluetooth driver
> from the RSI_COEX symbol.
> 
> Fixes: 38aa4da50483 ("Bluetooth: btrsi: add new rsi bluetooth driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: Pick a different from v1
> ---
> drivers/bluetooth/Kconfig        | 4 +---
> drivers/net/wireless/rsi/Kconfig | 4 +++-
> 2 files changed, 4 insertions(+), 4 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Since I think Kalle still has to take it through his tree until the btrsi driver makes it into net-next.

Regards

Marcel
