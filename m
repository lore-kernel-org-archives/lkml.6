Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18800C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEDE720820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hmD3Pd2a";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Sk5lWrru"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEDE720820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbeKAXky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 19:40:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33446 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbeKAXky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 19:40:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 16D2260881; Thu,  1 Nov 2018 14:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541083059;
        bh=8ToY11uJWHl3GGtVlpb8HitzvLpO1desv/BR+Im4hDA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hmD3Pd2abHUxH4nyOWUw05lXz0XQ/8T1+0x1pNUqiAZL7ayUydIBBKLjf4xy5FK2H
         R1YzAUTtYGxnQrBVZvz4IfTm945Z+VlnyvZODGQMI72noRoukJf/sxRdAPaMxq2oY/
         PsfyHXmnXAuW3PQIjUA1Kjy3e1jnsI65ZrTmXc+0=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id BCFAC6053D;
        Thu,  1 Nov 2018 14:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541083058;
        bh=8ToY11uJWHl3GGtVlpb8HitzvLpO1desv/BR+Im4hDA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Sk5lWrruiFhkifSJ+DthYvDfcXUPmQfIYsYemJqA8k7yYt/vjHEVS9/imxtkDmxLW
         WIdb/4AMQLR0DXS1als4ztjbdcgmgd0BK6eqH6uuF590BvyGenDUconeoszrK4Omue
         AalKTxizoLwAGra9YgZH1k9TmH2KqFRN+A1n54wo=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 01 Nov 2018 20:07:38 +0530
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
Subject: Re: [PATCH v2 3/3] Bluetooth: hci_qca: Set
 HCI_QUIRK_USE_BDADDR_PROPERTY for wcn3990
In-Reply-To: <20181030004415.237101-4-mka@chromium.org>
References: <20181030004415.237101-1-mka@chromium.org>
 <20181030004415.237101-4-mka@chromium.org>
Message-ID: <a9f882839c9c272cb23ed4ff06dbdcb5@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-30 06:14, Matthias Kaehlcke wrote:
> Set quirk for wcn3990 to read BD_ADDR from a firmware node property.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v2:
> - patch added to the series
> 
> tested with https://lore.kernel.org/patchwork/patch/1003830
> ("Bluetooth: hci_qca: Add helper to set device address.")
> ---
>  drivers/bluetooth/hci_qca.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index f036c8f98ea3..0535833caa52 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1193,6 +1193,7 @@ static int qca_setup(struct hci_uart *hu)
>  		 * setup for every hci up.
>  		 */
>  		set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
> +		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
>  		hu->hdev->shutdown = qca_power_off;
>  		ret = qca_wcn3990_init(hu);
>  		if (ret)

Tested-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>

-- 
Regards
Balakrishna.
