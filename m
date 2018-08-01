Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6656C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8746820894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LVyrba1n";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UaWyOla4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8746820894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389496AbeHAPpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 11:45:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56214 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389266AbeHAPpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 11:45:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6910860708; Wed,  1 Aug 2018 13:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533131970;
        bh=EQWN2PceHv5SxSpdVfQY/IFyNWe1j9wUdm0PLHzCUDQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LVyrba1nLgh1dRHUwbD8HBgX8/qVnoiuGNNsGZBNiyrbfREsvj23LnkHvs5rcrc3E
         cRXCK+7xoaqhV8961h3dRnNd/A4LGHkEHpHr4xbwMf5F06Rfbcuuaml1pYpxdtTIPM
         VUjyHNm2f3xcUTZcKYvAHM63DswqCyLMbPDNVw/A=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 0B7F2606CF;
        Wed,  1 Aug 2018 13:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533131969;
        bh=EQWN2PceHv5SxSpdVfQY/IFyNWe1j9wUdm0PLHzCUDQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UaWyOla46Gc8h81E/EkQG+wn0+ORvYgIJGqsQr3mGuX5uc+Y7EM6RDx82ExkOOl8R
         X9QQSu3dlBiUCsGhwW6tNtBiSlok7Zq2n+j/1KqRVJ8TnTdl0nr04TtfYxOtegBFBz
         bYomOfdVir7UDZ1Q9EZ4ijg0smSp6uY5NFiY0dc8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 01 Aug 2018 19:29:29 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v10 7/7] Bluetooth: hci_qca: Add support for Qualcomm
 Bluetooth chip wcn3990
In-Reply-To: <20180731160321.GD68975@google.com>
References: <20180720133243.6851-1-bgodavar@codeaurora.org>
 <20180720133243.6851-8-bgodavar@codeaurora.org>
 <20180723195441.GM129942@google.com>
 <81c324ee9104508cf5c862de3f697e4c@codeaurora.org>
 <20180725183144.GQ129942@google.com>
 <0666f40967de21db9ef3df9d94517ac1@codeaurora.org>
 <20180726195129.GW129942@google.com>
 <ba5c7f6cc8ba7c010ccd6c3573a5d234@codeaurora.org>
 <20180730200703.GB68975@google.com>
 <5870107568955802c024f0a67c86ea8f@codeaurora.org>
 <20180731160321.GD68975@google.com>
