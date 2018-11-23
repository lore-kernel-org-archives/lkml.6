Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2479C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B7120685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FqdLtM+p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4B7120685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394508AbeKWUdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:33:11 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57933 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388478AbeKWUdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:33:11 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181123094936euoutp0196dce7abbb4e8958aab6a32e134d634d~pt_0JUS351111411114euoutp01z
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 09:49:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181123094936euoutp0196dce7abbb4e8958aab6a32e134d634d~pt_0JUS351111411114euoutp01z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542966576;
        bh=ddu5i/0UMfTBUEYfP6jIV0PFasrBIEixc9tkSr274Js=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=FqdLtM+pMGwjvGtGqWSuLAvjLpII+HdRcDMPcsygkS0pbJsxPro8tQQuyaQrjXYpi
         mMMA60qD1/mahjTcacX0ihPY5F7VkAzmfc3hEW/ZsDezLoeqUBWx+Xrs95TbKEA5bw
         EIVKYe7i+U0nLh9oejZroZ3A8FxlO+Hcm2M0BmZM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181123094935eucas1p26b9d667e2ed0be4aadd7b5cb84a17bd3~pt_zZMcZ32483224832eucas1p2o;
        Fri, 23 Nov 2018 09:49:35 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 6D.C9.04441.E2DC7FB5; Fri, 23
        Nov 2018 09:49:34 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181123094934eucas1p2e6ba54e00dc59664264d9eca9ef9a745~pt_yagkho1561615616eucas1p2I;
        Fri, 23 Nov 2018 09:49:34 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181123094933eusmtrp133624bb62be2cd3af10f4bde3f908c42~pt_yKAk0G0880408804eusmtrp1j;
        Fri, 23 Nov 2018 09:49:33 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-c6-5bf7cd2e123f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E1.79.04284.D2DC7FB5; Fri, 23
        Nov 2018 09:49:33 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181123094933eusmtip158898f2eace2721537551dd112280fe7~pt_xqlbxa2198021980eusmtip11;
        Fri, 23 Nov 2018 09:49:33 +0000 (GMT)
Subject: Re: [PATCH] usb: dwc2: Revert
 "usb: dwc2: Disable all EP's on disconnect"
