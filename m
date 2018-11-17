Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2805C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 19:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828F02077C
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 19:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsJUns00"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 828F02077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbeKRGKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 01:10:23 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43738 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725732AbeKRGKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 01:10:22 -0500
Received: by mail-ot1-f65.google.com with SMTP id a11so20731413otr.10;
        Sat, 17 Nov 2018 11:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z1unspOKV9cQMU/k5WyXVsggpYcu2lBHV94shqmJQJA=;
        b=IsJUns00RXpZtolroF5VkD7ohUboch/MDnD0+8A0Q+wOCo0YfaUalkoaIsv8JvAxMM
         PFeFh3Shnn7n/q3DlN0ontzgpS8s/e3ilB0YLBIgueP7+3NZByJ2dmXMhCB7IHSiRBvl
         +JRH5XzSFBnuixL17WLt9RsrRDyWvOqbbWCMQxWngH1QMLt3RyU7CQ61K7DHBv+7g+Ut
         vKIVCwxiQmB1N8aL01s8riNOxZyKRL5ueCltvUCjPXDY+U2QjfIZBQFw8h5Zrwo1+bEA
         WenRx1WVTF388UgZ5lZckSXfh5cLDUXsiFoWL1h0HM/YyQMSWH7IzIo9kOaqg9jrGER6
         EZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z1unspOKV9cQMU/k5WyXVsggpYcu2lBHV94shqmJQJA=;
        b=GcRbnSyYu+CpJiXGt6nI3dlsJul+Rb1IBNokNj4gE2dbZtwcNu6EcUUAf5ehoza2I3
         bfGGPzjIpH0O+oJgWGrlGg1iGbI2vmkTosuMTPytuuuRyS63103RWThJctJ4zwfLZc/j
         iiNrzWWxU3Qn8/J+6iIrHQKU49/yffwrD+UBl8HLBDFWCn9aQ8uXNDaAIcEPu8/Xw4TF
         Ll6gCvGMyt7v3W5jyycr9ei5Vt/JlFZyXyPJ7mQYR7Un2B0PvLIGB/+mD/OCwSLRe5lZ
         9NlUH3HmAJD3pdTps32jlL5LDyOOdWxOwwWpszdHzR2lefDKzlt33b6Z1jBIWJ8d/NiM
         z47A==
X-Gm-Message-State: AGRZ1gLiCP9rXYTJzGL+/z3cAn+jJnCo11+mFR1Mnz1RxuzPsa7vZ/67
        8P8rm9RrPixI6egqzNiHbLsKYjOM
X-Google-Smtp-Source: AJdET5fBTuM+gvdioZhKhaoHYdA+pwJ7BzPcVJgk3jjd9PTh6IAMZmrdacAU7xzlTZ5wRm2myaAyMw==
X-Received: by 2002:a9d:4991:: with SMTP id g17mr9138489otf.261.1542484358349;
        Sat, 17 Nov 2018 11:52:38 -0800 (PST)
Received: from [192.168.1.2] (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.googlemail.com with ESMTPSA id s30sm13593120ota.80.2018.11.17.11.52.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 11:52:37 -0800 (PST)
Subject: Re: [PATCH v6] net: phy: mdio-gpio: Fix working over slow can_sleep
 GPIOs
To:     Martin Schiller <ms@dev.tdt.de>, andrew@lunn.ch,
        sergei.shtylyov@cogentembedded.com
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181114061703.11026-1-ms@dev.tdt.de>
 <20181116073836.6013-1-ms@dev.tdt.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <b2c0ee11-a994-f371-f260-668f972a493f@gmail.com>
Date:   Sat, 17 Nov 2018 11:52:36 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181116073836.6013-1-ms@dev.tdt.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/11/2018 23:38, Martin Schiller wrote:
> Up until commit 7e5fbd1e0700 ("net: mdio-gpio: Convert to use gpiod
> functions where possible"), the _cansleep variants of the gpio_ API was
> used. After that commit and the change to gpiod_ API, the _cansleep()
> was dropped. This then results in WARN_ON() when used with GPIO
> devices which do sleep. Add back the _cansleep() to avoid this.
> 
> Fixes: 7e5fbd1e0700 ("net: mdio-gpio: Convert to use gpiod functions where possible")
> Signed-off-by: Martin Schiller <ms@dev.tdt.de>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks Martin!
-- 
Florian
