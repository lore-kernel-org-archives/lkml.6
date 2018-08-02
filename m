Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF6BC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 20:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B39F421569
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 20:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Q2y8INsf";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TkPbkkn2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B39F421569
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbeHBWD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 18:03:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38454 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbeHBWD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 18:03:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F21F5602D7; Thu,  2 Aug 2018 20:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533240645;
        bh=TGznLwWCz+DyLjT4gRgIi5+dUnOsD/M/7veSr6MM1kw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q2y8INsfY0jBGFJWPqvLulJa6GrOt4COmivPihtZF4Suo0e9TsQY5WtOozJa8l72k
         KxCg4drhAa0GeVTwmT3E1252O7D/UMpZEHzFZJEWDcQNLi55scTdwk0jdP0MwYi9AM
         VGAer3RWRdKHavO+jQT6Zf2HqxolOYkj5QDNTSoY=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 5E368602D7;
        Thu,  2 Aug 2018 20:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533240643;
        bh=TGznLwWCz+DyLjT4gRgIi5+dUnOsD/M/7veSr6MM1kw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TkPbkkn2wzRRG/E8WF88rkZnWo0SivJqQmuFiSwPr43qKrzsFb1gYpXpFgCRSS7BO
         oM+RNs87Q4LFqbTCgn4u7A4Mumc+ehyqtCopmJgJ5FcTiu66ZQpf9ryFmP/KwbOhQa
         yvu6INP6w9VnH72TsqMAOYHPRoL97vdFxcjAwX2Y=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 03 Aug 2018 01:40:43 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v13 7/7] Bluetooth: hci_qca: Add support for Qualcomm
 Bluetooth chip wcn3990
In-Reply-To: <20180802195733.GQ68975@google.com>
References: <20180802190732.4811-1-bgodavar@codeaurora.org>
 <20180802190732.4811-8-bgodavar@codeaurora.org>
 <20180802195733.GQ68975@google.com>
