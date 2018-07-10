Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1060EC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AACC72084A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="E5v1slvE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OaWJLpGk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AACC72084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933428AbeGJMTZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 08:19:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34644 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933258AbeGJMTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 08:19:23 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D272F607EB; Tue, 10 Jul 2018 12:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531225162;
        bh=MzrvK6I5vi+tWFx1sSN2WlQCO07eaIOERKOy6W6SvPI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E5v1slvEo94bNNDiqSJeX0ibr3lAJGG5o4x0ktL4CF3OYYMLHt00OiD0hx+5dkAYW
         XIV48rofwJcvaG77WRctrrDQzMnK1bStFkdbc/1hE6XTtDuYMx/slvqOveVZ98zyUJ
         jAiwN63TF9lbymbZHe+WGujszKMwKB6zN0QPzEwg=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id E8E8F60251;
        Tue, 10 Jul 2018 12:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531225161;
        bh=MzrvK6I5vi+tWFx1sSN2WlQCO07eaIOERKOy6W6SvPI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OaWJLpGkFhLOlurtOeIwia57T9vAOD1mMzSu2hbRI4oYIq37gEvRx2thqcu78dwEt
         zPgGWjxFyR61lNu6CPzcwjxkWNnfpWZmD5nH/5fXkrjpO/SaLxFQzNz491/i/MLSu7
         esw8OxJmkspQJcPzD/P71iWnco4Nbd7uA9/yF5eM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 10 Jul 2018 17:49:20 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v9 4/7] Bluetooth: hci_qca: Add wrapper functions for
 setting UART speed
In-Reply-To: <20180706194059.GJ129942@google.com>
References: <20180705165515.13340-1-bgodavar@codeaurora.org>
 <20180705165515.13340-5-bgodavar@codeaurora.org>
 <20180706194059.GJ129942@google.com>
