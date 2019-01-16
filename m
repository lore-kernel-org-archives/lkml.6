Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D57C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D69C220840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lORbyVUH";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ISOkW6kQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391677AbfAPJge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 04:36:34 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:58754 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388925AbfAPJge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 04:36:34 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1155560312; Wed, 16 Jan 2019 09:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547631392;
        bh=YMPT6SYI8GgjTLV1b7KwKQn3bxYe94wggmokm1i+Dok=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lORbyVUHJO6PTVAKuSYIMby4sAwJ8jr1nXyDTAbwdp5a0sgJgViU04nMcXmunY29C
         0eBNOEtQqdVzzTl2uHqzvCslZ5NcqZQp6ALwZ05htF+l0xeHR8s2Ng4gn57xDOakBY
         9aiREk7LTTB6adMW6eQBXm4MKIgbqZ70oOLiKMMY=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id C226E60312;
        Wed, 16 Jan 2019 09:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547631389;
        bh=YMPT6SYI8GgjTLV1b7KwKQn3bxYe94wggmokm1i+Dok=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ISOkW6kQXJYtQVfYVdkTUlUzt2vBcRrkwo8MYwoJ+0IAX0eRkKQiJdpytxAUFqAm9
         pO8AFIQoIMhAvAup9DB/UpeAHQ0iOW4j73A4FCiCmSmKKaU8rYxr715kh+z/lkKJGR
         kLn9CrgefgNZI1KqUWrPeTvXVMkXlt4x1TJMopNw=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 16 Jan 2019 15:06:29 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v7 4/4] Bluetooth: btqca: inject command complete event
 during fw download
In-Reply-To: <20190115012002.GP261387@google.com>
References: <2C799DB5-8033-45B5-A790-A16F73641645@holtmann.org>
 <de93a7b7169a0cfb8f28f5d8e5138dc7@codeaurora.org>
 <1FC4CC11-B070-4ACF-9107-857A4D392876@holtmann.org>
 <1ec946b46301124c90aa12abffeca176@codeaurora.org>
 <20190102221510.GQ261387@google.com>
 <c34d44c656cf38a25dbfc9c6a1dd8106@codeaurora.org>
 <20190110204328.GA261387@google.com>
 <fc3430d2ba5e049883f91ff56aac0dbd@codeaurora.org>
 <20190111231229.GI261387@google.com>
 <5ef0fa1eca4a278ce31c88ef34c7c649@codeaurora.org>
 <20190115012002.GP261387@google.com>
