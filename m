Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4463EC2F421
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B9AA2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jVjZOW9n";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eYqYV718"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbfAUOlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:41:42 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:36798 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729223AbfAUOll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:41:41 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2DF686098C; Mon, 21 Jan 2019 14:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548081700;
        bh=/6BQd7nvJDHIvp8L1KNVDqAAGOL4mwTrIDRaiapo6TU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jVjZOW9nMWc9gPigdAcyOWkVufk/n6lAAk5svnBHTb8Z+Q3RZ4TNneCiMUq0ZJ9N5
         SLPLrUTeBXhssGDqRFX/tlNUXseXfGATDFEdHiC6o1UIziRtp315blKA2GecJ3UEd/
         w94jPfai6Cypz9JB76KfKCV1s0QEh0IWtoQUscZU=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id BBD8060850;
        Mon, 21 Jan 2019 14:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548081699;
        bh=/6BQd7nvJDHIvp8L1KNVDqAAGOL4mwTrIDRaiapo6TU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eYqYV71826z75zAaM2rF9BfETCdndAt6enVAxFbNYedVompsJ/VnPdPJ0tSofwk/z
         MWkeKr7kHNJPEiPhWON+v8HTWaofCq0KyT3WlSlIqlyxzIe2VUNsbxNUBUCXHhyL66
         +XWe8dp0FryWhda8VMDVjQD+SHX9pzN5m3CIYukA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 21 Jan 2019 20:11:39 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Johan Hovold <johan@kernel.org>, marcel@holtmann.org,
        johan.hedberg@gmail.com, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, Johan Hovold <jhovold@gmail.com>
Subject: Re: [PATCH v5 2/5] Bluetooth: hci_qca: Deassert RTS while baudrate
 change command
In-Reply-To: <20190119003109.GD261387@google.com>
References: <20190110143928.GE3430@localhost>
 <61301df80bd6a8ee0265b31b7f6a3aa1@codeaurora.org>
 <20190111013707.GD261387@google.com>
 <194b5d18ea86830b6a24939d483a964c@codeaurora.org>
 <20190111235633.GK261387@google.com>
 <a6e083d245baebc019b6e7163fd6f133@codeaurora.org>
 <20190115234628.GQ261387@google.com> <20190117160944.GV3691@localhost>
 <20190117172109.GU261387@google.com> <20190118094416.GB3691@localhost>
 <20190119003109.GD261387@google.com>
Message-ID: <24831204bab89250099ca56e7562bd16@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2019-01-19 06:01, Matthias Kaehlcke wrote:
> On Fri, Jan 18, 2019 at 10:44:16AM +0100, Johan Hovold wrote:
>> On Thu, Jan 17, 2019 at 09:21:09AM -0800, Matthias Kaehlcke wrote:
>> 
>> > I observed that the qcom_geni_serial driver doesn't raise RTS with
>> > flow control disabled. It seems we have to investigate why that's the
>> > case. I agree that the driver should be platform agnostic.
>> 
>> Sounds like a driver bug, unless the hardware is just "odd". The
>> driver implementation of this looks very non-standard judging from a
>> quick peek.
>> 
>> In fact, qcom_geni_serial_get_mctrl() is currently a no-op if hardware
>> flow control is not enabled:
>> 
>> 	if (uart_console(uport) || !uart_cts_enabled(uport))
>> 		return;
>> 
>> Perhaps dropping the !uart_cts_enabled() test is sufficient.
> 
> Thanks for taking a look Johan, that was indeed the problem (also
> in set_mctrl()). I posted a fix:
> https://lore.kernel.org/patchwork/patch/1033611/
> 
> Balakrishna, the following (applied on top of your patch) works for me
> with the UART patch above:
> 

[Bala]: will test and update BT patch accordingly.


> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 9d5e41f159c78f..60bfdf01f72841 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1080,7 +1080,7 @@ static int qca_set_speed(struct hci_uart *hu,
> enum qca_speed_type speed_type)
>  {
>  	unsigned int speed, qca_baudrate;
>  	struct qca_serdev *qcadev;
> -	int ret;
> +	int ret = 0;
> 
>  	if (speed_type == QCA_INIT_SPEED) {
>  		speed = qca_get_speed(hu, QCA_INIT_SPEED);
> @@ -1097,22 +1097,27 @@ static int qca_set_speed(struct hci_uart *hu,
> enum qca_speed_type speed_type)
>  		 * the old speed.
>  		 */
>  		qcadev = serdev_device_get_drvdata(hu->serdev);
> -		if (qcadev->btsoc_type == QCA_WCN3990)
> +		if (qcadev->btsoc_type == QCA_WCN3990) {
> +			hci_uart_set_flow_control(hu, true);
>  			serdev_device_set_rts(hu->serdev, false);
> +		}
> 
>  		qca_baudrate = qca_get_baudrate_value(speed);
>  		bt_dev_dbg(hu->hdev, "Set UART speed to %d", speed);
>  		ret = qca_set_baudrate(hu->hdev, qca_baudrate);
>  		if (ret)
> -			return ret;
> +			goto out;
> 
>  		host_set_baudrate(hu, speed);
> 
> -		if (qcadev->btsoc_type == QCA_WCN3990)
> +out:
> +		if (qcadev->btsoc_type == QCA_WCN3990) {
> +			hci_uart_set_flow_control(hu, false);
>  			serdev_device_set_rts(hu->serdev, true);
> +		}
>  	}
> 
> -	return 0;
> +	return ret;
>  }
> 
>  static int qca_wcn3990_init(struct hci_uart *hu)

-- 
Regards
Balakrishna.