To:     Minas Harutyunyan <minas.harutyunyan@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <dac02dc0-789e-3352-8519-b73ceae9490a@samsung.com>
Date:   Fri, 23 Nov 2018 10:49:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <410670D7E743164D87FA6160E7907A56013A7AA1EE@am04wembxa.internal.synopsys.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOKsWRmVeSWpSXmKPExsWy7djP87p6Z79HG/z7a2mxccZ6VovX/6az
        WMy/mWTx7NZeJovmxevZLC7vmsNmsWhZK7PFuym3mR04PA4d7mD0mHcy0GP/3DXsHh+f3mLx
        6NuyitFjy/7PjB6fN8kFsEdx2aSk5mSWpRbp2yVwZeye+I6poNW7ovXNatYGxh/2XYwcHBIC
        JhJnf5p3MXJxCAmsYJR4Or2NpYuRE8j5wihxfaInROIzo8TvRb+ZQRIgDVvutrJCJJYzShy8
        PxGq4z2jxInriSC2sECIxIsH68CKRAQ2MUo8uz2dEcRhFvjIKLH06ntGkCo2AUOJrrddbCA2
        r4CdxNyFi8FsFgFVibVd18CmigrESBxbeYMRokZQ4uTMJ2BxToEoiZ/HVrGC2MwC8hLNW2cz
        Q9jiEreezGeCOPUYu8TeA/YQtotE/7IP7BC2sMSr41ugbBmJ05N7WECOkxBoZpRonzGLHcLp
        YZTYOmcHG0SVtcTh4xdZQSHGLKApsX6XPkTYUeLLRpDFoIDkk7jxVhDiBj6JSdumQ4V5JTra
        hCCq1SRmHV8Ht/bghUvMExiVZiH5bBaSb2Yh+WYWwt4FjCyrGMVTS4tz01OLDfNSy/WKE3OL
        S/PS9ZLzczcxApPT6X/HP+1g/Hop6RCjAAejEg/vho3fooVYE8uKK3MPMUpwMCuJ8DYpfo8W
        4k1JrKxKLcqPLyrNSS0+xCjNwaIkzlvN8CBaSCA9sSQ1OzW1ILUIJsvEwSnVwFgUoeNVvOX2
        j639S/L6NsuKXPhVfCxiZen79U4m+jFXT/+6E9arvDZecd8pP4s31x6sNis2ebrmxvTGz3cX
        z35Y99bQwiLzj7X7vZvlSg3Kclnul/dGrOZ2PGb/+lv14h11KU4y02Y1al6+pfUlYLXhN9+q
        vSI3rlSenPArYIb1z4g9m3bW135SYinOSDTUYi4qTgQAIcO7IEoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsVy+t/xu7q6Z79HGxx4YmCxccZ6VovX/6az
        WMy/mWTx7NZeJovmxevZLC7vmsNmsWhZK7PFuym3mR04PA4d7mD0mHcy0GP/3DXsHh+f3mLx
        6NuyitFjy/7PjB6fN8kFsEfp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb
        2aSk5mSWpRbp2yXoZeye+I6poNW7ovXNatYGxh/2XYycHBICJhJb7raydjFycQgJLGWUmPWg
        jRUiISNxcloDlC0s8edaFxtE0VtGibP7O5lBEsICIRI7F81iAkmICGxilNjSfogFxGEW+Mwo
        8WzpV0aIloeMEsfXvwZrYRMwlOh6CzKLk4NXwE5i7sLFYDaLgKrE2q5rLCC2qECMROf1eVA1
        ghInZz4Bi3MKREn8PLYK7CZmAXWJP/MuMUPY8hLNW2dD2eISt57MZ5rAKDQLSfssJC2zkLTM
        QtKygJFlFaNIamlxbnpusaFecWJucWleul5yfu4mRmBUbjv2c/MOxksbgw8xCnAwKvHwbtj4
        LVqINbGsuDL3EKMEB7OSCG+T4vdoId6UxMqq1KL8+KLSnNTiQ4ymQM9NZJYSTc4HJoy8knhD
        U0NzC0tDc2NzYzMLJXHe8waVUUIC6YklqdmpqQWpRTB9TBycUg2M7r/OmlyMc+F6vrrmgu7E
        eAnv1ysnrf5qyi3I+vyR5qJ9G2csffbMr+aegMOiUxnPd+7lXMwQL1S1ziHwBP8vS/8GW7WH
        Jkyn1NdUn792QYb7j/jp5S8+HemI6dq9Qaf32PGCIylSZb8mfFuyWsGd2eSwEZOPWfWX4ss5
        Ypp7wzlrnaMdH6/cosRSnJFoqMVcVJwIADDpmwvgAgAA
X-CMS-MailID: 20181123094934eucas1p2e6ba54e00dc59664264d9eca9ef9a745
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181121154518eucas1p2cc7ffd4d071ff420c747e1d0c387ee5d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181121154518eucas1p2cc7ffd4d071ff420c747e1d0c387ee5d
References: <CGME20181121154518eucas1p2cc7ffd4d071ff420c747e1d0c387ee5d@eucas1p2.samsung.com>
        <20181121154504.13052-1-m.szyprowski@samsung.com>
        <410670D7E743164D87FA6160E7907A56013A7AA1EE@am04wembxa.internal.synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Minas,

