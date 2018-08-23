Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7D8C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 23:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38DBB2152D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 23:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuZRfyWU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38DBB2152D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbeHXDCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 23:02:31 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36450 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeHXDCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 23:02:30 -0400
Received: by mail-pg1-f196.google.com with SMTP id h17-v6so3400069pgv.3;
        Thu, 23 Aug 2018 16:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5EwisKCmybbuWrVzUR7BLxIaN5zUrmHv6nnXrV/4jw4=;
        b=kuZRfyWUOjnI8bjJHmBVMn7KD8HFwCZzYTnp0Q+4DpEtAtRp/IxBdkTd98J9tQteOO
         80ENzyjR9tdxhOAhIL3L5zJ9SfhyipeXy47QfN41aT2omZ2UKbZOVbXFZ0CiMfFnnY6l
         9w/PstNZOeIwjcck9j4p4M7Bul6sHSTvcN9qDK1rprHcQympTZ8C/U69wA5R5rjNMvjl
         y1J5ie3hnmgHwooVv2y+KP5NajIqTys+CvNN06zBNj3lchHMPap2VHJo2Cr25xKuOmod
         4b8rRuNjASrksbwTfW04I+TFrymNThvL9MWHkgMov9Zv3jydRDeijAFMp88P5rQA3mlU
         nTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5EwisKCmybbuWrVzUR7BLxIaN5zUrmHv6nnXrV/4jw4=;
        b=SvF1lGa7HSK8OB3xs8fXCm2srNTRinay9I3jDgasn6+8SzyIVeGhQPMFT8pXOFGCQy
         AoFmkWlSlyTX3e6ursN+m/pgJg1dJJArk5cZZ944UGVHyVb3yyHV7ah1LNsBX3j7LToj
         wmyrsBJGZHOeZrDfu2aWiJq5nf5SeMwDr1+Zv3daChA6B4SJ82yqradsA2A3F4x8++UL
         yHdO2Rr46avEyzfzyXqx++D3OFhlv3C66tBaq+y0WCP9of99KA3MWOMjzVqceh61h3fa
         rGiTrXpI6N37HuoFKqM2QG7gjFSMVtLpnmRvVnVQL/kErVnJa+ZCY4LRorYdm84uhxDn
         Sg9Q==
X-Gm-Message-State: AOUpUlGaibPwLjz7rnirjCTsTElxahAa18DIuadAVZVWqmOv+XBiFPUY
        MKEn+PK3ErxPpfE21iveKWo=
X-Google-Smtp-Source: AA+uWPxMQrwiVDHhPo7lsR03d6jFTZ4H6CtRqw07olaYZ61t6GhnTwfQ6rKTJQ5lkNzA+lIGCSZx2g==
X-Received: by 2002:a62:c90a:: with SMTP id k10-v6mr63907798pfg.180.1535067031810;
        Thu, 23 Aug 2018 16:30:31 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id p66-v6sm8720191pfd.65.2018.08.23.16.30.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 16:30:30 -0700 (PDT)
Date:   Thu, 23 Aug 2018 16:30:28 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Derek Basehore <dbasehore@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        joe@perches.com, andi@etezian.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH] Input: elants_i2c - Fix sw reset delays
Message-ID: <20180823233028.GC53155@dtor-ws>
References: <20180823231013.254037-1-dbasehore@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823231013.254037-1-dbasehore@chromium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Derek,

On Thu, Aug 23, 2018 at 04:10:13PM -0700, Derek Basehore wrote:
> We only need to wait 10ms instead of 30ms before starting fastboot or
> sending IAP on the touchscreen. Also, instead of delaying everytime
> sw_reset is called, this delays 10ms in the function that starts
> fastboot. There's also an explicit 20ms delay before sending IAP when
> updating the firmware, so no additional delay is needed there. This
> change also has the benefit of not delaying when wakeup is enabled
> during suspend. This is because sw_reset is called, yet fastboot
> isn't.
> 
> Change-Id: I9e3019720186ba0023891fafeb4fe3d2510e454b

This is not needed ;)

> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> ---
>  drivers/input/touchscreen/elants_i2c.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
> index d21ca39b0fdb..18ce04ba0173 100644
> --- a/drivers/input/touchscreen/elants_i2c.c
> +++ b/drivers/input/touchscreen/elants_i2c.c
> @@ -284,12 +284,6 @@ static int elants_i2c_sw_reset(struct i2c_client *client)
>  		return error;
>  	}
>  
> -	/*
> -	 * We should wait at least 10 msec (but no more than 40) before
> -	 * sending fastboot or IAP command to the device.
> -	 */
> -	msleep(30);
> -
>  	return 0;
>  }
>  
> @@ -500,6 +494,12 @@ static int elants_i2c_fastboot(struct i2c_client *client)
>  	const u8 boot_cmd[] = { 0x4D, 0x61, 0x69, 0x6E };
>  	int error;
>  
> +	/*
> +	 * We should wait at least 10 msec (but no more than 40) before sending
> +	 * fastboot command to the device.
> +	 */
> +	usleep_range(10 * 1000, 11 * 1000);
> +
>  	error = elants_i2c_send(client, boot_cmd, sizeof(boot_cmd));
>  	if (error) {
>  		dev_err(&client->dev, "boot failed: %d\n", error);
> @@ -643,6 +643,10 @@ static int elants_i2c_do_update_firmware(struct i2c_client *client,
>  			dev_err(&client->dev, "Failed close idle: %d\n", error);
>  		msleep(60);
>  		elants_i2c_sw_reset(client);
> +		/*
> +		 * We should wait at least 10 msec (but no more than 40) before
> +		 * sending IAP command to the device.
> +		 */
>  		msleep(20);

So the original comment was talking about timing on fastboot or IAP
command, but the original code had 50 msec wait here (30 from
elants_i2c_sw_reset plus the 20), thus already violating 40 msec rule
for IAP. Unless Elan folks can confirm it is OK to reduce the wait here
I'd prefer we kept it at 50. Firmware update is does not happen that
often anyway.

Thanks.

-- 
Dmitry
