Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D08ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59DDE20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eG6t7zXB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YedJG4fw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59DDE20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388510AbeGXRC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:02:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52258 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388409AbeGXRC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:02:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D62206055D; Tue, 24 Jul 2018 15:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532447717;
        bh=9m1UGGXd/f/tueyQjOk08tf5ke8QThlU1S/YZRmPfPQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eG6t7zXBNFXcsT0RliCaeBGItXBi1qJHHx2PAwFHBPWeZaSdImuAX5kfblQDr1A1d
         NOaa8PB65rWwKtSO1wrl5ckH0oHogvsqoSQz7GY0ft2UlLeYI7QvJx7XfrSV8CFDwq
         IwAN0lwt+a75+ZZXicxVz3/EZIFO7sEcMAF/9lf0=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 12AE66055D;
        Tue, 24 Jul 2018 15:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532447716;
        bh=9m1UGGXd/f/tueyQjOk08tf5ke8QThlU1S/YZRmPfPQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YedJG4fwI+4c5wvFxSmL1/2H7At/34T4OO2M0s1d218IuFUA2CpusVr+K5efe0iC8
         brCpnhs6uTCLln+SIFlRdJ8vU+X64fLYIyluaYe+cuCvyMw10TKIq7YYWEUkLaBOr1
         WO/gTayMGtgtacQ7SfmSCigRaogAisKc8UAUCR5o=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 24 Jul 2018 21:25:16 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v10 7/7] Bluetooth: hci_qca: Add support for Qualcomm
 Bluetooth chip wcn3990
In-Reply-To: <20180723195441.GM129942@google.com>
References: <20180720133243.6851-1-bgodavar@codeaurora.org>
 <20180720133243.6851-8-bgodavar@codeaurora.org>
 <20180723195441.GM129942@google.com>
Message-ID: <81c324ee9104508cf5c862de3f697e4c@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2018-07-24 01:24, Matthias Kaehlcke wrote:
> On Fri, Jul 20, 2018 at 07:02:43PM +0530, Balakrishna Godavarthi wrote:
>> Add support to set voltage/current of various regulators
>> to power up/down Bluetooth chip wcn3990.
>> 
>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> ---
>> changes in v10:
>>     * added support to read regulator currents from dts.
> 
> I commented on this below
> 
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
>> 
>> ---
>>  drivers/bluetooth/btqca.h   |   4 +
>>  drivers/bluetooth/hci_qca.c | 481 
>> ++++++++++++++++++++++++++++++++----
>>  2 files changed, 439 insertions(+), 46 deletions(-)
>> 
>> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
>> index a9c2779f3e07..9e2bbcf5c002 100644
>> --- a/drivers/bluetooth/btqca.h
>> +++ b/drivers/bluetooth/btqca.h
>> @@ -37,6 +37,10 @@
>>  #define EDL_TAG_ID_HCI			(17)
>>  #define EDL_TAG_ID_DEEP_SLEEP		(27)
>> 
>> +#define QCA_WCN3990_POWERON_PULSE	0xFC
>> +#define QCA_WCN3990_POWEROFF_PULSE	0xC0
>> +#define QCA_WCN3990_FORCE_BOOT_PULSE	0xC0
> 
> This is the same value as QCA_WCN3990_POWEROFF_PULSE. From the usage
> it seems it's really just a power off pulse, so let's stick to this
> name, instead of having two names for the same thing.
> 
[Bala] : will update.

>> +static int qca_send_vendor_pulse(struct hci_dev *hdev, u8 cmd)
> 
> My understanding from earlier discussion is that these pulses are
> limited to power on/off. If that is correct this should probably be
> called qca_send_power_pulse().
> 
[Bala]: will update the function name to qca_send_power_pulse().

