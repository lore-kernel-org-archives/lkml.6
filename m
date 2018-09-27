Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810C1C004D5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39CD22168B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JI0T5Q3j";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fTagY7NZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39CD22168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbeI0XAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:00:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47996 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbeI0XAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:00:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 72BE1605FF; Thu, 27 Sep 2018 16:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538066471;
        bh=8lHHPy2z1uiGwv+/qmUouiS8IzTdiybfQfffdZkv088=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JI0T5Q3jkFVUWhEEPJ9Rc3ztAHVJ7HGrNFTGaCFu2TOosqVbvJ9qlvoAdgFyNnDuA
         JTKNdWSlIjwVB9BUsBG5SntYLRyE4oGGeRbRK+KB4LLp/CXBCK1qIJBSCUMGBtxHCx
         iP00dnZg4cJIk64BGEYmy58FQ+6RGqQtjlIc0llY=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 6CF8960275;
        Thu, 27 Sep 2018 16:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538066470;
        bh=8lHHPy2z1uiGwv+/qmUouiS8IzTdiybfQfffdZkv088=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fTagY7NZOyfvU5G/r2lmWoUNDXEOF4PE54Odp6R4yY86YqtPY4vs89LrK/KB8QhhJ
         18lwSxQGmzbSU9z5LMFddZrgpy5pSvz80ZiMoxt64jbhmGH0xAk4wk4PikohiiORpq
         8+29N+opLosw//MLJXgwp9iadqX1XyyMIERzFo88=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 27 Sep 2018 22:11:10 +0530
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
Subject: Re: [PATCH v4 1/2] Bluetooth: Add device_get_bd_address()
In-Reply-To: <20180927004810.124185-2-mka@chromium.org>
References: <20180927004810.124185-1-mka@chromium.org>
 <20180927004810.124185-2-mka@chromium.org>
Message-ID: <b28c34475e447cc29a139f9121b3c1d9@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2018-09-27 06:18, Matthias Kaehlcke wrote:
> Provide an API for Bluetooth drivers to retrieve the Bluetooth Device
> address (BD_ADDR) for a device. If the firmware node of the device
> has a property 'local-bd-address' the BD address is read from this
> property.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
> Changes in v4:
> - move code from driver/base/property.c to net/bluetooth/lib.c
> - undo move of bdaddr_t declaration
> - merge fwnode_get_bd_address() into device_get_bd_address(). as of now
>   the function is not needed, it can be created later if necessary
> - minor improvements suggested by Sakari
> - updated commit message
> - added 'Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>' tag
> 
> Changes in v3:
> - move definition of bdaddr_t to types.h to avoid include of
>   bluetooth.h from property.h
> - add stubs for the new functions
> 
> Changes in v2:
> - use bdaddr_t instead of byte pointer + len
> - use EXPORT_SYMBOL_GPL for the new functions instead of EXPORT_SYMBOL
> - put new functions inside #if IS_ENABLED(CONFIG_BT)
> - some new line juggling in property.h
> - added 'Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>' tag
> ---
>  include/net/bluetooth/bluetooth.h |  2 ++
>  net/bluetooth/lib.c               | 34 +++++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/include/net/bluetooth/bluetooth.h
> b/include/net/bluetooth/bluetooth.h
> index ec9d6bc65855..6c4cecfda816 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -413,4 +413,6 @@ void mgmt_exit(void);
> 
>  void bt_sock_reclassify_lock(struct sock *sk, int proto);
> 
> +int device_get_bd_address(struct device *dev, bdaddr_t *bd_addr);
> +
>  #endif /* __BLUETOOTH_H */
> diff --git a/net/bluetooth/lib.c b/net/bluetooth/lib.c
> index 63e65d9b4b24..78a58ea586c6 100644
> --- a/net/bluetooth/lib.c
> +++ b/net/bluetooth/lib.c
> @@ -26,7 +26,10 @@
> 
>  #define pr_fmt(fmt) "Bluetooth: " fmt
> 
> +#include <linux/etherdevice.h>
>  #include <linux/export.h>
> +#include <linux/fwnode.h>
> +#include <linux/property.h>
> 
>  #include <net/bluetooth/bluetooth.h>
> 
> @@ -198,3 +201,34 @@ void bt_err_ratelimited(const char *format, ...)
>  	va_end(args);
>  }
>  EXPORT_SYMBOL(bt_err_ratelimited);
> +
> +/**
> + * device_get_bd_address - Get the Bluetooth Device Address (BD_ADDR) 
> for a
> + *                         given device
> + * @dev:	Pointer to the device
> + * @bd_addr:	Pointer to struct to store the BD address in
> + *
> + * Search the firmware node of the device for 'local-bd-address'.
> + *
> + * All-zero BD addresses are rejected, because those could be 
> properties
> + * that exist in the firmware tables, but were not updated by the 
> firmware. For
> + * example, the DTS could define 'local-bd-address', with zero BD 
> addresses.
> + */
> +int device_get_bd_address(struct device *dev, bdaddr_t *bd_addr)
> +{
> +	struct fwnode_handle *fwnode = dev_fwnode(dev);
> +	bdaddr_t ba;
> +	int ret;
> +
> +	ret = fwnode_property_read_u8_array(fwnode, "local-bd-address",
> +					    (u8 *)&ba, sizeof(ba));
> +	if (ret < 0)
> +		return ret;
> +	if (is_zero_ether_addr((u8 *)&ba))
> +		return -ENODATA;
> +
> +	*bd_addr = ba;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(device_get_bd_address);

Reviewed-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>

-- 
Regards
Balakrishna.
