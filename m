Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28A1C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C9EE2064D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="epMlGpmv";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="epMlGpmv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C9EE2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731388AbeGZPiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 11:38:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36168 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730587AbeGZPiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 11:38:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A96D3607B9; Thu, 26 Jul 2018 14:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532614873;
        bh=mHxDQWSbrgD7Zv/b5JTMRFc/YNyZWIQvXjzqXuuA38U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=epMlGpmvQU3F3rjgWpE6TjoRVYpA42GStPS7nhS1TorjC1ctjx7n7jZMgkzitYWEL
         CpqjY9xp3e4Cn9C+LRaEQNbxOAy5bi45DRqUrKycvcJI74CEqNyUhSBZKap+v5VtoS
         mdeogJSAycHF7H/OXjctPaGqf3Sto/aB5QvXutuw=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 0DD0B60594;
        Thu, 26 Jul 2018 14:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532614873;
        bh=mHxDQWSbrgD7Zv/b5JTMRFc/YNyZWIQvXjzqXuuA38U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=epMlGpmvQU3F3rjgWpE6TjoRVYpA42GStPS7nhS1TorjC1ctjx7n7jZMgkzitYWEL
         CpqjY9xp3e4Cn9C+LRaEQNbxOAy5bi45DRqUrKycvcJI74CEqNyUhSBZKap+v5VtoS
         mdeogJSAycHF7H/OXjctPaGqf3Sto/aB5QvXutuw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 26 Jul 2018 19:51:13 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v10 7/7] Bluetooth: hci_qca: Add support for Qualcomm
 Bluetooth chip wcn3990
In-Reply-To: <20180725183144.GQ129942@google.com>
References: <20180720133243.6851-1-bgodavar@codeaurora.org>
 <20180720133243.6851-8-bgodavar@codeaurora.org>
 <20180723195441.GM129942@google.com>
 <81c324ee9104508cf5c862de3f697e4c@codeaurora.org>
 <20180725183144.GQ129942@google.com>
