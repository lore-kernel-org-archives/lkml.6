Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F56FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 21:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EE57206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 21:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfBVV5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 16:57:35 -0500
Received: from foss.arm.com ([217.140.101.70]:41612 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbfBVV5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 16:57:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 038FD80D;
        Fri, 22 Feb 2019 13:57:35 -0800 (PST)
Received: from [192.168.1.123] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E08433F575;
        Fri, 22 Feb 2019 13:57:27 -0800 (PST)
Subject: Re: [PATCH 2/3] dt-bindings: net: btusb: add QCA6174A IDs
To:     Brian Norris <briannorris@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Rajat Jain <rajatja@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-kernel@lists.infradead.org
References: <20190222003403.128243-1-briannorris@chromium.org>
 <20190222003403.128243-2-briannorris@chromium.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <5efc9f02-eeb8-78cc-0f11-13e0010efd46@arm.com>
Date:   Fri, 22 Feb 2019 21:57:29 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190222003403.128243-2-briannorris@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-22 12:34 am, Brian Norris wrote:
> There are two USB PID/VID variations I've seen for this chip, and I want
> to utilize the 'interrupts' property defined here already.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>   Documentation/devicetree/bindings/net/btusb.txt | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/btusb.txt b/Documentation/devicetree/bindings/net/btusb.txt
> index 37d67926dd6d..43c96c3380a6 100644
> --- a/Documentation/devicetree/bindings/net/btusb.txt
> +++ b/Documentation/devicetree/bindings/net/btusb.txt
> @@ -9,6 +9,9 @@ Required properties:
>   		 (more may be added later) are:
>   
>   		  "usb1286,204e" (Marvell 8997)
> +		  "usb0cf3,e300" (Qualcomm QCA6174A)
> +		  "usb04ca,301a" (Qualcomm QCA6174A (Lite-On))

Nit: the USB device binding states that those leading zeroes in the VIDs 
should be suppressed.

Otherwise, thanks for the tip-off - I hadn't realised that OOB interrupt 
support was fully implemented already. I'll have to give this a go for 
the Realtek module in one of my TV boxes :)

Robin.

> +
>   
>   Also, vendors that use btusb may have device additional properties, e.g:
>   Documentation/devicetree/bindings/net/marvell-bt-8xxx.txt
> 
