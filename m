Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7803C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CDD520869
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wj/fYxwf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731744AbeL1TuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 14:50:23 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36713 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730760AbeL1TuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 14:50:23 -0500
Received: by mail-pl1-f194.google.com with SMTP id g9so10388546plo.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 11:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=96/pjSXhAMjwkHr3rbMEv/489k9NFNRoowfW2wnsCNA=;
        b=Wj/fYxwfXVyU2RA9Ip6FPglDMMCEpiKzEuo+TvDxrLeEO6JS9aeJVstE3zAuM3330F
         0gUFgNR+60Yqdsa2JtwJCnuEAHTrupH7EOpdpGN0iqvTCfIgG9EIPTU6TSlKfozPb1A5
         WwAgp+k6599Y5eyiOemry5+MDTCuNigUrR+dE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=96/pjSXhAMjwkHr3rbMEv/489k9NFNRoowfW2wnsCNA=;
        b=tR3UmkLX9zvpWDjcExxox4EGKNh8pDgfZWuGfxuJ5EfNCwnkMtM3AiOfDBt/Q/OdJN
         NZGOnXHR9MfLRxKc1ejoHWcRt8APTwIqx5UG8//ycQGAQClhcVCpwVSqUuDETNM/CagE
         loONAK6CgBlfpTsyabFUSerQE35ATjMuwBaMbX4GC2dVwH/o2wG/ELmJRWl6amixLqt/
         akLhrHBKAGmMoWImy3AfyuG5KwynQMSSv+tpKGLZo7xmdDpnIidoZZ20068I30qN6C5R
         FC+5PFu7e+ffLZD3EA4s+T0r+KjFyPQWmB12EKiARj7hmG/mry18mOLtEz1AF1g6GDGZ
         0QNA==
X-Gm-Message-State: AJcUukdp/8yfZSRIr93c5GQXcYxkZhWVTjecvcaRg1vmsZGEv818UaRM
        yERfjxGRtkpMd7IiMXbrClvm6g==
X-Google-Smtp-Source: ALg8bN6iZseIOZSPsjqMMPvYJ0ZOQlpCmyrxkwqmQ/OSwlJwb4fMlTo5ORq3VJD0tRdMwwTftl6oOQ==
X-Received: by 2002:a17:902:1127:: with SMTP id d36mr28000603pla.299.1546026622187;
        Fri, 28 Dec 2018 11:50:22 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id v89sm22789366pfj.164.2018.12.28.11.50.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 11:50:21 -0800 (PST)
Date:   Fri, 28 Dec 2018 11:50:20 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v7 4/4] Bluetooth: btqca: inject command complete event
 during fw download
Message-ID: <20181228195020.GN261387@google.com>
References: <20181228114819.17479-1-bgodavar@codeaurora.org>
 <20181228114819.17479-5-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181228114819.17479-5-bgodavar@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 05:18:19PM +0530, Balakrishna Godavarthi wrote:
> Latest qualcomm chips are not sending an command complete event for
> every firmware packet sent to chip. They only respond with a vendor
> specific event for the last firmware packet. This optimization will
> decrease the BT ON time. Due to this we are seeing a timeout error
> message logs on the console during firmware download. Now we are
> injecting a command complete event once we receive an vendor specific
> event for the last RAM firmware packet.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
>  drivers/bluetooth/btqca.c | 39 ++++++++++++++++++++++++++++++++++++++-
>  drivers/bluetooth/btqca.h |  3 +++
>  2 files changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index ec9e03a6b778..0b533f65f652 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -144,6 +144,7 @@ static void qca_tlv_check_data(struct rome_config *config,
>  		 * In case VSE is skipped, only the last segment is acked.
>  		 */
>  		config->dnld_mode = tlv_patch->download_mode;
> +		config->dnld_type = config->dnld_mode;
>  
>  		BT_DBG("Total Length           : %d bytes",
>  		       le32_to_cpu(tlv_patch->total_size));
> @@ -264,6 +265,31 @@ static int qca_tlv_send_segment(struct hci_dev *hdev, int seg_size,
>  	return err;
>  }
>  
> +static int qca_inject_cmd_complete_event(struct hci_dev *hdev)
> +{
> +	struct hci_event_hdr *hdr;
> +	struct hci_ev_cmd_complete *evt;
> +	struct sk_buff *skb;
> +
> +	skb = bt_skb_alloc(sizeof(*hdr) + sizeof(*evt) + 1, GFP_KERNEL);
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	hdr = skb_put(skb, sizeof(*hdr));
> +	hdr->evt = HCI_EV_CMD_COMPLETE;
> +	hdr->plen = sizeof(*evt) + 1;
> +
> +	evt = skb_put(skb, sizeof(*evt));
> +	evt->ncmd = 1;
> +	evt->opcode = HCI_OP_NOP;
> +
> +	skb_put_u8(skb, QCA_HCI_CC_SUCCESS);
> +
> +	hci_skb_pkt_type(skb) = HCI_EVENT_PKT;
> +
> +	return hci_recv_frame(hdev, skb);
> +}
> +
>  static int qca_download_firmware(struct hci_dev *hdev,
>  				  struct rome_config *config)
>  {
> @@ -297,11 +323,22 @@ static int qca_download_firmware(struct hci_dev *hdev,
>  		ret = qca_tlv_send_segment(hdev, segsize, segment,
>  					    config->dnld_mode);
>  		if (ret)
> -			break;
> +			goto out;
>  
>  		segment += segsize;
>  	}
>  
> +	/* Latest qualcomm chipsets are not sending a command complete event
> +	 * for every fw packet sent. They only respond with a vendor specific
> +	 * event for the last packet. This optimization in the chip will
> +	 * decrease the BT in initialization time. Here we will inject a command
> +	 * complete event to avoid a command timeout error message.
> +	 */
> +	if ((config->dnld_type == ROME_SKIP_EVT_VSE_CC ||
> +	    config->dnld_type == ROME_SKIP_EVT_VSE))
> +		return qca_inject_cmd_complete_event(hdev);
> +
> +out:
>  	release_firmware(fw);
>  
>  	return ret;
> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
> index 0c01f375fe83..5c8fc54133e3 100644
> --- a/drivers/bluetooth/btqca.h
> +++ b/drivers/bluetooth/btqca.h
> @@ -40,6 +40,8 @@
>  #define QCA_WCN3990_POWERON_PULSE	0xFC
>  #define QCA_WCN3990_POWEROFF_PULSE	0xC0
>  
> +#define QCA_HCI_CC_SUCCESS		0x00
> +
>  enum qca_bardrate {
>  	QCA_BAUDRATE_115200 	= 0,
>  	QCA_BAUDRATE_57600,
> @@ -81,6 +83,7 @@ struct rome_config {
>  	char fwname[64];
>  	uint8_t user_baud_rate;
>  	enum rome_tlv_dnld_mode dnld_mode;
> +	enum rome_tlv_dnld_mode dnld_type;

The ->dnld_type vs ->dnld_mode is a bit confusing, I don't have a
better suggestion though.

>  };
>  
>  struct edl_event_hdr {

I'm not an expert in dealing with HCI SKBs, as far as I can tell the
above looks sane to me and I confirmed that it fixes the timeout when
downloading firmware.

Tested-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
