Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E72C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A258A206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQjhzPNg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbfBLRA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:00:56 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34916 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfBLRAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:00:55 -0500
Received: by mail-lf1-f65.google.com with SMTP id v7so2585629lfd.2;
        Tue, 12 Feb 2019 09:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MtNeFdXmEvOtvAyUUaT5c7XY51tOKex9z7q/wJEpgbc=;
        b=PQjhzPNg/ri4Jw+2mIWA46Xt/uFszFppwoCuNqHa5L909brlPpwtrZ4xV7DdTvbSBq
         JquyggcJeFC6wYM31wNhH5+B/Hl8xP4rq2fdiRFSeZjOo9oKqP4G8VJXB5VAlP2Seqr5
         uxQ8kkbQyE1ikybx7LnqwZJCe+580KzK8aMAPAbj+baL6aqUhTutyChCEh0x2kJlVOWO
         GvZwji8GQXEeSF+QTPUbp0N9AHFIRbr8XF7NxqC46dRJIu1UIHPIQQqzOrqxhZJrafws
         SyAAAGMCtyC52Eaeb3WUZY9lG09UKD1eDBkVtY2bOAc72JYfxDLpkn9NtdjlRcbY8t1H
         JN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MtNeFdXmEvOtvAyUUaT5c7XY51tOKex9z7q/wJEpgbc=;
        b=mqca8cU2JebZOLZ0C7/zzCc+eDuU6WjxKuXMbNwB3p8rAq3fw8EmS7BUER8zt7G/gk
         M6Evr/DBDWG7VwogiN7RLb4tzmwaAnRJZ8XTNuuq6cqZFqjzOXJZPtRtZo1T6AlnW8Td
         VqVQ6JmPzcHvbRO6fiGxi3qYH9/6tEm4gnDhc7uDnfi4+OEAb199NFeBCYExJEPIb87+
         im/TNElcwVkolXA9NUfTyat8Q77DUrmf9OIAsWnyUVqLCbjOj9Ca2eDq+ONNMwkbEhVD
         C87J/+JNtVodExSDJ+f/vAUi0LWJfeaHt7PVjWih4XPG0FYJVL35xSr7X92BYItIK4Wj
         oVag==
X-Gm-Message-State: AHQUAuaiYzGaRZtv1Y8sJ1dWcA+q5WMUrcw18Mqv0ayB9pl2mJ2VKde6
        7obBkDYZSocRVyCz5SNCeiPUg0aUO44=
X-Google-Smtp-Source: AHgI3IbecKy4/x6Rtvvdq4f9mN+dl0CjiRHPrs5ETbRpKqDPsdLkKTOjU2Y03lYANMYxAPkyD39Taw==
X-Received: by 2002:ac2:561a:: with SMTP id v26mr3000519lfd.38.1549990853120;
        Tue, 12 Feb 2019 09:00:53 -0800 (PST)
Received: from localhost (89-70-37-207.dynamic.chello.pl. [89.70.37.207])
        by smtp.gmail.com with ESMTPSA id l7-v6sm2743180ljb.76.2019.02.12.09.00.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 09:00:52 -0800 (PST)
Date:   Tue, 12 Feb 2019 18:00:32 +0100
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Subject: Re: [PATCH] iio/gyro/bmg160: Use millidegrees for temperature scale
Message-ID: <20190212170031.GA14756@arch>
References: <1549981549-19786-1-git-send-email-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1549981549-19786-1-git-send-email-mike.looijmans@topic.nl>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 03:25:49PM +0100, Mike Looijmans wrote:
> Standard unit for temperature is millidegrees Celcius, whereas this driver
> was reporting in degrees. Fix the scale factor in the driver.
>
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
>  drivers/iio/gyro/bmg160_core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
> index 63ca316..ad7f8cb 100644
> --- a/drivers/iio/gyro/bmg160_core.c
> +++ b/drivers/iio/gyro/bmg160_core.c
> @@ -585,8 +585,9 @@ static int bmg160_read_raw(struct iio_dev *indio_dev,
>  		*val = 0;
>  		switch (chan->type) {
>  		case IIO_TEMP:
> -			*val2 = 500000;
> -			return IIO_VAL_INT_PLUS_MICRO;
> +			*val = 500;
> +			*val2 = 0;
> +			return IIO_VAL_INT;

You are returning integer type to iio so there's no point in touching
val2. iio will ignore it anyway.

>  		case IIO_ANGL_VEL:
>  		{
>  			int i;
> --
> 1.9.1
>
