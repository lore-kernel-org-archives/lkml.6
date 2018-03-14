Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2013340-1521041196-2-7842639614143366101
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521041195; b=sbqiKEpf82eme6Ss6BqAgNA7tLEEFAiUfIlpuE2gF6pZIlk
    sR5cGMrjIRN7kRneInHsNHMIyKYnQCn8Lyytfi7rrODxKu49osmg7ZDJVhCTUpWs
    YeUnrevPccf5uf0VwCWnkcz1NbC62SVeNVFbfVly5SkVVkt0vjHidZ/xkcvqZoEc
    BQnKv9GZDCi6dyuPP7aihMsnMcq4WkvQnVursY20eTrdxwtgtUotP5wRUF2N1Zcd
    kz7MkGpIvUq93jUmBzn4j3Rdtv0W2VXNSQC0ZGkXIg02mClWbryjP9jp8Dsv85LR
    664TvU+TDInLIFDujRarNL3xD3JHwvUV7kEXw2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521041195; bh=Gd7SYp
    bCtKiFhj8W4Jam+/cAZyaQACCuaR/wDVEiPPI=; b=XUdlTgUz2rcrx5uWpLJnIY
    N0IZqEQLHouneY30FxSZxgWRKdbAvNlh2OSOPmlKKirxkrbNh3+v9MSk5z7tdy0j
    +aj/E7XzW5f4S1DZ719dLr17htx6CtuBptGuXdrHuWpB/xmZtOW0xSKcG1acu50W
    dPIPNhCIIk9qO3c5ZRCg5PNt0TdqNppGnY9+aUDdHXIacgBG636WAsuzSHtYmW8q
    9QPTXij2aqbB9NKkWfHms9USEI0p+f8P4OKG7fLIOxlzDsaYdbAgkkl7X/zVxhu3
    6mSY5N9ktJbyNZ9KVMgnrIoUovOHP/dtYrYIzOS/0EdjpkmO9yfZCbJrOybENkQA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microchip.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microchip.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751390AbeCNP0T convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Wed, 14 Mar 2018 11:26:19 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:56360 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeCNP0S (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 14 Mar 2018 11:26:18 -0400
X-IronPort-AV: E=Sophos;i="5.47,470,1515481200";
   d="scan'208";a="12309395"
From: <Woojung.Huh@microchip.com>
To: <agraf@suse.de>
CC: <UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tbogendoerfer@suse.de>, <phil@raspberrypi.org>
Subject: RE: [PATCH] lan78xx: Connect phy early
Thread-Topic: [PATCH] lan78xx: Connect phy early
Thread-Index: AQHTu6RtZhZ6UcA9+0aQmeuzkFbzWKPP2a1A
Date: Wed, 14 Mar 2018 15:26:16 +0000
Message-ID: <9235D6609DB808459E95D78E17F2E43D40CCE531@CHN-SV-EXMX02.mchp-main.com>
References: <20180314145456.69029-1-agraf@suse.de>
In-Reply-To: <20180314145456.69029-1-agraf@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.10.76.4]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Alexander,

Thanks for patch. We will look into it if there is any corner case
Such as plug in/out while operations.

Woojung

