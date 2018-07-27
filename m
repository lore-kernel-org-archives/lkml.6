Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E18C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449D12089F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NZQNtLPu";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="frVtIVNC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 449D12089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732042AbeG0NAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:00:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47974 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730970AbeG0NAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:00:36 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EF8FA60594; Fri, 27 Jul 2018 11:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532691544;
        bh=0GeEX/sPXdsIfFlWAW/rNJ6Jn2UaH3v+YhoJnPBVLxI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NZQNtLPuQfbxhsVpYIWfIxTB0+AX932N1sdoAW/kcq7p0Avu0B8rV8TirZr/uYbDt
         xfEgc0jgJa826B63FDVeaPWJFRSU62Y6ra3YGRsJy6ufk7lMNNrlGw7QjfIEigI2+i
         cmUc6nb/aJpCFhUwnsCzGVEksDmY5Dwg8h+qfWT4=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 7E3EC60594;
        Fri, 27 Jul 2018 11:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532691542;
        bh=0GeEX/sPXdsIfFlWAW/rNJ6Jn2UaH3v+YhoJnPBVLxI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=frVtIVNC8qG7OlaD1RmEAJyww206Zh/+7hNlFBgjf/9ahhPYPFyCUcjeSUpZEDQKm
         SDgI/VORrA073EaVEeWNq21Lyp+ZsFFZuQMGA/5zz1qQS4Yyt65WhtC+2NFbGUW25F
         t5cLoSjAqfWUfJ7zQQpndQ8H3P2DO+mEFPy6fvis=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 27 Jul 2018 17:09:02 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v10 7/7] Bluetooth: hci_qca: Add support for Qualcomm
 Bluetooth chip wcn3990
In-Reply-To: <20180726195129.GW129942@google.com>
References: <20180720133243.6851-1-bgodavar@codeaurora.org>
 <20180720133243.6851-8-bgodavar@codeaurora.org>
 <20180723195441.GM129942@google.com>
 <81c324ee9104508cf5c862de3f697e4c@codeaurora.org>
 <20180725183144.GQ129942@google.com>
 <0666f40967de21db9ef3df9d94517ac1@codeaurora.org>
 <20180726195129.GW129942@google.com>
