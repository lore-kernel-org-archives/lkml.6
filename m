Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7928C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 22:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D949218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 22:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lInczR7f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729590AbfABWPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 17:15:18 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37271 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbfABWPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 17:15:13 -0500
Received: by mail-pf1-f195.google.com with SMTP id y126so15761755pfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 14:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=sL/L4QggFD/VjZGwokBedWAykxKnibxrFhA7xFl8ByA=;
        b=lInczR7f3OnOTdvtxDjUPwbjTzhMxbldE6Sm9bjouAM8YU2YSdTR3ZLFlpqIOGMMzt
         WbC5RKc1c9NB+j/ihCPPX7WJjY9OewJpG2hV6xggl+sS4Lu75A0OWLm8B2Q5FsCDdvvu
         +IRF5+a18O19Q0Qld4yS94SWHhLPipY4dj1K8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=sL/L4QggFD/VjZGwokBedWAykxKnibxrFhA7xFl8ByA=;
        b=tBhj56+W5V1+dffH8+5HRLpcrIjFXdBZMqDfUUCCLD3ds1Lnj5T+vN1UsKm+9zyUAg
         aSeDphHWyMrn6e6evtSIdKPd+ApHhIAkMGcTbr+b8kgHbtpCRsGWDynidHaY8Ekdr6L7
         lDHiSezbMiBCInY+EcCvGOyjUHuDf6esCJKZlyNRSIUYMCtTIykl2fP1O80LliBABWLs
         FvoSEXLCK1ICajHUDtSw+5MGL10ONxfZbl4Ugx7T+P0DCrZSrCsx36lBI6ptQz+dUpPt
         30bKJQ6Zd4a/3W7pd3ET+4+S0KNI06dCHiKhBPMEyLJP2x21tsk8sFIYkzB7ps/+xXey
         mUnw==
X-Gm-Message-State: AJcUukcWcK0DegLv9gBvX3L5CUSCjGSCJXunXzYCHgJ42K50ptfJusQi
        l0UdXHq2sexqsSprJG9txes0wQ==
X-Google-Smtp-Source: ALg8bN6qxbmHknk1z2ofI5SmX05XOHuuCgY9E14yDIpXUutUUs/SvtBOxoZnC1Pe3MrHHM/2QISrLg==
X-Received: by 2002:a63:2e88:: with SMTP id u130mr15243486pgu.9.1546467312171;
        Wed, 02 Jan 2019 14:15:12 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id z9sm152320614pfd.99.2019.01.02.14.15.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Jan 2019 14:15:11 -0800 (PST)
Date:   Wed, 2 Jan 2019 14:15:10 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v7 4/4] Bluetooth: btqca: inject command complete event
 during fw download
Message-ID: <20190102221510.GQ261387@google.com>
References: <20181228114819.17479-1-bgodavar@codeaurora.org>
 <20181228114819.17479-5-bgodavar@codeaurora.org>
 <2C799DB5-8033-45B5-A790-A16F73641645@holtmann.org>
 <de93a7b7169a0cfb8f28f5d8e5138dc7@codeaurora.org>
 <1FC4CC11-B070-4ACF-9107-857A4D392876@holtmann.org>
 <1ec946b46301124c90aa12abffeca176@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ec946b46301124c90aa12abffeca176@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 31, 2018 at 11:34:46AM +0530, Balakrishna Godavarthi wrote:
