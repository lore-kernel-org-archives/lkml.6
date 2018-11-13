Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F422C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE6B22360
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guNkVK77"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DE6B22360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731350AbeKNCwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 21:52:49 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40498 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbeKNCwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 21:52:49 -0500
Received: by mail-lj1-f194.google.com with SMTP id t22-v6so11441964lji.7;
        Tue, 13 Nov 2018 08:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NLNmQ6NE3SZvOamUITtsEFvtXjYkNVX43biqslafXKc=;
        b=guNkVK776GyeE0BHU4knvPcshf5CvwIFnQcq6+ES3E1wDnhR6s9Qa7chrhZuCqTdKe
         kWpU223ydLbfdHLNPlXnbmMnzmQWCbepU1+XhaI3Aj2W5eIrH6P4qGBO3GVBCzqPGI7Y
         M5GAdWyIXwWLvLwZgvZfRpCo1ZA9YfIDOj4vw3431TJb4GStMvhHahoZufT0UJV9L6cr
         7hTk08Ox8PbtvmTjVU4RqmcmD0D/okGsdpb6GFvtIEdi2TOELKdD36iY8IdFSTO7d5wa
         rANBQqmr/J48+u5a0srieksFVDT3PGalXOdaVGNvkp/dFTJGi6t3rR6rc0lh+RjWRHMa
         d11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NLNmQ6NE3SZvOamUITtsEFvtXjYkNVX43biqslafXKc=;
        b=tx5U2RxVHJJb0P1AYoc9+mIAZnX89ubrG7mcDjDC2V3E4epJetSMQR9fTmV+GpDgdl
         XWxcZ//cXPpwg4Vc/DoiVro2Gg+rrM55irQgShX+pHeoamvHjC4SBXTyjgIBVPDplC56
         PsLdSoCZq97nbWn4zJDD6iENx1yJCCkt6ehmN9I4uirNko/ijxae4MVlpfFdvIQWs2us
         7AU0ycOMikcO0ewoUy0bm2ZI2CQFTPFXXpbkHRt35MSvBzRuZZ+ute7FWzLUaBcTKNOd
         w/DSgIbox8NQKNN6KY9SitCFStDjWvpe8UezP+lhBYqmNigqHGFcgtjYV2xC3hHJ+jlN
         2K6Q==
X-Gm-Message-State: AGRZ1gLpZd+A3uVRYYSwh4w/CgU/gk1hxCWL5hAiGW49ou1+xAH9WoXE
        5KGQHeK1fKwLSOqXfbgmCjVlTtOM
X-Google-Smtp-Source: AJdET5e9pzHkxwnBcWH6+tSWWB5sTr3YZZZFSuIPEUxSZIYkRKe3B9FYIaVrD0bNieRzg0KY1/urDA==
X-Received: by 2002:a2e:9983:: with SMTP id w3-v6mr3926632lji.133.1542128031770;
        Tue, 13 Nov 2018 08:53:51 -0800 (PST)
Received: from [192.168.2.145] (ppp91-76-171-181.pppoe.mtu-net.ru. [91.76.171.181])
        by smtp.googlemail.com with ESMTPSA id l7-v6sm3393683ljh.5.2018.11.13.08.53.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 08:53:50 -0800 (PST)
Subject: Re: [PATCH] media: staging: tegra-vde: print long unsigned using %lu
 format specifier
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Colin King <colin.king@canonical.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181108110224.1916-1-colin.king@canonical.com>
 <0b3bf728-7b7e-7250-40eb-0827f8fe955b@xs4all.nl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <67306f07-f270-3395-48c4-f6d4954e0d04@gmail.com>
Date:   Tue, 13 Nov 2018 19:52:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <0b3bf728-7b7e-7250-40eb-0827f8fe955b@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.11.2018 17:32, Hans Verkuil wrote:
> On 11/08/18 12:02, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> The frame.flags & FLAG_B_FRAME is promoted to a long unsigned because
>> of the use of the BIT() macro when defining FLAG_B_FRAME and causing a
>> build warning. Fix this by using the %lu format specifer.
>>
>> Cleans up warning:
>> drivers/staging/media/tegra-vde/tegra-vde.c:267:5: warning: format
>> specifies type 'int' but the argument has type 'unsigned long' [-Wformat]
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>>  drivers/staging/media/tegra-vde/tegra-vde.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/media/tegra-vde/tegra-vde.c b/drivers/staging/media/tegra-vde/tegra-vde.c
>> index 6f06061a40d9..66cf14212c14 100644
>> --- a/drivers/staging/media/tegra-vde/tegra-vde.c
>> +++ b/drivers/staging/media/tegra-vde/tegra-vde.c
>> @@ -262,7 +262,7 @@ static void tegra_vde_setup_iram_tables(struct tegra_vde *vde,
>>  			value |= frame->frame_num;
>>  
>>  			dev_dbg(vde->miscdev.parent,
>> -				"\tFrame %d: frame_num = %d B_frame = %d\n",
>> +				"\tFrame %d: frame_num = %d B_frame = %lu\n",
>>  				i + 1, frame->frame_num,
>>  				(frame->flags & FLAG_B_FRAME));
>>  		} else {
>>
> 
> Compiling for i686 gives:
> 
> In file included from /home/hans/work/build/media-git/include/linux/printk.h:336,
>                  from /home/hans/work/build/media-git/include/linux/kernel.h:14,
>                  from /home/hans/work/build/media-git/include/linux/clk.h:16,
>                  from /home/hans/work/build/media-git/drivers/staging/media/tegra-vde/tegra-vde.c:12:
> /home/hans/work/build/media-git/drivers/staging/media/tegra-vde/tegra-vde.c: In function 'tegra_vde_setup_iram_tables':
> /home/hans/work/build/media-git/drivers/staging/media/tegra-vde/tegra-vde.c:265:5: warning: format '%lu' expects argument of type 'long unsigned int', but argument 6 has type 'u32' {aka 'unsigned int'} [-Wformat=]
>      "\tFrame %d: frame_num = %d B_frame = %lu\n",
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /home/hans/work/build/media-git/include/linux/dynamic_debug.h:135:39: note: in definition of macro 'dynamic_dev_dbg'
>    __dynamic_dev_dbg(&descriptor, dev, fmt, \
>                                        ^~~
> /home/hans/work/build/media-git/include/linux/device.h:1463:23: note: in expansion of macro 'dev_fmt'
>   dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
>                        ^~~~~~~
> /home/hans/work/build/media-git/drivers/staging/media/tegra-vde/tegra-vde.c:264:4: note: in expansion of macro 'dev_dbg'
>     dev_dbg(vde->miscdev.parent,
>     ^~~~~~~
> 
> Should it be %zu?

Same on ARM32. Yes, it should be either %zu or "!!(frame->flags & FLAG_B_FRAME)".
