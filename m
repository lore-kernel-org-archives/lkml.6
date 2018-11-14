Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF26C07E85
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 13:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73FAD223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 13:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MREqTpfD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Z2itNEfm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73FAD223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733057AbeKNXko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 18:40:44 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:60976 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728107AbeKNXko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 18:40:44 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E430A60452; Wed, 14 Nov 2018 13:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542202646;
        bh=PUwOWkpDQplNqhC4C6/JqUXs7AVHuJik6rmwSXexrMU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MREqTpfDgt5v49Tw9CDtVrM6BO6rQUF7ADRcd4SIn2ABgr4/2HuZF0J6k0l6VOFhl
         9j5id+tb7GEwx7uYCq+9M8Ub7KxkYKVAlDUbPtr7sF9ItXCdDxPp/ZJvXNcRf491lF
         4Rd9qGFrsbklNzHlyO26i0BH3StlsYmdUeXlM948=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id EF4AD601D4;
        Wed, 14 Nov 2018 13:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542202645;
        bh=PUwOWkpDQplNqhC4C6/JqUXs7AVHuJik6rmwSXexrMU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z2itNEfm48lNNdVo/swrPfG38DboEelevSi00HJuSe6IMMjNsIPufRL2pKxBlyXYL
         bq7wBERTwxSZOXQzgOkqWPOnT0aW+4epyNRC5xxBd46aPxZ+rUmY3eGKRmjJAlf4MI
         5tAscqh2mA/X+xHN+2zd5YC/yC266+tpD283+fVU=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 14 Nov 2018 19:07:24 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v1 3/4] Bluetooth: hci_qca: clear HCI_QUIRK_RESET_ON_CLOSE
 flag
In-Reply-To: <FD7AE55A-D7AF-4C90-9D01-2DC197A97550@holtmann.org>
References: <20181106120528.30342-1-bgodavar@codeaurora.org>
 <20181106120528.30342-4-bgodavar@codeaurora.org>
 <462C4F58-E6E2-4B20-B074-72DDFA6D7364@holtmann.org>
 <170e0419929840109d349b5df5e38364@codeaurora.org>
 <0CE81F0B-B122-4793-817F-F0F4738C44E0@holtmann.org>
 <c4ced688b33ad82b61a705908393a0a6@codeaurora.org>
 <3c9684ec5fcc9f5d99be7e9b2e705514@codeaurora.org>
 <FD7AE55A-D7AF-4C90-9D01-2DC197A97550@holtmann.org>
Message-ID: <ef69b8768782d1fd14a583bb543858d0@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

On 2018-11-14 13:18, Marcel Holtmann wrote:
> Hi Balakrishna,
> 
>>>>>>> During hci down we are sending reset command to chip, which
>>>>>>> is not required for wcn3990, as hdev->shutdown() will turn off 
>>>>>>> the
>>>>>>> regulators.
>>>>>>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>>>>>>> ---
>>>>>>> drivers/bluetooth/hci_qca.c | 1 +
>>>>>>> 1 file changed, 1 insertion(+)
>>>>>>> diff --git a/drivers/bluetooth/hci_qca.c 
>>>>>>> b/drivers/bluetooth/hci_qca.c
>>>>>>> index 8301663f0004..97b57e0f4725 100644
>>>>>>> --- a/drivers/bluetooth/hci_qca.c
>>>>>>> +++ b/drivers/bluetooth/hci_qca.c
>>>>>>> @@ -1190,6 +1190,7 @@ static int qca_setup(struct hci_uart *hu)
>>>>>>> 		 */
>>>>>>> 		set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
>>>>>>> 		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
>>>>>>> +		clear_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
>>>>>>> 		hu->hdev->shutdown = qca_power_off;
>>>>>>> 		ret = qca_wcn3990_init(hu);
>>>>>>> 		if (ret)
>>>>>> I am pretty certain that you didn’t want this quirk:
>>>>>>       /* When this quirk is set, the HCI Reset command is send 
>>>>>> when
>>>>>>        * closing the transport instead of when opening it.
>>>>>> This quirk is for Bluetooth 1.0b devices where the HCI_Reset 
>>>>>> behavior
>>>>>> was not clear or for devices that actually misbehave with the 
>>>>>> initial
>>>>>> HCI_Reset.
>>>>>> In addition, you commit message is totally misleading. That is not
>>>>>> what is happening with this quirk.
>>>>>> Regards
>>>>>> Marcel
>>>>> My intention was reset command is not required when we do an hci 
>>>>> down.
>>>>> this is because of hdev->shutdown will turn off the regulators.
>>>>> It is like turning off the chip. sending reset command after 
>>>>> turning off the chip is not required.
>>>>> I understand the usage of the quirk, will update the commit text.
>>>> you are papering over the issue. Actually
>>>> hci_serdev.c:hci_uart_register_device() is the culprit with the 
>>>> legacy
>>>> code copied over from hci_ldisc.c:hci_uart_register_dev(). I think
>>>> there is no point doing all this legacy line discipline quirk 
>>>> handling
>>>> until it is really needed. The serdev drivers are all for recent
>>>> hardware.
>>>> That said, having moved over to a btuart.c approach and killed the
>>>> whole hci_serdev.c thing would have been a lot better here. You will
>>>> keep running in weird situations where 18 year old code keeps
>>>> surprising you.
>>> [Bala]: even i feel the same. they are lot such kind of HACK's we 
>>> need
>>> to do with current arch.
>>>        when can we expect btuart.c merged to bt-next. i think having
>>> btuart will helps us to have the control of
>>>        vendor porto's call's like in btusb.c
>>>> Regards
>>>> Marcel
>> 
>> I need some clarification, do you expect some thing like this 
>> https://github.com/torvalds/linux/blob/master/drivers/bluetooth/btmtkuart.c 
>> for Qualcomm BT chip too.
>> it looks it is completely avoided hci_serdev.c interface.
> 
> you tell me actually. Are you using the H:4 transport or do you have
> an extra protocol layer / framing below it. If you do, then use your
> own driver, but if the transport is H:4 with vendor packets and vendor
> setup, then btuart.c (which is not yet upstream) should be your
> target.
> 
> For the MTK hardware it was obvious that it was better served as a
> separate driver. For QCA serial it really depends on how much extra
> protocol you have to run. So this might be an exercise in trying QCA
> serial as a separate driver and then go from there.
> 
> It is clear that the baggage from hci_ldisc.c etc is in the way for
> serdev based systems.
> 
> Regards
> 
> Marcel

[Bala]:
     From my experience of serdev and ldisc, I prefer to go as MTK, here 
are the reasons
     1.If btuart maintains same generic way as hci_serdev, hardware 
vendors will not have control on of
       port opening and close. Because qca want to close port when we do 
hci down where as hci_serdev it is not possible to do.
       This is an important feature for power saving of the device.
    2. I think btuart will have common recv_handle to handle all the 
received data irrespective to the vendors.
       but in our case,  we will receive debug logs as ACL packet which 
is not possible to bypass as diagnostic packet.

      The same with the susb system restart events too. So, I feel that 
having an different driver as same as MTK will help us.

-- 
Regards
Balakrishna.
