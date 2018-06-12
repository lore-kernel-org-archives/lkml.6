Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D3329C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 23:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E7B42086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 23:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqsviGXO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E7B42086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934733AbeFLXaj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 19:30:39 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40792 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934131AbeFLXai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 19:30:38 -0400
Received: by mail-pl0-f65.google.com with SMTP id t12-v6so368906plo.7;
        Tue, 12 Jun 2018 16:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=53ABYaNH2Q+5xBaM30O2LUITF599oD6Wkqs3cq0+kgQ=;
        b=BqsviGXORwLkkPuPP0JPA5lwg2hb3VynboX7bWwCeSeR2ebI4dMSFtQZFZgWH4VkD4
         7rmxJXUelYwvww/jZbos9AJwdDQdJdfhMX5wrJycwTm1hhAzNMrkXGkjSmSGdwUHbThb
         jUuQKSLjY9k8yvDJsy4RYw4/A3N0G5eC+4XqLPJe/kCxTMvqjGlN42dVkVACwfp36gC5
         3xdJ/Zfwn+tHDZadYseWECVmrhRn2iJYnVl0+25qQ8hDTWV/3hcfTUvFSWcEulQPvtiW
         GfJ9ZA0jw+2LVwcxKzT9jNaHtu3YU+ef/gEBC6J+04ZZQtAiok2H2CtH+jmetS+L25FF
         p4bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=53ABYaNH2Q+5xBaM30O2LUITF599oD6Wkqs3cq0+kgQ=;
        b=pMIadal5z8MXYFa6KVWqV2nsVipgSTG/l+NHreHZztCstQMh7cSKObXHFDCXUuFpPK
         PJLGplDQkCmpxAnDuzvSqfX72Jyq5UiRhQNhTAK/GofOyM8IgT6iqwou9c7uTOFUXGuk
         9E1vAqEGG1mUboc+9uU86HW2Ruq3eQst3OsfxXagLEFSrZCdpAFzwMr6MGKI/dqmN6vy
         8XSFF+NcV3Gm6nfMvCKvzjKuKjliB2z+BU2ezMy8r8/TUMN2W1XsPsySX9MJOays8KDH
         j0I7dctUyTSZo39nuEwjd+CGDfXKNKLabaMZFuqR4sqVuLG6t7oNW3ejDYjtb98sXa7L
         Ltkw==
X-Gm-Message-State: APt69E2gXJ2jq5BU17Czkcz5l5zZyoe82VcjfTquw1GxeXpmhrFKWEnK
        UD01qBsDylAX6lTpTttHXqs=
X-Google-Smtp-Source: ADUXVKKGP90Et+xeuGUaDiKctR8gRe2epXOKU72yWb8Ti1rEf3WTLT0tDtSuKqqrSVEHbmD62bXpOg==
X-Received: by 2002:a17:902:8206:: with SMTP id x6-v6mr2502043pln.220.1528846237086;
        Tue, 12 Jun 2018 16:30:37 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id u8-v6sm1529202pgq.7.2018.06.12.16.30.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 16:30:35 -0700 (PDT)
Date:   Tue, 12 Jun 2018 16:30:34 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v3 09/12] Input: cros_ec_keyb - Make license text and
 module license match.
Message-ID: <20180612233034.GE38773@dtor-ws>
References: <20180606150900.8342-1-enric.balletbo@collabora.com>
 <20180606150900.8342-10-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606150900.8342-10-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 05:08:57PM +0200, Enric Balletbo i Serra wrote:
> The license text is specifying "GPLv2" but the MODULE_LICENSE is set to
> GPL which means GNU Public License v2 or later. When MODULE_LICENSE and
> boiler plate does not match, go for boiler plate license.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Applied, thank you.

> ---
> 
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/input/keyboard/cros_ec_keyb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
> index 79eb29550c34..9dd8c146699f 100644
> --- a/drivers/input/keyboard/cros_ec_keyb.c
> +++ b/drivers/input/keyboard/cros_ec_keyb.c
> @@ -674,6 +674,6 @@ static struct platform_driver cros_ec_keyb_driver = {
>  
>  module_platform_driver(cros_ec_keyb_driver);
>  
> -MODULE_LICENSE("GPL");
> +MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("ChromeOS EC keyboard driver");
>  MODULE_ALIAS("platform:cros-ec-keyb");
> -- 
> 2.17.1
> 

-- 
Dmitry
