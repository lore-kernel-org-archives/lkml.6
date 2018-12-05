Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8A9C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62EBC206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="txIEH2uk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62EBC206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbeLEGZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 01:25:06 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37721 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbeLEGZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 01:25:05 -0500
Received: by mail-lj1-f194.google.com with SMTP id e5-v6so17242539lja.4;
        Tue, 04 Dec 2018 22:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5QY/1Ml4Uba9OMC9jYH1RXCMD6KPLn2BRWMhqIvwP7c=;
        b=txIEH2ukOndvOgoKSZhp/DeUAu+mxzNmLHemDyKVpRZ2JtuYH+mxswhVn402cukVGH
         YlYOdcq+PipTjH9weKcyYJ/MHBMowZdzUojWQcEn0cwoO5w/hFQ+n//YRYGhbh+V0Kul
         J9/GbGF+19Qmre2/7R/wJNX9DxXnp3hn4i5JOCcg6WI2zh2mvJ54OzJzGr59vSiGoYs3
         SjMuqYO2EXLBn5WFAOShTHbHZiNmwZYsdfyTZfx2QDTKPZY+5YBy5knABQEbqDhGt5iA
         qFxKDCcrd7W8v6XMOhyJOvaWVS7lCvnHEQnrkTNPUlK6q1//PTps4aTSje589VbGsJrr
         Sz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5QY/1Ml4Uba9OMC9jYH1RXCMD6KPLn2BRWMhqIvwP7c=;
        b=LU+wFixNRn4Ic7TMgMZ5YPt9x0zY7i5HLhxkbCahtVkzbwzyFPjAZbB7ePCP6dK6zO
         YA8ydSpz/HPkdrkG+Mw6QGehhrf87wXhyoR7yVi3vLOtCnty7kxL9l59knU3m8RYvmDT
         Gtrgi8v+rSfw6EV5hKKFVYEfF43iC58UmcxE9UPSQWsdIHy5sktUP92tZb0Qkosk9akk
         P6I6c1q/snh+VpunXnL90mKRrk+8QX4WRlgLBKrG9e5wp0n7pQZa4a6EL1ayQfEY1cDS
         pthmeAxCsU8jR6NiDxPbNeGWS9t5eHLlgIJXawdVGBUqda3glRaBjJLbcAIMCYfO1VBQ
         bM0Q==
X-Gm-Message-State: AA+aEWa0hwWIhI2J8ZG23+XptbfPY+CkkylLQ/hr8qlwsHJMtSZ8EXwp
        w15OfO5y5G9GMLG06UEf+Jk=
X-Google-Smtp-Source: AFSGD/XCZ8UvG3pTdJfJI8e1cG8p6V31B5zTlKmgz6Rxbm0in+FzQ569RojS6OMoja/kVc2kjkljaQ==
X-Received: by 2002:a2e:9694:: with SMTP id q20-v6mr14658588lji.173.1543991103049;
        Tue, 04 Dec 2018 22:25:03 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id c88-v6sm2377482ljf.60.2018.12.04.22.25.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 22:25:02 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gUQcJ-00019l-Vq; Wed, 05 Dec 2018 07:25:04 +0100
Date:   Wed, 5 Dec 2018 07:25:03 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 1/4] Bluetooth: hci_qca: use wait_until_sent() for
 power pulses
Message-ID: <20181205062503.GG18087@localhost>
References: <20181130150247.26294-1-bgodavar@codeaurora.org>
 <20181130150247.26294-2-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130150247.26294-2-bgodavar@codeaurora.org>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 08:32:44PM +0530, Balakrishna Godavarthi wrote:
> wcn3990 requires a power pulse to turn ON/OFF along with
> regulators. Sometimes we are observing the power pulses are sent
> out with some time delay, due to queuing these commands. This is
> causing synchronization issues with chip, which intern delay the
> chip setup or may end up with communication issues.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
> v3:
>   * no change.
> v2: 
>   * Updated function qca_send_power_pulse()
>   * addressed reviewer comments.

Please make sure to include reviewers on CC when resending, and as
someone else already mentioned, be a bit more specific about what
changes you actually made in response to the review feedback you
received.

> v1:
>  * initial patch
> ---
>  drivers/bluetooth/hci_qca.c | 37 +++++++++++++------------------------
>  1 file changed, 13 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index f036c8f98ea3..f5dd323c1967 100644
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
> +	ret = serdev_device_write(hu->serdev, &cmd, sizeof(cmd), 0);

You're still using 0 as a timeout here which is broken, as I already
told you.

From 4.21 this will result in an indefinite timeout, but currently
implies not to wait for a full write buffer to drain at all.

As I also mentioned, you need to to make sure to call
serdev_device_write_wakeup() in the write_wakup() path if you are going
to use serdev_device_write() at all.

Johan
