Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C7FC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1355C20867
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/hXU6VB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1355C20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbeLAFqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:46:40 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:40455 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbeLAFqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 00:46:40 -0500
Received: by mail-yw1-f68.google.com with SMTP id r130so2667604ywg.7;
        Fri, 30 Nov 2018 10:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hT1QYZNc5YI+3fa+2DfsDewJX8UjoXT4yxiBn8gXHMc=;
        b=F/hXU6VB3m0gSRVuz6qlUIY0cgj8wBYdqnZ8qSprol6pPpgmGso2XKPIUtSSSiCGCM
         u/KlMfvSBj4Wynw9BhZrNwxGdvrSqdKidAk8h00tREcXunEHQ/CkEca7KqiMOIc1EM9p
         QtYJAZ5yvcvfCUFBFhEOwW3an9jiJKzYe6Qbg2ivrlXHbXDK2Em+ptnMIkiQ1cGnP8Uu
         hBslNLaxBwScXM/NtesgnO2nktuFVNOR0Vh8uoBY1JYZjCIDCye8pkADsrU/OrUJnDHy
         9xBMjFii5iz2WYLlAyv1ZRYN0Q3S0adMHIuPxuuvLvobDv6PH1NtGRJWmMxqmWu/Rfnu
         CSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=hT1QYZNc5YI+3fa+2DfsDewJX8UjoXT4yxiBn8gXHMc=;
        b=Eqzg7dayhOs1vXPqmkr6yKlvmk4utYHbgZE94AmPcofPiWYfOeW8Nz5TfLazhdkEyD
         CVGqfTfNsZr/OOqmAW6RQ1jRyLZWkpz1wDW8XNVUaG3UL1c89/EunQaESu3WsTaO8AtN
         o3P/dgor5NpkRk0SCiC4EnQYeo8PjVcyzoG5VzlCrqH06xZIaD5wXeXMKwP54AR049tM
         IyOy7CBwtK34WLhLrpqphbSb4A7f21jSg95aCsyRMskV3CcQc9/x0CgS3AKsHhVqWOM9
         Sad/VUAMSH19peBMUTH9MX8m5TypQU/pWB83xORT+KHYwVZHQcwR9TIka9lC7zVt/jNL
         3O0Q==
X-Gm-Message-State: AA+aEWYJnIpJxe1f1isk/ZhqpD4ER9jZMvvRAeV3V4y/MQpoa4C+t7pV
        9ei74RvbtBJ80CIWwnAcpAQD8ZBP
X-Google-Smtp-Source: AFSGD/V97uKhkYDR0SzZ6Z4CvAF5wpoN8rs88k6L3B2Stbs0xRiShwfbzqayREJmHE+xaTGfI7AiJw==
X-Received: by 2002:a81:29d5:: with SMTP id p204mr6836078ywp.285.1543602989157;
        Fri, 30 Nov 2018 10:36:29 -0800 (PST)
Received: from [10.67.49.9] (igp-prod-emp-gw.vpn.broadcom.com. [192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id j186sm1688746ywg.36.2018.11.30.10.36.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 10:36:28 -0800 (PST)
Subject: Re: Adding a Basic DT for the Linksys ea6500 v2 wireless home router
To:     =?UTF-8?Q?Ren=c3=a9_Kjellerup?= <rk.katana.steel@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <CACE8ZKbUhFyWg5oK1B8+aWAa0tdqKf5Kokj80+8x1X2EUaA_DQ@mail.gmail.com>
 <CACE8ZKZEpQjOW6CSvUuM9xhjtkSCF0bYxcfQ3htSabC=rVJcTA@mail.gmail.com>
 <86f391e5-9e38-c8b0-4753-4646c322c9bc@hauke-m.de>
 <CACE8ZKb5CxEBAdCdGAhwaQHC9_nHBjTTVwxdDOXRayqgz0FK5g@mail.gmail.com>
 <CACE8ZKYCyDx_E+3sLpjQSV6xrFxGyrYwEfhEO=QZPGpm3jsBrQ@mail.gmail.com>
 <5a6a30cf-1d93-7232-e607-3919b86bbdff@gmail.com>
 <CACE8ZKaMBfa5vWJMp_xVjstkuxkjO=DDwp1srA+Am1RP46gZcQ@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <0d26bc69-6439-05c9-a219-beae33f847c2@gmail.com>
Date:   Fri, 30 Nov 2018 10:36:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CACE8ZKaMBfa5vWJMp_xVjstkuxkjO=DDwp1srA+Am1RP46gZcQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/18 6:09 PM, René Kjellerup wrote:
> 
> On Tue, Nov 27, 2018 at 4:23 PM Florian Fainelli <f.fainelli@gmail.com
> <mailto:f.fainelli@gmail.com>> wrote:
>>
>>
>>
>> On 11/26/18 4:49 PM, René Kjellerup wrote:
>> > To the broadcom kernel maintainers, (for BCM4708 CPUs)
>> >
>> > I just want to add a little attention to this patch again...
>> > let me know if there's any concerns and I will try to address
> highlighted issues
>> > as soon as possible.
>> >
>> > I've been running the development builds of OpenWrt kernels, where
>> > this patch has
>> > been included, on my Linksys EA6500v2 router for the past months,
>> > updating as new
>> > builds are available. With only the on board BCM4360 chip (5GHz
> WiFi) is being
>> > disabled, has so far been stable for my use case.
>>
>> (Please no top posting). Your submission did make it through patchwork
>> and looks okay, I will run build tests and queue it up for 4.21 if
>> everything looks good. Thanks.
>>
> ...
>>
>> --
>> Florian
> 
> thank you Florian for the update
> I appreciate the feedback

Now applied to devicetree/next, thanks. Please use git
format-patch/send-email in the future, as the patch was mangled a little
bit by being sent within the message body.

Thank you
-- 
Florian