Message-ID: <0666f40967de21db9ef3df9d94517ac1@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2018-07-26 00:01, Matthias Kaehlcke wrote:
> On Tue, Jul 24, 2018 at 09:25:16PM +0530, Balakrishna Godavarthi wrote:
>> Hi Matthias,
>> 
>> On 2018-07-24 01:24, Matthias Kaehlcke wrote:
>> > On Fri, Jul 20, 2018 at 07:02:43PM +0530, Balakrishna Godavarthi wrote:
>> > > +	 * sometimes we will face communication synchronization issues,
>> > > +	 * like reading version command timeouts. In which HCI_SETUP fails,
>> > > +	 * to overcome these issues, we try to communicate by performing an
>> > > +	 * COLD power OFF and ON.
>> > > +	 */
>> > > +	for (i = 1; i <= 10 && ret; i++) {
>> >
>> > Is it really that bad that more than say 3 iterations might be needed?
>> >
>> [Bala]: will restrict to 3 iterations.
> 
> Is 3x expected to be enough to 'guarantee' as successful
> initialization? Just wondered about the 10x since it suddendly changed
> from 1x. What is the failure rate without retries?
> 
> Could you provide more information about the 'communication
> synchronization issues'? Is the root cause understood? Maybe there is
> a better way than retries.
> 

[Bala]: basically before sending a every patch series we run a stress 
test to the driver to detect the bugs.
         in recent test results found one interesting bug that BT setups 
fails with version request timeouts,
         after we do a reboot for the device.
         we debugged the issue and found that wcn3900 is not responding 
to the version request commands
         sent by HOST. this is because before reboot, wcn3990 is in on 
state i.e. we are communicating to device.
         then we did a reboot and HOST is not sending a power off request 
to the regulators to turn off.
         so after reboot wcn3990 is still in ON state where it will not 
respond to version request commands which in turn fails HCI_SETUP.
         so we are sending the power off pulse and then sending the power 
on pulse.
         coming back to 3x or 10x iteration this is to avoid any such 
synchronization issues.
         i agreed for 3x because of stress test results. we have success 
rate of 99% for single iteration, where as 3x iterations will helps to 
handle 1% fails cases.

>> > > +static void qca_regulator_get_current(struct device *dev,
>> > > +				      struct qca_vreg *vregs)
>> > > +{
>> > > +	char prop_name[32]; /* 32 is max size of property name */
>> > > +
>> > > +	/* We have different platforms where the load value is controlled
>> > > +	 * via PMIC controllers. In such cases load required to power ON
>> > > +	 * Bluetooth chips are defined in the PMIC. We have option to set
>> > > +	 * operation mode like high or low power modes.
>> > > +	 * We do have some platforms where driver need to enable the load
>> > > for
>> > > +	 * WCN3990. Based on the current property value defined for the
>> > > +	 * regulators, driver will decide the regulator output load.
>> > > +	 * If the current property for the regulator is defined in the dts
>> > > +	 * we will read from dts tree, else from the default load values.
>> > > +	 */
>> >
>> > Let's make sure we all really understand why this is needed. You
>> > mentioned RPMh regulators earlier and said a special value of 1uA
>> > would be needed to enable high power mode. Later when I pointed to the
>> > RPMh regulator code you agreed that this special value wouldn't make
>> > any difference.
>> >
>> > Now the defaults are higher:
>> >
>> [Bala]: today i got the info from the power teams here, currently in 
>> the
>> downstream what we have is different wrt to the
>>         patch "https://patchwork.kernel.org/patch/10524299/" by David
>> Collins.
>>         prior to his patch we have different architecture where 1uA 
>> will
>> change the mode to HPM mode.
>>         which is not valid, so 1uA will not work any more. we have go 
>> with
>> actual current values.
> 
> Ok, in any case downstream drivers shouldn't impact the design of
> upstream drivers. If there are incompatibilities the BT driver needs
> to be hacked in the downstream tree.
> 
>>         coming back to reading current values from dts. we have reason 
>> for
>> it.
>>         let us assume that later stages of wcn3990 if we have less 
>> current
>> values than default values.
>>         instead of updating the driver again, we can assign the 
>> current no
>> in the dts, which we will read.
>> 
>>         This is how it works.
>> 
>>         if(current value for the reg is declared in dts tree)
>>               consider the current value from the dts.
>>         else
>>            go with default value.
>> 
>>       pls let me know if you any queries.
> 
> If I understand correctly you describe a hypothetical situation of a
> future wcn3990 variant having lower power requirements. I'd say let's
> deal with this when these chips actually exist and need to be
> supported by Linux. As of now it seems there is no need for current
> limits in the DT.
> 

[Bala]: will remove current property for dts.
         in previous mail you asked me a question for currents
         "The currents of 300mA and 450mA seem high for Bluetooth, I'm 
not an
          expert in this area though, they might be reasonable peak 
currents for
          certain use cases."

          yes we require 450mA and 300mA of current for rf and ch0 pins.  
setting regulator to required load will not pump load current to wcn3990
         it depends on operations, typical the above are the max current 
drawn by the two pins.

>> > > +	if (device_property_read_bool(dev, prop_name))
>> > > +		device_property_read_u32(dev, prop_name, &vregs->load_uA);
>> >
>> > Why device_property_read_bool()?
>> >
>> [Bala]: if the current prop is present we read from dts. else we go 
>> with
>> default current no's.
>>         if block  is used to check whether the property is present in 
>> dts or
>> not.
>>         this is required because before calling 
>> _regualtor_get_current() we
>> hold the default current in the vregs[].
>>         if we skip the read bool here, if the current property is not
>> present then the function call of device_property_read_u32() will 
>> assign
>> zero the vregs[].
>>         so we miss the default current values.
>> 
>>         this how it work if we miss read_bool check
>> 
>>         //vregs hold default current
>>          device_property_read_u32(dev, prop_name, &vregs->load_uA);
>>          the above will read the current property value from dts store 
>> in
>> the vregs.. if the property is missing in dts it will store zero.
> 
> Where does of_property_read_u32() set the value to zero when the
> property does not exist?
> 
> A simple test in a probe function:
> 
> {
> 	u32 v = 123;
> 	of_property_read_u32(node, "no-such-property", &v);
> 	printk("DBG: v = %d\n", v);
> }
> 
> [    7.598366] DBG: v = 123
> 
> And looking at the code, of_property_read_u32() ends up in a call to
> of_property_read_variable_u32_array():
> 
> int of_property_read_variable_u32_array(const struct device_node *np,
> 			       const char *propname, u32 *out_values,
> 			       size_t sz_min, size_t sz_max)
> {
> 	size_t sz, count;
> 	const __be32 *val = of_find_property_value_of_size(np, propname,
> 						(sz_min * sizeof(*out_values)),
> 						(sz_max * sizeof(*out_values)),
> 						&sz);
> 
> 	if (IS_ERR(val))
> 		return PTR_ERR(val);
> 
> 	...
> }
> 
> i.e. 'out_values' is not modified when the property does not exit.

[Bala]: Thanks for clarifying me.

-- 
Regards
Balakrishna.
