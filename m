Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50324C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2330E213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfBZJBh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 04:01:37 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:46347 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfBZJBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 04:01:37 -0500
Received: from marcel-macpro.fritz.box (p4FF9F361.dip0.t-ipconnect.de [79.249.243.97])
        by mail.holtmann.org (Postfix) with ESMTPSA id AEDF4CF2A3;
        Tue, 26 Feb 2019 10:09:29 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v2 1/3] Bluetooth: btusb: add QCA6174A compatible
 properties
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190222225345.69084-1-briannorris@chromium.org>
Date:   Tue, 26 Feb 2019 10:01:34 +0100
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
        Rajat Jain <rajatja@google.com>,
        Robin Murphy <robin.murphy@arm.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <49653AC5-5800-4319-B3C0-0CCA6A920E2C@holtmann.org>
References: <20190222225345.69084-1-briannorris@chromium.org>
To:     Brian Norris <briannorris@chromium.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian,

> We may need to specify a GPIO wake pin for this device, so add a
> compatible property for it.
> 
> There are at least to USB PID/VID variations of this chip: one with a
> Lite-On ID and one with an Atheros ID.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> v2:
> * drop leading zeroes from VID, per documented binding
> ---
> drivers/bluetooth/btusb.c | 2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 470ee68555d9..54cb5f583b1d 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2862,6 +2862,8 @@ static irqreturn_t btusb_oob_wake_handler(int irq, void *priv)
> 
> static const struct of_device_id btusb_match_table[] = {
> 	{ .compatible = "usb1286,204e" },
> +	{ .compatible = "usbcf3,e300" }, /* QCA6174A */
> +	{ .compatible = "usb4ca,301a" }, /* QCA6174A (Lite-On) */

are these really proper .compatible USB VID?PID strings. I think they are one letter short.

Regards

Marcel

