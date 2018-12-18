Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E66AC43612
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E581217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545124387;
	bh=zUFQpdcaWT/Rj/5p0J7zOMRT0X3gfwVnpGrdMolw7MY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S80Z6fYcY964iDp0wbAOX7z5pzMlhS+BzDvPF7ewapUUkHri8hJ5Udjp5sftP9z5X
	 xZ0yylYwW8UmJNaKJS1/MT73puT6aXle2rie4xH1ipr8nmiB6Sj0Cg0+ce2NTcchAO
	 QyzO91zA3JoXRS0kbhJ3E0Nx9u0uyRTxxaAjepF0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbeLRJNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 04:13:06 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34638 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbeLRJNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 04:13:06 -0500
Received: by mail-lf1-f66.google.com with SMTP id p6so11693373lfc.1;
        Tue, 18 Dec 2018 01:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6r0hfYSfE3H+Mwp6T1U8Eexoij36bxoyzYXm6MDevnk=;
        b=inHGPsApkBOl/l8VXy96N0gBlgo72Xcqkt73LbfTorkn4bBdYFrdjd16ke23x8kxzQ
         SJ9PbY2Awxu8wvSvobSwi/++mGITt4dhAKiEO/0jpmDyHHZyurEp9b5LwcWIXYwN1E4N
         P0Ce0Paa2npDGGoDPjYUyua3zs65N4SkFmpouqRREIZy2lnCox0yvfrWL6OgwqCLcEx9
         6o8cy5zQB8WWyyA6ijmEt5q/LUio8IxyJ1zYW/ZWqZ5cnsp5lENFHaixhbOJOFKT3vlV
         qeRQP8s8zDvRzOLFTgn4G9iAUwbeF1n8RBtwFv1E8hdfeoubP/haJ016f9AcMd5lopBz
         CXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6r0hfYSfE3H+Mwp6T1U8Eexoij36bxoyzYXm6MDevnk=;
        b=iI9VD5ODdKl0R0Lo8Tpu4b2rJkC+JgKWfwU2hOC7yEe/n9KI6M8NhflDJnn8mNxDmA
         o7IA9RAc73Lwiq8DYibEvegWKqZaeo39MUnR5CojY0zX6rNYH4HlaeOd/CfhN1yDwlF2
         XRYme2uatxZ0c29MXY73dvy+fSp+9UVAkkzUtQiimavaeNb21u145LYKcYwT01M5Staw
         TaSpv/Kh0HK9O81qC9TAGbn5IKE2nXWp0hCFEfrxgRd/BYe6Wco3aP3709vKpPETVQIt
         uZpNNEDFC4g5VGzNPtZBE4Xq8H1uWQid27X39CrsPqqSwumbfhcDfcWG5hqulPI+3y/I
         fzpw==
X-Gm-Message-State: AA+aEWasggPcptRxMzgALdwH3OxWJTxzcUh8b2p/7z8IbZS5IvYA6nwo
        zSkzoG96q74Oh77YjsDOB0s=
X-Google-Smtp-Source: AFSGD/VhxxCVtqCyBo7mATlvQS2HsiulYqLuZvKg06S4otYtyNiKoQ5ILRTfqr3m0Q/EVOoKZii91A==
X-Received: by 2002:a19:9508:: with SMTP id x8mr9722456lfd.112.1545124384054;
        Tue, 18 Dec 2018 01:13:04 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id s3-v6sm2998886lje.73.2018.12.18.01.13.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 01:13:03 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gZBR4-0002ME-72; Tue, 18 Dec 2018 10:13:06 +0100
Date:   Tue, 18 Dec 2018 10:13:06 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, johan@kernel.org,
        mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 1/5] Bluetooth: hci_qca: use wait_until_sent() for
 power pulses
Message-ID: <20181218091306.GA10562@localhost>
References: <20181217141330.6294-1-bgodavar@codeaurora.org>
 <20181217141330.6294-2-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217141330.6294-2-bgodavar@codeaurora.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 07:43:26PM +0530, Balakrishna Godavarthi wrote:
> wcn3990 requires a power pulse to turn ON/OFF along with
> regulators. Sometimes we are observing the power pulses are sent
> out with some time delay, due to queuing these commands. This is
> causing synchronization issues with chip, which intern delay the
> chip setup or may end up with communication issues.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
> v4:
>  * used serdev_device_write_buf() instead of serdev_device_write()
> 
> v3:
>   * no change.
> v2: 
>   * Updated function qca_send_power_pulse()
>   * addressed reviewer comments.
> 
> v1:
>  * initial patch
> 
> ---
>  drivers/bluetooth/hci_qca.c | 37 +++++++++++++------------------------
>  1 file changed, 13 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index f036c8f98ea3..d8bc77c8c9b9 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1013,11 +1013,9 @@ static inline void host_set_baudrate(struct hci_uart *hu, unsigned int speed)
>  		hci_uart_set_baudrate(hu, speed);
>  }
>  
> -static int qca_send_power_pulse(struct hci_dev *hdev, u8 cmd)
> +static int qca_send_power_pulse(struct hci_uart *hu, u8 cmd)
>  {
> -	struct hci_uart *hu = hci_get_drvdata(hdev);
> -	struct qca_data *qca = hu->priv;
> -	struct sk_buff *skb;
> +	int ret;
>  
>  	/* These power pulses are single byte command which are sent
>  	 * at required baudrate to wcn3990. On wcn3990, we have an external
> @@ -1029,19 +1027,16 @@ static int qca_send_power_pulse(struct hci_dev *hdev, u8 cmd)
>  	 * save power. Disabling hardware flow control is mandatory while
>  	 * sending power pulses to SoC.
>  	 */
> -	bt_dev_dbg(hdev, "sending power pulse %02x to SoC", cmd);
> -
> -	skb = bt_skb_alloc(sizeof(cmd), GFP_KERNEL);
> -	if (!skb)
> -		return -ENOMEM;
> -
> +	bt_dev_dbg(hu->hdev, "sending power pulse %02x to SoC", cmd);
>  	hci_uart_set_flow_control(hu, true);
> +	ret = serdev_device_write_buf(hu->serdev, &cmd, sizeof(cmd));
> +	if (ret < 0) {
> +		bt_dev_err(hu->hdev, "failed to send power pulse %02x to SoC",
> +			   cmd);
> +		return ret;
> +	}

As I mentioned earlier, serdev_device_write_buf() can buffer less than
sizeof(cmd) bytes if the tty driver's write buffer is full (and return
the number of bytes buffered).

How you want to deal with that is up to you and the bluetooth
maintainers, but I think you want to at least log it even if you choose
to ignore it.

Johan
