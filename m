Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118A2C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 06:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C082920864
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 06:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Gqc1c+tb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C082920864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392293AbeKVRbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:31:47 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:50190 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbeKVRbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:31:46 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id C408F24E0BD0;
        Wed, 21 Nov 2018 22:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542869624; bh=3hqqogX9SilFjtG1INkppgzTwglmFtOKDdPhmCGOXN0=;
        h=From:To:CC:Subject:Date:References:From;
        b=Gqc1c+tbV5MOYDRPsmgITsJW/jdc+Reb6Xvvi5whsLb+jKyrlMi4WoJ++lKog05Vb
         rfgU+SdueqW2JbIbeyTLGShetNkrWHoWtRi2fhthXQmdIWcEb56HX4RNfBDyD3LL2/
         DtQa32hERLi8w+xd64ZhD/OYz+ozDynE58i2oOkSRXmgaaDeFGXTU/mKHLsE8vHNHg
         2kvl8LDvzcKf0E/u+UvZXZ46XkcCw3llok945dtxJ4i8AV0N3rrEVJCMTrybPMMuyz
         8/Qygnx8YIZYEw0PW76yiTuWGWSYxCsZtOR0shTPDockrMkL8Gjq68mR4sVstx+CcS
         ocD+4rcCdZT6Q==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 4CA293409;
        Wed, 21 Nov 2018 22:53:43 -0800 (PST)
Received: from AM04WEHTCB.internal.synopsys.com (10.116.16.192) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 21 Nov 2018 22:53:42 -0800
Received: from AM04WEMBXA.internal.synopsys.com ([fe80::79c3:55f2:1f20:5bf4])
 by am04wehtcb.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Thu,
 22 Nov 2018 10:53:40 +0400
From:   Minas Harutyunyan <minas.harutyunyan@synopsys.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <minas.harutyunyan@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] usb: dwc2: Revert "usb: dwc2: Disable all EP's on
 disconnect"
Thread-Topic: [PATCH] usb: dwc2: Revert "usb: dwc2: Disable all EP's on
 disconnect"
Thread-Index: AQHUgbE8ouTBXi+nzkarEEkfP9zP5Q==
Date:   Thu, 22 Nov 2018 06:53:38 +0000
Message-ID: <410670D7E743164D87FA6160E7907A56013A7AA1EE@am04wembxa.internal.synopsys.com>
References: <CGME20181121154518eucas1p2cc7ffd4d071ff420c747e1d0c387ee5d@eucas1p2.samsung.com>
 <20181121154504.13052-1-m.szyprowski@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.116.70.39]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,=0A=
