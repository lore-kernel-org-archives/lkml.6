Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0A5ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E252075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jHLZQBLy";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Tjc2l/+8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E252075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731458AbeGRQLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:11:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42972 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731282AbeGRQLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:11:43 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 364E9602B3; Wed, 18 Jul 2018 15:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531927995;
        bh=ma2KxynTQd+XYyqETbYvadeZPWWVSBQ3YODZPyMX83g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jHLZQBLytGeEomSVabD2QEM/U3Hy5fgCh3Z3fxD9d7KTuhj+p/wa1v/F77xSPNRz0
         modCUYWDuJA/QS+X0venMFArzUhcSAYYmdBgOw2+5FuxuHB7g61dHYY1TZGky8pKQg
         h7DSuPPkrohoZon6fZY88Ppm26IlMnyCgkgW3Mt0=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id DFA49602B3;
        Wed, 18 Jul 2018 15:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531927989;
        bh=ma2KxynTQd+XYyqETbYvadeZPWWVSBQ3YODZPyMX83g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Tjc2l/+8HPKZDMw1DkQMQWQIosNl8VJ07lM9HCUd9I7g4mLveMxK8Ao921cqqg7cq
         4TIKbz32T0rZ3QROw80Hcxf5A1btLRoA+SiKSNcrhmocHlc7A4OzuzcJlSCAvYPRhT
         cQEkwzBUESMKkNxsNWCTvHi5jUDULeaM1ao05LbU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 18 Jul 2018 21:03:08 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v9 7/7] Bluetooth: hci_qca: Add support for Qualcomm
 Bluetooth chip wcn3990
In-Reply-To: <20180716160557.GY129942@google.com>
References: <20180705165515.13340-1-bgodavar@codeaurora.org>
 <20180705165515.13340-8-bgodavar@codeaurora.org>
 <20180706222110.GK129942@google.com>
 <ecc9d46aadb05d36f43ca9649cf44bf4@codeaurora.org>
 <20180716160557.GY129942@google.com>
