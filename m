Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EA3ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4714D2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZgySVpvg";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="m09XyD/c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4714D2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbeJYXNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:13:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47140 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbeJYXNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 19:13:46 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B8C26601CF; Thu, 25 Oct 2018 14:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540478441;
        bh=HlN903Jt49AbB3N+/1xzxoe68q8m5ov27TZYbuaUdJw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZgySVpvgOYZ0iPawD3Mm9uBJds0ZU7uQKDkUZ34y5s/thpTkrLg3itv23fnGtLB9g
         Yf0eFWLfz8mas3IGzSM3kHMviXi+9FXTqusxGf17RMC4q3/0c39QA+u5IUXgBMmTNn
         LvCVuFsZZk6mVmmtNzKUpViptAqkewxbPHMFSjds=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 3DEAD60795;
        Thu, 25 Oct 2018 14:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540478430;
        bh=HlN903Jt49AbB3N+/1xzxoe68q8m5ov27TZYbuaUdJw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m09XyD/c4Nn3DpWXaeWO1J4nnNmFZpLcrUl0UX0SJP+4Nwht1l6RA9icNejkXE7Lj
         FZ7d26TEEoYUq2tTITTO/APFzEwPPVqEmvsCNX93PiDk5i22NLVdZxd+8jD9HNB7Jl
         Z8+ebOZ+q8zKjzd7NfdeTAUT5UtxWDRLRJFqpi5c=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 25 Oct 2018 20:10:30 +0530
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
Subject: Re: [PATCH 2/2] Bluetooth: btqcomsmd: use
 HCI_QUIRK_USE_BDADDR_PROPERTY
In-Reply-To: <20181025002134.256791-3-mka@chromium.org>
References: <20181025002134.256791-1-mka@chromium.org>
 <20181025002134.256791-3-mka@chromium.org>
Message-ID: <bff4f1b7d82e217f45273872eeffa77f@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2018-10-25 05:51, Matthias Kaehlcke wrote:
> Use the HCI_QUIRK_USE_BDADDR_PROPERTY quirk to let the HCI
> core handle the reading of 'local-bd-address'. With this there
> is no need to set HCI_QUIRK_INVALID_BDADDR, the case of a
> non-existing or invalid fwnode property is handled by the core
> code.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> I couldn't actually test the changes in this driver since I
> don't have a device with this controller. Could someone
> from Qualcomm help with this?
> ---
>  drivers/bluetooth/btqcomsmd.c | 28 +++-------------------------
>  1 file changed, 3 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/bluetooth/btqcomsmd.c 
> b/drivers/bluetooth/btqcomsmd.c
> index 7df3eed1ef5e..e5841602c4f1 100644
> --- a/drivers/bluetooth/btqcomsmd.c
> +++ b/drivers/bluetooth/btqcomsmd.c
> @@ -125,23 +125,10 @@ static int btqcomsmd_setup(struct hci_dev *hdev)
>  		return PTR_ERR(skb);
>  	kfree_skb(skb);
> 
> -	/* Devices do not have persistent storage for BD address. If no
> -	 * BD address has been retrieved during probe, mark the device
> -	 * as having an invalid BD address.
> +	/* Devices do not have persistent storage for BD address. Retrieve
> +	 * it from the firmware node property.
>  	 */
> -	if (!bacmp(&btq->bdaddr, BDADDR_ANY)) {
> -		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
> -		return 0;
> -	}
> -
> -	/* When setting a configured BD address fails, mark the device
> -	 * as having an invalid BD address.
> -	 */
> -	err = qca_set_bdaddr_rome(hdev, &btq->bdaddr);
> -	if (err) {
> -		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
> -		return 0;
> -	}
> +	set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
> 
>  	return 0;
>  }
> @@ -169,15 +156,6 @@ static int btqcomsmd_probe(struct platform_device 
> *pdev)
>  	if (IS_ERR(btq->cmd_channel))
>  		return PTR_ERR(btq->cmd_channel);
> 
> -	/* The local-bd-address property is usually injected by the
> -	 * bootloader which has access to the allocated BD address.
> -	 */
> -	if (!of_property_read_u8_array(pdev->dev.of_node, "local-bd-address",
> -				       (u8 *)&btq->bdaddr, sizeof(bdaddr_t))) {
> -		dev_info(&pdev->dev, "BD address %pMR retrieved from device-tree",
> -			 &btq->bdaddr);
> -	}
> -
>  	hdev = hci_alloc_dev();
>  	if (!hdev)
>  		return -ENOMEM;

nit: can be remove unused "bdaddr_t bdaddr" variable.
https://elixir.bootlin.com/linux/v4.19-rc8/source/drivers/bluetooth/btqcomsmd.c#L31
Apart from this, It looks ok to me.

Reviewed-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
-- 
Regards
Balakrishna.