=0A=
On 11/21/2018 7:45 PM, Marek Szyprowski wrote:=0A=
> This reverts commit dccf1bad4be7eaa096c1f3697bd37883f9a08ecb.=0A=
> =0A=
> The reverted commit breaks locking in the DWC2 driver. It causes random=
=0A=
> crashes or memory corruption related issues on SMP machines. Here is an=
=0A=
> example of the observed reproducible issue (other are a bit more random):=
=0A=
> =0A=
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
> WARNING: bad unlock balance detected!=0A=
> 4.19.0-rc6-00027-gdccf1bad4be7-dirty #1119 Not tainted=0A=
> -------------------------------------=0A=
> ip/1464 is trying to release lock (&(&hsotg->lock)->rlock) at:=0A=
> [<c0615494>] dwc2_hsotg_complete_request+0x84/0x218=0A=
> but there are no more locks to release!=0A=
> =0A=
> other info that might help us debug this:=0A=
> 2 locks held by ip/1464:=0A=
>   #0: d69babd3 (rtnl_mutex){+.+.}, at: rtnetlink_rcv_msg+0x224/0x488=0A=
>   #1: 5fb350d2 (&(&dev->lock)->rlock){-.-.}, at: eth_stop+0x24/0xa8=0A=
> =0A=
> stack backtrace:=0A=
> CPU: 1 PID: 1464 Comm: ip Not tainted 4.19.0-rc6-00027-gdccf1bad4be7-dirt=
y #1119=0A=
> Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)=0A=
> [<c0111f9c>] (unwind_backtrace) from [<c010deb8>] (show_stack+0x10/0x14)=
=0A=
> [<c010deb8>] (show_stack) from [<c09d3398>] (dump_stack+0x90/0xc8)=0A=
> [<c09d3398>] (dump_stack) from [<c017d02c>] (print_unlock_imbalance_bug+0=
xb0/0xe0)=0A=
> [<c017d02c>] (print_unlock_imbalance_bug) from [<c01800dc>] (lock_release=
+0x1a4/0x374)=0A=
> [<c01800dc>] (lock_release) from [<c09ef7fc>] (_raw_spin_unlock+0x18/0x54=
)=0A=
> [<c09ef7fc>] (_raw_spin_unlock) from [<c0615494>] (dwc2_hsotg_complete_re=
quest+0x84/0x218)=0A=
> [<c0615494>] (dwc2_hsotg_complete_request) from [<c0617530>] (kill_all_re=
quests+0x44/0xb4)=0A=
> [<c0617530>] (kill_all_requests) from [<c0617690>] (dwc2_hsotg_ep_disable=
+0xf0/0x200)=0A=
> [<c0617690>] (dwc2_hsotg_ep_disable) from [<c0659698>] (usb_ep_disable+0x=
d0/0x1c8)=0A=
> [<c0659698>] (usb_ep_disable) from [<c065d4a8>] (eth_stop+0x68/0xa8)=0A=
> [<c065d4a8>] (eth_stop) from [<c077e0b8>] (__dev_close_many+0x94/0xfc)=0A=
> [<c077e0b8>] (__dev_close_many) from [<c078a064>] (__dev_change_flags+0xa=
0/0x198)=0A=
> [<c078a064>] (__dev_change_flags) from [<c078a17c>] (dev_change_flags+0x1=
8/0x48)=0A=
> [<c078a17c>] (dev_change_flags) from [<c07a1a98>] (do_setlink+0x298/0x990=
)=0A=
> [<c07a1a98>] (do_setlink) from [<c07a29f0>] (rtnl_newlink+0x4a0/0x6fc)=0A=
> [<c07a29f0>] (rtnl_newlink) from [<c079dd74>] (rtnetlink_rcv_msg+0x254/0x=
488)=0A=
> [<c079dd74>] (rtnetlink_rcv_msg) from [<c07c47f4>] (netlink_rcv_skb+0xe0/=
0x118)=0A=
> [<c07c47f4>] (netlink_rcv_skb) from [<c07c4094>] (netlink_unicast+0x180/0=
x1c8)=0A=
> [<c07c4094>] (netlink_unicast) from [<c07c4428>] (netlink_sendmsg+0x2bc/0=
x348)=0A=
> [<c07c4428>] (netlink_sendmsg) from [<c0760b9c>] (sock_sendmsg+0x14/0x24)=
=0A=
> [<c0760b9c>] (sock_sendmsg) from [<c0761af8>] (___sys_sendmsg+0x22c/0x248=
)=0A=
> [<c0761af8>] (___sys_sendmsg) from [<c0762740>] (__sys_sendmsg+0x40/0x6c)=
=0A=
> [<c0762740>] (__sys_sendmsg) from [<c0101000>] (ret_fast_syscall+0x0/0x28=
)=0A=
> Exception stack(0xede65fa8 to 0xede65ff0)=0A=
> ...=0A=
> =0A=
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>=0A=
> ---=0A=
> The suspicious locking has been already pointed in the review of the=0A=
> first version of this patch, but sadly the v2 didn't change it and=0A=
> landed in v4.20-rc1.=0A=
> ---=0A=
>   drivers/usb/dwc2/gadget.c | 30 +++++++-----------------------=0A=
>   1 file changed, 7 insertions(+), 23 deletions(-)=0A=
> =0A=
> diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c=0A=
> index 79189db4bf17..220c0f9b89b0 100644=0A=
> --- a/drivers/usb/dwc2/gadget.c=0A=
> +++ b/drivers/usb/dwc2/gadget.c=0A=
> @@ -3109,8 +3109,6 @@ static void kill_all_requests(struct dwc2_hsotg *hs=
otg,=0A=
>   		dwc2_hsotg_txfifo_flush(hsotg, ep->fifo_index);=0A=
>   }=0A=
>   =0A=
> -static int dwc2_hsotg_ep_disable(struct usb_ep *ep);=0A=
> -=0A=
>   /**=0A=
>    * dwc2_hsotg_disconnect - disconnect service=0A=
>    * @hsotg: The device state.=0A=
> @@ -3129,12 +3127,13 @@ void dwc2_hsotg_disconnect(struct dwc2_hsotg *hso=
tg)=0A=
>   	hsotg->connected =3D 0;=0A=
>   	hsotg->test_mode =3D 0;=0A=
>   =0A=
> -	/* all endpoints should be shutdown */=0A=
>   	for (ep =3D 0; ep < hsotg->num_of_eps; ep++) {=0A=
>   		if (hsotg->eps_in[ep])=0A=
> -			dwc2_hsotg_ep_disable(&hsotg->eps_in[ep]->ep);=0A=
> +			kill_all_requests(hsotg, hsotg->eps_in[ep],=0A=
> +					  -ESHUTDOWN);=0A=
>   		if (hsotg->eps_out[ep])=0A=
> -			dwc2_hsotg_ep_disable(&hsotg->eps_out[ep]->ep);=0A=
> +			kill_all_requests(hsotg, hsotg->eps_out[ep],=0A=
> +					  -ESHUTDOWN);=0A=
>   	}=0A=
>   =0A=
>   	call_gadget(hsotg, disconnect);=0A=
> @@ -3192,23 +3191,13 @@ void dwc2_hsotg_core_init_disconnected(struct dwc=
2_hsotg *hsotg,=0A=
>   	u32 val;=0A=
>   	u32 usbcfg;=0A=
>   	u32 dcfg =3D 0;=0A=
> -	int ep;=0A=
>   =0A=
>   	/* Kill any ep0 requests as controller will be reinitialized */=0A=
>   	kill_all_requests(hsotg, hsotg->eps_out[0], -ECONNRESET);=0A=
>   =0A=
> -	if (!is_usb_reset) {=0A=
> +	if (!is_usb_reset)=0A=
>   		if (dwc2_core_reset(hsotg, true))=0A=
>   			return;=0A=
> -	} else {=0A=
> -		/* all endpoints should be shutdown */=0A=
> -		for (ep =3D 1; ep < hsotg->num_of_eps; ep++) {=0A=
> -			if (hsotg->eps_in[ep])=0A=
> -				dwc2_hsotg_ep_disable(&hsotg->eps_in[ep]->ep);=0A=
> -			if (hsotg->eps_out[ep])=0A=
> -				dwc2_hsotg_ep_disable(&hsotg->eps_out[ep]->ep);=0A=
> -		}=0A=
> -	}=0A=
>   =0A=
>   	/*=0A=
>   	 * we must now enable ep0 ready for host detection and then=0A=
> @@ -4004,7 +3993,6 @@ static int dwc2_hsotg_ep_disable(struct usb_ep *ep)=
=0A=
>   	unsigned long flags;=0A=
>   	u32 epctrl_reg;=0A=
>   	u32 ctrl;=0A=
> -	int locked;=0A=
>   =0A=
>   	dev_dbg(hsotg->dev, "%s(ep %p)\n", __func__, ep);=0A=
>   =0A=
> @@ -4020,9 +4008,7 @@ static int dwc2_hsotg_ep_disable(struct usb_ep *ep)=
=0A=
>   =0A=
>   	epctrl_reg =3D dir_in ? DIEPCTL(index) : DOEPCTL(index);=0A=
>   =0A=
> -	locked =3D spin_is_locked(&hsotg->lock);=0A=
> -	if (!locked)=0A=
> -		spin_lock_irqsave(&hsotg->lock, flags);=0A=
> +	spin_lock_irqsave(&hsotg->lock, flags);=0A=
>   =0A=
>   	ctrl =3D dwc2_readl(hsotg, epctrl_reg);=0A=
>   =0A=
> @@ -4046,9 +4032,7 @@ static int dwc2_hsotg_ep_disable(struct usb_ep *ep)=
=0A=
>   	hs_ep->fifo_index =3D 0;=0A=
>   	hs_ep->fifo_size =3D 0;=0A=
>   =0A=
> -	if (!locked)=0A=
> -		spin_unlock_irqrestore(&hsotg->lock, flags);=0A=
> -=0A=
> +	spin_unlock_irqrestore(&hsotg->lock, flags);=0A=
>   	return 0;=0A=
>   }=0A=
>   =0A=
> =0A=
=0A=
Could you please apply "[PATCH v2] usb: dwc2: Disable all EP's on =0A=
disconnect" and fix for that patch "[PATCH] usb: dwc2: Fix ep disable =0A=
spinlock flow.". Let me know on test results.=0A=
=0A=
Thanks,=0A=
Minas=0A=
