Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8F6C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CBD02086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mkGjZOZm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gyg9kOFK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CBD02086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeJPXKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 19:10:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49006 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeJPXKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 19:10:48 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7223160769; Tue, 16 Oct 2018 15:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539703191;
        bh=6ogXmNlC7ZW0hqVK7pvj0KX1gRSqBobeM+zsJ3KPpWA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mkGjZOZma6pVRSPlPT2QaI0aXhnEjkhdLK++BfJecOLdsASh0DaTuDiaINTIS4A1G
         HwotZg2XNkTWKMIDd2eEn4K2A3zS92E0jbPy6GREUt/yurJ/SYm0XA8JhbnDXKZ7jE
         G5PHypjHl1MYUa2F8WLx26JH6QQ7r0y7DEI+kOvA=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 7A00E60386;
        Tue, 16 Oct 2018 15:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539703190;
        bh=6ogXmNlC7ZW0hqVK7pvj0KX1gRSqBobeM+zsJ3KPpWA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gyg9kOFKa7siGQN/pzjPUeNsdxaQ4N3OCNuNs3WnRWntmXpxz9NWjeZq02yedj7bg
         vEoAQsDsdwv2zdNhwTq7UnzjX5HtYbwJGPMYKbU9zLWcff9SrL7pNLyeLo5rMdp16/
         K4ZcqyZesIfcRyVKxhaWdhpch2wloeUf8nlTmtzc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 16 Oct 2018 20:49:50 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Harish Bandi <c-hbandi@codeaurora.org>
Subject: Re: [PATCH v2] Bluetooth: hci_qca: Add support for controller debug
 logs.
In-Reply-To: <01616379-E0FF-49AC-8C69-DA498DA9F51F@holtmann.org>
References: <20181003151144.10537-1-bgodavar@codeaurora.org>
 <2206464E-FA01-4A5A-8BC4-5CF70A0B9765@holtmann.org>
 <eca6c8832017269881709e51eadcf543@codeaurora.org>
 <EC27FDED-638A-4055-A861-C4AAD842F124@holtmann.org>
 <fed90ab28af93bc27a07c0b4e8ca933c@codeaurora.org>
 <01616379-E0FF-49AC-8C69-DA498DA9F51F@holtmann.org>
Message-ID: <540262ec6c6f1c5f3a9baf18b6f40d47@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

