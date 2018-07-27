Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E2FC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 20:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 609D920857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 20:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lwf2vhDC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 609D920857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389619AbeG0VqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 17:46:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39029 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389368AbeG0VqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 17:46:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id h10-v6so6208050wre.6;
        Fri, 27 Jul 2018 13:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JoRMeWEi897cAoS2mgHFQ37MAAlfCQVt2O9E6RQ4/i8=;
        b=Lwf2vhDCt4NJhPzuhv66KSBiznuEUa6DCiX5AHqzFn7sVakE66h0u6RTQaTUbyqpfC
         en5hcbPauUlfsxPIPm0uaUV/sns+jYP6ZGgeYwtSr9WWK8APgVeRV+7LQ2W1A5AkHGru
         g5ojA0widrppR1/XAfcPOXYpYAnYfB0jPHxi+AswdIQxaxqqZT6UkUb3QBhGtgQk/Lak
         UB9+xA9NW/HQemC/SlxoyP0P4yXMOS3keu94ZULkmC1ucryE43ggmz7U0zn+Ulut/1a3
         pbTxzYaeVscf5SSmgbMdUtj4+RqMCDQjk2FYuUuhadz6XgR1/3rEVTXHzjE8apAuq+vQ
         j/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JoRMeWEi897cAoS2mgHFQ37MAAlfCQVt2O9E6RQ4/i8=;
        b=rgQWKnJpdjkitA/izPBx+EGKZD7eE5FqTPrh1U2zr0bYx071GsZxSTgx/uAi3VMk9v
         zF/SH/+9fAPlHcTU/rBxISWarRnGcn2k6nwGpePKQdZ9tBe1/A5c+cplNVR/92rw2yft
         y94zXnIKSMxDINtXrA1K/8AG9JBQdAce3/OCQkw3I+QlPzzZ2Dh1m8Lf4SHpIvjn3DT4
         5DMnYE/wwHf5tOU1rJoWAxkgrZ8r7e/D7uDUe+VVpKKmb5/ztp9KOx0wqFxMUADBdfjk
         5FblFBkXg0BzW53a05ZB5+vxRWramzJHtqh++ISAWWts0G9gTN8hbGw5VuVvH+9n+PxM
         gM+A==
X-Gm-Message-State: AOUpUlEkXBoH8wGKmFntgHup+1vgi3+siQ8h3o/uSW+NUW7oetNfFVV7
        obg+mzAt8YKEZAmW5kZad8bVJVzK
X-Google-Smtp-Source: AAOMgpfpald037qYPB26oHTBljwXlukJMhZMtdRgMbfbZTRQFqa0bu5CPVgSMPLPqRE/nP20I7LZ0Q==
X-Received: by 2002:a5d:66c4:: with SMTP id k4-v6mr6179314wrw.154.1532722959594;
        Fri, 27 Jul 2018 13:22:39 -0700 (PDT)
Received: from [192.168.1.18] (dku38.neoplus.adsl.tpnet.pl. [83.24.24.38])
        by smtp.gmail.com with ESMTPSA id p3-v6sm5982983wrg.47.2018.07.27.13.22.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 13:22:38 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] leds: add Panasonic AN30259A support
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     Simon Shields <simon@lineageos.org>, linux-leds@vger.kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20180721141228.2283-1-simon@lineageos.org>
 <20180721141228.2283-3-simon@lineageos.org>
 <ba747c6d-c8a6-438b-efcf-95e24db0a09c@gmail.com>
Message-ID: <341157fb-257d-8984-c8d3-0e4a51c4479e@gmail.com>
Date:   Fri, 27 Jul 2018 22:22:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <ba747c6d-c8a6-438b-efcf-95e24db0a09c@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/27/2018 10:08 PM, Jacek Anaszewski wrote:
> Hi Simon,
> 
> Thank you for the updated patch. It looks good in general, with
> one reservation, please refer below.

And one more issue:

drivers/leds/leds-an30259a.c: In function 'an30259a_blink_set':
drivers/leds/leds-an30259a.c:129:23: warning: unused variable 'duty' 
[-Wunused-variable]
   unsigned int led_on, duty;
                        ^
BTW, this patch set version should be v4, so please set the next
one to v5.

-- 
Best regards,
Jacek Anaszewski