> Hi Marcel,
> 
> On 2018-12-30 13:40, Marcel Holtmann wrote:
> > Hi Balakrishna,
> > 
> > > > > Latest qualcomm chips are not sending an command complete event for
> > > > > every firmware packet sent to chip. They only respond with a vendor
> > > > > specific event for the last firmware packet. This optimization will
> > > > > decrease the BT ON time. Due to this we are seeing a timeout error
> > > > > message logs on the console during firmware download. Now we are
> > > > > injecting a command complete event once we receive an vendor
> > > > > specific
> > > > > event for the last RAM firmware packet.
> > > > > Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> > > > > ---
> > > > > drivers/bluetooth/btqca.c | 39
> > > > > ++++++++++++++++++++++++++++++++++++++-
> > > > > drivers/bluetooth/btqca.h |  3 +++
> > > > > 2 files changed, 41 insertions(+), 1 deletion(-)
> > > > > diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> > > > > index ec9e03a6b778..0b533f65f652 100644
> > > > > --- a/drivers/bluetooth/btqca.c
> > > > > +++ b/drivers/bluetooth/btqca.c
> > > > > @@ -144,6 +144,7 @@ static void qca_tlv_check_data(struct
> > > > > rome_config *config,
> > > > > 		 * In case VSE is skipped, only the last segment is acked.
> > > > > 		 */
> > > > > 		config->dnld_mode = tlv_patch->download_mode;
> > > > > +		config->dnld_type = config->dnld_mode;
> > > > > 		BT_DBG("Total Length           : %d bytes",
> > > > > 		       le32_to_cpu(tlv_patch->total_size));
> > > > > @@ -264,6 +265,31 @@ static int qca_tlv_send_segment(struct
> > > > > hci_dev *hdev, int seg_size,
> > > > > 	return err;
> > > > > }
> > > > > +static int qca_inject_cmd_complete_event(struct hci_dev *hdev)
> > > > > +{
> > > > > +	struct hci_event_hdr *hdr;
> > > > > +	struct hci_ev_cmd_complete *evt;
> > > > > +	struct sk_buff *skb;
> > > > > +
> > > > > +	skb = bt_skb_alloc(sizeof(*hdr) + sizeof(*evt) + 1, GFP_KERNEL);
> > > > > +	if (!skb)
> > > > > +		return -ENOMEM;
> > > > > +
> > > > > +	hdr = skb_put(skb, sizeof(*hdr));
> > > > > +	hdr->evt = HCI_EV_CMD_COMPLETE;
> > > > > +	hdr->plen = sizeof(*evt) + 1;
> > > > > +
> > > > > +	evt = skb_put(skb, sizeof(*evt));
> > > > > +	evt->ncmd = 1;
> > > > > +	evt->opcode = HCI_OP_NOP;

After looking a bit more at it I realize HCI_OP_NOP is not a good
value in this case:

static void hci_cmd_complete_evt(...)
{
  ...

  if (*opcode != HCI_OP_NOP)
    cancel_delayed_work(&hdev->cmd_timer);

  ...
}

https://elixir.bootlin.com/linux/v4.19/source/net/bluetooth/hci_event.c#L3351

Cancelling the command timeout is precisely what we want. Not sure why
the patch with HCI_OP_NOP makes the timeouts go away in most cases
(but not e.g. when inserting an msleep(1000) after downloading the
NVM.

I suggest to pass the opcode of the command to be completed.

> > > > > +
> > > > > +	skb_put_u8(skb, QCA_HCI_CC_SUCCESS);
> > > > > +
> > > > > +	hci_skb_pkt_type(skb) = HCI_EVENT_PKT;
> > > > > +
> > > > > +	return hci_recv_frame(hdev, skb);
> > > > > +}
> > > > > +
> > > > > static int qca_download_firmware(struct hci_dev *hdev,
> > > > > 				  struct rome_config *config)
> > > > > {
> > > > > @@ -297,11 +323,22 @@ static int
> > > > > qca_download_firmware(struct hci_dev *hdev,
> > > > > 		ret = qca_tlv_send_segment(hdev, segsize, segment,
> > > > > 					    config->dnld_mode);
> > > > > 		if (ret)
> > > > > -			break;
> > > > > +			goto out;
> > > > > 		segment += segsize;
> > > > > 	}
> > > > > +	/* Latest qualcomm chipsets are not sending a command
> > > > > complete event
> > > > > +	 * for every fw packet sent. They only respond with a
> > > > > vendor specific
> > > > > +	 * event for the last packet. This optimization in the chip will
> > > > > +	 * decrease the BT in initialization time. Here we will
> > > > > inject a command
> > > > > +	 * complete event to avoid a command timeout error message.
> > > > > +	 */
> > > > > +	if ((config->dnld_type == ROME_SKIP_EVT_VSE_CC ||
> > > > > +	    config->dnld_type == ROME_SKIP_EVT_VSE))
> > > > > +		return qca_inject_cmd_complete_event(hdev);
> > > > > +
> > > > have you actually considered using __hci_cmd_send in that case. It is
> > > > allowed for vendor OGF to use that command. I see you actually do use
> > > > it and now I am failing to understand what this is for.
> > > [Bala]: thanks for reviewing the change.
> > > 
> > > __hci_cmd_send() can be used only to send the command to the chip.
> > > it will not wait for the response for the command sent.
> > > 
> > > as you know that every vendor command sent to chip will respond with
> > > vendor specific event and command complete event.
> > > but in our case chip will only respond with vendor specific event
> > > only. so we are injecting command complete event.
> > 
> > and __hci_cmd_sync_ev is also not working for you? However since you
> > are not waiting for the vendor event anyway and just injecting
> > cmd_complete, I wonder what’s the difference in just using
> > __hci_cmd_send and not bothering to wait or inject at all. I am
> > failing to see where this injection makes a difference.
> > 
> > For me it is a big difference if we are injecting one event like in
> > the case of Intel compared to injecting one for every command. It will
> > show a wrong picture in btmon and that is a bad idea.
> > 
> > Regards
> > 
> > Marcel
> 
> [Bala]: here is the use case, when ever we download the fw packets i.e. RAM
> image, for every command sent(i.e. fw packet) from
> the host chip will respond with an vendor specific event and command
> complete event.
> 
> the above is taking more time to setup the BT device. then we came up with
> solution where we enable flags in fw file (i.e. RAM image header)
> whether to wait for event to be received or sent the total packets and wait
> for the events for the last packet.
> 
> So currently we are handling both the cases in the code. i.e wait for event
> for all packet or wait for an event for the last packet.
> 
> but in the second case i.e. wait for event for the last packet sent, we are
> only receiving an vendor specific event from chip which holds the status of
> fw download.
> 
> so as __hci_cmd_sync_ev() requires an command complete event. so we are
> injecting it after the vendor specific event received for the last packet.
> 
> This helps to overcome 0xfc00 timeout error logging on console.

Some more details:

The timeout error is actually from reading the 'SoC version', which
uses the same command code as the firmware download
(EDL_PATCH_CMD_OPCODE). Without reading the 'SoC version' it would be
from the command to write the first firmware segment.

If the download of a firmware binary takes >= 2s (HCI_CMD_TIMEOUT) the
timeout would still occur. If necessary this could be mitigated by
injecting some command complete events during the firmware download,
though I expect Marcel wouldn't be overly happy with that, since it
would affect btmon even more.

Regards

Matthias
