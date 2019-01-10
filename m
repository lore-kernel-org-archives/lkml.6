Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5848C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623DF214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NEHZLvSf";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Evuh1JXo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbfAJPAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:00:47 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:37270 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbfAJPAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:00:47 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 395B0608CB; Thu, 10 Jan 2019 15:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547132445;
        bh=m7bYZja4ggOEMMkyioE0lEp/57aXV5MwqgYIZ2sNAEs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NEHZLvSfWKQ2vXfpiouNWuE5Zafzd9WZ/DW8TgiJ7ETBejTnaefbg/P3WUsSR+Osc
         iRF/vpDrmSgpHc2LIyjF2HMgAnJqCZxBw6fTpTVw3sVLnfSxm15B0IoI89oQkD9OYT
         +ahrYqSnSDqF8gmFlkaVoFC1h9sSAfALuzYk4Y6I=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id C367960386;
        Thu, 10 Jan 2019 15:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547132443;
        bh=m7bYZja4ggOEMMkyioE0lEp/57aXV5MwqgYIZ2sNAEs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Evuh1JXoBXCPxbVs79BNIXBINAGp1qCVAFFWFrlynGF0KEFwkKM8d5SQ+j3vy2H5M
         jKlmhuCOob2wISLeM0wtVaYOSTdomRFypWR8o0lCyjSPlaPwk7PQuVyNrmJAEpdIxI
         XPdQ/UaX27GZggHopLtdzuXsxVyKlF1aUpGffHKY=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 10 Jan 2019 20:30:43 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v7 4/4] Bluetooth: btqca: inject command complete event
 during fw download
In-Reply-To: <20190102221510.GQ261387@google.com>
References: <20181228114819.17479-1-bgodavar@codeaurora.org>
 <20181228114819.17479-5-bgodavar@codeaurora.org>
 <2C799DB5-8033-45B5-A790-A16F73641645@holtmann.org>
 <de93a7b7169a0cfb8f28f5d8e5138dc7@codeaurora.org>
 <1FC4CC11-B070-4ACF-9107-857A4D392876@holtmann.org>
 <1ec946b46301124c90aa12abffeca176@codeaurora.org>
 <20190102221510.GQ261387@google.com>
