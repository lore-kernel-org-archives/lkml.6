Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0B2C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B0F20878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="T9WbiKYH";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PVRuajPa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7B0F20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbeJBOOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:14:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33270 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbeJBOOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:14:36 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 24D9A60397; Tue,  2 Oct 2018 07:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538465565;
        bh=tUlfmW5aV9ZtLXvsrD+JrK/a6+a3QMyifa3gApfVOZ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T9WbiKYHWjlS9QFrwdUX8+94otxW45bUDYBXkJnLhN4fFHqBhVmfhGJGGI5T+F4jO
         fLdKm4cPOKbj4ZTXfeVtNx3xJnqvQlSYAZZpDFmOttxv4p9LFcNeXlcySBbz1PiW6d
         aAqGdvG25Ozpo+336mGpm+DeG9w26EYDpsrN1y/A=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 39A1760866;
        Tue,  2 Oct 2018 07:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538465564;
        bh=tUlfmW5aV9ZtLXvsrD+JrK/a6+a3QMyifa3gApfVOZ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PVRuajPaB2+Y8370LNeLoWelLLsFGM7xbhzwbkSbWZ5YsYKCGJmMu2BKHHgd5PBZZ
         VdRo9hc7e7ls6T7l5slYMc8tq67gZpd24jlKbIJQ5IX5OCtnFvPZIBAjIhYlqiUIzb
         NUBhlN+keC7xMW4jF0dtXBT3Zxgkoed5c47QFzmk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 02 Oct 2018 13:02:44 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        Harish Bandi <c-hbandi@codeaurora.org>
Subject: Re: [PATCH v1] Bluetooth: hci_qca: Add support for controller debug
 logs.
In-Reply-To: <20181001194821.GH22824@google.com>
References: <20181001135102.17453-1-bgodavar@codeaurora.org>
 <20181001194821.GH22824@google.com>
Message-ID: <3eb67181ab722c9cc1af76d80bde9e76@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2018-10-02 01:18, Matthias Kaehlcke wrote:
> Hi Balakrishna,
> 
> On Mon, Oct 01, 2018 at 07:21:02PM +0530, Balakrishna Godavarthi wrote:
>> This patch will prevent error messages splashing on console.
>> 
>> [   78.426697] Bluetooth: hci_core.c:hci_acldata_packet() hci0: ACL 
>> packet for unknown connection handle 3804
>> [   78.436682] Bluetooth: hci_core.c:hci_acldata_packet() hci0: ACL 
>> packet for unknown connection handle 3804
>> [   78.446639] Bluetooth: hci_core.c:hci_acldata_packet() hci0: ACL 
>> packet for unknown connection handle 3804
>> [   78.456596] Bluetooth: hci_core.c:hci_acldata_packet() hci0: ACL 
>> packet for unknown connection handle 3804
>> 
>> QCA wcn3990 will send the debug logs in the form of ACL packets.
>> While decoding packet in qca_recv(), marking the received debug log
>> packet as diagnostic packet.
>> 
>> Signed-off-by: Harish Bandi <c-hbandi@codeaurora.org>
>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> ---
>>  drivers/bluetooth/hci_qca.c | 27 ++++++++++++++++++++++++++-
>>  1 file changed, 26 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index d98ed0442201..a00910aaed54 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -63,6 +63,10 @@
>>  /* susclk rate */
>>  #define SUSCLK_RATE_32KHZ	32768
>> 
>> +/* Controller debug log header */
>> +#define QCA_DEBUG_HDR_MSB	0xDC
>> +#define QCA_DEBUG_HDR_LSB	0x2E
>> +
>>  /* HCI_IBS transmit side sleep protocol states */
>>  enum tx_ibs_states {
>>  	HCI_IBS_TX_ASLEEP,
>> @@ -849,6 +853,20 @@ static int qca_ibs_wake_ack(struct hci_dev *hdev, 
>> struct sk_buff *skb)
>>  	return 0;
>>  }
>> 
>> +static int qca_recv_acl_data(struct hci_dev *hdev, struct sk_buff 
>> *skb)
>> +{
>> +	/* We receive debug logs from chip as an ACL packets.
>> +	 * Instead of sending the data to ACL to decode the
>> +	 * received data, we are pushing them to the above layers
>> +	 * as a diagnostic packet.
>> +	 */
>> +	if ((skb->len > 2) && (skb->data[0] == QCA_DEBUG_HDR_MSB) &&
>> +	    (skb->data[1] == QCA_DEBUG_HDR_LSB))
>> +		return hci_recv_diag(hdev, skb);
>> +	else
>> +		return hci_recv_frame(hdev, skb);
> 
> nit: you could just do hci_recv_frame() after the if branch, instead
> of doing it in 'else'. That would make it clearer at first sight that
> the QCA debug packets are a special case and other packets normal
> operation.
> 

[Bala]: will update.

>> +}
>> +
>>  #define QCA_IBS_SLEEP_IND_EVENT \
>>  	.type = HCI_IBS_SLEEP_IND, \
>>  	.hlen = 0, \
>> @@ -870,13 +888,20 @@ static int qca_ibs_wake_ack(struct hci_dev 
>> *hdev, struct sk_buff *skb)
>>  	.lsize = 0, \
>>  	.maxlen = HCI_MAX_IBS_SIZE
>> 
>> +#define QCA_RECV_ACL_DATA \
>> +	.type = HCI_ACLDATA_PKT, \
>> +	.hlen = HCI_ACL_HDR_SIZE, \
>> +	.loff = 2, \
>> +	.lsize = 2, \
>> +	.maxlen = HCI_MAX_FRAME_SIZE
> 
> Is there any actual advantage of adding this 'macro' instead of just
> using H4_RECV_ACL, which is exactly the same?
> 

[Bala]: yes we can use same macro, will update.

>>  static const struct h4_recv_pkt qca_recv_pkts[] = {
>> -	{ H4_RECV_ACL,             .recv = hci_recv_frame    },
>>  	{ H4_RECV_SCO,             .recv = hci_recv_frame    },
>>  	{ H4_RECV_EVENT,           .recv = hci_recv_frame    },
>>  	{ QCA_IBS_WAKE_IND_EVENT,  .recv = qca_ibs_wake_ind  },
>>  	{ QCA_IBS_WAKE_ACK_EVENT,  .recv = qca_ibs_wake_ack  },
>>  	{ QCA_IBS_SLEEP_IND_EVENT, .recv = qca_ibs_sleep_ind },
>> +	{ QCA_RECV_ACL_DATA,       .recv = qca_recv_acl_data },
>>  };
>> 
>>  static int qca_recv(struct hci_uart *hu, const void *data, int count)

-- 
Regards
Balakrishna.