Message-ID: <db854b94ad686d2506ba1cfcb5aef196@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-03 01:27, Matthias Kaehlcke wrote:
> On Fri, Aug 03, 2018 at 12:37:32AM +0530, Balakrishna Godavarthi wrote:
>> Add support to set voltage/current of various regulators
>> to power up/down Bluetooth chip wcn3990.
>> 
>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
>> ---
>> Changes in v13:
>>    * updated review comments.
>> 
>> Changes in v12:
>>     * removed retrying iteration loop in qca_wcn3990_init.
>> 
>> Changes in v11:
>>     * removed support to read regulator currents from dts.
>>     * updated review comments.
>> 
>> Changes in v10:
>>     * added support to read regulator currents from dts.
>>     * added support to try to connect with chip if it fails to respond 
>> to initial commands
>>     * updated review comments.
>> 
>> changes in v9:
>>     * moved flow control to vendor and set_baudarte functions.
>>     * removed parent regs.
>> 
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
>> ---
>>  drivers/bluetooth/btqca.h   |   3 +
>>  drivers/bluetooth/hci_qca.c | 402 
>> +++++++++++++++++++++++++++++++-----
>>  2 files changed, 358 insertions(+), 47 deletions(-)
>> 
>> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
>> index a9c2779f3e07..0c01f375fe83 100644
>> --- a/drivers/bluetooth/btqca.h
>> +++ b/drivers/bluetooth/btqca.h
>> @@ -37,6 +37,9 @@
>>  #define EDL_TAG_ID_HCI			(17)
>>  #define EDL_TAG_ID_DEEP_SLEEP		(27)
>> 
>> +#define QCA_WCN3990_POWERON_PULSE	0xFC
>> +#define QCA_WCN3990_POWEROFF_PULSE	0xC0
>> +
>>  enum qca_bardrate {
>>  	QCA_BAUDRATE_115200 	= 0,
>>  	QCA_BAUDRATE_57600,
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index a6e7d38ef931..66f36527e4dd 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -5,7 +5,7 @@
>>   *  protocol extension to H4.
>>   *
>>   *  Copyright (C) 2007 Texas Instruments, Inc.
>> - *  Copyright (c) 2010, 2012 The Linux Foundation. All rights 
>> reserved.
>> + *  Copyright (c) 2010, 2012, 2018 The Linux Foundation. All rights 
>> reserved.
>>   *
>>   *  Acknowledgements:
>>   *  This file is based on hci_ll.c, which was...
>> @@ -31,9 +31,14 @@
>>  #include <linux/kernel.h>
>>  #include <linux/clk.h>
>>  #include <linux/debugfs.h>
>> +#include <linux/delay.h>
>> +#include <linux/device.h>
>>  #include <linux/gpio/consumer.h>
>>  #include <linux/mod_devicetable.h>
>>  #include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regulator/consumer.h>
>>  #include <linux/serdev.h>
>> 
>>  #include <net/bluetooth/bluetooth.h>
>> @@ -124,12 +129,46 @@ enum qca_speed_type {
>>  	QCA_OPER_SPEED
>>  };
>> 
>> +/*
>> + * Voltage regulator information required for configuring the
>> + * QCA Bluetooth chipset
>> + */
>> +struct qca_vreg {
>> +	const char *name;
>> +	unsigned int min_uV;
>> +	unsigned int max_uV;
>> +	unsigned int load_uA;
>> +};
>> +
>> +struct qca_vreg_data {
>> +	enum qca_btsoc_type soc_type;
>> +	struct qca_vreg *vregs;
>> +	size_t num_vregs;
>> +};
>> +
>> +/*
>> + * Platform data for the QCA Bluetooth power driver.
>> + */
>> +struct qca_power {
>> +	struct device *dev;
>> +	const struct qca_vreg_data *vreg_data;
>> +	struct regulator_bulk_data *vreg_bulk;
>> +	bool vregs_on;
>> +};
>> +
>>  struct qca_serdev {
>>  	struct hci_uart	 serdev_hu;
>>  	struct gpio_desc *bt_en;
>>  	struct clk	 *susclk;
>> +	enum qca_btsoc_type btsoc_type;
>> +	struct qca_power *bt_power;
>> +	u32 init_speed;
>> +	u32 oper_speed;
>>  };
>> 
>> +static int qca_power_setup(struct hci_uart *hu, bool on);
>> +static void qca_power_shutdown(struct hci_dev *hdev);
>> +
>>  static void __serial_clock_on(struct tty_struct *tty)
>>  {
>>  	/* TODO: Some chipset requires to enable UART clock on client
>> @@ -407,6 +446,7 @@ static int qca_open(struct hci_uart *hu)
>>  {
>>  	struct qca_serdev *qcadev;
>>  	struct qca_data *qca;
>> +	int ret;
>> 
>>  	BT_DBG("hu %p qca_open", hu);
>> 
>> @@ -458,19 +498,32 @@ static int qca_open(struct hci_uart *hu)
>> 
>>  	hu->priv = qca;
>> 
>> -	timer_setup(&qca->wake_retrans_timer, hci_ibs_wake_retrans_timeout, 
>> 0);
>> -	qca->wake_retrans = IBS_WAKE_RETRANS_TIMEOUT_MS;
>> -
>> -	timer_setup(&qca->tx_idle_timer, hci_ibs_tx_idle_timeout, 0);
>> -	qca->tx_idle_delay = IBS_TX_IDLE_TIMEOUT_MS;
>> -
>>  	if (hu->serdev) {
>>  		serdev_device_open(hu->serdev);
>> 
>>  		qcadev = serdev_device_get_drvdata(hu->serdev);
>> -		gpiod_set_value_cansleep(qcadev->bt_en, 1);
>> +		if (qcadev->btsoc_type != QCA_WCN3990) {
>> +			gpiod_set_value_cansleep(qcadev->bt_en, 1);
>> +		} else {
>> +			hu->init_speed = qcadev->init_speed;
>> +			hu->oper_speed = qcadev->oper_speed;
>> +			ret = qca_power_setup(hu, true);
>> +			if (ret) {
>> +				destroy_workqueue(qca->workqueue);
>> +				kfree_skb(qca->rx_skb);
>> +				hu->priv = NULL;
>> +				kfree(qca);
>> +				return ret;
>> +			}
>> +		}
>>  	}
>> 
>> +	timer_setup(&qca->wake_retrans_timer, hci_ibs_wake_retrans_timeout, 
>> 0);
>> +	qca->wake_retrans = IBS_WAKE_RETRANS_TIMEOUT_MS;
>> +
>> +	timer_setup(&qca->tx_idle_timer, hci_ibs_tx_idle_timeout, 0);
>> +	qca->tx_idle_delay = IBS_TX_IDLE_TIMEOUT_MS;
>> +
>>  	BT_DBG("HCI_UART_QCA open, tx_idle_delay=%u, wake_retrans=%u",
>>  	       qca->tx_idle_delay, qca->wake_retrans);
>> 
>> @@ -554,10 +607,13 @@ static int qca_close(struct hci_uart *hu)
>>  	qca->hu = NULL;
>> 
>>  	if (hu->serdev) {
>> -		serdev_device_close(hu->serdev);
>> -
>>  		qcadev = serdev_device_get_drvdata(hu->serdev);
>> -		gpiod_set_value_cansleep(qcadev->bt_en, 0);
>> +		if (qcadev->btsoc_type == QCA_WCN3990)
>> +			qca_power_shutdown(hu->hdev);
>> +		else
>> +			gpiod_set_value_cansleep(qcadev->bt_en, 0);
>> +
>> +		serdev_device_close(hu->serdev);
>>  	}
>> 
>>  	kfree_skb(qca->rx_skb);
>> @@ -891,6 +947,7 @@ static int qca_set_baudrate(struct hci_dev *hdev, 
>> uint8_t baudrate)
>>  	struct hci_uart *hu = hci_get_drvdata(hdev);
>>  	struct qca_data *qca = hu->priv;
>>  	struct sk_buff *skb;
>> +	struct qca_serdev *qcadev;
>>  	u8 cmd[] = { 0x01, 0x48, 0xFC, 0x01, 0x00 };
>> 
>>  	if (baudrate > QCA_BAUDRATE_3200000)
>> @@ -904,6 +961,13 @@ static int qca_set_baudrate(struct hci_dev *hdev, 
>> uint8_t baudrate)
>>  		return -ENOMEM;
>>  	}
>> 
>> +	/* Disabling hardware flow control is mandatory while
>> +	 * sending change baudrate request to wcn3990 SoC.
>> +	 */
>> +	qcadev = serdev_device_get_drvdata(hu->serdev);
>> +	if (qcadev->btsoc_type == QCA_WCN3990)
>> +		hci_uart_set_flow_control(hu, true);
>> +
>>  	/* Assign commands to change baudrate and packet type. */
>>  	skb_put_data(skb, cmd, sizeof(cmd));
>>  	hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
>> @@ -919,6 +983,9 @@ static int qca_set_baudrate(struct hci_dev *hdev, 
>> uint8_t baudrate)
>>  	schedule_timeout(msecs_to_jiffies(BAUDRATE_SETTLE_TIMEOUT_MS));
>>  	set_current_state(TASK_RUNNING);
>> 
>> +	if (qcadev->btsoc_type == QCA_WCN3990)
>> +		hci_uart_set_flow_control(hu, false);
>> +
>>  	return 0;
>>  }
>> 
>> @@ -930,6 +997,43 @@ static inline void host_set_baudrate(struct 
>> hci_uart *hu, unsigned int speed)
>>  		hci_uart_set_baudrate(hu, speed);
>>  }
>> 
>> +static int qca_send_power_pulse(struct hci_dev *hdev, u8 cmd)
>> +{
>> +	struct hci_uart *hu = hci_get_drvdata(hdev);
>> +	struct qca_data *qca = hu->priv;
>> +	struct sk_buff *skb;
>> +
>> +	/* These power pulses are single byte command which are sent
>> +	 * at required baudrate to wcn3990. On wcn3990, we have an external
>> +	 * circuit at Tx pin which decodes the pulse sent at specific 
>> baudrate.
>> +	 * For example, wcn3990 supports RF COEX antenna for both Wi-Fi/BT
>> +	 * and also we use the same power inputs to turn on and off for
>> +	 * Wi-Fi/BT. Powering up the power sources will not enable BT, until
>> +	 * we send a power on pulse at 115200 bps. This algorithm will help 
>> to
>> +	 * save power. Disabling hardware flow control is mandatory while
>> +	 * sending power pulses to SoC.
>> +	 */
>> +	bt_dev_dbg(hdev, "sending power pulse %02x to SoC", cmd);
>> +
>> +	skb = bt_skb_alloc(sizeof(cmd), GFP_KERNEL);
>> +	if (!skb)
>> +		return -ENOMEM;
>> +
>> +	hci_uart_set_flow_control(hu, true);
>> +
>> +	skb_put_u8(skb, cmd);
>> +	hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
>> +
>> +	skb_queue_tail(&qca->txq, skb);
>> +	hci_uart_tx_wakeup(hu);
>> +
>> +	/* Wait for 100 uS for SoC to settle down */
>> +	usleep_range(100, 200);
>> +	hci_uart_set_flow_control(hu, false);
>> +
>> +	return 0;
>> +}
>> +
>>  static unsigned int qca_get_speed(struct hci_uart *hu,
>>  				  enum qca_speed_type speed_type)
>>  {
>> @@ -952,9 +1056,18 @@ static unsigned int qca_get_speed(struct 
>> hci_uart *hu,
>> 
>>  static int qca_check_speeds(struct hci_uart *hu)
>>  {
>> -	if (!qca_get_speed(hu, QCA_INIT_SPEED) ||
>> -	    !qca_get_speed(hu, QCA_OPER_SPEED))
>> -		return -EINVAL;
>> +	struct qca_serdev *qcadev;
>> +
>> +	qcadev = serdev_device_get_drvdata(hu->serdev);
>> +	if (qcadev->btsoc_type == QCA_WCN3990) {
>> +		if (!qca_get_speed(hu, QCA_INIT_SPEED) &&
>> +		    !qca_get_speed(hu, QCA_OPER_SPEED))
>> +			return -EINVAL;
>> +	} else {
>> +		if (!qca_get_speed(hu, QCA_INIT_SPEED) ||
>> +		    !qca_get_speed(hu, QCA_OPER_SPEED))
>> +			return -EINVAL;
>> +	}
>> 
>>  	return 0;
>>  }
>> @@ -974,7 +1087,7 @@ static int qca_set_speed(struct hci_uart *hu, 
>> enum qca_speed_type speed_type)
>>  			return 0;
>> 
>>  		qca_baudrate = qca_get_baudrate_value(speed);
>> -		bt_dev_info(hu->hdev, "Set UART speed to %d", speed);
>> +		bt_dev_dbg(hu->hdev, "Set UART speed to %d", speed);
>>  		ret = qca_set_baudrate(hu->hdev, qca_baudrate);
>>  		if (ret)
>>  			return ret;
>> @@ -985,15 +1098,51 @@ static int qca_set_speed(struct hci_uart *hu, 
>> enum qca_speed_type speed_type)
>>  	return 0;
>>  }
>> 
>> +static int qca_wcn3990_init(struct hci_uart *hu, u32 *soc_ver)
>> +{
> 
> I focussed more on other things in the last review rounds and
> overlooked that qca_read_soc_version() and the soc_ver pointer slipped
> in here with v10 (v9: https://patchwork.kernel.org/patch/10510029/).
> 
> In a similar line as in an earlier discussion about reading the SoC
> version in qca_uart_setup() 
> (https://patchwork.kernel.org/patch/10467903/)
> I don't think the init function is the right place and it shouldn't
> receive this soc_ver parameter about which it doesn't really
> care. Please switch back as it was in v9 and read the SoC version in
> qca_setup() (like it is done for Rome).
> 
> Then we should be done from my side.

so it should be some thing like this?

if (qcadev->btsoc_type == QCA_WCN3990) {
		bt_dev_info(hdev, "setting up wcn3990");
		ret = qca_wcn3990_init(hu);
		if (ret)
			return ret;
                 hci_uart_set_flow_control(hu, false);
                 ret = qca_read_soc_version(hdev, &soc_ver);
                 if (ret)
                      return ret;
	}

-- 
Regards
Balakrishna.