On 2018-11-22 07:53, Minas Harutyunyan wrote:
> On 11/21/2018 7:45 PM, Marek Szyprowski wrote:
>> This reverts commit dccf1bad4be7eaa096c1f3697bd37883f9a08ecb.
>>
>> The reverted commit breaks locking in the DWC2 driver. It causes random
>> crashes or memory corruption related issues on SMP machines. Here is an
>> example of the observed reproducible issue (other are a bit more random):
>>
>> =====================================
>> WARNING: bad unlock balance detected!
>> 4.19.0-rc6-00027-gdccf1bad4be7-dirty #1119 Not tainted
>> -------------------------------------
>> ip/1464 is trying to release lock (&(&hsotg->lock)->rlock) at:
>> [<c0615494>] dwc2_hsotg_complete_request+0x84/0x218
>> but there are no more locks to release!
>>
>> other info that might help us debug this:
>> 2 locks held by ip/1464:
>>   #0: d69babd3 (rtnl_mutex){+.+.}, at: rtnetlink_rcv_msg+0x224/0x488
>>   #1: 5fb350d2 (&(&dev->lock)->rlock){-.-.}, at: eth_stop+0x24/0xa8
>>
>> stack backtrace:
>> CPU: 1 PID: 1464 Comm: ip Not tainted 4.19.0-rc6-00027-gdccf1bad4be7-dirty #1119
>> Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
>> [<c0111f9c>] (unwind_backtrace) from [<c010deb8>] (show_stack+0x10/0x14)
>> [<c010deb8>] (show_stack) from [<c09d3398>] (dump_stack+0x90/0xc8)
>> [<c09d3398>] (dump_stack) from [<c017d02c>] (print_unlock_imbalance_bug+0xb0/0xe0)
>> [<c017d02c>] (print_unlock_imbalance_bug) from [<c01800dc>] (lock_release+0x1a4/0x374)
>> [<c01800dc>] (lock_release) from [<c09ef7fc>] (_raw_spin_unlock+0x18/0x54)
>> [<c09ef7fc>] (_raw_spin_unlock) from [<c0615494>] (dwc2_hsotg_complete_request+0x84/0x218)
>> [<c0615494>] (dwc2_hsotg_complete_request) from [<c0617530>] (kill_all_requests+0x44/0xb4)
>> [<c0617530>] (kill_all_requests) from [<c0617690>] (dwc2_hsotg_ep_disable+0xf0/0x200)
>> [<c0617690>] (dwc2_hsotg_ep_disable) from [<c0659698>] (usb_ep_disable+0xd0/0x1c8)
>> [<c0659698>] (usb_ep_disable) from [<c065d4a8>] (eth_stop+0x68/0xa8)
>> [<c065d4a8>] (eth_stop) from [<c077e0b8>] (__dev_close_many+0x94/0xfc)
>> [<c077e0b8>] (__dev_close_many) from [<c078a064>] (__dev_change_flags+0xa0/0x198)
>> [<c078a064>] (__dev_change_flags) from [<c078a17c>] (dev_change_flags+0x18/0x48)
>> [<c078a17c>] (dev_change_flags) from [<c07a1a98>] (do_setlink+0x298/0x990)
>> [<c07a1a98>] (do_setlink) from [<c07a29f0>] (rtnl_newlink+0x4a0/0x6fc)
>> [<c07a29f0>] (rtnl_newlink) from [<c079dd74>] (rtnetlink_rcv_msg+0x254/0x488)
>> [<c079dd74>] (rtnetlink_rcv_msg) from [<c07c47f4>] (netlink_rcv_skb+0xe0/0x118)
>> [<c07c47f4>] (netlink_rcv_skb) from [<c07c4094>] (netlink_unicast+0x180/0x1c8)
>> [<c07c4094>] (netlink_unicast) from [<c07c4428>] (netlink_sendmsg+0x2bc/0x348)
>> [<c07c4428>] (netlink_sendmsg) from [<c0760b9c>] (sock_sendmsg+0x14/0x24)
>> [<c0760b9c>] (sock_sendmsg) from [<c0761af8>] (___sys_sendmsg+0x22c/0x248)
>> [<c0761af8>] (___sys_sendmsg) from [<c0762740>] (__sys_sendmsg+0x40/0x6c)
>> [<c0762740>] (__sys_sendmsg) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
>> Exception stack(0xede65fa8 to 0xede65ff0)
>> ...
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>> The suspicious locking has been already pointed in the review of the
>> first version of this patch, but sadly the v2 didn't change it and
>> landed in v4.20-rc1.
>> ---
>>   drivers/usb/dwc2/gadget.c | 30 +++++++-----------------------
>>   1 file changed, 7 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
>> index 79189db4bf17..220c0f9b89b0 100644
>> --- a/drivers/usb/dwc2/gadget.c
>> +++ b/drivers/usb/dwc2/gadget.c
>> @@ -3109,8 +3109,6 @@ static void kill_all_requests(struct dwc2_hsotg *hsotg,
>>   		dwc2_hsotg_txfifo_flush(hsotg, ep->fifo_index);
>>   }
>>   
>> -static int dwc2_hsotg_ep_disable(struct usb_ep *ep);
>> -
>>   /**
>>    * dwc2_hsotg_disconnect - disconnect service
>>    * @hsotg: The device state.
>> @@ -3129,12 +3127,13 @@ void dwc2_hsotg_disconnect(struct dwc2_hsotg *hsotg)
>>   	hsotg->connected = 0;
>>   	hsotg->test_mode = 0;
>>   
>> -	/* all endpoints should be shutdown */
>>   	for (ep = 0; ep < hsotg->num_of_eps; ep++) {
>>   		if (hsotg->eps_in[ep])
>> -			dwc2_hsotg_ep_disable(&hsotg->eps_in[ep]->ep);
>> +			kill_all_requests(hsotg, hsotg->eps_in[ep],
>> +					  -ESHUTDOWN);
>>   		if (hsotg->eps_out[ep])
>> -			dwc2_hsotg_ep_disable(&hsotg->eps_out[ep]->ep);
>> +			kill_all_requests(hsotg, hsotg->eps_out[ep],
>> +					  -ESHUTDOWN);
>>   	}
>>   
>>   	call_gadget(hsotg, disconnect);
>> @@ -3192,23 +3191,13 @@ void dwc2_hsotg_core_init_disconnected(struct dwc2_hsotg *hsotg,
>>   	u32 val;
>>   	u32 usbcfg;
>>   	u32 dcfg = 0;
>> -	int ep;
>>   
>>   	/* Kill any ep0 requests as controller will be reinitialized */
>>   	kill_all_requests(hsotg, hsotg->eps_out[0], -ECONNRESET);
>>   
>> -	if (!is_usb_reset) {
>> +	if (!is_usb_reset)
>>   		if (dwc2_core_reset(hsotg, true))
>>   			return;
>> -	} else {
>> -		/* all endpoints should be shutdown */
>> -		for (ep = 1; ep < hsotg->num_of_eps; ep++) {
>> -			if (hsotg->eps_in[ep])
>> -				dwc2_hsotg_ep_disable(&hsotg->eps_in[ep]->ep);
>> -			if (hsotg->eps_out[ep])
>> -				dwc2_hsotg_ep_disable(&hsotg->eps_out[ep]->ep);
>> -		}
>> -	}
>>   
>>   	/*
>>   	 * we must now enable ep0 ready for host detection and then
>> @@ -4004,7 +3993,6 @@ static int dwc2_hsotg_ep_disable(struct usb_ep *ep)
>>   	unsigned long flags;
>>   	u32 epctrl_reg;
>>   	u32 ctrl;
>> -	int locked;
>>   
>>   	dev_dbg(hsotg->dev, "%s(ep %p)\n", __func__, ep);
>>   
>> @@ -4020,9 +4008,7 @@ static int dwc2_hsotg_ep_disable(struct usb_ep *ep)
>>   
>>   	epctrl_reg = dir_in ? DIEPCTL(index) : DOEPCTL(index);
>>   
>> -	locked = spin_is_locked(&hsotg->lock);
>> -	if (!locked)
>> -		spin_lock_irqsave(&hsotg->lock, flags);
>> +	spin_lock_irqsave(&hsotg->lock, flags);
>>   
>>   	ctrl = dwc2_readl(hsotg, epctrl_reg);
>>   
>> @@ -4046,9 +4032,7 @@ static int dwc2_hsotg_ep_disable(struct usb_ep *ep)
>>   	hs_ep->fifo_index = 0;
>>   	hs_ep->fifo_size = 0;
>>   
>> -	if (!locked)
>> -		spin_unlock_irqrestore(&hsotg->lock, flags);
>> -
>> +	spin_unlock_irqrestore(&hsotg->lock, flags);
>>   	return 0;
>>   }
>>   
>>
> Could you please apply "[PATCH v2] usb: dwc2: Disable all EP's on 
> disconnect" and fix for that patch "[PATCH] usb: dwc2: Fix ep disable 
> spinlock flow.". Let me know on test results.

I've checked and even with your fix "[PATCH] usb: dwc2: Fix ep disable
spinlock flow.", the issue is there. Playing conditionally with
spinlocks seems to be very bad idea. When spinlock is taken, the other
CPU is touching DWC2 registers. Don't expect that if you skip spinlock
and forcibly change DWC2 registers, the hardware will do what you really
expects... There random crashes and lockdep still prints a warning:

=====================================
WARNING: bad unlock balance detected!
4.20.0-rc3-00005-g1246b0e2e509 #5096 Not tainted
-------------------------------------
ip/1491 is trying to release lock (&(&hsotg->lock)->rlock) at:
[<c061c2ec>] dwc2_hsotg_complete_request+0x84/0x214
but there are no more locks to release!

other info that might help us debug this:
2 locks held by ip/1491:
 #0: e2180f30 (rtnl_mutex){+.+.}, at: rtnetlink_rcv_msg+0x224/0x488
 #1: 68ab9014 (&(&dev->lock)->rlock){-.-.}, at: eth_stop+0x24/0xa8

stack backtrace:
CPU: 1 PID: 1491 Comm: ip Not tainted 4.20.0-rc3-00005-g1246b0e2e509 #5096
Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[<c0111a0c>] (unwind_backtrace) from [<c010d8f4>] (show_stack+0x10/0x14)
[<c010d8f4>] (show_stack) from [<c09e4198>] (dump_stack+0x90/0xc8)
[<c09e4198>] (dump_stack) from [<c017d2c8>]
(print_unlock_imbalance_bug+0xb0/0xe0)
[<c017d2c8>] (print_unlock_imbalance_bug) from [<c0180404>]
(lock_release+0x190/0x380)
[<c0180404>] (lock_release) from [<c0a042a4>] (_raw_spin_unlock+0x18/0x54)
[<c0a042a4>] (_raw_spin_unlock) from [<c061c2ec>]
(dwc2_hsotg_complete_request+0x84/0x214)
[<c061c2ec>] (dwc2_hsotg_complete_request) from [<c061e378>]
(kill_all_requests+0x44/0xb4)
[<c061e378>] (kill_all_requests) from [<c061e4fc>]
(dwc2_hsotg_ep_disable+0x114/0x21c)
[<c061e4fc>] (dwc2_hsotg_ep_disable) from [<c066085c>]
(usb_ep_disable+0xd0/0x1c8)
[<c066085c>] (usb_ep_disable) from [<c0664664>] (eth_stop+0x68/0xa8)
[<c0664664>] (eth_stop) from [<c07871b8>] (__dev_close_many+0x94/0xfc)
[<c07871b8>] (__dev_close_many) from [<c07931b0>]
(__dev_change_flags+0xa0/0x198)
[<c07931b0>] (__dev_change_flags) from [<c07932c8>]
(dev_change_flags+0x18/0x48)
[<c07932c8>] (dev_change_flags) from [<c07ab798>] (do_setlink+0x298/0x990)
[<c07ab798>] (do_setlink) from [<c07ac760>] (rtnl_newlink+0x4a8/0x70c)
[<c07ac760>] (rtnl_newlink) from [<c07a7688>]
(rtnetlink_rcv_msg+0x254/0x488)
[<c07a7688>] (rtnetlink_rcv_msg) from [<c07cf844>]
(netlink_rcv_skb+0xe0/0x118)
[<c07cf844>] (netlink_rcv_skb) from [<c07cf0e4>]
(netlink_unicast+0x180/0x1c8)
[<c07cf0e4>] (netlink_unicast) from [<c07cf478>]
(netlink_sendmsg+0x2bc/0x348)
[<c07cf478>] (netlink_sendmsg) from [<c0769a38>] (sock_sendmsg+0x14/0x24)
[<c0769a38>] (sock_sendmsg) from [<c076a9b0>] (___sys_sendmsg+0x22c/0x248)
[<c076a9b0>] (___sys_sendmsg) from [<c076b5f8>] (__sys_sendmsg+0x40/0x6c)
[<c076b5f8>] (__sys_sendmsg) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
Exception stack(0xedec5fa8 to 0xedec5ff0)
...


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