Message-ID: <6889ee31f9700659109c7b772bef76d9@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-15 06:50, Matthias Kaehlcke wrote:
> On Mon, Jan 14, 2019 at 09:21:25PM +0530, Balakrishna Godavarthi wrote:
>> On 2019-01-12 04:42, Matthias Kaehlcke wrote:
>> > On Fri, Jan 11, 2019 at 07:53:43PM +0530, Balakrishna Godavarthi wrote:
>> > > Hi Matthias,
>> > >
>> > > On 2019-01-11 02:13, Matthias Kaehlcke wrote:
>> > > > Hi Balakrishna,
>> > > >
>> > > > On Thu, Jan 10, 2019 at 08:30:43PM +0530, Balakrishna Godavarthi wrote:
>> > > > > Hi Matthias,
>> > > > >
>> > > > > On 2019-01-03 03:45, Matthias Kaehlcke wrote:
>> > > > > > On Mon, Dec 31, 2018 at 11:34:46AM +0530, Balakrishna Godavarthi wrote:
>> > > > > > > Hi Marcel,
>> > > > > > >
>> > > > > > > On 2018-12-30 13:40, Marcel Holtmann wrote:
>> > > > > > > > Hi Balakrishna,
>> > > > > > > >
>> > > > > > > > > > > Latest qualcomm chips are not sending an command complete event for
>> > > > > > > > > > > every firmware packet sent to chip. They only respond with a vendor
>> > > > > > > > > > > specific event for the last firmware packet. This optimization will
>> > > > > > > > > > > decrease the BT ON time. Due to this we are seeing a timeout error
>> > > > > > > > > > > message logs on the console during firmware download. Now we are
>> > > > > > > > > > > injecting a command complete event once we receive an vendor
>> > > > > > > > > > > specific
>> > > > > > > > > > > event for the last RAM firmware packet.
>> > > > > > > > > > > Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> > > > > > > > > > > ---
>> > > > > > > > > > > drivers/bluetooth/btqca.c | 39
>> > > > > > > > > > > ++++++++++++++++++++++++++++++++++++++-
>> > > > > > > > > > > drivers/bluetooth/btqca.h |  3 +++
>> > > > > > > > > > > 2 files changed, 41 insertions(+), 1 deletion(-)
>> > > > > > > > > > > diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
>> > > > > > > > > > > index ec9e03a6b778..0b533f65f652 100644
>> > > > > > > > > > > --- a/drivers/bluetooth/btqca.c
>> > > > > > > > > > > +++ b/drivers/bluetooth/btqca.c
>> > > > > > > > > > > @@ -144,6 +144,7 @@ static void qca_tlv_check_data(struct
>> > > > > > > > > > > rome_config *config,
>> > > > > > > > > > > 		 * In case VSE is skipped, only the last segment is acked.
>> > > > > > > > > > > 		 */
>> > > > > > > > > > > 		config->dnld_mode = tlv_patch->download_mode;
>> > > > > > > > > > > +		config->dnld_type = config->dnld_mode;
>> > > > > > > > > > > 		BT_DBG("Total Length           : %d bytes",
>> > > > > > > > > > > 		       le32_to_cpu(tlv_patch->total_size));
>> > > > > > > > > > > @@ -264,6 +265,31 @@ static int qca_tlv_send_segment(struct
>> > > > > > > > > > > hci_dev *hdev, int seg_size,
>> > > > > > > > > > > 	return err;
>> > > > > > > > > > > }
>> > > > > > > > > > > +static int qca_inject_cmd_complete_event(struct hci_dev *hdev)
>> > > > > > > > > > > +{
>> > > > > > > > > > > +	struct hci_event_hdr *hdr;
>> > > > > > > > > > > +	struct hci_ev_cmd_complete *evt;
>> > > > > > > > > > > +	struct sk_buff *skb;
>> > > > > > > > > > > +
>> > > > > > > > > > > +	skb = bt_skb_alloc(sizeof(*hdr) + sizeof(*evt) + 1, GFP_KERNEL);
>> > > > > > > > > > > +	if (!skb)
>> > > > > > > > > > > +		return -ENOMEM;
>> > > > > > > > > > > +
>> > > > > > > > > > > +	hdr = skb_put(skb, sizeof(*hdr));
>> > > > > > > > > > > +	hdr->evt = HCI_EV_CMD_COMPLETE;
>> > > > > > > > > > > +	hdr->plen = sizeof(*evt) + 1;
>> > > > > > > > > > > +
>> > > > > > > > > > > +	evt = skb_put(skb, sizeof(*evt));
>> > > > > > > > > > > +	evt->ncmd = 1;
>> > > > > > > > > > > +	evt->opcode = HCI_OP_NOP;
>> > > > > >
>> > > > > > After looking a bit more at it I realize HCI_OP_NOP is not a good
>> > > > > > value in this case:
>> > > > > >
>> > > > > > static void hci_cmd_complete_evt(...)
>> > > > > > {
>> > > > > >   ...
>> > > > > >
>> > > > > >   if (*opcode != HCI_OP_NOP)
>> > > > > >     cancel_delayed_work(&hdev->cmd_timer);
>> > > > > >
>> > > > > >   ...
>> > > > > > }
>> > > > > >
>> > > > > > https://elixir.bootlin.com/linux/v4.19/source/net/bluetooth/hci_event.c#L3351
>> > > > > >
>> > > > > > Cancelling the command timeout is precisely what we want. Not sure why
>> > > > > > the patch with HCI_OP_NOP makes the timeouts go away in most cases
>> > > > > > (but not e.g. when inserting an msleep(1000) after downloading the
>> > > > > > NVM.
>> > > > > >
>> > > > > > I suggest to pass the opcode of the command to be completed.
>> > > > > >
>> > > > > > > > > > > +
>> > > > > > > > > > > +	skb_put_u8(skb, QCA_HCI_CC_SUCCESS);
>> > > > > > > > > > > +
>> > > > > > > > > > > +	hci_skb_pkt_type(skb) = HCI_EVENT_PKT;
>> > > > > > > > > > > +
>> > > > > > > > > > > +	return hci_recv_frame(hdev, skb);
>> > > > > > > > > > > +}
>> > > > > > > > > > > +
>> > > > > > > > > > > static int qca_download_firmware(struct hci_dev *hdev,
>> > > > > > > > > > > 				  struct rome_config *config)
>> > > > > > > > > > > {
>> > > > > > > > > > > @@ -297,11 +323,22 @@ static int
>> > > > > > > > > > > qca_download_firmware(struct hci_dev *hdev,
>> > > > > > > > > > > 		ret = qca_tlv_send_segment(hdev, segsize, segment,
>> > > > > > > > > > > 					    config->dnld_mode);
>> > > > > > > > > > > 		if (ret)
>> > > > > > > > > > > -			break;
>> > > > > > > > > > > +			goto out;
>> > > > > > > > > > > 		segment += segsize;
>> > > > > > > > > > > 	}
>> > > > > > > > > > > +	/* Latest qualcomm chipsets are not sending a command
>> > > > > > > > > > > complete event
>> > > > > > > > > > > +	 * for every fw packet sent. They only respond with a
>> > > > > > > > > > > vendor specific
>> > > > > > > > > > > +	 * event for the last packet. This optimization in the chip will
>> > > > > > > > > > > +	 * decrease the BT in initialization time. Here we will
>> > > > > > > > > > > inject a command
>> > > > > > > > > > > +	 * complete event to avoid a command timeout error message.
>> > > > > > > > > > > +	 */
>> > > > > > > > > > > +	if ((config->dnld_type == ROME_SKIP_EVT_VSE_CC ||
>> > > > > > > > > > > +	    config->dnld_type == ROME_SKIP_EVT_VSE))
>> > > > > > > > > > > +		return qca_inject_cmd_complete_event(hdev);
>> > > > > > > > > > > +
>> > > > > > > > > > have you actually considered using __hci_cmd_send in that case. It is
>> > > > > > > > > > allowed for vendor OGF to use that command. I see you actually do use
>> > > > > > > > > > it and now I am failing to understand what this is for.
>> > > > > > > > > [Bala]: thanks for reviewing the change.
>> > > > > > > > >
>> > > > > > > > > __hci_cmd_send() can be used only to send the command to the chip.
>> > > > > > > > > it will not wait for the response for the command sent.
>> > > > > > > > >
>> > > > > > > > > as you know that every vendor command sent to chip will respond with
>> > > > > > > > > vendor specific event and command complete event.
>> > > > > > > > > but in our case chip will only respond with vendor specific event
>> > > > > > > > > only. so we are injecting command complete event.
>> > > > > > > >
>> > > > > > > > and __hci_cmd_sync_ev is also not working for you? However since you
>> > > > > > > > are not waiting for the vendor event anyway and just injecting
>> > > > > > > > cmd_complete, I wonder what’s the difference in just using
>> > > > > > > > __hci_cmd_send and not bothering to wait or inject at all. I am
>> > > > > > > > failing to see where this injection makes a difference.
>> > > > > > > >
>> > > > > > > > For me it is a big difference if we are injecting one event like in
>> > > > > > > > the case of Intel compared to injecting one for every command. It will
>> > > > > > > > show a wrong picture in btmon and that is a bad idea.
>> > > > > > > >
>> > > > > > > > Regards
>> > > > > > > >
>> > > > > > > > Marcel
>> > > > > > >
>> > > > > > > [Bala]: here is the use case, when ever we download the fw packets
>> > > > > > > i.e. RAM
>> > > > > > > image, for every command sent(i.e. fw packet) from
>> > > > > > > the host chip will respond with an vendor specific event and command
>> > > > > > > complete event.
>> > > > > > >
>> > > > > > > the above is taking more time to setup the BT device. then we came
>> > > > > > > up with
>> > > > > > > solution where we enable flags in fw file (i.e. RAM image header)
>> > > > > > > whether to wait for event to be received or sent the total packets
>> > > > > > > and wait
>> > > > > > > for the events for the last packet.
>> > > > > > >
>> > > > > > > So currently we are handling both the cases in the code. i.e wait
>> > > > > > > for event
>> > > > > > > for all packet or wait for an event for the last packet.
>> > > > > > >
>> > > > > > > but in the second case i.e. wait for event for the last packet sent,
>> > > > > > > we are
>> > > > > > > only receiving an vendor specific event from chip which holds the
>> > > > > > > status of
>> > > > > > > fw download.
>> > > > > > >
>> > > > > > > so as __hci_cmd_sync_ev() requires an command complete event. so we
>> > > > > > > are
>> > > > > > > injecting it after the vendor specific event received for the last
>> > > > > > > packet.
>> > > > > > >
>> > > > > > > This helps to overcome 0xfc00 timeout error logging on console.
>> > > > > >
>> > > > > > Some more details:
>> > > > > >
>> > > > > > The timeout error is actually from reading the 'SoC version', which
>> > > > > > uses the same command code as the firmware download
>> > > > > > (EDL_PATCH_CMD_OPCODE). Without reading the 'SoC version' it would be
>> > > > > > from the command to write the first firmware segment.
>> > > > > >
>> > > > > > If the download of a firmware binary takes >= 2s (HCI_CMD_TIMEOUT) the
>> > > > > > timeout would still occur. If necessary this could be mitigated by
>> > > > > > injecting some command complete events during the firmware download,
>> > > > > > though I expect Marcel wouldn't be overly happy with that, since it
>> > > > > > would affect btmon even more.
>> > > > > >
>> > > > > > Regards
>> > > > > >
>> > > > > > Matthias
>> > > > >
>> > > > > [Bala]: Basically every vendor specific command we sent to chip,
>> > > > > chip should respond with an vendor specific event followed by an
>> > > > > command
>> > > > > complete event
>> > > > > or some times it will only respond with an command complete event.
>> > > > > but in any case command complete event is mandatory to all the
>> > > > > command we
>> > > > > sent to the chip.
>> > > >
>> > > > Is this ("command complete event is mandatory to all the command we
>> > > > sent to the chip") a description of what the chip actually does, or
>> > > > what it should be doing according to the spec?
>> > > >
>> > > > As mentioned earlier, the timeout we see originates from reading the
>> > > > SoC version:
>> > > >
>> > > > diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
>> > > > index 0b533f65f652fc..1e484e61799571 100644
>> > > > --- a/drivers/bluetooth/btqca.c
>> > > > +++ b/drivers/bluetooth/btqca.c
>> > > > @@ -400,6 +400,10 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t
>> > > > baudrate,
>> > > >                 return err;
>> > > >         }
>> > > >
>> > > > +       printk("DBG: ZZZzzzzzzz\n");
>> > > > +       msleep(2500);
>> > > > +       printk("DBG: good morning!\n");
>> > > > +
>> > > >         /* Download NVM configuration */
>> > > >         config.type = TLV_TYPE_NVM;
>> > > >         if (soc_type == QCA_WCN3990)
>> > > >
>> > > > When you boot with this patch you'll see something like this:
>> > > >
>> > > > [   15.531365] DBG: reading SoC version
>> > > > [   15.544963] DBG: ZZZzzzzzzz
>> > > > [   17.590282] Bluetooth: hci0: command 0xfc00 tx timeout
>> > > > [   18.099110] DBG: good morning!
>> > > >
>> > >
>> > > [Bala]: my previous analysis were wrong. thanks for pointing me to the
>> > > correct issue.
>> > >         i am able to see timeout after version command.(used some
>> > > sleep)
>> > >         here is the reason for it.
>> > >
>> > >         01 00 fc 01 19 (we send the command to chip to request
>> > > version)
>> > >         04 ff 0e 00 02 0a 00 00 00 01 00 01 02 14 02 01 40(chip will
>> > > respond
>> > > with the vendor specific event payload will be chip version)
>> > >         04 0e 04 01 00 00 00(command complete event)
>> > >
>> > >        issue is with command complete event. ideally command
>> > > complete event
>> > > payload holds the command for which chip sends command complete event.
>> > >
>> > >        breaking the command
>> > >
>> > >        04 : event packet (fixed)
>> > >        0e : command complete event(fixed)
>> > >        04 : size of the payload,
>> > >
>> > >        01 : no of commands in the payload
>> > >        00 : OCF (opocde lsb)
>> > >        00 : OGF (opcode msb)
>> > >        00 : status of command executed,
>> > >
>> > >       payload is form byte 4 to byte 7. which hold the command i.e
>> > > opcode
>> > >       form the above response opcode is 0x0000. ideally this should be
>> > > 0xfc00
>> > >       because the command complete response from the chip is for the
>> > > command
>> > > 0xfc00.
>> > >
>> > >       Checked with Chip firmware dev team for the reason, it was an
>> > > limitation or an bug in the chip ROM firmware
>> > >       in the current chipset, which is fixed in the coming chipset.
>> > >
>> > >       so we expect the command 0xfc00 but recevuies 0x00. so that is
>> > > the
>> > > reason we see an timeouts.
>> > >       for all the vendor commands we receive 0x0000 in the command
>> > > complete
>> > > event.
>> >
>> > Thanks for your analysis.
>> >
>> > It is unfortunate (though not unexpected) that this is a problem in
>> > the ROM were we can't fix it, but at least the FW team is aware of it
>> > and fixed it for future hardware.
>> >
>> > >       if comes a new question how are we not seeing an 0xfc00 when
>> > > we inject
>> > > an command complete event.
>> > >       i experimented this patch, when i inject the command complete
>> > > event
>> > > from the soc version still i can see the command timeouts.
>> >
>> > I don't see command timeouts when injecting a command complete event
>> > after reading the SoC version. I suspect you still use patch which
>> > injects a command complete event with HCI_OP_NOP, which is precisely
>> > what the chip does ...
>> >
>> [Bala]: i am seeing command timeout after injecting cc event after 
>> read
>> version request.
>> 
>> > >       The reason for no timeouts error, we are injecting an command
>> > > complete
>> > > after last packet sent out, so this injection helps
>> > >       .bin file to speed out it download part, so as the bin is dumped
>> > > fastly we send an HCI RESET Comamnd where we recevie an command
>> > > complete
>> > > event
>> > >       with non zero opcode which is cancelling the command timeout
>> > > timer.
>> > >
>> > >       when we inject command complete event, in short we are
>> > > completing
>> > > setup process in less than 2 seconds(command timeout timer value),
>> > >       so before 2 seconds we are sending an HCI RESET command whose
>> > > command
>> > > complete event opcode value is an non zero (which cancels the command
>> > > timeout timer)
>> >
>> > I agree that HCI_RESET cancels the command timeout timer if it is sent
>> > before the 2s timout expires, but I have doubts on the part about
>> > command complete events.
>> >
>> > In my observations there are no command timeouts if a command complete
>> > (with opcode != HCI_OP_NOP) is injected after the firmware download,
>> > even if a 3s sleep is added before sending the HCI_RESET.
>> >
>> 
>> [Bala]: add sleep before sending HCI reset, oxfc00 timeout observed.
> 
> Please double check your setup. Are you 100% sure you are not still
> sending HCI_OP_NOP as opcode?
> 

[Bala]: sorry i am injecting the HCI_OP_NOP, so that is the reason we 
have an timeouts.
         yes if the opcode 0x42 injected, no timeouts are observed.

> This is the diff I use for debugging on top of your patchset:
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index 0b533f65f652fc..5bb9e0ca7c348b 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -27,6 +27,8 @@
> 
>  #define VERSION "0.1"
> 
> +static int qca_inject_cmd_complete_event(struct hci_dev *hdev);
> +
>  int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version)
>  {
>  	struct sk_buff *skb;
> @@ -84,6 +86,11 @@ int qca_read_soc_version(struct hci_dev *hdev, u32
> *soc_version)
>  	if (*soc_version == 0)
>  		err = -EILSEQ;
> 
> +	qca_inject_cmd_complete_event(hdev);
> +	printk("DBG: ZZZzzzzzzz\n");
> +	msleep(2500);
> +	printk("DBG: good morning!\n");
> +
>  out:
>  	kfree_skb(skb);
>  	if (err)
> @@ -281,7 +288,7 @@ static int qca_inject_cmd_complete_event(struct
> hci_dev *hdev)
> 
>  	evt = skb_put(skb, sizeof(*evt));
>  	evt->ncmd = 1;
> -	evt->opcode = HCI_OP_NOP;
> +	evt->opcode = 0x42;
> 
>  	skb_put_u8(skb, QCA_HCI_CC_SUCCESS);
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index f12555f23a49a0..c87ac1823439ab 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -3348,8 +3348,11 @@ static void hci_cmd_complete_evt(struct hci_dev
> *hdev, struct sk_buff *skb,
>  		break;
>  	}
> 
> -	if (*opcode != HCI_OP_NOP)
> +	if (*opcode != HCI_OP_NOP) {
> +		printk("DBG: cancelling command timer (opcode = 0x%02x)\n",
> +		       *opcode);
>  		cancel_delayed_work(&hdev->cmd_timer);
> +	}
> 
>  	if (ev->ncmd && !test_bit(HCI_RESET, &hdev->flags))
>  		atomic_set(&hdev->cmd_cnt, 1);
> 
> 
> With that I see:
> 
> [   18.725417] Bluetooth: hci0: setting up wcn3990
> [   18.860381] DBG: ZZZzzzzzzz
> [   18.863332] DBG: cancelling command timer (opcode = 0x42)
> [   21.427085] DBG: good morning!
> 
> 
> The timer is clearly cancelled by the injected command (opcode 0x42)
> and no timeout occurs. I wouldn't expect you to see anything vastly
> different.
> 
> Cheers
> 
> Matthias

[Bala]: I think it would be better if we inject a command complete event 
after we
         receive the version data.  instead of injecting in between 
firmware download.
         this change will be only for wcn3990.


-- 
Regards
Balakrishna.