On 2018-10-16 20:39, Marcel Holtmann wrote:
> Hi Balakrishna,
> 
>>>>>> This patch will prevent error messages splashing on console.
>>>>>> [   78.426697] Bluetooth: hci_core.c:hci_acldata_packet() hci0: 
>>>>>> ACL packet for unknown connection handle 3804
>>>>>> [   78.436682] Bluetooth: hci_core.c:hci_acldata_packet() hci0: 
>>>>>> ACL packet for unknown connection handle 3804
>>>>>> [   78.446639] Bluetooth: hci_core.c:hci_acldata_packet() hci0: 
>>>>>> ACL packet for unknown connection handle 3804
>>>>>> [   78.456596] Bluetooth: hci_core.c:hci_acldata_packet() hci0: 
>>>>>> ACL packet for unknown connection handle 3804
>>>>>> QCA wcn3990 will send the debug logs in the form of ACL packets.
>>>>>> While decoding packet in qca_recv(), marking the received debug 
>>>>>> log
>>>>>> packet as diagnostic packet.
>>>>>> Signed-off-by: Harish Bandi <c-hbandi@codeaurora.org>
>>>>>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>>>>>> ---
>>>>>> v2:
>>>>>> * Addressed reviewer comments.
>>>>>> v1:
>>>>>> * initial patch
>>>>>> ---
>>>>>> drivers/bluetooth/hci_qca.c | 20 +++++++++++++++++++-
>>>>>> 1 file changed, 19 insertions(+), 1 deletion(-)
>>>>>> diff --git a/drivers/bluetooth/hci_qca.c 
>>>>>> b/drivers/bluetooth/hci_qca.c
>>>>>> index d98ed0442201..63ac3c6b4149 100644
>>>>>> --- a/drivers/bluetooth/hci_qca.c
>>>>>> +++ b/drivers/bluetooth/hci_qca.c
>>>>>> @@ -63,6 +63,10 @@
>>>>>> /* susclk rate */
>>>>>> #define SUSCLK_RATE_32KHZ	32768
>>>>>> +/* Controller debug log header */
>>>>>> +#define QCA_DEBUG_HDR_MSB	0xDC
>>>>>> +#define QCA_DEBUG_HDR_LSB	0x2E
>>>>>> +
>>>>> since this is actually the ACL handle, why not call it 
>>>>> QCA_DEBUG_HANDLE.
>>>> [Bala]: will update.
>>>>>> /* HCI_IBS transmit side sleep protocol states */
>>>>>> enum tx_ibs_states {
>>>>>> 	HCI_IBS_TX_ASLEEP,
>>>>>> @@ -849,6 +853,20 @@ static int qca_ibs_wake_ack(struct hci_dev 
>>>>>> *hdev, struct sk_buff *skb)
>>>>>> 	return 0;
>>>>>> }
>>>>>> +static int qca_recv_acl_data(struct hci_dev *hdev, struct sk_buff 
>>>>>> *skb)
>>>>>> +{
>>>>>> +	/* We receive debug logs from chip as an ACL packets.
>>>>>> +	 * Instead of sending the data to ACL to decode the
>>>>>> +	 * received data, we are pushing them to the above layers
>>>>>> +	 * as a diagnostic packet.
>>>>>> +	 */
>>>>>> +	if ((skb->len > 2) && (skb->data[0] == QCA_DEBUG_HDR_MSB) &&
>>>>>> +	    (skb->data[1] == QCA_DEBUG_HDR_LSB))
>>>>> Skip the individual () since they are not needed. Also the skb->len
>>>>> check is not needed since the H4_RECV_ACL already ensures the 
>>>>> proper
>>>>> length of the header.
>>>>> And just use get_unaligned_le16(skb->data) here (or be16 if that is
>>>>> the byte order).
>>>> [Bala] : will update condition with _le16()
>>>>>> +		return hci_recv_diag(hdev, skb);
>>>>> Is there any reason to keep the 4 octets hci_acl_hdr with this SKB? 
>>>>> Or
>>>>> would it be better to be stripped off. Mainly asking are they any
>>>>> other magic handles that we might want to feed through the diag
>>>>> channel?
>>>> [Bala]: yes we need header in the stack, to  differentiate between 
>>>> actual diagnostic packet and debug packet.
>>> please explain that a bit more. There is just one debug handle or do
>>> you have more special handles?
>> [Bala]: Qualcomm bluetooth chip sends the debug data of the chip with 
>> ACL header along with fixed handler i.e. 0x2edc..
>>        this handler is dedicated for the debug logs sent by qcomm bt 
>> chip and it is not used for any other connection handlers.
>>        so here we are checking this handler and sending to stack as an
>>        a diagnostic packet.. so during the log capture we will read 
>> this diagnostic packet and handler,to decode the debug packet.
>>        that is the  reason why we don't remove handler during 
>> condition check,  in future, if qualcomm chip sends diagnostic packet,
>>        then this will create an problem to upper layers to decide 
>> whether it is an diagnostic packet or the debug packet.
>> 
>>       this is how we do it.
>>      if( diagnostic packet && handler == 0x2edc)
>>         treat them as an ddebug packet
>>      else
>>          treat as diagnostic packet.
>> 
> 
> let me interpret this answer. Besides debug handle 0x2edc, there are
> other handles that are not connection handles. And in future updates
> you want to send these handles also via hci_recv_diag channel.
> 

No, 0x2edc is an dedicated handle for debug logs, i don't really think 
they we will have an new handle coming up.
this is only the handle we will send via hci_recv_diag channel to the 
stack.

what i mean in my previous answer was,we don't to remove debug 
connection handle from the skb, because in the stack
we look for a diagnostic packet and debug connection handler to decode 
the message.

> Regards
> 
> Marcel

-- 
Regards
Balakrishna.
