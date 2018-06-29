Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDD2C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81DB927946
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fzFevUfm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fzFevUfm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81DB927946
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935703AbeF2Rh1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 13:37:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46156 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752423AbeF2RhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 13:37:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E50BB60452; Fri, 29 Jun 2018 17:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530293843;
        bh=q0SFDf8Wf5OmahQsFezyRt86MLF6lhKoKKG1XdhkjnY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fzFevUfmm/mv2oQ1FTHJulAT2DNZh4OGPhg/+5TQIG0QgKu511Bj0s7CejeHo9syP
         yB7PWCRAZ6B4bmXYHAn9MkuL9EtDQUKhjOdZhgdqfZ/Ldwx0ECRjOoDscDNtxDRDvj
         bIUfko3dgCC5mEYD/5749mCGTrI++HZWXHrL8eHg=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id E782F60711;
        Fri, 29 Jun 2018 17:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530293843;
        bh=q0SFDf8Wf5OmahQsFezyRt86MLF6lhKoKKG1XdhkjnY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fzFevUfmm/mv2oQ1FTHJulAT2DNZh4OGPhg/+5TQIG0QgKu511Bj0s7CejeHo9syP
         yB7PWCRAZ6B4bmXYHAn9MkuL9EtDQUKhjOdZhgdqfZ/Ldwx0ECRjOoDscDNtxDRDvj
         bIUfko3dgCC5mEYD/5749mCGTrI++HZWXHrL8eHg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 29 Jun 2018 23:07:22 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, rtatiya@codeaurora.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v8 7/7] Bluetooth: hci_qca: Add support for Qualcomm
 Bluetooth chip wcn3990
In-Reply-To: <20180626010559.GK129942@google.com>
References: <20180625134013.19684-1-bgodavar@codeaurora.org>
 <20180625134013.19684-8-bgodavar@codeaurora.org>
 <20180626010559.GK129942@google.com>
