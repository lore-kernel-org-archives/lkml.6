Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F4AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 112D820823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfARLAF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 06:00:05 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:51406 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfARLAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 06:00:04 -0500
Received: from marcel-macpro.fritz.box (p4FF9FD60.dip0.t-ipconnect.de [79.249.253.96])
        by mail.holtmann.org (Postfix) with ESMTPSA id DE08DCF2C5;
        Fri, 18 Jan 2019 12:07:49 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] bluetooth: hci_intel: Check for driver register failure
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20181228195351.11009-1-pakki001@umn.edu>
Date:   Fri, 18 Jan 2019 12:00:03 +0100
Cc:     kjlu@umn.edu, Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <5F10A419-10F3-47F2-A83A-F559073F9F77@holtmann.org>
References: <20181228195351.11009-1-pakki001@umn.edu>
To:     Aditya Pakki <pakki001@umn.edu>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aditya,

> While initializing the driver, the function platform_driver_register can
> fail and return an error. Consistent with other invocations, this patch
> returns the error upstream.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
> drivers/bluetooth/hci_intel.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
> index f31410526c57..8450389a2017 100644
> --- a/drivers/bluetooth/hci_intel.c
> +++ b/drivers/bluetooth/hci_intel.c
> @@ -1242,7 +1242,11 @@ static struct platform_driver intel_driver = {
> 
> int __init intel_init(void)
> {
> -	platform_driver_register(&intel_driver);
> +	int rc;
> +
> +	rc = platform_driver_register(&intel_driver);
> +	if (rc)
> +		return rc;

same here. Let this fail since even if it fails, the rest of the driver will be still functioning.

Regards

Marcel