> -----Original Message-----
> From: Alexander Graf [mailto:agraf@suse.de]
> Sent: Wednesday, March 14, 2018 10:55 AM
> To: Woojung Huh - C21699 <Woojung.Huh@microchip.com>
> Cc: UNGLinuxDriver <UNGLinuxDriver@microchip.com>; netdev@vger.kernel.org; linux-
> usb@vger.kernel.org; linux-kernel@vger.kernel.org; Thomas Bogendoerfer
> <tbogendoerfer@suse.de>; Phil Elwell <phil@raspberrypi.org>
> Subject: [PATCH] lan78xx: Connect phy early
> 
> When using wicked with a lan78xx device attached to the system, we
> end up with ethtool commands issued on the device before an ifup
> got issued. That lead to the following crash:
> 
>     Unable to handle kernel NULL pointer dereference at virtual address 0000039c
>     pgd = ffff800035b30000
>     [0000039c] *pgd=0000000000000000
>     Internal error: Oops: 96000004 [#1] SMP
>     Modules linked in: [...]
>     Supported: Yes
>     CPU: 3 PID: 638 Comm: wickedd Tainted: G            E      4.12.14-0-default #1
>     Hardware name: raspberrypi rpi/rpi, BIOS 2018.03-rc2 02/21/2018
>     task: ffff800035e74180 task.stack: ffff800036718000
>     PC is at phy_ethtool_ksettings_get+0x20/0x98
>     LR is at lan78xx_get_link_ksettings+0x44/0x60 [lan78xx]
>     pc : [<ffff0000086f7f30>] lr : [<ffff000000dcca84>] pstate: 20000005
>     sp : ffff80003671bb20
>     x29: ffff80003671bb20 x28: ffff800035e74180
>     x27: ffff000008912000 x26: 000000000000001d
>     x25: 0000000000000124 x24: ffff000008f74d00
>     x23: 0000004000114809 x22: 0000000000000000
>     x21: ffff80003671bbd0 x20: 0000000000000000
>     x19: ffff80003671bbd0 x18: 000000000000040d
>     x17: 0000000000000001 x16: 0000000000000000
>     x15: 0000000000000000 x14: ffffffffffffffff
>     x13: 0000000000000000 x12: 0000000000000020
>     x11: 0101010101010101 x10: fefefefefefefeff
>     x9 : 7f7f7f7f7f7f7f7f x8 : fefefeff31677364
>     x7 : 0000000080808080 x6 : ffff80003671bc9c
>     x5 : ffff80003671b9f8 x4 : ffff80002c296190
>     x3 : 0000000000000000 x2 : 0000000000000000
>     x1 : ffff80003671bbd0 x0 : ffff80003671bc00
>     Process wickedd (pid: 638, stack limit = 0xffff800036718000)
>     Call trace:
>     Exception stack(0xffff80003671b9e0 to 0xffff80003671bb20)
>     b9e0: ffff80003671bc00 ffff80003671bbd0 0000000000000000 0000000000000000
>     ba00: ffff80002c296190 ffff80003671b9f8 ffff80003671bc9c 0000000080808080
>     ba20: fefefeff31677364 7f7f7f7f7f7f7f7f fefefefefefefeff 0101010101010101
>     ba40: 0000000000000020 0000000000000000 ffffffffffffffff 0000000000000000
>     ba60: 0000000000000000 0000000000000001 000000000000040d ffff80003671bbd0
>     ba80: 0000000000000000 ffff80003671bbd0 0000000000000000 0000004000114809
>     baa0: ffff000008f74d00 0000000000000124 000000000000001d ffff000008912000
>     bac0: ffff800035e74180 ffff80003671bb20 ffff000000dcca84 ffff80003671bb20
>     bae0: ffff0000086f7f30 0000000020000005 ffff80002c296000 ffff800035223900
>     bb00: 0000ffffffffffff 0000000000000000 ffff80003671bb20 ffff0000086f7f30
>     [<ffff0000086f7f30>] phy_ethtool_ksettings_get+0x20/0x98
>     [<ffff000000dcca84>] lan78xx_get_link_ksettings+0x44/0x60 [lan78xx]
>     [<ffff0000087cbc40>] ethtool_get_settings+0x68/0x210
>     [<ffff0000087cc0d4>] dev_ethtool+0x214/0x2180
>     [<ffff0000087e5008>] dev_ioctl+0x400/0x630
>     [<ffff00000879dd00>] sock_do_ioctl+0x70/0x88
>     [<ffff00000879f5f8>] sock_ioctl+0x208/0x368
>     [<ffff0000082cde10>] do_vfs_ioctl+0xb0/0x848
>     [<ffff0000082ce634>] SyS_ioctl+0x8c/0xa8
>     Exception stack(0xffff80003671bec0 to 0xffff80003671c000)
>     bec0: 0000000000000009 0000000000008946 0000fffff4e841d0 0000aa0032687465
>     bee0: 0000aaaafa2319d4 0000fffff4e841d4 0000000032687465 0000000032687465
>     bf00: 000000000000001d 7f7fff7f7f7f7f7f 72606b622e71ff4c 7f7f7f7f7f7f7f7f
>     bf20: 0101010101010101 0000000000000020 ffffffffffffffff 0000ffff7f510c68
>     bf40: 0000ffff7f6a9d18 0000ffff7f44ce30 000000000000040d 0000ffff7f6f98f0
>     bf60: 0000fffff4e842c0 0000000000000001 0000aaaafa2c2e00 0000ffff7f6ab000
>     bf80: 0000fffff4e842c0 0000ffff7f62a000 0000aaaafa2b9f20 0000aaaafa2c2e00
>     bfa0: 0000fffff4e84818 0000fffff4e841a0 0000ffff7f5ad0cc 0000fffff4e841a0
>     bfc0: 0000ffff7f44ce3c 0000000080000000 0000000000000009 000000000000001d
>     bfe0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> 
> The culprit is quite simple: The driver tries to access the phy left and right,
> but only actually has a working reference to it when the device is up.
> 
> The fix thus is quite simple too: Get a reference to the phy on probe already
> and keep it even when the device is going down.
> 
> With this patch applied, I can successfully run wicked on my system and bring
> the interface up and down as many times as I want, without getting NULL pointer
> dereferences in between.
> 
> Signed-off-by: Alexander Graf <agraf@suse.de>
> ---
>  drivers/net/usb/lan78xx.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> index 60a604cc7647..931cc124ab0c 100644
> --- a/drivers/net/usb/lan78xx.c
> +++ b/drivers/net/usb/lan78xx.c
> @@ -2082,8 +2082,6 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
> 
>  	dev->fc_autoneg = phydev->autoneg;
> 
> -	phy_start(phydev);
> -
>  	netif_dbg(dev, ifup, dev->net, "phy initialised successfully");
> 
>  	return 0;
> @@ -2512,9 +2510,7 @@ static int lan78xx_open(struct net_device *net)
>  	if (ret < 0)
>  		goto done;
> 
> -	ret = lan78xx_phy_init(dev);
> -	if (ret < 0)
> -		goto done;
> +	phy_start(net->phydev);
> 
>  	/* for Link Check */
>  	if (dev->urb_intr) {
> @@ -2575,13 +2571,7 @@ static int lan78xx_stop(struct net_device *net)
>  	if (timer_pending(&dev->stat_monitor))
>  		del_timer_sync(&dev->stat_monitor);
> 
> -	phy_unregister_fixup_for_uid(PHY_KSZ9031RNX, 0xfffffff0);
> -	phy_unregister_fixup_for_uid(PHY_LAN8835, 0xfffffff0);
> -
>  	phy_stop(net->phydev);
> -	phy_disconnect(net->phydev);
> -
> -	net->phydev = NULL;
> 
>  	clear_bit(EVENT_DEV_OPEN, &dev->flags);
>  	netif_stop_queue(net);
> @@ -3481,6 +3471,11 @@ static void lan78xx_disconnect(struct usb_interface *intf)
>  	net = dev->net;
>  	unregister_netdev(net);
> 
> +	phy_unregister_fixup_for_uid(PHY_KSZ9031RNX, 0xfffffff0);
> +	phy_unregister_fixup_for_uid(PHY_LAN8835, 0xfffffff0);
> +
> +	phy_disconnect(net->phydev);
> +
>  	cancel_delayed_work_sync(&dev->wq);
> 
>  	usb_scuttle_anchored_urbs(&dev->deferred);
> @@ -3634,6 +3629,10 @@ static int lan78xx_probe(struct usb_interface *intf,
>  	pm_runtime_set_autosuspend_delay(&udev->dev,
>  					 DEFAULT_AUTOSUSPEND_DELAY);
> 
> +	ret = lan78xx_phy_init(dev);
> +	if (ret < 0)
> +		return ret;
> +
>  	return 0;
> 
>  out3:
> --
> 2.12.3