Message-ID: <b28d946b9926beb009815923beb00322@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2018-07-31 21:33, Matthias Kaehlcke wrote:
> On Tue, Jul 31, 2018 at 08:08:40PM +0530, Balakrishna Godavarthi wrote:
>> Hi Matthias,
>> 
>> On 2018-07-31 01:37, Matthias Kaehlcke wrote:
>> > On Fri, Jul 27, 2018 at 05:09:02PM +0530, Balakrishna Godavarthi wrote:
>> > > Hi Matthias,
>> > >
>> > > On 2018-07-27 01:21, Matthias Kaehlcke wrote:
>> > > > On Thu, Jul 26, 2018 at 07:51:13PM +0530, Balakrishna Godavarthi wrote:
>> > > > > Hi Matthias,
>> > > > >
>> > > > > On 2018-07-26 00:01, Matthias Kaehlcke wrote:
>> > > > > > On Tue, Jul 24, 2018 at 09:25:16PM +0530, Balakrishna Godavarthi wrote:
>> > > > > > > Hi Matthias,
>> > > > > > >
>> > > > > > > On 2018-07-24 01:24, Matthias Kaehlcke wrote:
>> > > > > > > > On Fri, Jul 20, 2018 at 07:02:43PM +0530, Balakrishna Godavarthi wrote:
>> > > > > > > > > +	 * sometimes we will face communication synchronization issues,
>> > > > > > > > > +	 * like reading version command timeouts. In which HCI_SETUP fails,
>> > > > > > > > > +	 * to overcome these issues, we try to communicate by performing an
>> > > > > > > > > +	 * COLD power OFF and ON.
>> > > > > > > > > +	 */
>> > > > > > > > > +	for (i = 1; i <= 10 && ret; i++) {
>> > > > > > > >
>> > > > > > > > Is it really that bad that more than say 3 iterations might be needed?
>> > > > > > > >
>> > > > > > > [Bala]: will restrict to 3 iterations.
>> > > > > >
>> > > > > > Is 3x expected to be enough to 'guarantee' as successful
>> > > > > > initialization? Just wondered about the 10x since it suddendly changed
>> > > > > > from 1x. What is the failure rate without retries?
>> > > > > >
>> > > > > > Could you provide more information about the 'communication
>> > > > > > synchronization issues'? Is the root cause understood? Maybe there is
>> > > > > > a better way than retries.
>> > > > > >
>> > > > >
>> > > > > [Bala]: basically before sending a every patch series we run a
>> > > > > stress test
>> > > > > to the driver to detect the bugs.
>> > > > >         in recent test results found one interesting bug that BT
>> > > > > setups
>> > > > > fails with version request timeouts,
>> > > > >         after we do a reboot for the device.
>> > > > >         we debugged the issue and found that wcn3900 is not
>> > > > > responding to
>> > > > > the version request commands
>> > > > >         sent by HOST. this is because before reboot, wcn3990 is in
>> > > > > on state
>> > > > > i.e. we are communicating to device.
>> > > > >         then we did a reboot and HOST is not sending a power off
>> > > > > request to
>> > > > > the regulators to turn off.
>> > > > >         so after reboot wcn3990 is still in ON state where it will not
>> > > > > respond to version request commands which in turn fails HCI_SETUP.
>> > > > >         so we are sending the power off pulse and then sending the
>> > > > > power on
>> > > > > pulse.
>> > > > >         coming back to 3x or 10x iteration this is to avoid any such
>> > > > > synchronization issues.
>> > > > >         i agreed for 3x because of stress test results. we have
>> > > > > success rate
>> > > > > of 99% for single iteration, where as 3x iterations will helps to
>> > > > > handle 1%
>> > > > > fails cases.
>> > > >
>> > > > Thanks for the clarification. Couldn't you assure the device is in a
>> > > > defined state by calling qca_power_shutdown() as one of the first
>> > > > things in qca_wcn3990_init()?
>> > >
>> > > [Bala]:  we have reasons behind writing qca_power_setup(true) at the
>> > > start.
>> > >
>> > >         1. the reason to add iteration here, is to handle BT fails
>> > > cases
>> > > either due to communication failure of wcn3900 or due to regulator
>> > > issues.
>> > >            before calling qca_setup(), we have our regulator turned
>> > > on and
>> > > in qca_setup i.e. init routine if we added power_shutdown as first
>> > > statement
>> > > before
>> > >            communicating with chip then regulator will be off and
>> > > again we
>> > > need to call function to ON regulators.
>> > >            so it could be some thing like this
>> > >
>> > >            init(){
>> > >
>> > >                for () {
>> > >                      shutdown() // regs are off
>> > >                      poweron(true) // regs are on.
>> > >                      if(!start communicating with chip()) {
>> > >                         break;
>> > >                       }
>> > >
>> > >                }
>> > >            }
>> > >            as the reason to add the iteration handling is to
>> > > overcome 1% of
>> > > fail cases, so every time when we call it will turn off the regs and
>> > > turn it
>> > > back. which require an turning in off regs and on it back for 99% pass
>> > >             cases.
>> >
>> > But would turning off the regs really add a significant delay here?
>> > The setup is already really slow, with a 100ms delay in the
>> > loop (still wonder if booting the chip without loading firmware really
>> > takes that long) and later the firmware is loaded.
>> >
>> [Bala]: By default we will have an firmware loaded in ROM of wcn3990, 
>> 100 ms
>> delay will help wcn3990 boot up with default firmware.
> 
> Ok, thanks.
> 
>>         Once it is booted up with default firmware on ROM, we will 
>> download
>> the firmware from the firmware files, these firmware files
>>         contains bug fixes of wcn3990. Once the firmware files are 
>> loaded we
>> will send the reset command to wcn3990.
>>         wcn3990 will start working with latest firmware which is 
>> loaded.
>> 
>> > If the chip needs to be in a defined state we should make sure to put
>> > in into that state, unless there is a significant overhead wrt 'try
>> > first and only reset in case of failure'. As a nice side effect the
>> > code would be cleaner and we probably could get rid of the loop
>> > completely, since it's supposed to address the case where the chip
>> > wasn't properly reset on a reboot.
>> >
>> 
>> [Bala]: i too agree with you, Now we have observed issue because of 
>> reboot.
>> But let us take a real time example here.
>>         if clocks of UART are not stable or there is an issue of UART 
>> GPIO's
>> or some thing related might have broken in UART. Then will have
>> communication issues with BT chip.
>>         where HCI_SETUP fails, instead of giving a fails status, we 
>> are
>> trying to communicate once again and these is also be in 1% of fail 
>> cases.
> 
> If there are issues with unstable clocks, GPIOs or similar the problem
> should be fixed at it's root, instead of papering over it in the BT
> driver. Kernel drivers would be a complete mess if they tried to
> recover from all possible problems in other subsystems.
> 
> I don't have general objections agains a retry loop when it is really
> needed, but I don't have the impressions this is the case here. If
> your stress tests reveal problems that can't be addresses otherwise
> please let us know and we might end up with the retry loop after all.
> 
[Bala]: current results point out failures cases only while reboot.
         if we have any issue that causes the problem of BT failure then 
we will add
         the loop. For now we will go with out retry loop :)

