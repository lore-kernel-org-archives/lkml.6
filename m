Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752807AbeCOVQy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 17:16:54 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:40650 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751975AbeCOVQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 17:16:52 -0400
X-Google-Smtp-Source: AG47ELuN2MiurQxi2UlxiZWtfvfUAm14huSNQG5U1mwxBCuZZ7ct+CfRV4t++++BD1AW/EBp77zbmTlY6E6iMOxBDw8=
MIME-Version: 1.0
In-Reply-To: <988BDE3E-B2D2-4ABF-B644-4BFF41AF4157@holtmann.org>
References: <20180315165050.2211236-1-arnd@arndb.de> <988BDE3E-B2D2-4ABF-B644-4BFF41AF4157@holtmann.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 15 Mar 2018 22:16:51 +0100
X-Google-Sender-Auth: aznJ39sXU3jco4b9TqofXDawtgE
Message-ID: <CAK8P3a1DTbbRUoCoYsmaSAQBQhaePZ0Tx-g2+xuab3yRcGhLpw@mail.gmail.com>
Subject: Re: [PATCH] [v2] Bluetooth: btrsi: rework dependencies
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>, Sebastian Reichel <sre@kernel.org>,
        Amitkumar Karwar <amit.karwar@redpinesignals.com>,
        Siva Rebbagondla <siva.rebbagondla@redpinesignals.com>,
        Linux Bluetooth mailing list
        <linux-bluetooth@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 7:30 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Arnd,
>
>> The linkage between the bluetooth driver and the wireless
>> driver is not defined properly, leading to build problems
>> such as:
>>
>> warning: (BT_HCIRSI) selects RSI_COEX which has unmet direct dependencies (NETDEVICES && WLAN && WLAN_VENDOR_RSI && BT_HCIRSI && RSI_91X)
>> drivers/net/wireless/rsi/rsi_91x_main.o: In function `rsi_read_pkt':
>> (.text+0x205): undefined reference to `rsi_bt_ops'
>>
>> As the dependency is actually the reverse (RSI_91X uses
>> the BT_RSI driver, not the other way round), this changes
>> the dependency to match, and enables the bluetooth driver
>> from the RSI_COEX symbol.
>>
>> Fixes: 38aa4da50483 ("Bluetooth: btrsi: add new rsi bluetooth driver")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>> v2: Pick a different from v1
>> ---
>> drivers/bluetooth/Kconfig        | 4 +---
>> drivers/net/wireless/rsi/Kconfig | 4 +++-
>> 2 files changed, 4 insertions(+), 4 deletions(-)
>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
>
> Since I think Kalle still has to take it through his tree until the btrsi driver makes it into net-next.

Ok. Kalle, please wait for v3 though, I just ran into another build failure
caused by a typo in v2.

        Arnd
