Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D9FC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D90206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547045546;
	bh=A+VzfcjrHJEwoNmY7LN6qVm0Y6NW79eDYnwIh5MM3U8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NaY9kU/BJeNpMy/4YhZhgiqu/oX0npJeZAQ5Pc1zXcpcf0yHCvVq2tKB89tG+PiH4
	 hr2vr4T0Wvdg5Oxz1Y8KFbnbclJ+dfHVghzrzbxiPec4V9Gse97EXQCtXqfx+vofMf
	 ash3dmEXnI36fO1RTklRGkE+OrpdS4wBLueGmhLs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732134AbfAIOwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:52:25 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37237 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731894AbfAIOwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:52:24 -0500
Received: by mail-lf1-f65.google.com with SMTP id y11so5850871lfj.4;
        Wed, 09 Jan 2019 06:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CTOH2U9RnpHUdI/YfiBNuwRGlHn4ti/2BLzinWpx71A=;
        b=gimAuo9EG2tEFGet8cxftE3/of/TsHB3hlbvNuU4JTKX80EoMYFS1jMz6riWn79vho
         /PMeIKn0ARMYQRk23Jm3xabZH4P9JWjNPK3bknoICz9Y4/Mu3diE9Ov1ha3wMGUr8h9A
         OnbxYimrW+l8kZqhDmbknII1/Am/jPJignnO51Lf0k83RuBqQgVjrbOeexGr3fsNCcgN
         1xniGpPAzD7Gf0PvkBejgZbbDlJzf70iBrY7CzKQeNme4nbkgxzyGMg2M46ubM9WL9Eo
         Zr8Fnbxx+r1YmYrj7dPefRrArwYmzL7GXqur24tQM9n+D90+KiVqeufZs/bs4fQ8IqrR
         FClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=CTOH2U9RnpHUdI/YfiBNuwRGlHn4ti/2BLzinWpx71A=;
        b=OFzQ4xyGJiX5SVfReUHG1bVps03KWW58Qo7kpK+zh6lzuGV/docaeFK6oi2kovJytX
         MnBWxx7aAo5oQbD9fjGUK3c38Qwos6zYzt5tN37mjn1e6HK4h447OLD4n1rghO/J1+MS
         K6PRn5qYfBkj4Tl+2R0LgNok3EMK6MQOVR9bf3ynTUqIOvLWFTwNQ74Pa8G0h4HtPFvo
         tE6xlVSYFz9w281FIgXBZbZXuJUSXAVkPSymjW605cD2b/2WE9rc0mCT0efawRPKNYev
         jeqN8r6oaZhfEAXkXyP8ezFaDcy0b7ZQuePvg8pe5HSEWgwSZjd6j6X5gCZzCJiYLnbc
         6i3w==
X-Gm-Message-State: AJcUukfPXQSNpsF+g3WfoxOAOYtO4/+xXUXtTXV84n/Fpu0Q+Jm55lz4
        zim80+q2X0Gkk954bcAtG4U=
X-Google-Smtp-Source: ALg8bN4vl6auDLxa5fEhpTZFGpIGQ+MDO+/LNsKr0lHwoubLl5stD9bo5hiAEknLS9NtiIbN7zoVUA==
X-Received: by 2002:a19:8fce:: with SMTP id s75mr3537633lfk.151.1547045541898;
        Wed, 09 Jan 2019 06:52:21 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id k21-v6sm14646036ljc.15.2019.01.09.06.52.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 06:52:20 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1ghFDU-0000fN-QQ; Wed, 09 Jan 2019 15:52:24 +0100
Date:   Wed, 9 Jan 2019 15:52:24 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, johan@kernel.org,
        mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 2/5] Bluetooth: hci_qca: Deassert RTS while baudrate
 change command
Message-ID: <20190109145224.GN14782@localhost>
References: <20181220144639.15928-1-bgodavar@codeaurora.org>
 <20181220144639.15928-3-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220144639.15928-3-bgodavar@codeaurora.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 08:16:36PM +0530, Balakrishna Godavarthi wrote:
> This patch will help to stop frame reassembly errors while changing
> the baudrate. This is because host send a change baudrate request
> command to the chip with 115200 bps, Whereas chip will change their
> UART clocks to the enable for new baudrate and sends the response
> for the change request command with newer baudrate, On host side
> we are still operating in 115200 bps which results of reading garbage
> data. Here we are pulling RTS line, so that chip we will wait to send data
> to host until host change its baudrate.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/bluetooth/hci_qca.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 5a07c2370289..1680ead6cc3d 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -963,7 +963,6 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
>  	struct hci_uart *hu = hci_get_drvdata(hdev);
>  	struct qca_data *qca = hu->priv;
>  	struct sk_buff *skb;
> -	struct qca_serdev *qcadev;
>  	u8 cmd[] = { 0x01, 0x48, 0xFC, 0x01, 0x00 };
>  
>  	if (baudrate > QCA_BAUDRATE_3200000)
> @@ -977,13 +976,6 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
>  		return -ENOMEM;
>  	}
>  
> -	/* Disabling hardware flow control is mandatory while
> -	 * sending change baudrate request to wcn3990 SoC.
> -	 */
> -	qcadev = serdev_device_get_drvdata(hu->serdev);
> -	if (qcadev->btsoc_type == QCA_WCN3990)
> -		hci_uart_set_flow_control(hu, true);
> -
>  	/* Assign commands to change baudrate and packet type. */
>  	skb_put_data(skb, cmd, sizeof(cmd));
>  	hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
> @@ -999,9 +991,6 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
>  	schedule_timeout(msecs_to_jiffies(BAUDRATE_SETTLE_TIMEOUT_MS));
>  	set_current_state(TASK_RUNNING);
>  
> -	if (qcadev->btsoc_type == QCA_WCN3990)
> -		hci_uart_set_flow_control(hu, false);
> -
>  	return 0;
>  }
>  
> @@ -1086,6 +1075,7 @@ static int qca_check_speeds(struct hci_uart *hu)
>  static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>  {
>  	unsigned int speed, qca_baudrate;
> +	struct qca_serdev *qcadev;
>  	int ret;
>  
>  	if (speed_type == QCA_INIT_SPEED) {
> @@ -1097,6 +1087,15 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>  		if (!speed)
>  			return 0;
>  
> +		/* Deassert RTS while changing the baudrate of chip and host.
> +		 * This will prevent chip from transmitting its response with
> +		 * the new baudrate while the host port is still operating at
> +		 * the old speed.
> +		 */
> +		qcadev = serdev_device_get_drvdata(hu->serdev);
> +		if (qcadev->btsoc_type == QCA_WCN3990)
> +			serdev_device_set_rts(hu->serdev, false);
> +

This may not do what you want unless you also disable hardware flow
control.

Johan
