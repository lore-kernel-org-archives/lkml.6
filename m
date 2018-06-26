Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B681AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 637E0263EA
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LIOtJooR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cKCymEQO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 637E0263EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935119AbeFZBbV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 21:31:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56306 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934339AbeFZBbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 21:31:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F2BE560500; Tue, 26 Jun 2018 01:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529976679;
        bh=b2gK2mtxMfv3WuFxBJiIL1LG0ByWtzDbcbXdCCQ7/84=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LIOtJooRPLcERwDvC7mFWKeVFp3jFSlk13swhdXu0m+NLwDnx7GNNHx899DiuA3nJ
         9Lap2p0TWzkcaJLo367jamAXt5TQTuyrrYZSs03y4jkAaVwxeCPJMpCuW7dUDY0JtC
         0DR8Fp1LcmBt0zAdwpVzqKreLarkn1vF+eUXGuaA=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 0A82560392;
        Tue, 26 Jun 2018 01:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529976678;
        bh=b2gK2mtxMfv3WuFxBJiIL1LG0ByWtzDbcbXdCCQ7/84=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cKCymEQOCjnACxBeKqTE0h2pRDCFXioVNBvEKsRBeagsl78Fsh67K6VI8fnDkS5MV
         scS+s1O6H/yvWOiPyNwQLZAywX12nDgC2hFNDt/R9Fv2sVAAL32ryW7VL42p1r/khw
         Nbqn3bvaVYqRrbHPc3xDWygqYGIw6S98co/tPg10=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 26 Jun 2018 07:01:18 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, rtatiya@codeaurora.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v8 4/7] Bluetooth: hci_qca: Add wrapper functions for
 setting UART speed
In-Reply-To: <20180625234354.GI129942@google.com>
References: <20180625134013.19684-1-bgodavar@codeaurora.org>
 <20180625134013.19684-5-bgodavar@codeaurora.org>
 <20180625234354.GI129942@google.com>
