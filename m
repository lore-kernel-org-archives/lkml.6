Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4DEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150DD2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SjFa5VLg";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SCU9HIob"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfBZMRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:17:01 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:37426 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfBZMRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 07:17:01 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CF6A360247; Tue, 26 Feb 2019 12:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551183420;
        bh=X/BAHELntUVhwGqaETlAWH7F/cpWbkaQ4IcxIUKuQ4U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SjFa5VLgidQuYD+045fd9ViJZtLpb9LZkVpx/VKJ1+olrgNOMg1T+Vov7u15Dx+VR
         zLhze9fnZWkx09BHb9oRActMKITjjFXmWYMSwcveM77KBYU8t2CAMdvKRmg8krSunn
         KzZKpzGb/mYdnavV727OFBeZ19kMWX8z6XGuIFUQ=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 7EF6760247;
        Tue, 26 Feb 2019 12:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551183416;
        bh=X/BAHELntUVhwGqaETlAWH7F/cpWbkaQ4IcxIUKuQ4U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SCU9HIobrkxrN5BMbAI4oz9TGLhE1jH2rMKwfRABlI5LSOVH4H3F0JZinIODczviM
         12idkzOpCoYv/Rlfv13rp6PrW9C0ij75dUC1QZJygrGkE/A04+XIamycHVWbPYaDy9
         gfLIOhmD/HUnOgWEMiTkuxMyf4xo6wh5EWWMZFdo=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 26 Feb 2019 17:46:56 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        hemantg@codeaurora.org
Subject: Re: [PATCH 1/3] Bluetooth: hci_qca: Pass boolean 'on/off' to
 qca_send_power_pulse()
In-Reply-To: <20190225234954.82942-2-mka@chromium.org>
References: <20190225234954.82942-1-mka@chromium.org>
 <20190225234954.82942-2-mka@chromium.org>
Message-ID: <2da5702b5d8a59306a797e692377e036@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-26 05:19, Matthias Kaehlcke wrote:
> There are only two types of power pulses 'on' or 'off', pass a boolean
> instead of the power pulse 'command'.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/bluetooth/hci_qca.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 5e03504c4e0ca..e4128774e9686 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1004,10 +1004,11 @@ static inline void host_set_baudrate(struct
> hci_uart *hu, unsigned int speed)
>  		hci_uart_set_baudrate(hu, speed);
>  }
> 
> -static int qca_send_power_pulse(struct hci_uart *hu, u8 cmd)
> +static int qca_send_power_pulse(struct hci_uart *hu, bool on)
>  {
>  	int ret;
>  	int timeout = msecs_to_jiffies(POWER_PULSE_TRANS_TIMEOUT_MS);
> +	u8 cmd = on ? QCA_WCN3990_POWERON_PULSE : QCA_WCN3990_POWEROFF_PULSE;
> 
>  	/* These power pulses are single byte command which are sent
>  	 * at required baudrate to wcn3990. On wcn3990, we have an external
> @@ -1138,12 +1139,12 @@ static int qca_wcn3990_init(struct hci_uart 
> *hu)
> 
>  	/* Forcefully enable wcn3990 to enter in to boot mode. */
>  	host_set_baudrate(hu, 2400);
> -	ret = qca_send_power_pulse(hu, QCA_WCN3990_POWEROFF_PULSE);
> +	ret = qca_send_power_pulse(hu, false);
>  	if (ret)
>  		return ret;
> 
>  	qca_set_speed(hu, QCA_INIT_SPEED);
> -	ret = qca_send_power_pulse(hu, QCA_WCN3990_POWERON_PULSE);
> +	ret = qca_send_power_pulse(hu, true);
>  	if (ret)
>  		return ret;
> 
> @@ -1289,7 +1290,7 @@ static void qca_power_shutdown(struct hci_uart 
> *hu)
>  	spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
> 
>  	host_set_baudrate(hu, 2400);
> -	qca_send_power_pulse(hu, QCA_WCN3990_POWEROFF_PULSE);
> +	qca_send_power_pulse(hu, false);
>  	qca_power_setup(hu, false);
>  }

Reviewed-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>

-- 
Regards
Balakrishna.