Message-ID: <7a413cd329ce84f57346cf2b9775f6dd@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2018-07-16 21:35, Matthias Kaehlcke wrote:
> On Mon, Jul 16, 2018 at 07:21:56PM +0530, Balakrishna Godavarthi wrote:
>> Hi Matthias,
>> 
>> On 2018-07-07 03:51, Matthias Kaehlcke wrote:
>> > On Thu, Jul 05, 2018 at 10:25:15PM +0530, Balakrishna Godavarthi wrote:
>> > > Add support to set voltage/current of various regulators
>> > > to power up/down Bluetooth chip wcn3990.
>> > >
>> > > Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> > > ---
>> > > changes in v9:
>> > >     * moved flow control to vendor and set_baudarte functions.
>> > >     * removed parent regs.
>> > >
>> > > changes in v8:
>> > >     * closing qca buffer, if qca_power_setup fails
>> > >     * chnaged ibs start timer function call location.
>> > >     * updated review comments.
>> > >
>> > > changes in v7:
>> > >     * addressed review comments.
>> > >
>> > > changes in v6:
>> > >     * Hooked up qca_power to qca_serdev.
>> > >     * renamed all the naming inconsistency functions with qca_*
>> > >     * leveraged common code of ROME for wcn3990.
>> > >     * created wrapper functions for re-usable blocks.
>> > >     * updated function of _*regulator_enable and _*regualtor_disable.
>> > >     * removed redundant comments and functions.
>> > >     * addressed review comments.
>> > >
>> > > Changes in v5:
>> > >     * updated regulator vddpa min_uV to 1304000.
>> > >       * addressed review comments.
>> > >
>> > > Changes in v4:
>> > >     * Segregated the changes of btqca from hci_qca
>> > >     * rebased all changes on top of bluetooth-next.
>> > >     * addressed review comments.
>> > >
>> > > ---
>> > >  drivers/bluetooth/btqca.h   |   3 +
>> > >  drivers/bluetooth/hci_qca.c | 387
>> > > +++++++++++++++++++++++++++++++-----
>> > >  2 files changed, 345 insertions(+), 45 deletions(-)
>> > >
>> > > diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
>> > > index a9c2779f3e07..0c01f375fe83 100644
>> > > --- a/drivers/bluetooth/btqca.h
>> > > +++ b/drivers/bluetooth/btqca.h
>> > > @@ -37,6 +37,9 @@
>> > >  #define EDL_TAG_ID_HCI			(17)
>> > >  #define EDL_TAG_ID_DEEP_SLEEP		(27)
>> > >
>> > > +#define QCA_WCN3990_POWERON_PULSE	0xFC
>> > > +#define QCA_WCN3990_POWEROFF_PULSE	0xC0
>> > > +
>> > >  enum qca_bardrate {
>> > >  	QCA_BAUDRATE_115200 	= 0,
>> > >  	QCA_BAUDRATE_57600,
>> > > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> > > index 7ebfaa0edf3f..d62c7785a618 100644
>> > > --- a/drivers/bluetooth/hci_qca.c
>> > > +++ b/drivers/bluetooth/hci_qca.c
>> > > @@ -5,7 +5,7 @@
>> > >   *  protocol extension to H4.
>> > >   *
>> > >   *  Copyright (C) 2007 Texas Instruments, Inc.
>> > > - *  Copyright (c) 2010, 2012 The Linux Foundation. All rights
>> > > reserved.
>> > > + *  Copyright (c) 2010, 2012, 2018 The Linux Foundation. All rights
>> > > reserved.
>> > >   *
>> > >   *  Acknowledgements:
>> > >   *  This file is based on hci_ll.c, which was...
>> > > @@ -31,9 +31,14 @@
>> > >  #include <linux/kernel.h>
>> > >  #include <linux/clk.h>
>> > >  #include <linux/debugfs.h>
>> > > +#include <linux/delay.h>
>> > > +#include <linux/device.h>
>> > >  #include <linux/gpio/consumer.h>
>> > >  #include <linux/mod_devicetable.h>
>> > >  #include <linux/module.h>
>> > > +#include <linux/of_device.h>
>> > > +#include <linux/platform_device.h>
>> > > +#include <linux/regulator/consumer.h>
>> > >  #include <linux/serdev.h>
>> > >
>> > >  #include <net/bluetooth/bluetooth.h>
>> > > @@ -124,12 +129,46 @@ enum qca_speed_type {
>> > >  	QCA_OPER_SPEED
>> > >  };
>> > >
>> > > +/*
>> > > + * Voltage regulator information required for configuring the
>> > > + * QCA Bluetooth chipset
>> > > + */
>> > > +struct qca_vreg {
>> > > +	const char *name;
>> > > +	unsigned int min_uV;
>> > > +	unsigned int max_uV;
>> > > +	unsigned int load_uA;
>> > > +};
>> > > +
>> > > +struct qca_vreg_data {
>> > > +	enum qca_btsoc_type soc_type;
>> > > +	struct qca_vreg *vregs;
>> > > +	size_t num_vregs;
>> > > +};
>> > > +
>> > > +/*
>> > > + * Platform data for the QCA Bluetooth power driver.
>> > > + */
>> > > +struct qca_power {
>> > > +	struct device *dev;
>> > > +	const struct qca_vreg_data *vreg_data;
>> > > +	struct regulator_bulk_data *vreg_bulk;
>> > > +	bool vregs_on;
>> > > +};
>> > > +
>> > >  struct qca_serdev {
>> > >  	struct hci_uart	 serdev_hu;
>> > >  	struct gpio_desc *bt_en;
>> > >  	struct clk	 *susclk;
>> > > +	enum qca_btsoc_type btsoc_type;
>> > > +	struct qca_power *bt_power;
>> > > +	u32 init_speed;
>> > > +	u32 oper_speed;
>> > >  };
>> > >
>> > > +static int qca_power_setup(struct hci_uart *hu, bool on);
>> > > +static void qca_power_shutdown(struct hci_uart *hu);
>> > > +
>> > >  static void __serial_clock_on(struct tty_struct *tty)
>> > >  {
>> > >  	/* TODO: Some chipset requires to enable UART clock on client
>> > > @@ -407,6 +446,7 @@ static int qca_open(struct hci_uart *hu)
>> > >  {
>> > >  	struct qca_serdev *qcadev;
>> > >  	struct qca_data *qca;
>> > > +	int ret;
>> > >
>> > >  	BT_DBG("hu %p qca_open", hu);
>> > >
>> > > @@ -458,19 +498,32 @@ static int qca_open(struct hci_uart *hu)
>> > >
>> > >  	hu->priv = qca;
>> > >
>> > > -	timer_setup(&qca->wake_retrans_timer,
>> > > hci_ibs_wake_retrans_timeout, 0);
>> > > -	qca->wake_retrans = IBS_WAKE_RETRANS_TIMEOUT_MS;
>> > > -
>> > > -	timer_setup(&qca->tx_idle_timer, hci_ibs_tx_idle_timeout, 0);
>> > > -	qca->tx_idle_delay = IBS_TX_IDLE_TIMEOUT_MS;
>> > > -
>> > >  	if (hu->serdev) {
>> > >  		serdev_device_open(hu->serdev);
>> > >
>> > >  		qcadev = serdev_device_get_drvdata(hu->serdev);
>> > > -		gpiod_set_value_cansleep(qcadev->bt_en, 1);
>> > > +		if (qcadev->btsoc_type != QCA_WCN3990) {
>> > > +			gpiod_set_value_cansleep(qcadev->bt_en, 1);
>> > > +		} else {
>> > > +			hu->init_speed = qcadev->init_speed;
>> > > +			hu->oper_speed = qcadev->oper_speed;
>> > > +			ret = qca_power_setup(hu, true);
>> > > +			if (ret) {
>> > > +				destroy_workqueue(qca->workqueue);
>> > > +				kfree_skb(qca->rx_skb);
>> > > +				hu->priv = NULL;
>> > > +				kfree(qca);
>> > > +				return ret;
>> > > +			}
>> > > +		}
>> > >  	}
>> > >
>> > > +	timer_setup(&qca->wake_retrans_timer,
>> > > hci_ibs_wake_retrans_timeout, 0);
>> > > +	qca->wake_retrans = IBS_WAKE_RETRANS_TIMEOUT_MS;
>> > > +
>> > > +	timer_setup(&qca->tx_idle_timer, hci_ibs_tx_idle_timeout, 0);
>> > > +	qca->tx_idle_delay = IBS_TX_IDLE_TIMEOUT_MS;
>> > > +
>> > >  	BT_DBG("HCI_UART_QCA open, tx_idle_delay=%u, wake_retrans=%u",
>> > >  	       qca->tx_idle_delay, qca->wake_retrans);
>> > >
>> > > @@ -554,10 +607,13 @@ static int qca_close(struct hci_uart *hu)
>> > >  	qca->hu = NULL;
>> > >
>> > >  	if (hu->serdev) {
>> > > -		serdev_device_close(hu->serdev);
>> > > -
>> > >  		qcadev = serdev_device_get_drvdata(hu->serdev);
>> > > -		gpiod_set_value_cansleep(qcadev->bt_en, 0);
>> > > +		if (qcadev->btsoc_type == QCA_WCN3990)
>> > > +			qca_power_shutdown(hu);
>> > > +		else
>> > > +			gpiod_set_value_cansleep(qcadev->bt_en, 0);
>> > > +
>> > > +		serdev_device_close(hu->serdev);
>> > >  	}
>> > >
>> > >  	kfree_skb(qca->rx_skb);
>> > > @@ -891,6 +947,7 @@ static int qca_set_baudrate(struct hci_dev
>> > > *hdev, uint8_t baudrate)
>> > >  	struct hci_uart *hu = hci_get_drvdata(hdev);
>> > >  	struct qca_data *qca = hu->priv;
>> > >  	struct sk_buff *skb;
>> > > +	struct qca_serdev *qcadev;
>> > >  	u8 cmd[] = { 0x01, 0x48, 0xFC, 0x01, 0x00 };
>> > >
>> > >  	if (baudrate > QCA_BAUDRATE_3200000)
>> > > @@ -904,6 +961,13 @@ static int qca_set_baudrate(struct hci_dev
>> > > *hdev, uint8_t baudrate)
>> > >  		return -ENOMEM;
>> > >  	}
>> > >
>> > > +	/* Disabling hardware flow control is mandate while
>> >
>> > nit: s/mandate/mandatory|required/
>> >
>> > > +	 * sending change baudrate request to wcn3990 SoC.
>> > > +	 */
>> > > +	qcadev = serdev_device_get_drvdata(hu->serdev);
>> > > +	if (qcadev->btsoc_type == QCA_WCN3990)
>> > > +		hci_uart_set_flow_control(hu, true);
>> > > +
>> > >  	/* Assign commands to change baudrate and packet type. */
>> > >  	skb_put_data(skb, cmd, sizeof(cmd));
>> > >  	hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
>> > > @@ -919,6 +983,9 @@ static int qca_set_baudrate(struct hci_dev
>> > > *hdev, uint8_t baudrate)
>> > >  	schedule_timeout(msecs_to_jiffies(BAUDRATE_SETTLE_TIMEOUT_MS));
>> > >  	set_current_state(TASK_RUNNING);
>> > >
>> > > +	if (qcadev->btsoc_type == QCA_WCN3990)
>> > > +		hci_uart_set_flow_control(hu, false);
>> > > +
>> > >  	return 0;
>> > >  }
>> > >
>> > > @@ -930,6 +997,36 @@ static inline void host_set_baudrate(struct
>> > > hci_uart *hu, unsigned int speed)
>> > >  		hci_uart_set_baudrate(hu, speed);
>> > >  }
>> > >
>> > > +static int qca_send_vendor_cmd(struct hci_dev *hdev, u8 cmd)
>> > > +{
>> > > +	struct hci_uart *hu = hci_get_drvdata(hdev);
>> > > +	struct qca_data *qca = hu->priv;
>> > > +	struct sk_buff *skb;
>> > > +
>> > > +	bt_dev_dbg(hdev, "sending command %02x to SoC", cmd);
>> > > +
>> > > +	skb = bt_skb_alloc(sizeof(cmd), GFP_KERNEL);
>> > > +	if (!skb)
>> > > +		return -ENOMEM;
>> > > +
>> > > +	/* Disabling hardware flow control is mandate while
>> >
>> > Same nit as above
>> >
>> > > +	 * sending vendor power on and off pulse to SoC.
>> > > +	 */
>> >
>> > The function is called qca_send_vendor_cmd(), the comment about power
>> > on/off pulses seems misplaced here. Are there other 'vendor commands'
>> > that require a different flow control behavior?
>> >
>> > Perhaps the function should have a different name or we need another
>> > wrapper.
>> >
>> > > +	hci_uart_set_flow_control(hu, true);
>> >
>> > Should the changing of the flow control be limited to wcn3990? As of
>> > now the function is only called for wcn3990, however this is not
>> > stated as a requirement and might change in the future.
>> >
>> > > +	skb_put_u8(skb, cmd);
>> > > +	hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
>> > > +
>> > > +	skb_queue_tail(&qca->txq, skb);
>> > > +	hci_uart_tx_wakeup(hu);
>> > > +
>> > > +	/* Wait for 100 uS for SoC to settle down */
>> > > +	usleep_range(100, 200);
>> >
>> > Is this needed for any 'vendor command' or directly related with the
>> > power on/off pulses?
>> >
>> > > +	hci_uart_set_flow_control(hu, false);
>> > > +
>> > > +	return 0;
>> > > +}
>> > > +
>> > >  static unsigned int qca_get_speed(struct hci_uart *hu,
>> > >  				  enum qca_speed_type speed_type)
>> > >  {
>> > > @@ -952,10 +1049,19 @@ static unsigned int qca_get_speed(struct
>> > > hci_uart *hu,
>> > >
>> > >  static int qca_check_speeds(struct hci_uart *hu)
>> > >  {
>> > > -	/* One or the other speeds should be non zero. */
>> > > -	if (!qca_get_speed(hu, QCA_INIT_SPEED) &&
>> > > -	    !qca_get_speed(hu, QCA_OPER_SPEED))
>> > > +	struct qca_serdev *qcadev;
>> > > +
>> > > +	qcadev = serdev_device_get_drvdata(hu->serdev);
>> > > +	if ((qcadev->btsoc_type == QCA_WCN3990 &&
>> > > +	    !qca_get_speed(hu, QCA_INIT_SPEED)) ||
>> > > +	    !qca_get_speed(hu, QCA_OPER_SPEED)) {
>> > > +		/* Both INIT and OPER speed should be non zero. */
>> > >  		return -EINVAL;
>> > > +	} else if (!qca_get_speed(hu, QCA_INIT_SPEED) &&
>> > > +		    !qca_get_speed(hu, QCA_OPER_SPEED)) {
>> > > +		/* One or the other speeds should be non zero. */
>> > > +		return -EINVAL;
>> > > +	}
>> >
>> > It is questionable if the comments are useful, they are basically
>> > stating the same as the conditions.
>> >
>> > if-else statements with a single statement in all branches shouldn't
>> > use curly braces. Personally I don't dislike them in this case with
>> > the multi-line conditions, but in principle they shoulnd't be there.
>> >
>> > nit: this would be easier to read with nested if statements:
>> >
>> > 	if (qcadev->btsoc_type == QCA_WCN3990)
>> > 		if (!qca_get_speed(hu, QCA_INIT_SPEED)) ||
>> > 		    !qca_get_speed(hu, QCA_OPER_SPEED))
>> > 			return -EINVAL;
>> > 	else
>> > 		if (!qca_get_speed(hu, QCA_INIT_SPEED) &&
>> > 		    !qca_get_speed(hu, QCA_OPER_SPEED)) {
>> > 			return -EINVAL;
>> >
>> > >  	return 0;
>> > >  }
>> > > @@ -986,15 +1092,40 @@ static int qca_set_speed(struct hci_uart *hu,
>> > > enum qca_speed_type speed_type)
>> > >  	return 0;
>> > >  }
>> > >
>> > > +static int qca_wcn3990_init(struct hci_uart *hu)
>> > > +{
>> > > +	int ret;
>> > > +
>> > > +	ret = qca_send_vendor_cmd(hu->hdev, QCA_WCN3990_POWERON_PULSE);
>> > > +	if (ret)
>> > > +		return ret;
>> > > +
>> > > +	/* Wait for 100 ms for SoC to boot up */
>> > > +	msleep(100);
>> > > +	serdev_device_close(hu->serdev);
>> > > +	ret = serdev_device_open(hu->serdev);
>> > > +	if (ret) {
>> > > +		bt_dev_err(hu->hdev, "failed to open port");
>> > > +		return ret;
>> > > +	}
>> > > +
>> > > +	/* Setup initial baudrate */
>> > > +	qca_set_speed(hu, QCA_INIT_SPEED);
>> >
>> > The comment is a bit redundant.
>> >
>> > > +	hci_uart_set_flow_control(hu, false);
>> > > +
>> > > +	return 0;
>> > > +}
>> > > +
>> > >  static int qca_setup(struct hci_uart *hu)
>> > >  {
>> > >  	struct hci_dev *hdev = hu->hdev;
>> > >  	struct qca_data *qca = hu->priv;
>> > >  	unsigned int speed, qca_baudrate = QCA_BAUDRATE_115200;
>> > > +	struct qca_serdev *qcadev;
>> > >  	int ret;
>> > >  	int soc_ver = 0;
>> > >
>> > > -	bt_dev_info(hdev, "ROME setup");
>> > > +	qcadev = serdev_device_get_drvdata(hu->serdev);
>> > >
>> > >  	ret = qca_check_speeds(hu);
>> > >  	if (ret)
>> > > @@ -1006,6 +1137,21 @@ static int qca_setup(struct hci_uart *hu)
>> > >  	/* Setup initial baudrate */
>> > >  	qca_set_speed(hu, QCA_INIT_SPEED);
>> > >
>> > > +	if (qcadev->btsoc_type == QCA_WCN3990) {
>> > > +		bt_dev_dbg(hdev, "setting up wcn3990");
>> >
>> > Seems like this should be bt_dev_info() for consistency with Rome.
>> >
>> > > +		ret = qca_wcn3990_init(hu);
>> > > +		if (ret)
>> > > +			return ret;
>> > > +
>> > > +		ret = qca_read_soc_version(hdev, &soc_ver);
>> > > +		if (ret < 0 || soc_ver == 0) {
>> > > +			bt_dev_err(hdev, "Failed to get version %d", ret);
>> > > +			return ret;
>> > > +		}
>> > > +	} else {
>> > > +		bt_dev_info(hdev, "ROME setup");
>> > > +	}
>> > > +
>> > >  	/* Setup user speed if needed */
>> > >  	speed = qca_get_speed(hu, QCA_OPER_SPEED);
>> > >  	if (speed) {
>> > > @@ -1016,16 +1162,18 @@ static int qca_setup(struct hci_uart *hu)
>> > >  		qca_baudrate = qca_get_baudrate_value(speed);
>> > >  	}
>> > >
>> > > -	/* Get QCA version information */
>> > > -	ret = qca_read_soc_version(hdev, &soc_ver);
>> > > -	if (ret < 0 || soc_ver == 0) {
>> > > -		bt_dev_err(hdev, "QCA Failed to get version (%d)", ret);
>> > > -		return ret;
>> > > +	if (!soc_ver) {
>> >
>> >
>> > The following would probably be clearer:
>> >
>> >   	if (qcadev->btsoc_type != QCA_WCN3990) {
>> >
>> > > +		/* Get QCA version information */
>> > > +		ret = qca_read_soc_version(hdev, &soc_ver);
>> > > +		if (ret < 0 || soc_ver == 0) {
>> > > +			bt_dev_err(hdev, "QCA Failed to get version (%d)", ret);
>> > > +			return ret;
>> > > +		}
>> > > +		bt_dev_info(hdev, "QCA controller version 0x%08x", soc_ver);
>> >
>> > Couldn't we hide some of this in qca_read_soc_version()?
>> >
>> > qca_read_soc_version() could at least do the logging in the error case
>> > (the 'soc_ver == 0' case could be handled there as well), which would
>> > leave us with:
>> >
>> >
>> > 	ret = qca_read_soc_version(hdev, &soc_ver);
>> > 	if (ret)
>> > 		return ret;
>> >
>> > And the same above.
>> >
>> > The controller version can be logged outside of the branch for both
>> > wcn3990 and Rome.
>> >
>> > >  	}
>> > > -	bt_dev_info(hdev, "QCA controller version 0x%08x", soc_ver);
>> > >
>> > >  	/* Setup patch / NVM configurations */
>> > > -	ret = qca_uart_setup(hdev, qca_baudrate, QCA_ROME, soc_ver);
>> > > +	ret = qca_uart_setup(hdev, qca_baudrate, qcadev->btsoc_type,
>> > > soc_ver);
>> > >  	if (!ret) {
>> > >  		set_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
>> > >  		qca_debugfs_init(hdev);
>> > > @@ -1061,9 +1209,123 @@ static struct hci_uart_proto qca_proto = {
>> > >  	.dequeue	= qca_dequeue,
>> > >  };
>> > >
>> > > +static const struct qca_vreg_data qca_soc_data = {
>> > > +	.soc_type = QCA_WCN3990,
>> > > +	.vregs = (struct qca_vreg []) {
>> > > +		{ "vddio",   1800000, 1800000,  0 },
>> > > +		{ "vddxo",   1800000, 1800000,  1 },
>> > > +		{ "vddrf",   1304000, 1304000,  1 },
>> > > +		{ "vddch0",  3000000, 3312000,  1 },
>> > > +	},
>> > > +	.num_vregs = 4,
>> > > +};
>> >
>> > I didn't chime in earlier in the discussion with Stephen on the
>> > regulators (https://patchwork.kernel.org/patch/10467911/), however I
>> > agree with him that specifying at load of 1uA doesn't seem to make
>> > much sense. What would happen if the load remained unspecified (or 0)?
>> 
>> [Bala]: On RPMh based designs, calling a regulator_set_load with a 
>> non-zero
>> value moves the regulator to NPM (high power mode) which is required 
>> for BT
>> communication.
>>         and call with 0uA  moves it to low-power-mode (vote from 
>> APPS).
>> Basically whenever BT wants these in NPM  it calls set-load with 1.
> 
> This assumes that the chip is powered by RPMh regulators, which
> depending on the system may or may not be true. On systems with other
> regulators you are telling the regulator that the max load is 1uA, and
> the regulator might comply, going in a low power mode that does not
> provide enough current for the chip to operate properly.
> 
> Doesn't the datasheet of the chip specify actual max currents for
> these consumers that could be used instead of the bogus 1uA? If not
> you could ask the designers of the chip for an approximate number
> (preferably erring on the upper side).

[Bala]: yes your true, now current values are aligned according to the 
RPMH regs packages.
         this is not our goal. what ever the package we use wcn3990 
should be platform independent.
         I propose an idea that, we will have default current value in 
driver i.e current required by regs to turn on wcn3990 and also we will 
provide interface in driver
         to read current from dts tree.

        i.e. if we have prop for current to the reg in the dts, we will 
read the value assigned to prop else we will take default current

   <code snippets>

        qca->vreg_data->vregs[i].name = current; // holds the default 
current value taken from data provided from deb. this will value remains 
unchanged.
        if (device_property_read_bool(dev, prop_name))  // if we have 
prop name enabled then read the value.
                 device_property_read_u32(dev, prop_name, 
&vregs->load_uA);


-- 
Regards
Balakrishna.
