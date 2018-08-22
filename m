Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028BDC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 18:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A238720C08
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 18:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtGlK1aG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A238720C08
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbeHVVeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 17:34:18 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34942 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbeHVVeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 17:34:18 -0400
Received: by mail-qt0-f195.google.com with SMTP id f19-v6so1746197qtf.2;
        Wed, 22 Aug 2018 11:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pHy+g1NFNSKciLi7LPwZcuLIkW0bx8y/4Sruevpf9Mg=;
        b=GtGlK1aGVoacdj2ORMfbG/fYlB9xc5eLXvjmXSt339lPoAHcyI1B/Q4H0g6eTmysEV
         I/Wo3J/gm2ST4NjIb0a9ctHZkcbUYueu5DJcDerLbCLg7s6wcEVCDJes0x9NDyeBB+4L
         ZrThf2uYUQaH8Gna2dzHLifTzGfFc29VpTHj9M30ATFDjwrcYRNrSuO8KOcveVjodjAi
         Hy3lmonGSmkO2pPkbjql26lHATYnweesLjggZU8RId4mZuzFZVuR5GGSlW5/WSJjzYhX
         MTWLhBEjmFk1waRQxLqLR4nCvm7FNdN4Xy+h6VVrz/2PoU95/FyB0EKOht/cY+4pYAjq
         RTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pHy+g1NFNSKciLi7LPwZcuLIkW0bx8y/4Sruevpf9Mg=;
        b=W0t1qWTYHZ650iaPknwn0xbcqLsDo4dfJl/mEpYa3HjVAp+fCii9RJmuSE2x/cXrSX
         7Qyy8H8CJvsYeVWelHjCxlVjF0vqDmw4pQxcOzQPrJ2gFEwLxZ6Qb26Qv9LwXj4anOzo
         GjQg5B1BVl3T1seVqkTFTEq1FafzHJK0hwutGEtgICfqFsJ3unXuU7Vrde0q+rK7RmVD
         RlLLUZYyuXwgtmCVjd1OS9O4jNbijXHF7ThXwplfp3KQqjSlHB2RjAfuW06lEnuVPpE1
         LSmwema7zk049R9ws/EAzVSWM53Z59DZGqGrmV88cHJ54Tpt83fozBffqJZYTzM4gZTs
         CwfQ==
X-Gm-Message-State: AOUpUlHOoKe6dqCyNUWfcdjc/u7+/i6zrI2FcShIZGDlcj5uiygneHPh
        nE8kbVgual9hERVXJSzeEcg=
X-Google-Smtp-Source: AA+uWPz+iPwJjrQ0sj3lCCKC1Dg8x3LNF3v/q64KuCa/oXUGzdHYYT+MZGO4QfwZJ2tFCoLNU940LQ==
X-Received: by 2002:a0c:f883:: with SMTP id u3-v6mr52167886qvn.28.1534961302880;
        Wed, 22 Aug 2018 11:08:22 -0700 (PDT)
Received: from gandalf.middle.earth.net (pool-173-48-42-19.bstnma.fios.verizon.net. [173.48.42.19])
        by smtp.gmail.com with ESMTPSA id r1-v6sm1438944qkl.85.2018.08.22.11.08.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 11:08:22 -0700 (PDT)
From:   "George G. Davis" <ggdavisiv@gmail.com>
X-Google-Original-From: "George G. Davis" <george_davis@mentor.com>
Date:   Wed, 22 Aug 2018 14:08:20 -0400
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     nick@shmanahar.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, alexandre.belloni@bootlin.com,
        dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/3] Input: atmel_mxt_ts: Wait for device be ready for
 communication
Message-ID: <20180822180820.GB4102@gandalf.middle.earth.net>
References: <1533050291-11502-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1533050291-11502-3-git-send-email-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1533050291-11502-3-git-send-email-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Paweł,

On Tue, Jul 31, 2018 at 05:18:10PM +0200, Paweł Chmiel wrote:
> According to documentation, device isn't ready for communication,
> until firmware asserts the CHG line. Add missing wait for this.
> 
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index 2cd7f6db6ba9..79e08916359f 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -202,6 +202,7 @@ enum t100_type {
>  #define MXT_CRC_TIMEOUT		1000	/* msec */
>  #define MXT_FW_RESET_TIME	3000	/* msec */
>  #define MXT_FW_CHG_TIMEOUT	300	/* msec */
> +#define MXT_POWERON_DELAY	150	/* msec */
>  
>  /* Command to unlock bootloader */
>  #define MXT_UNLOCK_CMD_MSB	0xaa
> @@ -3046,6 +3047,16 @@ static int mxt_regulator_enable(struct mxt_data *data)
>  		msleep(MXT_REGULATOR_DELAY);
>  		gpiod_set_value(data->reset_gpio, 1);
>  		msleep(MXT_RESET_INVALID_CHG);
> +
> +retry_wait:
> +		reinit_completion(&data->bl_completion);
> +		data->in_bootloader = true;
> +		error = mxt_wait_for_completion(data, &data->bl_completion,
> +										MXT_POWERON_DELAY);

Please fix the following checkpatch issues:

drivers/input/touchscreen/atmel_mxt_ts.c:3078: WARNING:LONG_LINE: line over 80 characters
drivers/input/touchscreen/atmel_mxt_ts.c:3078: CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis

Thanks!

--
Regards,
George

> +		if (error == -EINTR)
> +			goto retry_wait;
> +
> +		data->in_bootloader = false;
>  	}
>  
>  	return 0;
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