>> +{
>> +	struct hci_uart *hu = hci_get_drvdata(hdev);
>> +	struct qca_data *qca = hu->priv;
>> +	struct sk_buff *skb;
>> +
>> +	/* These vendor pulses are single byte command which are sent
>> +	 * at required baudrate to WCN3990. on WCN3990, we have an external
> 
> s/on/On/
[Bala]: will update.

> 
>> +	 * circuit at Tx pin which decodes the pulse sent at specific 
>> baudrate.
>> +	 * For example, as WCN3990 supports RF COEX frequency for both 
>> Wi-Fi/BT
>> +	 * and also, we use the same power inputs to turn ON and OFF for
> 
> nit: not sure how much value is added by (sometimes) using upper case
> for certain things (ON, OFF, COLD, HOST, ...).
> 
[Bala] : will use lower case.

>> +	 * Wi-Fi/BT. Powering up the power sources will not enable BT, until
>> +	 * we send a POWER ON pulse at 115200. This algorithm will help to
> 
> 115200 what? bps I guess.
> 
[Bala] : will add bps.

>> +static int qca_wcn3990_init(struct hci_uart *hu, u32 *soc_ver)
>> +{
>> +	struct hci_dev *hdev = hu->hdev;
>> +	int i, ret = 1;
> 
> Initialization not necessary, more details below.
> 
>> +
>> +	/* WCN3990 is a discrete Bluetooth chip connected to APPS processor.
> 
> APPS is a Qualcomm specific term, and some QCA docs also call it
> APSS. Just say 'SoC' which is universally understood.
> 
[Bala]: will update to SoC.

>> +	 * sometimes we will face communication synchronization issues,
>> +	 * like reading version command timeouts. In which HCI_SETUP fails,
>> +	 * to overcome these issues, we try to communicate by performing an
>> +	 * COLD power OFF and ON.
>> +	 */
>> +	for (i = 1; i <= 10 && ret; i++) {
> 
> Is it really that bad that more than say 3 iterations might be needed?
> 
[Bala]: will restrict to 3 iterations.

> Common practice is to start loops with index 0.
> 

[Bala] : will init i=0

> The check for ret is not needed. All jumps to 'regs_off' are done
> when an error is detected. The loop is left when 'ret == 0' at the
> bottom.
> 
[Bala]: will update.

>> +		/* This helper will turn ON chip if it is powered off.
>> +		 * if the chip is already powered ON, function call will
>> +		 * return zero.
>> +		 */
> 
> Comments are great when they add value, IMO this one doesn't and just
> adds distraction. Most readers will assume that after
> qca_power_setup(hu, true) the chip is powered on, regardless of the
> previous power state.
> 
[Bala] : will remove the comment.

>> +		ret = qca_power_setup(hu, true);
>> +		if (ret)
>> +			goto regs_off;
>> +
>> +		/* Forcefully enable wcn3990 to enter in to boot mode. */
> 
> nit: Sometimes the comments and logs name the chip wcn3990, others
> WCN3990. Personally I don't care which spelling is used, but please be
> consistent.
> 
[Bala]: will use "wcn3990" through our the code.

>> +		host_set_baudrate(hu, 2400);
>> +		ret = qca_send_vendor_pulse(hdev, QCA_WCN3990_FORCE_BOOT_PULSE);
>> +		if (ret)
>> +			goto regs_off;
>> +
>> +		qca_set_speed(hu, QCA_INIT_SPEED);
>> +		ret = qca_send_vendor_pulse(hdev, QCA_WCN3990_POWERON_PULSE);
>> +		if (ret)
>> +			goto regs_off;
>> +
>> +		/* Wait for 100 ms for SoC to boot */
>> +		msleep(100);
>> +
>> +		/* Now the device is in ready state to communicate with host.
>> +		 * To sync HOST with device we need to reopen port.
>> +		 * Without this, we will have RTS and CTS synchronization
>> +		 * issues.
>> +		 */
>> +		serdev_device_close(hu->serdev);
>> +		ret = serdev_device_open(hu->serdev);
>> +		if (ret) {
>> +			bt_dev_err(hu->hdev, "failed to open port");
>> +			break;
>> +		}
>> +
>> +		hci_uart_set_flow_control(hu, false);
>> +		ret = qca_read_soc_version(hdev, soc_ver);
>> +		if (ret < 0 || soc_ver == 0)
>> +			bt_dev_err(hdev, "Failed to get version:%d", ret);
> 
> The check for soc_ver is/should be done in qca_read_soc_version(),
> same for the error log.
> 
[Bala]: will remove the check here.

>> +		if (!ret)
>> +			break;
>> +
>> +regs_off:
>> +		bt_dev_err(hdev, "retrying to establish communication: %d", i);
> 
> Use i + 1 if starting the loop at 0.
> 

[Bala] : will update.

>> +static const struct qca_vreg_data qca_soc_data = {
>> +	.soc_type = QCA_WCN3990,
>> +	.vregs = (struct qca_vreg []) {
>> +		{ "vddio",   1800000, 1800000,  15000  },
>> +		{ "vddxo",   1800000, 1800000,  80000  },
>> +		{ "vddrf",   1304000, 1304000,  300000 },
>> +		{ "vddch0",  3000000, 3312000,  450000 },
>> +	},
> 
> The currents of 300mA and 450mA seem high for Bluetooth, I'm not an
> expert in this area though, they might be reasonable peak currents for
> certain use cases.
> 

[Bala]: rf and ch0 are required for rf antenna of wcn3990. will double 
confirm on this.

>> +static int qca_power_shutdown(struct hci_dev *hdev)
>> +{
>> +	struct hci_uart *hu = hci_get_drvdata(hdev);
>> +
>> +	host_set_baudrate(hu, 2400);
>> +	qca_send_vendor_pulse(hdev, QCA_WCN3990_POWEROFF_PULSE);
>> +	return qca_power_setup(hu, false);
>> +}
> 
> The return value changed from void to int, but nobody ever checks it 
> ...
> 
[Bala] : will update.

>> +static void qca_regulator_get_current(struct device *dev,
>> +				      struct qca_vreg *vregs)
>> +{
>> +	char prop_name[32]; /* 32 is max size of property name */
>> +
>> +	/* We have different platforms where the load value is controlled
>> +	 * via PMIC controllers. In such cases load required to power ON
>> +	 * Bluetooth chips are defined in the PMIC. We have option to set
>> +	 * operation mode like high or low power modes.
>> +	 * We do have some platforms where driver need to enable the load 
>> for
>> +	 * WCN3990. Based on the current property value defined for the
>> +	 * regulators, driver will decide the regulator output load.
>> +	 * If the current property for the regulator is defined in the dts
>> +	 * we will read from dts tree, else from the default load values.
>> +	 */
> 
> Let's make sure we all really understand why this is needed. You
> mentioned RPMh regulators earlier and said a special value of 1uA
> would be needed to enable high power mode. Later when I pointed to the
> RPMh regulator code you agreed that this special value wouldn't make
> any difference.
> 
> Now the defaults are higher:
> 
[Bala]: today i got the info from the power teams here, currently in the 
downstream what we have is different wrt to the
         patch "https://patchwork.kernel.org/patch/10524299/" by David 
Collins.
         prior to his patch we have different architecture where 1uA will 
change the mode to HPM mode.
         which is not valid, so 1uA will not work any more. we have go 
with actual current values.

         coming back to reading current values from dts. we have reason 
for it.
         let us assume that later stages of wcn3990 if we have less 
current values than default values.
         instead of updating the driver again, we can assign the current 
no in the dts, which we will read.

         This is how it works.

         if(current value for the reg is declared in dts tree)
               consider the current value from the dts.
         else
            go with default value.

       pls let me know if you any queries.

>> +		{ "vddio",   1800000, 1800000,  15000  },
>> +		{ "vddxo",   1800000, 1800000,  80000  },
>> +		{ "vddrf",   1304000, 1304000,  300000 },
>> +		{ "vddch0",  3000000, 3312000,  450000 },
> 
> What would supposedly go wrong if these values were passed to one of
> the PMICs you are concerned about? Please be more specific than the
> above comment.
> 

>> +	snprintf(prop_name, 32, "%s-current", vregs->name);
>> +	BT_DBG("Looking up %s from device tree\n", prop_name);
> 
> '\n' not needed with BT_DBG()
> 
[Bala]: will update.
>> +
>> +	if (device_property_read_bool(dev, prop_name))
>> +		device_property_read_u32(dev, prop_name, &vregs->load_uA);
> 
> Why device_property_read_bool()?
> 
[Bala]: if the current prop is present we read from dts. else we go with 
default current no's.
         if block  is used to check whether the property is present in 
dts or not.
         this is required because before calling _regualtor_get_current() 
we hold the default current in the vregs[].
         if we skip the read bool here, if the current property is not 
present then the function call of device_property_read_u32() will assign 
zero the vregs[].
         so we miss the default current values.

         this how it work if we miss read_bool check

         //vregs hold default current
          device_property_read_u32(dev, prop_name, &vregs->load_uA);
          the above will read the current property value from dts store 
in the vregs.. if the property is missing in dts it will store zero.

>> +	BT_DBG("current %duA selected for regulator %s", vregs->load_uA,
>> +		vregs->name);
>> +}
>> +
>> +static int qca_init_regulators(struct qca_power *qca,
>> +				const struct qca_vreg_data *data)
>> +{
>> +	int i, num_vregs;
>> +	int load_uA;
>> +
>> +	num_vregs = data->num_vregs;
>> +	qca->vreg_bulk = devm_kzalloc(qca->dev, num_vregs *
>> +				      sizeof(struct regulator_bulk_data),
>> +				      GFP_KERNEL);
>> +	if (!qca->vreg_bulk)
>> +		return -ENOMEM;
>> +
>> +	qca->vreg_data = devm_kzalloc(qca->dev, sizeof(struct 
>> qca_vreg_data),
>> +				      GFP_KERNEL);
>> +	if (!qca->vreg_data)
>> +		return -ENOMEM;
>> +
>> +	qca->vreg_data->num_vregs = data->num_vregs;
>> +	qca->vreg_data->soc_type = data->soc_type;
>> +
>> +	qca->vreg_data->vregs = devm_kzalloc(qca->dev, num_vregs *
>> +				      sizeof(struct qca_vreg_data),
> 
> sizeof(struct qca_vreg)
> 
>> +				      GFP_KERNEL);
>> +
>> +	if (!qca->vreg_data->vregs)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < num_vregs; i++) {
>> +		/* copy regulator name, min voltage, max voltage */
>> +		qca->vreg_data->vregs[i].name = data->vregs[i].name;
>> +		qca->vreg_data->vregs[i].min_uV = data->vregs[i].min_uV;
>> +		qca->vreg_data->vregs[i].max_uV = data->vregs[i].max_uV;
>> +		load_uA = data->vregs[i].load_uA;
>> +		qca->vreg_data->vregs[i].load_uA = load_uA;
> 
> memcpy(&qca->vreg_data->vregs[i], &data->vregs[i]); ?
> 
> Or do it outside of the loop for all regulators at once.
> 
[Bala] : will use memcpy

>>  static int qca_serdev_probe(struct serdev_device *serdev)
>>  {
>>  	struct qca_serdev *qcadev;
>> +	const struct qca_vreg_data *data;
>>  	int err;
>> 
>>  	qcadev = devm_kzalloc(&serdev->dev, sizeof(*qcadev), GFP_KERNEL);
>> @@ -1069,47 +1418,87 @@ static int qca_serdev_probe(struct 
>> serdev_device *serdev)
>>  		return -ENOMEM;
>> 
>>  	qcadev->serdev_hu.serdev = serdev;
>> +	data = of_device_get_match_data(&serdev->dev);
>>  	serdev_device_set_drvdata(serdev, qcadev);
>> +	if (data && data->soc_type == QCA_WCN3990) {
>> +		qcadev->btsoc_type = QCA_WCN3990;
>> +		qcadev->bt_power = devm_kzalloc(&serdev->dev,
>> +						sizeof(struct qca_power),
>> +						GFP_KERNEL);
>> +		if (!qcadev->bt_power)
>> +			return -ENOMEM;
>> +
>> +		qcadev->bt_power->dev = &serdev->dev;
>> +		err = qca_init_regulators(qcadev->bt_power, data);
>> +		if (err) {
>> +			BT_ERR("Failed to init regulators:%d", err);
>> +			goto out;
>> +		}
>> 
>> -	qcadev->bt_en = devm_gpiod_get(&serdev->dev, "enable",
>> -				       GPIOD_OUT_LOW);
>> -	if (IS_ERR(qcadev->bt_en)) {
>> -		dev_err(&serdev->dev, "failed to acquire enable gpio\n");
>> -		return PTR_ERR(qcadev->bt_en);
>> -	}
>> +		qcadev->bt_power->vregs_on = false;
>> 
>> -	qcadev->susclk = devm_clk_get(&serdev->dev, NULL);
>> -	if (IS_ERR(qcadev->susclk)) {
>> -		dev_err(&serdev->dev, "failed to acquire clk\n");
>> -		return PTR_ERR(qcadev->susclk);
>> -	}
>> +		/* Read max speed supported by wcn3990 from dts
>> +		 * tree. if max-speed property is not enabled in
>> +		 * dts, QCA driver will use default operating speed
>> +		 * from proto structure.
>> +		 */
> 
> The comment doesn't add much value.

[Bala]: will remove the comment.

> 
>> +		device_property_read_u32(&serdev->dev, "max-speed",
>> +					 &qcadev->oper_speed);
>> +		if (!qcadev->oper_speed)
>> +			BT_INFO("UART will pick default operating speed");
> 
> Not a change in this version, but BT_INFO seems a bit verbose, we
> should avoid spamming the kernel log.
[Bala] : will move above BT_INFO to BT_DBG.

Thanks for reviewing the patch. Pls let me know if you have quires.
will send v11 with updated comments

-- 
Regards
Balakrishna.
