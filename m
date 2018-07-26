Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC07C67790
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 00:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 198FC20852
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 00:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DupluEng"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 198FC20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbeGZCGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 22:06:30 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42476 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbeGZCGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 22:06:30 -0400
Received: by mail-pl0-f67.google.com with SMTP id z7-v6so4001154plo.9;
        Wed, 25 Jul 2018 17:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LsOB+sBjc5JCoaeZhEAOxaHCPVdGRezpDi2kOmvNSb0=;
        b=DupluEngw4ddiT3Sd9MsKl5A704BIGMz5JlAt/vHZymTjbhxE/X5UXtld87eaQeBzR
         2BAteJ0jnWmbB3GylhrtmLpyrHCTUQ0RZXQsfiYT6iggBK5eGOoHKy7B97VKJ6RQAutz
         awjGD5/JEbanVsYOXfi/4uATzlW/fyvhKLMfaZyEIqVrDcoNirgHni8HqcJIREEkunl7
         lDL1B8pAsALY22JFGmfwD3ThwvEEC18vTh/oIapIeEUIn96DKD6MOjCTxrjrK/PQksNK
         iqiudYIbMQGLz2vTlnC3E2aaYs7O91KkMDeXzMVnzkTYKydEDXxMAuUQ5xAtBIODbtN3
         X7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LsOB+sBjc5JCoaeZhEAOxaHCPVdGRezpDi2kOmvNSb0=;
        b=QVBFNy7Wnl3X0E42OIA0lvjdkZ0komyYrcfxJJ5Ry465mfCOxJthEQUHjgi7HAmikj
         suX4rcoUQ6N+jT+3ALXr49bdxhB2mferfUR1vRhqksdUTnMeYSJRVd30w1urjK9OpMsN
         cF8TY72w5jC9+LoyTEhj7fLBwUTJbK7IQ8n4LpZGnd8jxbKdYY/DovS981ywkP9d5nrE
         /9AnTqVBfi4yXYR1+3gjajO54hbCqY8CD4tsW67zUx5HLUqtVycl2jVBnLaGkPoZ/2ry
         RHBVJtJQUgNvsOHpsKFsHfSgx1XHFzZKeAvTohcttN2/Yi8UYdN8HCL865MJ0tujuIaQ
         Oq1Q==
X-Gm-Message-State: AOUpUlFEjy3PPtE+mX2PM+9/MiD7MtD4ouJ6WMPvOtMrfWQ3xcSOWeG/
        UQhAfoFwh004k7sMar5c0K0=
X-Google-Smtp-Source: AAOMgpdd+vQeIACHtNEaBd8TJLEM31hceUnUU0Zk7gSE99Y4bm2GnP3k0vvJOez2ANZ4YwuZ/I9S2Q==
X-Received: by 2002:a17:902:bd42:: with SMTP id b2-v6mr2630479plx.205.1532566335484;
        Wed, 25 Jul 2018 17:52:15 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id b73-v6sm27999882pfl.152.2018.07.25.17.52.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 17:52:14 -0700 (PDT)
Date:   Wed, 25 Jul 2018 17:52:12 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@bootlin.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH v4 2/3] Input: edt-ft5x06 - Set wake/reset values on
 resume/suspend
Message-ID: <20180726005212.GE80336@dtor-ws>
References: <20180725073410.730-1-mylene.josserand@bootlin.com>
 <20180725073410.730-3-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180725073410.730-3-mylene.josserand@bootlin.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mylène,

On Wed, Jul 25, 2018 at 09:34:09AM +0200, Mylène Josserand wrote:
> On resume and suspend, set the value of wake and reset gpios
> to be sure that we are in a know state after suspending/resuming.
> 
> Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
> ---
>  drivers/input/touchscreen/edt-ft5x06.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> index dcde719094f7..dad2f1f8bf89 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
> @@ -1158,6 +1158,12 @@ static int __maybe_unused edt_ft5x06_ts_suspend(struct device *dev)
>  	else
>  		regulator_disable(tsdata->vcc);
>  
> +	if (tsdata->wake_gpio)
> +		gpiod_set_value(tsdata->wake_gpio, 0);
> +
> +	if (tsdata->reset_gpio)
> +		gpiod_set_value(tsdata->reset_gpio, 1);

Ondřej mentioned in previous review that if you power off the controller
it will not be able to wake up the system, and you had to move call to
regulator_disable() into "else" branch of check whether the controller
is a wakeup device. Guess what happens if you unconditionally put the
device into reset state?

Thanks.

-- 
Dmitry
