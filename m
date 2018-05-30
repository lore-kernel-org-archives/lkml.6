Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968498AbeE3Guq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 02:50:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:54944 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936939AbeE3Gup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 02:50:45 -0400
Date: Wed, 30 May 2018 08:50:43 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: steam: select CONFIG_POWER_SUPPLY
In-Reply-To: <20180525153118.3015806-1-arnd@arndb.de>
Message-ID: <nycvar.YFH.7.76.1805300850320.27054@cbobk.fhfr.pm>
References: <20180525153118.3015806-1-arnd@arndb.de>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 May 2018, Arnd Bergmann wrote:

> Using the power supply APIs requires selecting the appropriate
> Kconfig symbol, otherwise we get this build failure:
> 
> drivers/hid/hid-steam.o: In function `steam_unregister':
> hid-steam.c:(.text+0x1cc): undefined reference to `power_supply_unregister'
> drivers/hid/hid-steam.o: In function `steam_battery_get_property':
> hid-steam.c:(.text+0x2d2): undefined reference to `power_supply_get_drvdata'
> drivers/hid/hid-steam.o: In function `steam_raw_event':
> hid-steam.c:(.text+0xcba): undefined reference to `power_supply_changed'
> drivers/hid/hid-steam.o: In function `steam_register':
> hid-steam.c:(.text+0x13e3): undefined reference to `power_supply_register'
> hid-steam.c:(.text+0x13fe): undefined reference to `power_supply_powers'
> 
> Fixes: f82719790751 ("HID: steam: add battery device.")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