Message-ID: <55c70cb40b421ab87c36dd2ecf886c1b@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2018-07-07 01:10, Matthias Kaehlcke wrote:
> On Thu, Jul 05, 2018 at 10:25:12PM +0530, Balakrishna Godavarthi wrote:
>> In function qca_setup, we set initial and operating speeds for 
>> Qualcomm
>> Bluetooth SoC's. This block of code is common across different
>> Qualcomm Bluetooth SoC's. Instead of duplicating the code, created
>> a wrapper function to set the speeds. So that future coming SoC's
>> can use these wrapper functions to set speeds.
>> 
>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> ---
>> Changes in v9:
>>     * added corner case to fail driver if speeds are missing.
>> 
>> Changes in v8:
>>     * common function to set INIT and operating speeds.
>> 
>> Changes in v7:
>>     * initial patch
>>     * created wrapper functions for init and operating speeds.
>> ---
>>  drivers/bluetooth/hci_qca.c | 94 
>> ++++++++++++++++++++++++++++---------
>>  1 file changed, 71 insertions(+), 23 deletions(-)
>> 
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index c02e1d465cca..9106547324fa 100644
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
>> @@ -923,6 +928,62 @@ static inline void host_set_baudrate(struct 
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
>> +static int qca_check_speeds(struct hci_uart *hu)
>> +{
>> +	/* One or the other speeds should be non zero. */
>> +	if (!qca_get_speed(hu, QCA_INIT_SPEED) &&
>> +	    !qca_get_speed(hu, QCA_OPER_SPEED))
>> +		return -EINVAL;
>> +
>> +	return 0;
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
> 
> mega-nit: for consistency with the 'else' branch you could return if
> 'speed == 0'. Not important though, feel free to ignore.
> 
>> +	} else {
>> +		speed = qca_get_speed(hu, QCA_OPER_SPEED);
>> +		if (!speed)
>> +			return 0;
>> +
>> +		qca_baudrate = qca_get_baudrate_value(speed);
>> +		bt_dev_info(hu->hdev, "Set UART speed to %d", speed);
>> +		ret = qca_set_baudrate(hu->hdev, qca_baudrate);
>> +		if (ret)
>> +			return ret;
>> +
>> +		host_set_baudrate(hu, speed);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  static int qca_setup(struct hci_uart *hu)
>>  {
>>  	struct hci_dev *hdev = hu->hdev;
>> @@ -933,37 +994,24 @@ static int qca_setup(struct hci_uart *hu)
>> 
>>  	bt_dev_info(hdev, "ROME setup");
>> 
>> +	ret = qca_check_speeds(hu);
>> +	if (ret)
>> +		return ret;
>> +
>>  	/* Patch downloading has to be done without IBS mode */
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
>> -
>> +	speed = qca_get_speed(hu, QCA_OPER_SPEED);
>>  	if (speed) {
>> -		qca_baudrate = qca_get_baudrate_value(speed);
>> -
>> -		bt_dev_info(hdev, "Set UART speed to %d", speed);
>> -		ret = qca_set_baudrate(hdev, qca_baudrate);
>> -		if (ret) {
>> -			bt_dev_err(hdev, "Failed to change the baud rate (%d)",
>> -				   ret);
>> +		ret = qca_set_speed(hu, QCA_OPER_SPEED);
>> +		if (ret)
>>  			return ret;
>> -		}
>> -		host_set_baudrate(hu, speed);
>> +
>> +		qca_baudrate = qca_get_baudrate_value(speed);
>>  	}
> 
> One doubt, the outcome of this change is:
> 
> 	qca_set_speed(hu, QCA_INIT_SPEED);
> 
> 	/* Setup user speed if needed */
> 	speed = qca_get_speed(hu, QCA_OPER_SPEED);
> 	if (speed) {
> 		ret = qca_set_speed(hu, QCA_OPER_SPEED);
> 		if (ret)
> 			return ret;
> 
> 		qca_baudrate = qca_get_baudrate_value(speed);
> 	}
> 
> So we set the init speed and then directly switch to operating speed
> if it is defined.
> 
> Couldn't we do this instead:
> 
> 	/* Setup user speed if needed */
> 	speed = qca_get_speed(hu, QCA_OPER_SPEED);
> 	if (speed) {
> 		ret = qca_set_speed(hu, QCA_OPER_SPEED);
> 		if (ret)
> 			return ret;
> 
> 		qca_baudrate = qca_get_baudrate_value(speed);
> 	} else {
> 	       qca_set_speed(hu, QCA_INIT_SPEED);
> 	}
> 
> 

[Bala]: above else block is not required.
         if we have operating speed to set, then we need to send the baud 
rate change request to BT chip on INIT baud rate. so before sending or 
setting operating baud rate.. HOST driver should be on the HOST init 
baud rate.
         Pls refer below for more info how we set speed and hci driver 
works.
> 
> Or is setting the init speed needed before the operating speed can be
> set? Sorry if we discussed this earlier in this series, I know I had a
> few doubts about the speed management but don't recall this one
> specifically.
> 

[Bala]: Let me give a big picture how we make BT work via serdev HCI 
arch. (qca chip is taken as reference)

         1. first of all, probe is called when we have compatible string 
matches in qca_bluetooth_of_match table.
         2. that will call qca_serdev_probe() in which based on BT device 
connected to the platform, we decide IO's
            which required from HOST to chip i.e.. controls required to 
turn ON/OFF BT. which includes clocks and regulators and GPIO's.
         3. in qca_serdev_probe() we call  hci_uart_register_device() and 
pass ops (operations handler) handler for driver registration.
         4. in hci_uart_register_device(), we call qca_open().. where we 
open the port via serdev_device_open() that
            intern will call Qualcomm specific lower level UART driver 
i.e.. where we read and write to port register address.
            so serdev_device_open() is a common function to all BT chip 
vendor, but the open routine in the low level driver is completely 
vendor dependent.
            for example, some vendors will set an default UART speed 
(speed can be any) while opening the uart_port(). where as other will 
not set. Just open the port with basic configurations.

         5. coming back to qca_open(), we try to make chip to boot up by 
enabling clock from HOST for BT chip to operate..  it is purely chip 
defined.
         6. moving back to hci_uart_register_device()... we will call 
hci_register_dev() in that function we call hci_power_on().. that will 
call hci_dev_do_open()
         7. in hci_dev_do_open() we call hdev->setup() i.e. 
hci_uart_setup() in that function we set initial baud rate and operating 
bartender if we have protos defined for setting chip baud rate.(in our 
case it is null)

         8. so it will call setup function will be vendor specific.. as 
we are using an UART, HOST and chip need to stick to the agreement of 
initial UART speed for commands to send until and change baud rate 
request is
            sent.
         9. now in qca_setup(), we setup an initial host baud rate i.e. 
what we have agreement with BT chip for initial communication. Now here 
the question comes why are we setting init speed again and again
            i.e uart_open() and hci_uart_setup().. here is the answer, wt 
ever layer we have are common to all vendors may also tend to change. we 
can't take a risk, we will setup init baud rate in vendor layer i.e.
            qca_setup().
         10. then we need to change the baud rate of chip..so we need to 
send commands to chip. at wt speed we need to send change baud rate 
request is totally based on agreement with BT Chip. so here we use 
initial
             baud rate.
         11. we need to change baud rate request command to chip on init 
baud rate. if command sending is successful we change the host baud rate 
from init to operating baud rate.. else we operate on init baud rate.


         the above is based on my understanding. Pls let me know if i 
have cleared your doubt.


> Other than that:
> 
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>



-- 
Regards
Balakrishna.
