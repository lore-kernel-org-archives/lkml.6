Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274FBC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8CF220868
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+Db2eC1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbfAPVTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:19:19 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46558 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728911AbfAPVTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 16:19:18 -0500
Received: by mail-lf1-f65.google.com with SMTP id y14so6051831lfg.13;
        Wed, 16 Jan 2019 13:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=3Pw9Bl+85YVlz0O9hyqzej+goDDW8LLooXTpue6J4bc=;
        b=d+Db2eC1V+ucP9TF9y5uq5IlxLnmqzyeyeOlCugnOUjX51Fsa1Ckcq2lsmRxaEsHTD
         iQPOQJ4iXfNcNNtmVvQmE6y1ytzbTUP8KoBMrhdH9VYHIG0ppPv6SYjxRtt+NWE39otU
         InLsEOpcXv0fB+jMRmDs1/FIVM/gGVgUbgU2Exlob6jd1Q3Wg3HCGuRLxW3vYazb203L
         +J8FkP1O2dsUJa9fOLAAQAOTvT5EocWnLQBUsCDGN0ikgj3vxB3uqHPzfDFZNouwyhgM
         pcLCd6ZqIqj33YppUO1SFIyCIJU1OA1dFdNV7oCK95jpd8yE0WWAJu4NIQ16KzmDItZY
         XByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3Pw9Bl+85YVlz0O9hyqzej+goDDW8LLooXTpue6J4bc=;
        b=tZNUL3ERAhEp5D4wyJe/l7o8kl5LVz5Yns0nSs90iHxtFdDTNnp7qNy0bLpsGSz/8a
         tNBhwsA1jinPmgQrehD+re8xy/FrRlJMuAf0AqSS7DiHnTyOY/Gu0nJz5MBRo3UVGyxT
         Nv7SWqwT2aoxcS1p2N4kFJ7kjjnNscAChP+pb9vTVWOGppH+/H+7KNxJksHDBiLAzIkl
         3mS8i/7/C9IH7u2i2Fd+lOk9m6DjaI/MfVC04edoei4vKbhcidPQJWsOonCEtegZuFKd
         ExnGA3DVD+iqZkZEyoXwlxNTsKZBG1pdBkOInaI1koV05vC7Rgo4nvB959y1KTu5Qtje
         1Glg==
X-Gm-Message-State: AJcUukfQlJysF7WXiL89qYyprxKwbt80xMNsOP9uAEU3Uz6zICtwPNsA
        oKxLoN5KX96EmD+fYK/vpyQrVt/k
X-Google-Smtp-Source: ALg8bN5Ph95FykQ//hWnXgaOtwLQQ3nuQzXyj0zvdKnIOWxMv4OR5zUS6qg/3kdqxe3/hzIqPcRoTw==
X-Received: by 2002:a19:d90c:: with SMTP id q12mr8094137lfg.24.1547673555471;
        Wed, 16 Jan 2019 13:19:15 -0800 (PST)
Received: from [192.168.1.18] (bgt38.neoplus.adsl.tpnet.pl. [83.28.83.38])
        by smtp.gmail.com with ESMTPSA id c20sm1357991lfj.67.2019.01.16.13.19.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 13:19:14 -0800 (PST)
Subject: Re: [PATCH v7 0/5] leds: trigger: Add pattern initialization from
 Device Tree
To:     Krzysztof Kozlowski <krzk@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org
References: <1547045089-19128-1-git-send-email-krzk@kernel.org>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <0d835201-41f0-6e74-8483-24ab62ab76d7@gmail.com>
Date:   Wed, 16 Jan 2019 22:19:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1547045089-19128-1-git-send-email-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof.

On 1/9/19 3:44 PM, Krzysztof Kozlowski wrote:
> Hi,
> 
> Changes since v6:
> 1. Drop goto from led_get_default_pattern() and rename "DeviceTree"
>     into "device tree".
> 2. Add Pavel's ack to patch 1/5.
> 
> Changes since v5:
> 1. Drop the "classdev" prefix from helper for getting default pattern
>     and move the kerneldoc to header file (this was not fixed in v5 by
>     mistake).
> 
> Changes since v4:
> 1. Move helper to get default pattern from led-class.c to led-core.c and
>     rename it (build issue pointed by kbuild robot).
> 
> Changes since v3:
> 1. Add missing EXPORT_SYMBOL_GPL.
> 2. Put pattern trigger format into common file - shared between
>     dt-bindings and sysfs.
> 3. Use array of integers as led-pattern property (since it is bigger change
>     I did not add Pavel's ack to patch 2/5).
> 4. Mention ms units for led-pattern bindings.
> 
> Changes since v2:
> 1. Drop Jacek's patches and my "led: triggers: Initialize
>     LED_INIT_DEFAULT_TRIGGER if trigger is brought after class".
> 2. Follow Rob's advices about bindings - use "led-pattern" property
>     and generalize usage of it into to three triggers.
> 3. New patches (2/5, 4/5 and 5/5).
> 
> Changes since v1:
> 1. Rebase on Jacek's patches.
> 2. Add patch 3/5 for fixup of Jacek's solution.
> 3. Drop first two patches from the series (applied).
> 4. Patch 5/5: Use LED_INIT_DEFAULT_TRIGGER (suggested by Jacek Anaszewski).
> 5. Patch 5/5: Return-on-error and log warning (suggested by Pavel Machek).
> 
> 
> Best regards,
> Krzysztof
> 
> Krzysztof Kozlowski (5):
>    dt-bindings: leds: Add pattern initialization from Device Tree
>    leds: Add helper for getting default pattern from Device Tree
>    leds: trigger: pattern: Add pattern initialization from Device Tree
>    leds: trigger: oneshot: Add initialization from Device Tree
>    leds: trigger: timer: Add initialization from Device Tree
> 
>   .../ABI/testing/sysfs-class-led-trigger-pattern    | 51 +----------
>   Documentation/devicetree/bindings/leds/common.txt  | 12 +++
>   .../bindings/leds/leds-trigger-pattern.txt         | 49 +++++++++++
>   drivers/leds/led-core.c                            | 30 +++++++
>   drivers/leds/trigger/ledtrig-oneshot.c             | 38 ++++++++-
>   drivers/leds/trigger/ledtrig-pattern.c             | 99 +++++++++++++++++-----
>   drivers/leds/trigger/ledtrig-timer.c               | 34 ++++++++
>   include/linux/leds.h                               | 13 +++
>   8 files changed, 257 insertions(+), 69 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/leds/leds-trigger-pattern.txt
> 

Patch set applied to the for-next branch of linux-leds.git.

Thank you for your effort.

-- 
Best regards,
Jacek Anaszewski
