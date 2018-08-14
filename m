Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F2DC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 07:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A90CE218E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 07:00:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A90CE218E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731105AbeHNJqf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 05:46:35 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:58219 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbeHNJqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 05:46:35 -0400
Received: from marcel-macpro.fritz.box (p4FEFCC41.dip0.t-ipconnect.de [79.239.204.65])
        by mail.holtmann.org (Postfix) with ESMTPSA id 6A497CEFA2;
        Tue, 14 Aug 2018 09:07:46 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] Use default .cfg file name for RTL8723BS devices with id
 of OBDA8723
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180814064742.14519-1-ianwmorrison@gmail.com>
Date:   Tue, 14 Aug 2018 09:00:43 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        hdegoede@redhat.com
Content-Transfer-Encoding: 8BIT
Message-Id: <B7F47DB8-B3B9-4F20-9DA1-3756B20ED866@holtmann.org>
References: <20180814064742.14519-1-ianwmorrison@gmail.com>
To:     Ian W MORRISON <ianwmorrison@gmail.com>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

> For RTL8723BS devices the current config file name is a composite of
> both the config name (rtl8723bs) and a postfix of the device-id.
> 
> Given the majority of RTL8723BS devices use a device-id of OBDA8723
> this simplifies the config file name to use "rtl8723bs_config.bin"
> as a default of for these devices.
> 
> Signed-off-by: Ian W MORRISON <ianwmorrison@gmail.com>
> ---
> drivers/bluetooth/hci_h5.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> index 8eede1197cd2..cce422dc1b8d 100644
> --- a/drivers/bluetooth/hci_h5.c
> +++ b/drivers/bluetooth/hci_h5.c
> @@ -852,7 +852,9 @@ static int h5_btrtl_setup(struct h5 *h5)
> 	bool flow_control;
> 	int err;
> 
> -	btrtl_dev = btrtl_initialize(h5->hu->hdev, h5->id);
> +	btrtl_dev = strcmp("OBDA8723", h5->id) ?
> +		btrtl_initialize(h5->hu->hdev, h5->id) :
> +			btrtl_initialize(h5->hu->hdev, NULL);

I am not letting you duplicate the PNPID here. This needs to be done cleanly with the device table that is already present.

Regards

Marcel

