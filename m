Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552B0C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB20620685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Zlrl+gwL";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Dh+oyHKL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB20620685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbeJaWez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 18:34:55 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34710 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728828AbeJaWez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 18:34:55 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 683F160767; Wed, 31 Oct 2018 13:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540993010;
        bh=7g7rWHaUbX4iK4y6RMA4SlsxAcUAB2QDnfDr4puMUas=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Zlrl+gwL4WEHd0dyClRCqTFXc5Ky7zKW1iJp2KNlUetGSgbmDtpBpifbFL36AgBAb
         stwzXODOmHx+RhB/JsqLozVk8bnnXNtr5SAdIbEny3A3Dg8VuGWIRWYjWKWxZ+qeUn
         S/hVPGo0AnLa81McL8f+aE0lG0EolIOS1EeUlQy0=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 7698E602BD;
        Wed, 31 Oct 2018 13:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540993009;
        bh=7g7rWHaUbX4iK4y6RMA4SlsxAcUAB2QDnfDr4puMUas=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Dh+oyHKLJFOsRSdKMz0Y3Mh+XU7VccL/lb2uVPDWpSmg0JGW2OZ3ssTEcUbmE8M4u
         Si0aIBDMr0GPFJ/ZVF4q18UX1yA7ugtwn0XGuKrzUBSk4R3rfoOoEx6NkyK/ODIUfZ
         dtRJ31p524B6EWnRTFjAopZDonXO/zcpzk+WfIi4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 31 Oct 2018 19:06:49 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v1] Bluetooth: hci_qca: Add helper to set device address.
In-Reply-To: <20181026185314.GD22824@google.com>
References: <20181026140450.13172-1-bgodavar@codeaurora.org>
 <20181026185314.GD22824@google.com>
Message-ID: <e2785ffd2c5c614ba92d170afef3ea3b@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2018-10-27 00:23, Matthias Kaehlcke wrote:
> On Fri, Oct 26, 2018 at 07:34:50PM +0530, Balakrishna Godavarthi wrote:
>> This patch add qca_set_device_bdaddr() to set the device
>> address for latest Qualcomm Bluetooth chipset wcn3990 and above.
>> 
>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> ---
>>  drivers/bluetooth/btqca.c   | 21 +++++++++++++++++++++
>>  drivers/bluetooth/btqca.h   |  9 ++++++++-
>>  drivers/bluetooth/hci_qca.c |  5 ++++-
>>  3 files changed, 33 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
>> index ec9e03a6b778..132dc6ceb174 100644
>> --- a/drivers/bluetooth/btqca.c
>> +++ b/drivers/bluetooth/btqca.c
>> @@ -391,6 +391,27 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t 
>> baudrate,
>>  }
>>  EXPORT_SYMBOL_GPL(qca_uart_setup);
>> 
>> +int qca_set_device_bdaddr(struct hci_dev *hdev, const bdaddr_t 
>> *bdaddr)
> 
> nit: just qca_set_bdaddr() ? That would be consistent with
> qca_set_bdaddr_rome() and ->set_bdaddr().
> 

[Bala]: will update.

>> +{
>> +	struct sk_buff *skb;
>> +	u8 cmd[6];
> 
> nit: this doesn't really contain the command (which is
> EDL_WRITE_BD_ADDR_OPCODE). Name it 'buf', 'ba' or similar?
> 
[Bala]: will update with ba.
> re-nit: in the memcpy below 'sizeof(bdaddr_t)' is used, do the same in
> the declaration?
> 
>> +	int err;
>> +
>> +	memcpy(cmd, bdaddr, sizeof(bdaddr_t));
>> +	skb = __hci_cmd_sync_ev(hdev, EDL_WRITE_BD_ADDR_OPCODE, sizeof(cmd),
>> +				cmd, HCI_EV_VENDOR, HCI_INIT_TIMEOUT);
>> +	if (IS_ERR(skb)) {
>> +		err = PTR_ERR(skb);
>> +		bt_dev_err(hdev, "QCA Change address cmd failed (%d)", err);
>> +		return err;
>> +	}
>> +
>> +	kfree_skb(skb);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(qca_set_device_bdaddr);
>> +
>>  MODULE_AUTHOR("Ben Young Tae Kim <ytkim@qca.qualcomm.com>");
>>  MODULE_DESCRIPTION("Bluetooth support for Qualcomm Atheros family ver 
>> " VERSION);
>>  MODULE_VERSION(VERSION);
>> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
>> index 0c01f375fe83..8771fc2b193d 100644
>> --- a/drivers/bluetooth/btqca.h
>> +++ b/drivers/bluetooth/btqca.h
>> @@ -20,6 +20,7 @@
>> 
>>  #define EDL_PATCH_CMD_OPCODE		(0xFC00)
>>  #define EDL_NVM_ACCESS_OPCODE		(0xFC0B)
>> +#define EDL_WRITE_BD_ADDR_OPCODE	(0xFC14)
>>  #define EDL_PATCH_CMD_LEN		(1)
>>  #define EDL_PATCH_VER_REQ_CMD		(0x19)
>>  #define EDL_PATCH_TLV_REQ_CMD		(0x1E)
>> @@ -140,7 +141,7 @@ int qca_set_bdaddr_rome(struct hci_dev *hdev, 
>> const bdaddr_t *bdaddr);
>>  int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>>  		   enum qca_btsoc_type soc_type, u32 soc_ver);
>>  int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version);
>> -
>> +int qca_set_device_bdaddr(struct hci_dev *hdev, const bdaddr_t 
>> *bdaddr);
>>  #else
>> 
>>  static inline int qca_set_bdaddr_rome(struct hci_dev *hdev, const 
>> bdaddr_t *bdaddr)
>> @@ -159,4 +160,10 @@ static inline int qca_read_soc_version(struct 
>> hci_dev *hdev, u32 *soc_version)
>>  	return -EOPNOTSUPP;
>>  }
>> 
>> +static inline int qca_set_device_bdaddr(struct hci_dev *hdev,
>> +					const bdaddr_t *bdaddr)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +
>>  #endif
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index f036c8f98ea3..f18d9f5a7782 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -1241,7 +1241,10 @@ static int qca_setup(struct hci_uart *hu)
>>  	}
>> 
>>  	/* Setup bdaddr */
>> -	hu->hdev->set_bdaddr = qca_set_bdaddr_rome;
>> +	if (qcadev->btsoc_type == QCA_WCN3990)
>> +		hu->hdev->set_bdaddr = qca_set_device_bdaddr;
>> +	else
>> +		hu->hdev->set_bdaddr = qca_set_bdaddr_rome;
>> 
>>  	return ret;
>>  }
> 
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>

-- 
Regards
Balakrishna.