Message-ID: <89b1e4ce98a26d79935bf2ba9a4bc278@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2018-06-26 05:13, Matthias Kaehlcke wrote:
> This is a nice improvement, a few remaining questions inline.
> 
> On Mon, Jun 25, 2018 at 07:10:10PM +0530, Balakrishna Godavarthi wrote:
>> In function qca_setup, we set initial and operating speeds for 
>> Qualcomm
>> Bluetooth SoC's. This block of code is common across different
>> Qualcomm Bluetooth SoC's. Instead of duplicating the code, created
>> a wrapper function to set the speeds. So that future coming SoC's
>> can use these wrapper functions to set speeds.
>> 
>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> ---
>> Changes in v8:
>>     * common function to set INIT and operating speeds.
>>     * moved hardware flow control to qca_set_speed().
>> 
>> Changes in v7:
>>     * initial patch
>>     * created wrapper functions for init and operating speeds.
>> ---
>>  drivers/bluetooth/hci_qca.c | 89 
>> +++++++++++++++++++++++++++----------
>>  1 file changed, 65 insertions(+), 24 deletions(-)
>> 
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index fe62420ef838..38b7dbe6c897 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -119,6 +119,11 @@ struct qca_data {
>>  	u64 votes_off;
>>  };
>> 
>> +enum qca_speed_type {
>> +	QCA_INIT_SPEED = 1,
>> +	QCA_OPER_SPEED
>> +};
>> +
>>  struct qca_serdev {
>>  	struct hci_uart	 serdev_hu;
>>  	struct gpio_desc *bt_en;
>> @@ -923,6 +928,60 @@ static inline void host_set_baudrate(struct 
>> hci_uart *hu, unsigned int speed)
>>  		hci_uart_set_baudrate(hu, speed);
>>  }
>> 
>> +static unsigned int qca_get_speed(struct hci_uart *hu,
>> +				  enum qca_speed_type speed_type)
>> +{
>> +	unsigned int speed = 0;
>> +
>> +	if (speed_type == QCA_INIT_SPEED) {
>> +		if (hu->init_speed)
>> +			speed = hu->init_speed;
>> +		else if (hu->proto->init_speed)
>> +			speed = hu->proto->init_speed;
>> +	} else {
>> +		if (hu->oper_speed)
>> +			speed = hu->oper_speed;
>> +		else if (hu->proto->oper_speed)
>> +			speed = hu->proto->oper_speed;
>> +	}
>> +
>> +	return speed;
>> +}
>> +
>> +static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type 
>> speed_type)
>> +{
>> +	unsigned int speed, qca_baudrate;
>> +	int ret;
>> +
>> +	if (speed_type == QCA_INIT_SPEED) {
>> +		speed = qca_get_speed(hu, QCA_INIT_SPEED);
>> +		if (speed)
>> +			host_set_baudrate(hu, speed);
>> +		else
>> +			bt_dev_err(hu->hdev, "Init speed should be non zero");
> 
> The check for 'speed == 0' is done in multiple places. From this
> code I deduce that it is expected that both INIT and OPER speed are
> set to non-zero values. What happens if either of them is zero? Is the
> driver still operational?
> 
[Bala]: yes in hci_uart_setup()(hci_serdev.c) function before calling 
qca_setup().
         we actually set baudrate, but int  above code missed to restrict 
the further call to qca_setup()
        if speed =0. so we are checking the same in the qca_setup().. 
i.e. qca_get_speed().


>> +		return 0;
>> +	}
>> +
>> +	speed = qca_get_speed(hu, QCA_OPER_SPEED);
>> +	if (!speed) {
>> +		bt_dev_err(hu->hdev, "operating speed should be non zero");
>> +		return 0;
>> +	}
>> +
>> +	qca_baudrate = qca_get_baudrate_value(speed);
>> +	bt_dev_info(hu->hdev, "Set UART speed to %d", speed);
>> +	ret = qca_set_baudrate(hu->hdev, qca_baudrate);
>> +	if (ret) {
>> +		bt_dev_err(hu->hdev, "Failed to change the baudrate (%d)", ret);
>> +		return ret;
>> +	}
>> +
>> +	host_set_baudrate(hu, speed);
>> +
>> +	return ret;
>> +}
> 
> In the discussion on "[v7,8/8] Bluetooth: hci_qca: Add support for
> Qualcomm Bluetooth chip wcn3990" you mentioned the possbility to move
> the hci_uart_set_flow_control() calls into _set_speed(). This seemed
> interesting but finally it isn't done in this series. Did you
> encounter that it is not feasible/desirable for some reason?
> 

[Bala]: this patch is for rome where flow control is not used.
         after we integrate wcn3990, flow control is hidden in the 
qca_set_speed()
         Pls check [v8 7/7] patch.

>> +
>>  static int qca_setup(struct hci_uart *hu)
>>  {
>>  	struct hci_dev *hdev = hu->hdev;
>> @@ -937,35 +996,17 @@ static int qca_setup(struct hci_uart *hu)
>>  	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
>> 
>>  	/* Setup initial baudrate */
>> -	speed = 0;
>> -	if (hu->init_speed)
>> -		speed = hu->init_speed;
>> -	else if (hu->proto->init_speed)
>> -		speed = hu->proto->init_speed;
>> -
>> -	if (speed)
>> -		host_set_baudrate(hu, speed);
>> +	qca_set_speed(hu, QCA_INIT_SPEED);
>> 
>>  	/* Setup user speed if needed */
>> -	speed = 0;
>> -	if (hu->oper_speed)
>> -		speed = hu->oper_speed;
>> -	else if (hu->proto->oper_speed)
>> -		speed = hu->proto->oper_speed;
>> +	ret = qca_set_speed(hu, QCA_OPER_SPEED);
>> +	if (ret)
>> +		return ret;
>> 
>> -	if (speed) {
>> +	speed = qca_get_speed(hu, QCA_OPER_SPEED);
>> +	if (speed)
>>  		qca_baudrate = qca_get_baudrate_value(speed);
> 
> Is the check here necessary? qca_get_baudrate_value() returns
> QCA_BAUDRATE_115200 for a zero speed.

this if for no zero operating speed,

-- 
Regards
Balakrishna.