Message-ID: <ba5c7f6cc8ba7c010ccd6c3573a5d234@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2018-07-27 01:21, Matthias Kaehlcke wrote:
> On Thu, Jul 26, 2018 at 07:51:13PM +0530, Balakrishna Godavarthi wrote:
>> Hi Matthias,
>> 
>> On 2018-07-26 00:01, Matthias Kaehlcke wrote:
>> > On Tue, Jul 24, 2018 at 09:25:16PM +0530, Balakrishna Godavarthi wrote:
>> > > Hi Matthias,
>> > >
>> > > On 2018-07-24 01:24, Matthias Kaehlcke wrote:
>> > > > On Fri, Jul 20, 2018 at 07:02:43PM +0530, Balakrishna Godavarthi wrote:
>> > > > > +	 * sometimes we will face communication synchronization issues,
>> > > > > +	 * like reading version command timeouts. In which HCI_SETUP fails,
>> > > > > +	 * to overcome these issues, we try to communicate by performing an
>> > > > > +	 * COLD power OFF and ON.
>> > > > > +	 */
>> > > > > +	for (i = 1; i <= 10 && ret; i++) {
>> > > >
>> > > > Is it really that bad that more than say 3 iterations might be needed?
>> > > >
>> > > [Bala]: will restrict to 3 iterations.
>> >
>> > Is 3x expected to be enough to 'guarantee' as successful
>> > initialization? Just wondered about the 10x since it suddendly changed
>> > from 1x. What is the failure rate without retries?
>> >
>> > Could you provide more information about the 'communication
>> > synchronization issues'? Is the root cause understood? Maybe there is
>> > a better way than retries.
>> >
>> 
>> [Bala]: basically before sending a every patch series we run a stress 
>> test
>> to the driver to detect the bugs.
>>         in recent test results found one interesting bug that BT 
>> setups
>> fails with version request timeouts,
>>         after we do a reboot for the device.
>>         we debugged the issue and found that wcn3900 is not responding 
>> to
>> the version request commands
>>         sent by HOST. this is because before reboot, wcn3990 is in on 
>> state
>> i.e. we are communicating to device.
>>         then we did a reboot and HOST is not sending a power off 
>> request to
>> the regulators to turn off.
>>         so after reboot wcn3990 is still in ON state where it will not
>> respond to version request commands which in turn fails HCI_SETUP.
>>         so we are sending the power off pulse and then sending the 
>> power on
>> pulse.
>>         coming back to 3x or 10x iteration this is to avoid any such
>> synchronization issues.
>>         i agreed for 3x because of stress test results. we have 
>> success rate
>> of 99% for single iteration, where as 3x iterations will helps to 
>> handle 1%
>> fails cases.
> 
> Thanks for the clarification. Couldn't you assure the device is in a
> defined state by calling qca_power_shutdown() as one of the first
> things in qca_wcn3990_init()?

[Bala]:  we have reasons behind writing qca_power_setup(true) at the 
start.

         1. the reason to add iteration here, is to handle BT fails cases 
either due to communication failure of wcn3900 or due to regulator 
issues.
            before calling qca_setup(), we have our regulator turned on 
and in qca_setup i.e. init routine if we added power_shutdown as first 
statement before
            communicating with chip then regulator will be off and again 
we need to call function to ON regulators.
            so it could be some thing like this

            init(){

                for () {
                      shutdown() // regs are off
                      poweron(true) // regs are on.
                      if(!start communicating with chip()) {
                         break;
                       }

                }
            }
            as the reason to add the iteration handling is to overcome 1% 
of fail cases, so every time when we call it will turn off the regs and 
turn it back. which require an turning in off regs and on it back for 
99% pass
             cases.

         2. this is the one of the main reason for adding 
qca_power_setup(true) in the init() function first.
            as we know that power management is so critical for long 
lasting of battery.
            now present implementation is when we off BT from UI i.e. 
hci0 down, we put BT into an suspend or low power mode, as soon as we 
turn ON the BT back from UI we make hci0 up.
            the above is putting device into suspend state and bring it 
back where the regulator are still on state. so we will have leakage 
currents which can be minimal or may be in few mA.
            to over come the above case, we want to do an cold on/off for 
BT chip wcn3990. i.e. when bt is off from UI, we will off the regulators 
and turn on it again once the BT is ON from UI.
            every time we disable i.e. off BT from UI we will call 
hdev->shutdown() i.e. completely powering off the chip.
            so it require an reprogram again, when we turn ON BT from UI. 
it will call qca_setup()--> init().. so here actually qca_power_on(true) 
will turn on the chip and dump the fw files into it.
            so that is also a reason behind to write power on first.

            the above feature is under testing state, will post a patch 
series once the driver code merged to bt-next.

> 
> Some more comments on the functions, for if the retry loop is kept:
> 
>> +static int qca_wcn3990_init(struct hci_uart *hu, u32 *soc_ver)
>> +{
>> +	struct hci_dev *hdev = hu->hdev;
>> +	int i, ret = 1;
>> +
>> +	/* WCN3990 is a discrete Bluetooth chip connected to APPS processor.
>> +	 * sometimes we will face communication synchronization issues,
>> +	 * like reading version command timeouts. In which HCI_SETUP fails,
>> +	 * to overcome these issues, we try to communicate by performing an
>> +	 * COLD power OFF and ON.
>> +	 */
>> +	for (i = 1; i <= 10 && ret; i++) {
>> +		/* This helper will turn ON chip if it is powered off.
>> +		 * if the chip is already powered ON, function call will
>> +		 * return zero.
>> +		 */
>> +		ret = qca_power_setup(hu, true);
>> +		if (ret)
>> +			goto regs_off;
> 
> A failure here is not caused by a communication problem, so this
> should probably be a 'return' instead of a 'goto'.
> 

[Bala]: yes you are true, but if any chance we have issue with regulator 
to turn on, we try to turn on them again.
        so that HCI_SETUP should not fail.

>> +
>> +		/* Forcefully enable wcn3990 to enter in to boot mode. */
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
> 
> 			return ret;
> 
>> +		}
>  > +
>> +		hci_uart_set_flow_control(hu, false);
>> +		ret = qca_read_soc_version(hdev, soc_ver);
>> +		if (ret < 0 || soc_ver == 0)
>> +			bt_dev_err(hdev, "Failed to get version:%d", ret);
> 
> nit: add a space between ':' and '%d'
> 

[Bala]: will update.

>> +
>> +		if (!ret)
>> +			break;
> 
> 			return 0;
> 
>> +
>> +regs_off:
>> +		bt_dev_err(hdev, "retrying to establish communication: %d", i);
>> +		qca_power_shutdown(hdev);
> 
> Is qca_power_shutdown() needed or would qca_power_setup(hu,
> false) be enough? This is qca_power_shutdown():
> 

[Bala]: qca_power_shutdown is needed, as we need to send power pulse at 
2400 bps before turning off the soc.
         this is an complete turn off BT portion in wcn3990.

> static int qca_power_shutdown(struct hci_dev *hdev)
> {
>         struct hci_uart *hu = hci_get_drvdata(hdev);
> 
>         host_set_baudrate(hu, 2400);
>         qca_send_vendor_pulse(hdev, QCA_WCN3990_POWEROFF_PULSE);
>         return qca_power_setup(hu, false);
> }
> 
> It additionally sends the power off pulse, which is also done in the
> loop (though it is currently called QCA_WCN3990_FORCE_BOOT_PULSE).
> 
> The code flow with the gotos and the error handling at the end of the
> loop is a bit messy. Moving the power down to the top of the loop
> (basically in line with my comment above to get rid of the loop) would
> help here. In this case checking 'ret' in the loop condition (which I
> suggested to remove) would make sense, since it elimninates the need
> for the break/return in the success case. But if we can do without the
> loop even better :)
> 

[Bala]: there is a reason to add the loop here, here we go with reason 
to add.
         let us assume that qca_setup fails to establish a communication 
with wcn3990
         then next steps will not be pass and we can't populate hci0 
rfkill entry.
         in traditional bluez stack i.e. bluetoothd daemon will looks for 
hci0, if we have entry for hci0
         then only BT option is visible in UI or else BT option will not 
be available in UI.
         we don't have any mechanism handled in bluez user space to 
reinitiate the communication at latest to try for second time to make 
hci0 up.
         so that is reason behind to add so that we can handle fault 
handling of wcn3990 and establish the communication to make BT option 
available in BT.

>> > If I understand correctly you describe a hypothetical situation of a
>> > future wcn3990 variant having lower power requirements. I'd say let's
>> > deal with this when these chips actually exist and need to be
>> > supported by Linux. As of now it seems there is no need for current
>> > limits in the DT.
>> >
>> 
>> [Bala]: will remove current property for dts.
>>         in previous mail you asked me a question for currents
>>         "The currents of 300mA and 450mA seem high for Bluetooth, I'm 
>> not an
>>          expert in this area though, they might be reasonable peak 
>> currents
>> for
>>          certain use cases."
>> 
>>          yes we require 450mA and 300mA of current for rf and ch0 
>> pins.
>> setting regulator to required load will not pump load current to 
>> wcn3990
>>         it depends on operations, typical the above are the max 
>> current
>> drawn by the two pins.
> 
> Ok, thanks for confirming.

Pls let me know if you require more info :)

-- 
Regards
Balakrishna.
