Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C421DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9102173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfBZNbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 08:31:53 -0500
Received: from foss.arm.com ([217.140.101.70]:47430 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbfBZNbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 08:31:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B102780D;
        Tue, 26 Feb 2019 05:31:52 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6EFB23F703;
        Tue, 26 Feb 2019 05:31:50 -0800 (PST)
Subject: Re: [PATCH v2 1/3] Bluetooth: btusb: add QCA6174A compatible
 properties
To:     Marcel Holtmann <marcel@holtmann.org>,
        Brian Norris <briannorris@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rockchip@lists.infradead.org,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajat Jain <rajatja@google.com>
References: <20190222225345.69084-1-briannorris@chromium.org>
 <49653AC5-5800-4319-B3C0-0CCA6A920E2C@holtmann.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <a23b9467-1c41-e399-f011-8ca183be585d@arm.com>
Date:   Tue, 26 Feb 2019 13:31:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <49653AC5-5800-4319-B3C0-0CCA6A920E2C@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/02/2019 09:01, Marcel Holtmann wrote:
> Hi Brian,
> 
>> We may need to specify a GPIO wake pin for this device, so add a
>> compatible property for it.
>>
>> There are at least to USB PID/VID variations of this chip: one with a
>> Lite-On ID and one with an Atheros ID.
>>
>> Signed-off-by: Brian Norris <briannorris@chromium.org>
>> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
>> ---
>> v2:
>> * drop leading zeroes from VID, per documented binding
>> ---
>> drivers/bluetooth/btusb.c | 2 ++
>> 1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>> index 470ee68555d9..54cb5f583b1d 100644
>> --- a/drivers/bluetooth/btusb.c
>> +++ b/drivers/bluetooth/btusb.c
>> @@ -2862,6 +2862,8 @@ static irqreturn_t btusb_oob_wake_handler(int irq, void *priv)
>>
>> static const struct of_device_id btusb_match_table[] = {
>> 	{ .compatible = "usb1286,204e" },
>> +	{ .compatible = "usbcf3,e300" }, /* QCA6174A */
>> +	{ .compatible = "usb4ca,301a" }, /* QCA6174A (Lite-On) */
> 
> are these really proper .compatible USB VID?PID strings. I think they are one letter short.

Yup - however weird it may end up looking, the usb-device binding says 
"...with leading zeros suppressed". Blame Open Firmware, I guess ;)

Robin.
