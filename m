Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5283FC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BBA921533
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nbkr8hUe";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="X6d0qcBL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BBA921533
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbeI0XCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:02:40 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48704 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbeI0XCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:02:40 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AFF6960B7F; Thu, 27 Sep 2018 16:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538066612;
        bh=JgyS7sK/VBHt5d9FJyRb2iIu9DA332bCHcB345Kqdlk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nbkr8hUeiTjqPIfqjrqPmKe6QYYtozevxIQs27+4MYuVBGTd5626uVpO9d/9Nh8g0
         9tczN+6fUPH5PvVnjLwYcuxdw1s8RJA52oUO6kagi5pE4hV6m3w8QHdskV+55gTMUe
         wmNiixlq90QTjHCqASU/Cwk9llLd4NETM1K1Pf0E=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 6CD16607DD;
        Thu, 27 Sep 2018 16:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538066611;
        bh=JgyS7sK/VBHt5d9FJyRb2iIu9DA332bCHcB345Kqdlk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X6d0qcBLcNv5k73U3WdM45Yp4o0wKmk7YtVxRpAG8iyx59pohVbL4e68GE+TAR8Hv
         NNCE5seogCvuK0FZ9nwGgWmP6FLxrAo8icwhCyqOaUYfVgWi3POiiM9QketgNz8vSX
         D+hmGsOGGNH7ef9EkaQoPEa9JQ6KPOdnBOPFjy6Y=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 27 Sep 2018 22:13:31 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Andy Shevchenko Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v4 2/2] Bluetooth: btqcomsmd: Get the BD address with
 device_get_bd_address()
In-Reply-To: <20180927004810.124185-3-mka@chromium.org>
References: <20180927004810.124185-1-mka@chromium.org>
 <20180927004810.124185-3-mka@chromium.org>
Message-ID: <32aa77b08ef306d017b615cd270e3529@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2018-09-27 06:18, Matthias Kaehlcke wrote:
> Use the new API to get the BD address instead of reading it directly
> from the device tree.
> 
> Also remove an unncessary pair of braces in the same area of code.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
> Changes in v4:
> - added 'Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>' tag
> 
> Changes in v3:
> - added 'Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>' tag
> 
> Changes in v2:
> - pass bdaddr_t instead of byte pointer + len
> ---
>  drivers/bluetooth/btqcomsmd.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/btqcomsmd.c 
> b/drivers/bluetooth/btqcomsmd.c
> index 7df3eed1ef5e..ff74d2c46991 100644
> --- a/drivers/bluetooth/btqcomsmd.c
> +++ b/drivers/bluetooth/btqcomsmd.c
> @@ -172,11 +172,9 @@ static int btqcomsmd_probe(struct platform_device 
> *pdev)
>  	/* The local-bd-address property is usually injected by the
>  	 * bootloader which has access to the allocated BD address.
>  	 */
> -	if (!of_property_read_u8_array(pdev->dev.of_node, "local-bd-address",
> -				       (u8 *)&btq->bdaddr, sizeof(bdaddr_t))) {
> +	if (!device_get_bd_address(&pdev->dev, &btq->bdaddr))
>  		dev_info(&pdev->dev, "BD address %pMR retrieved from device-tree",
>  			 &btq->bdaddr);
> -	}
> 
>  	hdev = hci_alloc_dev();
>  	if (!hdev)

Reviewed-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>

-- 
Regards
Balakrishna.