>> > >         2. this is the one of the main reason for adding
>> > > qca_power_setup(true) in the init() function first.
>> > >            as we know that power management is so critical for long
>> > > lasting
>> > > of battery.
>> > >            now present implementation is when we off BT from UI i.e.
>> > > hci0
>> > > down, we put BT into an suspend or low power mode, as soon as we
>> > > turn ON the
>> > > BT back from UI we make hci0 up.
>> > >            the above is putting device into suspend state and bring
>> > > it back
>> > > where the regulator are still on state. so we will have leakage
>> > > currents
>> > > which can be minimal or may be in few mA.
>> > >            to over come the above case, we want to do an cold on/off
>> > > for BT
>> > > chip wcn3990. i.e. when bt is off from UI, we will off the
>> > > regulators and
>> > > turn on it again once the BT is ON from UI.
>> > >            every time we disable i.e. off BT from UI we will call
>> > > hdev->shutdown() i.e. completely powering off the chip.
>> > >            so it require an reprogram again, when we turn ON BT from
>> > > UI. it
>> > > will call qca_setup()--> init().. so here actually
>> > > qca_power_on(true) will
>> > > turn on the chip and dump the fw files into it.
>> > >            so that is also a reason behind to write power on first.
>> > >
>> > >            the above feature is under testing state, will post a patch
>> > > series once the driver code merged to bt-next.
>> >
>> > Thanks for the info.
>> >
>> > If I understand correctly what you describe isn't incompatible with
>> > performing a proper reset. 'vregs_on' can be checked to avoid
>> > disabling already disabled regulators:
>> >
>> >   if (qcadev->bt_power->vregs_on)
>> >           qca_power_shutdown(hdev);
>> >
>> >   // short delay needed here?
>> >
>> >   qca_power_setup(hu, true);
>> >
>> > Unless there are drawbacks that I'm missing I think that's preferable
>> > over the retry loop.
>> >
>> > > > The code flow with the gotos and the error handling at the end of the
>> > > > loop is a bit messy. Moving the power down to the top of the loop
>> > > > (basically in line with my comment above to get rid of the loop) would
>> > > > help here. In this case checking 'ret' in the loop condition (which I
>> > > > suggested to remove) would make sense, since it elimninates the need
>> > > > for the break/return in the success case. But if we can do without the
>> > > > loop even better :)
>> > > >
>> > >
>> > > [Bala]: there is a reason to add the loop here, here we go with
>> > > reason to
>> > > add.
>> > >         let us assume that qca_setup fails to establish a
>> > > communication with
>> > > wcn3990
>> > >         then next steps will not be pass and we can't populate hci0
>> > > rfkill
>> > > entry.
>> > >         in traditional bluez stack i.e. bluetoothd daemon will looks
>> > > for
>> > > hci0, if we have entry for hci0
>> > >         then only BT option is visible in UI or else BT option will
>> > > not be
>> > > available in UI.
>> > >         we don't have any mechanism handled in bluez user space to
>> > > reinitiate the communication at latest to try for second time to
>> > > make hci0
>> > > up.
>> > >         so that is reason behind to add so that we can handle fault
>> > > handling
>> > > of wcn3990 and establish the communication to make BT option
>> > > available in
>> > > BT.
>> >
>> > The loop is supposed to address the following case (quoting you from
>> > earlier discussion in the thread):
>> >
>> > > found one interesting bug that BT setups fails with version request
>> > > timeouts, after we do a reboot for the device. we debugged the issue
>> > > and found that wcn3900 is not responding to the version request
>> > > commands sent by HOST. this is because before reboot, wcn3990 is in
>> > > on state i.e. we are communicating to device. then we did a reboot
>> > > and HOST is not sending a power off request to the regulators to
>> > > turn off. so after reboot wcn3990 is still in ON state where it will
>> > > not respond to version request commands which in turn fails
>> > > HCI_SETUP. so we are sending the power off pulse and then sending the
>> > > power on pulse.
>> >
>> > My suggestion to address this failure case is to reset/power off the
>> > chip before initializing it. With that the loop shouldn't be needed,
>> > actually it wasn't there before you found this specific error.
>> 
>> [Bala]: I will update loop according to your suggestions, But i am 
>> little
>> bit worried, if the HCI_SETUP fails due to some
>>         external issue of UART, so in that cases we can't able to 
>> handle
>> with out loop and as i said, some operating system,
>>        will not handle HCI SETUP failures, we at the driver need to 
>> handle
>> such cases too.
> 
> As I said above, in most cases the problem should be addressed in the
> driver that causes it. Not hiding issues may allow to fix them
> properly, which also benefits other users of the UART/component.
> 
> Cheers
> 
> Matthias

[Bala]: below is how qca_wcn3990_init() after update.

qca_wcn3990_init()
{
        /* Forcefully enable wcn3990 to enter in to boot mode. */
         host_set_baudrate(hu, 2400);
         ret = qca_send_power_pulse(hdev, QCA_WCN3990_POWEROFF_PULSE);
         if (ret)
                 return ret;

         qca_set_speed(hu, QCA_INIT_SPEED);
         ret = qca_send_power_pulse(hdev, QCA_WCN3990_POWERON_PULSE);
         if (ret)
                 return ret;

         /* Wait for 100 ms for SoC to boot */
         msleep(100);

         /* Now the device is in ready state to communicate with host.
          * To sync host with device we need to reopen port.
          * Without this, we will have RTS and CTS synchronization
          * issues.
          */
         serdev_device_close(hu->serdev);
         ret = serdev_device_open(hu->serdev);
         if (ret) {
                 bt_dev_err(hu->hdev, "failed to open port");
                 return ret;
         }

         hci_uart_set_flow_control(hu, false);
         ret = qca_read_soc_version(hdev, soc_ver);

         return ret;

}

-- 
Regards
Balakrishna.
