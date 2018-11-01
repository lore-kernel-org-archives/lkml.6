Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C48ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B16ED2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hw9fE0gx";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QyemS6IQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B16ED2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbeKAXk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 19:40:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33178 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbeKAXk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 19:40:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0AF356053D; Thu,  1 Nov 2018 14:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541083031;
        bh=qgmGOdyotRQ1YuDddNjDwhIzZyAPZyt0vN4BHm4AhZQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hw9fE0gx+aXskbJ4rojgN/rLo4wGfU1ExXi8DaXGAxe/e+eycGFT7b81dA5W7s3Yf
         X1eMGn9UJNr50oPDQmCO2bHWNzW0wy8dGYrzYXLc+4kqKbxys3yEilG1N8uZVnIjow
         vp9HIwlRy9Xs8oTWDLefVB7f3k1vkqyxxzFTgEKQ=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id C4DAB60744;
        Thu,  1 Nov 2018 14:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541083029;
        bh=qgmGOdyotRQ1YuDddNjDwhIzZyAPZyt0vN4BHm4AhZQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QyemS6IQVQaSuhGjHP2qkZjPKcBo63Yt7pIQ4z4R1c9GK75dly+M4+TKOEQ5+Lw8C
         1Z15KlHDWxAGhwV7jR+tYvVj7W04clH1YpOnfPzsp4vwC+ZeGWEmCyAgQ9M2ayNEb1
         KvKcjncDckcjUuWgHjTdO+KRnxd92UUbOkafSZlY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 01 Nov 2018 20:07:09 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Dmitry Grinberg <dmitrygr@google.com>
Subject: Re: [PATCH v2 1/3] Bluetooth: Add quirk for reading BD_ADDR from
 fwnode property
In-Reply-To: <20181030004415.237101-2-mka@chromium.org>
References: <20181030004415.237101-1-mka@chromium.org>
 <20181030004415.237101-2-mka@chromium.org>
Message-ID: <1592cb8d81a32ac089b2edb83f58c9e3@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-30 06:14, Matthias Kaehlcke wrote:
> Add HCI_QUIRK_USE_BDADDR_PROPERTY to allow controllers to retrieve
> the public Bluetooth address from the firmware node property
> 'local-bd-address'. If quirk is set and the property does not exist
> or is invalid the controller is marked as unconfigured.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
> Changes in v2:
> - added check for return value of ->setup()
> - only read BD_ADDR from the property if it isn't assigned yet. This
>   is needed to support configuration from user space
> - refactored the branch of the new quirk to get rid of 'bd_addr_set'
> - added 'Reviewed-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>' 
> tag
> ---
>  include/net/bluetooth/hci.h | 12 ++++++++++
>  net/bluetooth/hci_core.c    | 45 +++++++++++++++++++++++++++++++++++++
>  net/bluetooth/mgmt.c        |  6 +++--
>  3 files changed, 61 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index c36dc1e20556..fbba43e9bef5 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -158,6 +158,18 @@ enum {
>  	 */
>  	HCI_QUIRK_INVALID_BDADDR,
> 
> +	/* When this quirk is set, the public Bluetooth address
> +	 * initially reported by HCI Read BD Address command
> +	 * is considered invalid. The public BD Address can be
> +	 * specified in the fwnode property 'local-bd-address'.
> +	 * If this property does not exist or is invalid controller
> +	 * configuration is required before this device can be used.
> +	 *
> +	 * This quirk can be set before hci_register_dev is called or
> +	 * during the hdev->setup vendor callback.
> +	 */
> +	HCI_QUIRK_USE_BDADDR_PROPERTY,
> +
>  	/* When this quirk is set, the duplicate filtering during
>  	 * scanning is based on Bluetooth devices addresses. To allow
>  	 * RSSI based updates, restart scanning if needed.
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 7352fe85674b..d4149005a661 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -30,6 +30,7 @@
>  #include <linux/rfkill.h>
>  #include <linux/debugfs.h>
>  #include <linux/crypto.h>
> +#include <linux/property.h>
>  #include <asm/unaligned.h>
> 
>  #include <net/bluetooth/bluetooth.h>
> @@ -1355,6 +1356,36 @@ int hci_inquiry(void __user *arg)
>  	return err;
>  }
> 
> +/**
> + * hci_dev_get_bd_addr_from_property - Get the Bluetooth Device 
> Address
> + *				       (BD_ADDR) for a HCI device from
> + *				       a firmware node property.
> + * @hdev:	The HCI device
> + *
> + * Search the firmware node for 'local-bd-address'.
> + *
> + * All-zero BD addresses are rejected, because those could be 
> properties
> + * that exist in the firmware tables, but were not updated by the 
> firmware. For
> + * example, the DTS could define 'local-bd-address', with zero BD 
> addresses.
> + */
> +static int hci_dev_get_bd_addr_from_property(struct hci_dev *hdev)
> +{
> +	struct fwnode_handle *fwnode = dev_fwnode(hdev->dev.parent);
> +	bdaddr_t ba;
> +	int ret;
> +
> +	ret = fwnode_property_read_u8_array(fwnode, "local-bd-address",
> +					    (u8 *)&ba, sizeof(ba));
> +	if (ret < 0)
> +		return ret;
> +	if (!bacmp(&ba, BDADDR_ANY))
> +		return -ENODATA;
> +
> +	hdev->public_addr = ba;
> +
> +	return 0;
> +}
> +
>  static int hci_dev_do_open(struct hci_dev *hdev)
>  {
>  	int ret = 0;
> @@ -1422,6 +1453,20 @@ static int hci_dev_do_open(struct hci_dev *hdev)
>  		if (hdev->setup)
>  			ret = hdev->setup(hdev);
> 
> +		if (ret)
> +			goto setup_failed;
> +
> +		if (test_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks)) {
> +			if (!bacmp(&hdev->public_addr, BDADDR_ANY))
> +				hci_dev_get_bd_addr_from_property(hdev);
> +
> +			if (!bacmp(&hdev->public_addr, BDADDR_ANY) ||
> +			    !hdev->set_bdaddr ||
> +			    hdev->set_bdaddr(hdev, &hdev->public_addr))
> +				hci_dev_set_flag(hdev, HCI_UNCONFIGURED);
> +		}
> +
> +setup_failed:
>  		/* The transport driver can set these quirks before
>  		 * creating the HCI device or in its setup callback.
>  		 *
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index ccce954f8146..fae84353d030 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -551,7 +551,8 @@ static bool is_configured(struct hci_dev *hdev)
>  	    !hci_dev_test_flag(hdev, HCI_EXT_CONFIGURED))
>  		return false;
> 
> -	if (test_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks) &&
> +	if ((test_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks) ||
> +	     test_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks)) &&
>  	    !bacmp(&hdev->public_addr, BDADDR_ANY))
>  		return false;
> 
> @@ -566,7 +567,8 @@ static __le32 get_missing_options(struct hci_dev 
> *hdev)
>  	    !hci_dev_test_flag(hdev, HCI_EXT_CONFIGURED))
>  		options |= MGMT_OPTION_EXTERNAL_CONFIG;
> 
> -	if (test_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks) &&
> +	if ((test_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks) ||
> +	     test_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks)) &&
>  	    !bacmp(&hdev->public_addr, BDADDR_ANY))
>  		options |= MGMT_OPTION_PUBLIC_ADDRESS;

Tested by dts entry and also via btmgnt tool

Tested-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>

-- 
Regards
Balakrishna.
