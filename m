Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A0EECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA63320834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUjo4QPt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA63320834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbeJZDvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 23:51:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45533 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbeJZDvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 23:51:51 -0400
Received: by mail-wr1-f66.google.com with SMTP id n5-v6so6690055wrw.12;
        Thu, 25 Oct 2018 12:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+9WQBmlmTANT0VRkTSJ/8ARuwk8Qeuwd3Nn8D8A5U64=;
        b=MUjo4QPtIS39gM1YY5x/GcVHkB2SSZNo5cBxSgiTdOqRMrUJGHAO4hRX0f3NYfxlvD
         PLA0vIFQ8KMMOQKgKZNSxaINhjwvuMvb70d5SbrbgTSU0wuouEe7tUuJVF5hGH/dInb8
         14zlRIMRd7hxD/qhnFqc9ALKNwNRi5QyRh2M/eurEZZuZYAJhJo17RBh0v6j4kXmZJ4W
         rziSMFxadlfbBwSP72DNvPDP2rCcY3dAJ5eNOzzaj9Vt+UPlszFpn36jrCauYXlkH+RM
         nyeRdTp12l9lsJQ6cuFGcgZBYxIqRjItBgsm8hqcAiKmIbGjA2JrV05wlKyjT/DciafA
         J0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+9WQBmlmTANT0VRkTSJ/8ARuwk8Qeuwd3Nn8D8A5U64=;
        b=Up/YPcFE16X/7Jt4yw+7Nrb/TiHtTnXDV6Yy++sp6AV9NcGLFsC+qdvkPY+6dVdzYR
         WWa5BN7hRtc+LTSJexo5DtzUu3MkZ+sTmXYOIjzNUppuxMZArsnIUEvwkp5224g9kG6I
         xuBWUTwprcc3hYPAIuovclK1802iGfk4dmS2Rv0D1MqN4MYzFgSmYEHXSC4pSime3bYJ
         KSZ6d8NcNUiNtRzwh7WNP1CR0a8jbsFVJwNdkDRg2GB8m2lIbmNWobkR3NKVXB+XczZN
         WvApSa5GrAs8DySRtRE/GoEkPdApKIS8ZzzhiaX8FXJiNzdmX4wMCrG1PgBILwJb5ckg
         RxWw==
X-Gm-Message-State: AGRZ1gLi1wNgAm76XBnGHNzjQzUI16eO1nZ4KuMGrfh3KJhEDrLVJwE9
        Xei6kt775zItC63cmeOfaTECh8Kq
X-Google-Smtp-Source: AJdET5fD0StOBO4tjRKCJg27WbFKUZYg+lItVzvhNSNeF8MyVOFz3fscJ2oDzu0K9AdzYtVkiAKnDQ==
X-Received: by 2002:a5d:6589:: with SMTP id q9-v6mr3061642wru.141.1540495067590;
        Thu, 25 Oct 2018 12:17:47 -0700 (PDT)
Received: from [192.168.1.18] (dnt139.neoplus.adsl.tpnet.pl. [83.24.101.139])
        by smtp.gmail.com with ESMTPSA id g8-v6sm9387691wri.58.2018.10.25.12.17.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 12:17:47 -0700 (PDT)
Subject: Re: [PATCH] Fix pattern handling optimalization
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Baolin Wang <baolin.wang@linaro.org>, rteysseyre@gmail.com,
        bjorn.andersson@linaro.org, broonie@kernel.org,
        linus.walleij@linaro.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <9794969ab8a5a6f62d8ac54cdebcaa3caedfc6d6.1539230481.git.baolin.wang@linaro.org>
 <d90397dd-429f-4f3f-307c-b69dccc360e0@gmail.com> <20181024083143.GA24165@amd>
 <bdadda71-f919-b6a6-4e1c-f87ed298b6b5@gmail.com> <20181024204439.GA32300@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <79c29d20-ae6a-4a12-28fa-93d7305a0623@gmail.com>
Date:   Thu, 25 Oct 2018 21:17:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181024204439.GA32300@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel.

Thank you for the patch.

On 10/24/2018 10:44 PM, Pavel Machek wrote:
> 
> Check for zero duration before skipping step. This fixes pattern
>     
>     echo "0 1000 10 2550 0 1000" > pattern
>     
> which should do [  .-xXx-.] but does [   Xx-.]
>     
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> Suggested-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> 
> 
> diff --git a/drivers/leds/trigger/ledtrig-pattern.c b/drivers/leds/trigger/ledtrig-pattern.c
> index ce7acd1..bc5f495 100644
> --- a/drivers/leds/trigger/ledtrig-pattern.c
> +++ b/drivers/leds/trigger/ledtrig-pattern.c
> @@ -87,9 +87,10 @@ static void pattern_trig_timer_function(struct timer_list *t)
>  					   data->curr->brightness);
>  			mod_timer(&data->timer,
>  				  jiffies + msecs_to_jiffies(data->curr->delta_t));
> -
> -			/* Skip the tuple with zero duration */
> -			pattern_trig_update_patterns(data);
> +			if (!data->next->delta_t) {
> +				/* Skip the tuple with zero duration */
> +				pattern_trig_update_patterns(data);
> +			}
>  			/* Select next tuple */
>  			pattern_trig_update_patterns(data);
>  		} else {
> 

Yep, it fixes the issue.

Applied to the fixes-for-4.20-rc2 branch of linux-leds.git

-- 
Best regards,
Jacek Anaszewski
