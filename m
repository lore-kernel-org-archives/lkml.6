Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9851C282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94016217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbfAYHvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 02:51:19 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:38959 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728680AbfAYHvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 02:51:18 -0500
Received: from marcel-macpro.fritz.box (p4FF9FD60.dip0.t-ipconnect.de [79.249.253.96])
        by mail.holtmann.org (Postfix) with ESMTPSA id 155D9CF174;
        Fri, 25 Jan 2019 08:59:04 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v6 4/4] Bluetooth: btusb: Use the cmd_timeout method to
 reset the Intel BT chip
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190124232814.252661-4-rajatja@google.com>
Date:   Fri, 25 Jan 2019 08:51:16 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dtor@chromium.org>,
        Alex Hung <alex.hung@canonical.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        rajatxjain@gmail.com, dtor@google.com, raghuram.hegde@intel.com,
        chethan.tumkur.narayan@intel.com, sukumar.ghorai@intel.com
Content-Transfer-Encoding: 7bit
Message-Id: <9916633A-DB56-49E2-94D5-CE809AE20A31@holtmann.org>
References: <20181117010748.24347-1-rajatja@google.com>
 <20190124232814.252661-1-rajatja@google.com>
 <20190124232814.252661-4-rajatja@google.com>
To:     Rajat Jain <rajatja@google.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rajat,

> If the platform provides it, use the reset gpio to reset the Intel BT
> chip, as part of cmd_timeout handling. This has been found helpful on
> Intel bluetooth controllers where the firmware gets stuck and the only
> way out is a hard reset pin provided by the platform.
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
> v6: Move the cmd_timeout() hook assignment with other hooks, move the
>    reset_gpio check in the timeout function.
> v5: Rename the hook to cmd_timeout, and wait for 5 timeouts before
>    resetting the device.
> v4: Use data->flags instead of clearing the quirk in btusb_hw_reset()
> v3: Better error handling for gpiod_get_optional()
> v2: Handle the EPROBE_DEFER case.
> 
> drivers/bluetooth/btusb.c | 54 +++++++++++++++++++++++++++++++++++++++
> 1 file changed, 54 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

