Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D120C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59BB3218C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbfBRIPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 03:15:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:45266 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725920AbfBRIPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 03:15:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BB8D1AD47;
        Mon, 18 Feb 2019 08:15:44 +0000 (UTC)
Message-ID: <1550477077.11088.2.camel@suse.com>
Subject: Re: [PATCH 2/2] RTL8153-BD is used in Dell DA300 type-C dongle. It
 should be added to the whitelist of devices to activate MAC address pass
 through.
From:   Oliver Neukum <oneukum@suse.com>
To:     David Chen <david0813@gmail.com>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org
Cc:     kai.heng.feng@canonical.com, davem@davemloft.net,
        david.chen7@dell.com, mario.limonciello@dell.com,
        f.fainelli@gmail.com, edumazet@google.com, zhongjiang@huawei.com,
        bigeasy@linutronix.de, hayeswang@realtek.com, jslaby@suse.cz
Date:   Mon, 18 Feb 2019 09:04:37 +0100
In-Reply-To: <20190218034817.7515-1-david0813@gmail.com>
References: <20190218034817.7515-1-david0813@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mo, 2019-02-18 at 11:48 +0800, David Chen wrote:
> From: David Chen <david.chen7@dell.com>
> 
> Per confirming with Realtek all devices containing RTL8153-BD should
> activate MAC pass through and there won't use pass through bit on efuse
> like in RTL8153-AD.
> 
> Signed-off-by: David Chen <david.chen7@dell.com>
> ---
>  drivers/net/usb/r8152.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index ada6baf8847a..86c8c64fbb0f 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -1179,7 +1179,7 @@ static int vendor_mac_passthru_addr_read(struct r8152 *tp, struct sockaddr *sa)
>  	} else {
>  		/* test for RTL8153-BND and RTL8153-BD */
>  		ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, USB_MISC_1);
> -		if ((ocp_data & BND_MASK) == 0 && (ocp_data & BD_MASK)) {
> +		if ((ocp_data & BND_MASK) == 0 && (ocp_data & BD_MASK) == 0) {

You are inverting the second half of the test. How can this possibly be
right? Had you dropped it, I would understand. But this? Are you sure?

	Regards
		Oliver

