Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B60DC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48BB22087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fGEUzvPW";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Qoq9E9hy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbfAGOqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 09:46:53 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:41982 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbfAGOqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 09:46:52 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 66C8160740; Mon,  7 Jan 2019 14:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546872411;
        bh=16fNLFKqqjRvHsFBLfso/8HBLbShOY3uqTRNcD3M5r4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fGEUzvPW0C1/WV7X25wKTSvPtRbQ8MFkRGvXaCnYCDeTuhE3g8Qy01KHxo3SvwKWF
         NB0UT/T5G6LOE8UxQoYJkQvuw/YQRZd6xgTDpAlxWOt7JTlcS3chdAkQTO/DEodNxF
         1bvDlz12v0+sMRWJpXNF5dT1fDuwXsj0DFtQu+/I=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id A7E5760300;
        Mon,  7 Jan 2019 14:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546872410;
        bh=16fNLFKqqjRvHsFBLfso/8HBLbShOY3uqTRNcD3M5r4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Qoq9E9hyzci3v19KCA35Ekut0DAOkALhtlE5dpTYaRCWmyAPe/JMCHQXhdJvw4p5J
         G5+cW94BhwDcjkBZub3cspPoTljml1ph70m6YCfoYcG20vVbhNYyB7PnrP1tbMkmND
         sMKIr0ZAfTcXnE0jgsa/Ll9TeaPUeQ/DHhLI1Yew=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 07 Jan 2019 20:16:49 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [RESEND, v2] Bluetooth: hci_qca: Add helper to set device address
In-Reply-To: <20181228120719.20571-1-bgodavar@codeaurora.org>
References: <20181228120719.20571-1-bgodavar@codeaurora.org>
Message-ID: <b30b273b4e1554afe2a20febaeda1411@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

On 2018-12-28 17:37, Balakrishna Godavarthi wrote:
> This patch add qca_set_bdaddr() to set the device
> address for latest Qualcomm Bluetooth chipset wcn3990 and above.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/bluetooth/btqca.c   | 19 +++++++++++++++++++
>  drivers/bluetooth/btqca.h   |  8 +++++++-
>  drivers/bluetooth/hci_qca.c |  5 ++++-
>  3 files changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index ec9e03a6b778..612268574fc7 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -391,6 +391,25 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t 
> baudrate,
>  }
>  EXPORT_SYMBOL_GPL(qca_uart_setup);
> 
> +int qca_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
> +{
> +	struct sk_buff *skb;
> +	int err;
> +
> +	skb = __hci_cmd_sync_ev(hdev, EDL_WRITE_BD_ADDR_OPCODE, 6, bdaddr,
> +				HCI_EV_VENDOR, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		err = PTR_ERR(skb);
> +		bt_dev_err(hdev, "QCA Change address cmd failed (%d)", err);
> +		return err;
> +	}
> +
> +	kfree_skb(skb);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(qca_set_bdaddr);
> +
>  MODULE_AUTHOR("Ben Young Tae Kim <ytkim@qca.qualcomm.com>");
>  MODULE_DESCRIPTION("Bluetooth support for Qualcomm Atheros family ver
> " VERSION);
>  MODULE_VERSION(VERSION);
> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
> index 0c01f375fe83..c72c56ea7480 100644
> --- a/drivers/bluetooth/btqca.h
> +++ b/drivers/bluetooth/btqca.h
> @@ -20,6 +20,7 @@
> 
>  #define EDL_PATCH_CMD_OPCODE		(0xFC00)
>  #define EDL_NVM_ACCESS_OPCODE		(0xFC0B)
> +#define EDL_WRITE_BD_ADDR_OPCODE	(0xFC14)
>  #define EDL_PATCH_CMD_LEN		(1)
>  #define EDL_PATCH_VER_REQ_CMD		(0x19)
>  #define EDL_PATCH_TLV_REQ_CMD		(0x1E)
> @@ -140,7 +141,7 @@ int qca_set_bdaddr_rome(struct hci_dev *hdev,
> const bdaddr_t *bdaddr);
>  int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  		   enum qca_btsoc_type soc_type, u32 soc_ver);
>  int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version);
> -
> +int qca_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
>  #else
> 
>  static inline int qca_set_bdaddr_rome(struct hci_dev *hdev, const
> bdaddr_t *bdaddr)
> @@ -159,4 +160,9 @@ static inline int qca_read_soc_version(struct
> hci_dev *hdev, u32 *soc_version)
>  	return -EOPNOTSUPP;
>  }
> 
> +static inline int qca_set_bdaddr(struct hci_dev *hdev, const bdaddr_t 
> *bdaddr)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  #endif
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index f036c8f98ea3..53ac5ade532b 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1241,7 +1241,10 @@ static int qca_setup(struct hci_uart *hu)
>  	}
> 
>  	/* Setup bdaddr */
> -	hu->hdev->set_bdaddr = qca_set_bdaddr_rome;
> +	if (qcadev->btsoc_type == QCA_WCN3990)
> +		hu->hdev->set_bdaddr = qca_set_bdaddr;
> +	else
> +		hu->hdev->set_bdaddr = qca_set_bdaddr_rome;
> 
>  	return ret;
>  }


Can you pls review this change.

-- 
Regards
Balakrishna.
