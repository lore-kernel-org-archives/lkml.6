Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF58FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2324D20882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PSdkfFYd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2324D20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbeINQ5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 12:57:21 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:38548 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbeINQ5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 12:57:21 -0400
Received: by mail-it0-f65.google.com with SMTP id p129-v6so2114878ite.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 04:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=syh85p44PLh5sAxF+A7jwfOlvfCFjJ1xtF6lIhTmvrI=;
        b=PSdkfFYdtcwZ9kH+zdgpeUr5Vb+s+qx0TpoE4+1Uo4Ur+TiKrBQVUQ78JO+FLhRNlv
         T/Nplc8kwiHIMPlRNDkkiVV5mvJjd9XpKvA61iP9J2mq3XBble66sILihGUyFqmr5mfc
         uo4IXcJ/shqS4MRY3sQ/1Ldkmod5av8xplhH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=syh85p44PLh5sAxF+A7jwfOlvfCFjJ1xtF6lIhTmvrI=;
        b=eZ4fu5jPVtS4YQd1xhA1OU5TrhPXEZPEWm5GpC5LdLZwsP759uE6o+gdHLNoR5F11h
         w/8PVhp3Dcd/+owesfNKaruOKguplv2HLsFCgFplC6HJuTA75Fu57fvpWBnIwtDFVJES
         9v7xA+ZteUVepoAJt86hNYZisrgA58rBuFlw3E9YY8W/VaHB2RPj6yQUlC2zHTN04FZH
         HrbgWB8zL/b88eIDsJK6845n7vqgizqkLJnkBik0LqC6jBm9yE/vCDSc2T9krZ1HMoBY
         0i/cflcviSDp4lbZlFake8hTrgiucZpqDePSDHX6xxDLaMT2QRLb/2RI55NkZ8s9Xt3s
         5mwQ==
X-Gm-Message-State: APzg51AKhl806ko6lvd6vrWzf7+2MKTk73Gq28WavLKUswG/gtqgj3mN
        r39KyPHMuBBgirVK1s6KpiT2RbVd0Fo=
X-Google-Smtp-Source: ANB0Vdag68dFyXinc19ZlYOMDjh4bjce3em47IH+eUx7kZAyEcmJK1AVs4DK1rDhy/+nc5teaiM+vg==
X-Received: by 2002:a24:46cd:: with SMTP id j196-v6mr1943435itb.0.1536925393327;
        Fri, 14 Sep 2018 04:43:13 -0700 (PDT)
Received: from [172.22.22.26] (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.googlemail.com with ESMTPSA id y9-v6sm2174775iop.57.2018.09.14.04.43.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 04:43:12 -0700 (PDT)
Subject: Re: [greybus-dev] [PATCH] staging: greybus: fix spelling mistake
 "entires" -> "entries"
To:     Colin King <colin.king@canonical.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180914112451.4127-1-colin.king@canonical.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <eea53471-2998-5bad-7187-44430a9bde8c@linaro.org>
Date:   Fri, 14 Sep 2018 06:43:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180914112451.4127-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/14/2018 06:24 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake

I hate to have two-character fixes to documentation like this.  I.e.,
as long as you're touching the README file it might have been nice to
review it and look for other things.  I suspect you found this in the
program output though, and also noticed it in the README file.

So...  Looks good to me.

Reviewed-by: Alex Elder <elder@linaro.org>

> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/staging/greybus/tools/README.loopback | 2 +-
>  drivers/staging/greybus/tools/loopback_test.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/greybus/tools/README.loopback b/drivers/staging/greybus/tools/README.loopback
> index 845b08dc4696..070a510cbe7c 100644
> --- a/drivers/staging/greybus/tools/README.loopback
> +++ b/drivers/staging/greybus/tools/README.loopback
> @@ -79,7 +79,7 @@ Here is the summary of the available options:
>     -t     must be one of the test names - sink, transfer or ping
>     -i     iteration count - the number of iterations to run the test over
>   Optional arguments
> -   -S     sysfs location - location for greybus 'endo' entires default /sys/bus/greybus/devices/
> +   -S     sysfs location - location for greybus 'endo' entries default /sys/bus/greybus/devices/
>     -D     debugfs location - location for loopback debugfs entries default /sys/kernel/debug/gb_loopback/
>     -s     size of data packet to send during test - defaults to zero
>     -m     mask - a bit mask of connections to include example: -m 8 = 4th connection -m 9 = 1st and 4th connection etc
> diff --git a/drivers/staging/greybus/tools/loopback_test.c b/drivers/staging/greybus/tools/loopback_test.c
> index b82e2befe935..2fa88092514d 100644
> --- a/drivers/staging/greybus/tools/loopback_test.c
> +++ b/drivers/staging/greybus/tools/loopback_test.c
> @@ -192,7 +192,7 @@ void usage(void)
>  	"   -t     must be one of the test names - sink, transfer or ping\n"
>  	"   -i     iteration count - the number of iterations to run the test over\n"
>  	" Optional arguments\n"
> -	"   -S     sysfs location - location for greybus 'endo' entires default /sys/bus/greybus/devices/\n"
> +	"   -S     sysfs location - location for greybus 'endo' entries default /sys/bus/greybus/devices/\n"
>  	"   -D     debugfs location - location for loopback debugfs entries default /sys/kernel/debug/gb_loopback/\n"
>  	"   -s     size of data packet to send during test - defaults to zero\n"
>  	"   -m     mask - a bit mask of connections to include example: -m 8 = 4th connection -m 9 = 1st and 4th connection etc\n"
> 