Message-ID: <c34d44c656cf38a25dbfc9c6a1dd8106@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2019-01-03 03:45, Matthias Kaehlcke wrote:
> On Mon, Dec 31, 2018 at 11:34:46AM +0530, Balakrishna Godavarthi wrote:
>> Hi Marcel,
>> 
>> On 2018-12-30 13:40, Marcel Holtmann wrote:
>> > Hi Balakrishna,
>> >
>> > > > > Latest qualcomm chips are not sending an command complete event for
>> > > > > every firmware packet sent to chip. They only respond with a vendor
>> > > > > specific event for the last firmware packet. This optimization will
>> > > > > decrease the BT ON time. Due to this we are seeing a timeout error
>> > > > > message logs on the console during firmware download. Now we are
>> > > > > injecting a command complete event once we receive an vendor
>> > > > > specific
>> > > > > event for the last RAM firmware packet.
>> > > > > Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> > > > > ---
>> > > > > drivers/bluetooth/btqca.c | 39
>> > > > > ++++++++++++++++++++++++++++++++++++++-
>> > > > > drivers/bluetooth/btqca.h |  3 +++
>> > > > > 2 files changed, 41 insertions(+), 1 deletion(-)
>> > > > > diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
>> > > > > index ec9e03a6b778..0b533f65f652 100644
>> > > > > --- a/drivers/bluetooth/btqca.c
>> > > > > +++ b/drivers/bluetooth/btqca.c
>> > > > > @@ -144,6 +144,7 @@ static void qca_tlv_check_data(struct
>> > > > > rome_config *config,
>> > > > > 		 * In case VSE is skipped, only the last segment is acked.
>> > > > > 		 */
>> > > > > 		config->dnld_mode = tlv_patch->download_mode;
>> > > > > +		config->dnld_type = config->dnld_mode;
>> > > > > 		BT_DBG("Total Length           : %d bytes",
>> > > > > 		       le32_to_cpu(tlv_patch->total_size));
>> > > > > @@ -264,6 +265,31 @@ static int qca_tlv_send_segment(struct
>> > > > > hci_dev *hdev, int seg_size,
>> > > > > 	return err;
>> > > > > }
>> > > > > +static int qca_inject_cmd_complete_event(struct hci_dev *hdev)
>> > > > > +{
>> > > > > +	struct hci_event_hdr *hdr;
>> > > > > +	struct hci_ev_cmd_complete *evt;
>> > > > > +	struct sk_buff *skb;
>> > > > > +
>> > > > > +	skb = bt_skb_alloc(sizeof(*hdr) + sizeof(*evt) + 1, GFP_KERNEL);
>> > > > > +	if (!skb)
>> > > > > +		return -ENOMEM;
>> > > > > +
>> > > > > +	hdr = skb_put(skb, sizeof(*hdr));
>> > > > > +	hdr->evt = HCI_EV_CMD_COMPLETE;
>> > > > > +	hdr->plen = sizeof(*evt) + 1;
>> > > > > +
>> > > > > +	evt = skb_put(skb, sizeof(*evt));
>> > > > > +	evt->ncmd = 1;
>> > > > > +	evt->opcode = HCI_OP_NOP;
> 
> After looking a bit more at it I realize HCI_OP_NOP is not a good
> value in this case:
> 
> static void hci_cmd_complete_evt(...)
> {
>   ...
> 
>   if (*opcode != HCI_OP_NOP)
>     cancel_delayed_work(&hdev->cmd_timer);
> 
>   ...
> }
> 
> https://elixir.bootlin.com/linux/v4.19/source/net/bluetooth/hci_event.c#L3351
> 
> Cancelling the command timeout is precisely what we want. Not sure why
> the patch with HCI_OP_NOP makes the timeouts go away in most cases
> (but not e.g. when inserting an msleep(1000) after downloading the
> NVM.
> 
> I suggest to pass the opcode of the command to be completed.
> 
>> > > > > +
>> > > > > +	skb_put_u8(skb, QCA_HCI_CC_SUCCESS);
>> > > > > +
>> > > > > +	hci_skb_pkt_type(skb) = HCI_EVENT_PKT;
>> > > > > +
>> > > > > +	return hci_recv_frame(hdev, skb);
>> > > > > +}
>> > > > > +
>> > > > > static int qca_download_firmware(struct hci_dev *hdev,
>> > > > > 				  struct rome_config *config)
>> > > > > {
>> > > > > @@ -297,11 +323,22 @@ static int
>> > > > > qca_download_firmware(struct hci_dev *hdev,
>> > > > > 		ret = qca_tlv_send_segment(hdev, segsize, segment,
>> > > > > 					    config->dnld_mode);
>> > > > > 		if (ret)
>> > > > > -			break;
>> > > > > +			goto out;
>> > > > > 		segment += segsize;
>> > > > > 	}
>> > > > > +	/* Latest qualcomm chipsets are not sending a command
>> > > > > complete event
>> > > > > +	 * for every fw packet sent. They only respond with a
>> > > > > vendor specific
>> > > > > +	 * event for the last packet. This optimization in the chip will
>> > > > > +	 * decrease the BT in initialization time. Here we will
>> > > > > inject a command
>> > > > > +	 * complete event to avoid a command timeout error message.
>> > > > > +	 */
>> > > > > +	if ((config->dnld_type == ROME_SKIP_EVT_VSE_CC ||
>> > > > > +	    config->dnld_type == ROME_SKIP_EVT_VSE))
>> > > > > +		return qca_inject_cmd_complete_event(hdev);
>> > > > > +
>> > > > have you actually considered using __hci_cmd_send in that case. It is
>> > > > allowed for vendor OGF to use that command. I see you actually do use
>> > > > it and now I am failing to understand what this is for.
>> > > [Bala]: thanks for reviewing the change.
>> > >
>> > > __hci_cmd_send() can be used only to send the command to the chip.
>> > > it will not wait for the response for the command sent.
>> > >
>> > > as you know that every vendor command sent to chip will respond with
>> > > vendor specific event and command complete event.
>> > > but in our case chip will only respond with vendor specific event
>> > > only. so we are injecting command complete event.
>> >
>> > and __hci_cmd_sync_ev is also not working for you? However since you
>> > are not waiting for the vendor event anyway and just injecting
>> > cmd_complete, I wonder what’s the difference in just using
>> > __hci_cmd_send and not bothering to wait or inject at all. I am
>> > failing to see where this injection makes a difference.
>> >
>> > For me it is a big difference if we are injecting one event like in
>> > the case of Intel compared to injecting one for every command. It will
>> > show a wrong picture in btmon and that is a bad idea.
>> >
>> > Regards
>> >
>> > Marcel
>> 
>> [Bala]: here is the use case, when ever we download the fw packets 
>> i.e. RAM
>> image, for every command sent(i.e. fw packet) from
>> the host chip will respond with an vendor specific event and command
>> complete event.
>> 
>> the above is taking more time to setup the BT device. then we came up 
>> with
>> solution where we enable flags in fw file (i.e. RAM image header)
>> whether to wait for event to be received or sent the total packets and 
>> wait
>> for the events for the last packet.
>> 
>> So currently we are handling both the cases in the code. i.e wait for 
>> event
>> for all packet or wait for an event for the last packet.
>> 
>> but in the second case i.e. wait for event for the last packet sent, 
>> we are
>> only receiving an vendor specific event from chip which holds the 
>> status of
>> fw download.
>> 
>> so as __hci_cmd_sync_ev() requires an command complete event. so we 
>> are
>> injecting it after the vendor specific event received for the last 
>> packet.
>> 
>> This helps to overcome 0xfc00 timeout error logging on console.
> 
> Some more details:
> 
> The timeout error is actually from reading the 'SoC version', which
> uses the same command code as the firmware download
> (EDL_PATCH_CMD_OPCODE). Without reading the 'SoC version' it would be
> from the command to write the first firmware segment.
> 
> If the download of a firmware binary takes >= 2s (HCI_CMD_TIMEOUT) the
> timeout would still occur. If necessary this could be mitigated by
> injecting some command complete events during the firmware download,
> though I expect Marcel wouldn't be overly happy with that, since it
> would affect btmon even more.
> 
> Regards
> 
> Matthias

[Bala]: Basically every vendor specific command we sent to chip,
chip should respond with an vendor specific event followed by an command 
complete event
or some times it will only respond with an command complete event.
but in any case command complete event is mandatory to all the command 
we sent to the chip.

In our case, we have an two fw files i.e. *.tlv and *.bin.
tlv is an RAM image of the chip where as bin is an nvm image of the 
chip. so tlv will be of
more size which require an  lot more time to dump the file in to chip,
while dumping the tlv, we divide tlv as packet of size 245 bytes and 
send
them as an command packet to the chip. chip should respond with an  
command complete event.
then only we will send the next packet. but size of the tlv is large, to 
optimize this we will
not wait for the either an vendor specific event or an command complete 
event.
But as we need to be on the sync, i.e. whether are we sending an correct 
packets or not,
for the last fw packet we sent to the chip.. chip will to do an CRC 
check for the total no of packets received and respond with an vendor 
specific event.

We decode the vendor specific event and decide whether the fw download 
is success or not.  here we send an fw packet as command so stack 
expects an command complete event.
where this is missing from the chip. this is  expected behavior from 
chip.

So currently i am inject an command complete event after receiving an 
vendor event for the last packet of the tlv.

This we inject only once for the last command packet sent to the chip.
i don't think this will effect the btmon.

-- 
Regards
Balakrishna.
