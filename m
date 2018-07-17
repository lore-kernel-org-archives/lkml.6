Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481B3ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED47120850
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Rei0m9Cl";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nAGSimJ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED47120850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbeGQPvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 11:51:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41772 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbeGQPvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 11:51:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2B1DC602BC; Tue, 17 Jul 2018 15:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531840691;
        bh=dFqtVQPldfzCiQ3BnTnK1eS48Nl74y28Bd2tRy2mx4E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Rei0m9ClfuG0sam0deaXxYDdlGwu6MEe1+FspEZrIRu1+PoeDOJ1/dSz+5TeG8oY5
         aLeShdXOtN0WtsWKkGwKn0GnXVlpeidk60GMUIenNn+Vm6+rIWXb9vmB0RCvkTelA5
         LKVa2m9dEwTNSHaIlTmquxiBNqKQqMwzWjBSR4nw=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 780B7602BC;
        Tue, 17 Jul 2018 15:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531840690;
        bh=dFqtVQPldfzCiQ3BnTnK1eS48Nl74y28Bd2tRy2mx4E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nAGSimJ2OUSr7KoufDvc78k6irzWdokkDnAe1FxsyocybNwXcKJ4TALTOg8E5g1iR
         P3sJ/NgsGXgdilPygi/cPkI12QcZe+IoY3HfTAEJ5sMYnYwSY4MbpqpGVe2YsYv5fT
         4lJcuS9ZipDedC0y0ejJXAmVPxh1xeK+MHGAqHn4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 17 Jul 2018 20:48:10 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v9 7/7] Bluetooth: hci_qca: Add support for Qualcomm
 Bluetooth chip wcn3990
In-Reply-To: <20180710163909.GQ129942@google.com>
References: <20180705165515.13340-1-bgodavar@codeaurora.org>
 <20180705165515.13340-8-bgodavar@codeaurora.org>
 <20180706222110.GK129942@google.com>
 <a5d87ad5d916df5b5ca7c0c69a786e4a@codeaurora.org>
 <20180710163909.GQ129942@google.com>
Message-ID: <9facaf095d66067eab4bff6722267ba1@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2018-07-10 22:09, Matthias Kaehlcke wrote:
> Hi Bala,
> 
> On Tue, Jul 10, 2018 at 06:22:02PM +0530, Balakrishna Godavarthi wrote:
>> Hi Matthias,
>> 
>> On 2018-07-07 03:51, Matthias Kaehlcke wrote:
>> > On Thu, Jul 05, 2018 at 10:25:15PM +0530, Balakrishna Godavarthi wrote:
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
>> 
>> [Bala]: this function is used to send single byte vendor commands. 
>> like
>> power on and off pulse.
>>         and all single byte vendor commands require an flow control 
>> off and
>> on.
>>         so might be function name change is required.
>>         instead of qca_send_vendor_cmd(). i want to change function 
>> name to
>> qca_send_pulse() as this will be generic.
> 
> 'pulse' covers power on/off pulses, is it also applicable to other
> single byte commands? How are these commands named in the QCA
> documentation?
> 
[Bala]: in QCA wcn3990 for these two bytes we will turn off the flow 
control while sending command and turn on back once it is enabled.
         in documentation it was mentioned as power on and power off 
pulse.
         for all other single bytes we need flow control enable.

> In any case the comment about 'vendor power on and off pulse' should
> be updated to refer to 'vendor commands'/'pulses' or whatever
> terminology we decide to use.

[Bala]: will update the the function name.

> 
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
>> 
>> [Bala] : flow control  off/on is needed for power on and off pulses 
>> along
>> with
>>          command to set baudrate.. this is common across all the 
>> present
>> chips and chips which are in development stages.
>>          might be function name is confusing will update the function 
>> name.
> 
> The current name *might* be ok, depending on if we come up with
> something better. If the QCA docs refer to them as 'vendor commands'
> and there are no other multi-byte 'vendor commands' I'm fine with it.
> 
> Is the settling down of 100us specific to the power on/off pulses or
> also applicable to other commands?
> 
[Bala]: 100 us is specific to power on and off pulses.

> Thanks
> 
> Matthias

-- 
Regards
Balakrishna.