Message-ID: <364baccde12829e0c160a3ba2bbcdee0@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2018-06-26 06:35, Matthias Kaehlcke wrote:
> On Mon, Jun 25, 2018 at 07:10:13PM +0530, Balakrishna Godavarthi wrote:
>> Add support to set voltage/current of various regulators
>> to power up/down Bluetooth chip wcn3990.
>> 
>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> ---
>> changes in v8:
>>     * closing qca buffer, if qca_power_setup fails
>>     * chnaged ibs start timer function call location.
>>     * updated review comments.
>> 
>> changes in v7:
>>     * addressed review comments.
>> 
>> changes in v6:
>>     * Hooked up qca_power to qca_serdev.
>>     * renamed all the naming inconsistency functions with qca_*
>>     * leveraged common code of ROME for wcn3990.
>>     * created wrapper functions for re-usable blocks.
>>     * updated function of _*regulator_enable and _*regualtor_disable.
>>     * removed redundant comments and functions.
>>     * addressed review comments.
>> 
>> Changes in v5:
>>     * updated regulator vddpa min_uV to 1304000.
>>       * addressed review comments.
>> 
>> Changes in v4:
>>     * Segregated the changes of btqca from hci_qca
>>     * rebased all changes on top of bluetooth-next.
>>     * addressed review comments.
>> 
>> ---
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index 28187a89b850..bd4c9a78716f 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> ...
>> +static int qca_send_vendor_cmd(struct hci_dev *hdev, u8 cmd)
>> +{
>> +	struct hci_uart *hu = hci_get_drvdata(hdev);
>> +	struct qca_data *qca = hu->priv;
>> +	struct sk_buff *skb;
>> +
>> +	bt_dev_dbg(hdev, "sending command %02x to SoC", cmd);
>> +
>> +	skb = bt_skb_alloc(sizeof(cmd), GFP_KERNEL);
>> +	if (!skb) {
>> +		bt_dev_err(hdev, "Failed to allocate memory for vendor packet");
> 
> As mentioned on v7, custom OOM messages should be avoided.
> 

[Bala]: sry i might have missed it, will update.

>>  static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type 
>> speed_type)
>>  {
>> +	struct qca_serdev *qcadev;
>>  	unsigned int speed, qca_baudrate;
>>  	int ret;
>> 
>> @@ -971,6 +1054,13 @@ static int qca_set_speed(struct hci_uart *hu, 
>> enum qca_speed_type speed_type)
>>  		return 0;
>>  	}
>> 
>> +	qcadev = serdev_device_get_drvdata(hu->serdev);
>> +	/* Disabling hardware flow control is preferred while
>> +	 * sending change baud rate command to SoC.
>> +	 */
> 
> Is it only preferred or must be?
> 

[Bala]: must be. will update.

>> +	if (qcadev->btsoc_type == QCA_WCN3990)
>> +		hci_uart_set_flow_control(hu, true);
>> +
> 
> nit: consider doing this just before qca_set_baudrate(). It doesn't
> make a difference but leaves it clearer what exactly needs to be
> 'protected' (analogy to locking).

[Bala] : will do it.

> 
>>  	qca_baudrate = qca_get_baudrate_value(speed);
>>  	bt_dev_info(hu->hdev, "Set UART speed to %d", speed);
>>  	ret = qca_set_baudrate(hu->hdev, qca_baudrate);
>> @@ -980,8 +1070,10 @@ static int qca_set_speed(struct hci_uart *hu, 
>> enum qca_speed_type speed_type)
>>  	}
>> 
>>  	host_set_baudrate(hu, speed);
>> +	if (qcadev->btsoc_type == QCA_WCN3990)
>> +		hci_uart_set_flow_control(hu, false);
> 
>>  static int qca_setup(struct hci_uart *hu)
>> @@ -989,10 +1081,11 @@ static int qca_setup(struct hci_uart *hu)
>>  	struct hci_dev *hdev = hu->hdev;
>>  	struct qca_data *qca = hu->priv;
>>  	unsigned int speed, qca_baudrate = QCA_BAUDRATE_115200;
>> +	struct qca_serdev *qcadev;
>>  	int ret;
>>  	int soc_ver = 0;
>> 
>> -	bt_dev_info(hdev, "ROME setup");
>> +	qcadev = serdev_device_get_drvdata(hu->serdev);
>> 
>>  	/* Patch downloading has to be done without IBS mode */
>>  	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
>> @@ -1000,6 +1093,35 @@ static int qca_setup(struct hci_uart *hu)
>>  	/* Setup initial baudrate */
>>  	qca_set_speed(hu, QCA_INIT_SPEED);
>> 
>> +	if (qcadev->btsoc_type == QCA_WCN3990) {
>> +		bt_dev_dbg(hdev, "setting up wcn3990");
>> +		hci_uart_set_flow_control(hu, true);
>> +		ret = qca_send_vendor_cmd(hdev, QCA_WCN3990_POWERON_PULSE);
>> +		if (ret)
>> +			return ret;
>> +
>> +		hci_uart_set_flow_control(hu, false);
>> +		serdev_device_close(hu->serdev);
>> +		ret = serdev_device_open(hu->serdev);
>> +		if (ret) {
>> +			bt_dev_err(hdev, "failed to open port");
>> +			return ret;
>> +		}
>> +
>> +		msleep(100);
> 
> Is the sleep really related with _open() or is it rather that the
> device needs to settle after the power on pulse? In the latter case
> I'd suggest to do the sleep before _open(), if it doesn't make a
> functional difference (makes the code a bit more self documenting).
> 
>> +		/* Setup initial baudrate */
>> +		qca_set_speed(hu, QCA_INIT_SPEED);
>> +		hci_uart_set_flow_control(hu, false);
> 
> This is still a bit noisy with all the open/close and flow control
> stuff. If I understand correctly this essentially switches the
> controller on (or resets it?) and brings it (and the driver) into a
> sane state. Would it make sense to move the above block into a
> wcn3990_init/reset() or so?

[Bala]: It is very good idea, may be future chips also will flow same 
functions with some initial setup changes.
         will group these functions into a common functions.


-- 
Regards
Balakrishna.
