Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACCDC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 419A123FCB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCJrMLMD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 419A123FCB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754025AbeGEVbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 17:31:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33061 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753432AbeGEVbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 17:31:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id k7-v6so2209320wrq.0;
        Thu, 05 Jul 2018 14:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i1MMdwFi1P+Upd1sVEe8Kc5IRR51nHdHIeZwKQmYGHk=;
        b=YCJrMLMDNyXSkXry1bx9iCmxTL4naFZsoElB+r3lDLsiqChuszdPcAGJmARGY77Rkz
         1zcDqE5FEnEXh1Zjtwk1FP7AZ2/BDZllMiKanHDeztj8Dduek3AsrziCluJ4PKcLVkdY
         l+Xll68JVOLSdVJ4NcMqiq9SzEuL3uwmUHUI74dzSXf1KWLpn2mTVvPrliUDW0KX9UC0
         A89YWqtQOrDrCx1n7Va107FK69OQ+pVidUVtKEBqZ3guh7c5oteCu2zUIzl6mADBorKn
         9yDlPnCFKFaB/g1ZpkRqgywSkBYf08/iWKm77z44ccylFN5YgUdiHXXbzvktSIfAIPVL
         LZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i1MMdwFi1P+Upd1sVEe8Kc5IRR51nHdHIeZwKQmYGHk=;
        b=LUIFIcEEHqFJz2LWYf+tTAFSMatgtI8GOjgY0EXdngBpQFP5qHknAFh3eC6hJH7V3a
         Zgc56enJbMmMoBlPLaeidFaTRYV4PWh/QfndjhD9F6ZKtLUDpOe6IMgtabkGzA59cvLe
         u0wG7pRfBZVkrcLZbv+yZGoHYeVi9wgJTEJC8kTEKdRm6HLCOG3HO6ymj1WAOUlEnqsM
         1pq0zHGp/ORsmP07xg0/oBc6c7/zRFBREuxiTlHmJrx4Awj4oubtpsOxIcRUYNSBWN97
         y2kJu8zIAe37RGmrMI/pa9NkEx+rOMJCGeJ1n7TLUjHjLa/4VhKDhNEcArPJQOL8xjQf
         IeCw==
X-Gm-Message-State: APt69E0NCwPvYaVPgRCYVqz3m+fesky7qpO+h9IB8e0wDVVAgjLmtmTw
        Ab0ryyKx4joxIHHjP6HZOUnuX1jg
X-Google-Smtp-Source: AAOMgpcUsAxN1Ao4Avz/TG+6o5mX3y3Wg2DLN9ONi6KJVfEONhGmpUdg3f2sbH0CiVVeah1VEq0QEw==
X-Received: by 2002:adf:f188:: with SMTP id h8-v6mr6104744wro.214.1530826290605;
        Thu, 05 Jul 2018 14:31:30 -0700 (PDT)
Received: from [192.168.1.18] (chi28.neoplus.adsl.tpnet.pl. [83.31.6.28])
        by smtp.gmail.com with ESMTPSA id y13-v6sm16612752wrc.55.2018.07.05.14.31.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 14:31:29 -0700 (PDT)
Subject: Re: [PATCH v7 02/16] leds: triggers: let struct
 led_trigger::activate() return an error code
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Pavel Machek <pavel@ucw.cz>, kernel@pengutronix.de,
        linux-leds@vger.kernel.org, kernel-patch-test@lists.linaro.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-bluetooth@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <a9b3548b-09c4-fae4-1bce-abf3392b9ceb@gmail.com>
 <20180702200535.1337-2-u.kleine-koenig@pengutronix.de>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <1172a776-a951-28d5-fae4-824969f4a82b@gmail.com>
Date:   Thu, 5 Jul 2018 23:31:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180702200535.1337-2-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe,

On 07/02/2018 10:05 PM, Uwe Kleine-König wrote:
> Given that activating a trigger can fail, let the callback return an
> indication. This prevents to have a trigger active according to the
> "trigger" sysfs attribute but not functional.
> 
> All users are changed accordingly to return 0 for now. There is no intended
> change in behaviour.
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
[...]
> -static void ieee80211_tx_led_activate(struct led_classdev *led_cdev)
> +static int ieee80211_tx_led_activate(struct led_classdev *led_cdev)
>   {
>   	struct ieee80211_local *local = container_of(led_cdev->trigger,
>   						     struct ieee80211_local,
>   						     tx_led);
>   
>   	atomic_inc(&local->tx_led_active);
> +
> +	return 0
[...]

s/return 0/return 0;/

Fixed it up and applied. I'm taking lack of net maintainer feedback
as a tacit approval (or lack of interest).

-- 
Best regards,
Jacek Anaszewski
