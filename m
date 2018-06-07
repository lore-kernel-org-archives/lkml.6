Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id F8rLAKkIGVsZUwAAmS7hNA
	; Thu, 07 Jun 2018 10:27:53 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E633C607E7; Thu,  7 Jun 2018 10:27:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5BB1F602FC;
	Thu,  7 Jun 2018 10:27:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5BB1F602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932699AbeFGK1v (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 06:27:51 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55632 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753471AbeFGK1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 06:27:49 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id AEE7180591; Thu,  7 Jun 2018 12:27:47 +0200 (CEST)
Date: Thu, 7 Jun 2018 12:27:40 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 04/19] Bluetooth: hci_nokia: Add serdev_id_table
Message-ID: <20180607102740.GD4372@localhost>
References: <20180529131014.18641-1-ricardo.ribalda@gmail.com>
 <20180529131014.18641-5-ricardo.ribalda@gmail.com>
 <E848BED5-1D83-47FA-A673-29B366A60227@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E848BED5-1D83-47FA-A673-29B366A60227@holtmann.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Describe which hardware is supported by the current driver.
> > 
> > Cc: Marcel Holtmann <marcel@holtmann.org>
> > Cc: Johan Hedberg <johan.hedberg@gmail.com>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Johan Hovold <johan@kernel.org>
> > Cc: linux-bluetooth@vger.kernel.org
> > Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> > ---
> > drivers/bluetooth/hci_nokia.c | 6 ++++++
> > 1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/bluetooth/hci_nokia.c b/drivers/bluetooth/hci_nokia.c
> > index 3539fd03f47e..e32dfcd56b8d 100644
> > --- a/drivers/bluetooth/hci_nokia.c
> > +++ b/drivers/bluetooth/hci_nokia.c
> > @@ -801,6 +801,11 @@ static const struct of_device_id nokia_bluetooth_of_match[] = {
> > MODULE_DEVICE_TABLE(of, nokia_bluetooth_of_match);
> > #endif
> > 
> > +static struct serdev_device_id nokia_bluetooth_serdev_id[] = {
> > +	{ "hp4-bluetooth", },
> > +	{},
> > +};
> > +
> > static struct serdev_device_driver nokia_bluetooth_serdev_driver = {
> > 	.probe = nokia_bluetooth_serdev_probe,
> > 	.remove = nokia_bluetooth_serdev_remove,
> > @@ -809,6 +814,7 @@ static struct serdev_device_driver nokia_bluetooth_serdev_driver = {
> > 		.pm = &nokia_bluetooth_pm_ops,
> > 		.of_match_table = of_match_ptr(nokia_bluetooth_of_match),
> > 	},
> > +	.id_table = nokia_bluetooth_serdev_id,
> > };
> 
> I would actually skip this hardware. First of all it is such a dedicated custom Nokia transport and hardware, and secondly it is no longer produced anyway.
> 

Would it make sense to cc: sre here? We want good support even for old
hardware, and this is n9/n950, it is still on "top ten supported
phones" list... Probably even top 5.

Thanks,
								 Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
