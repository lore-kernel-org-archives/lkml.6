Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2E4C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 20:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A573620892
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 20:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAJsutEj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A573620892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438484AbeKWGeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 01:34:20 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34653 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438454AbeKWGeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 01:34:17 -0500
Received: by mail-wr1-f66.google.com with SMTP id j2so10328414wrw.1;
        Thu, 22 Nov 2018 11:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9GMxjTuLZKlFe6ydRMWnN07NzQnOnkhLvwidrdTJ3o8=;
        b=jAJsutEj6Sps7FDJmG9AwrhkR5+QWNVnTvYIZhMfQvAMJJ0q7Rul3IVtXv8WIiCNy1
         bQ5EdJN3OOJas/5FMwJfebedgW/ydsg1taEeUxuMQIZe0+u2f5s77hY7xjU6XEpKPzHP
         TtBzBcgrxnXcO8tmxMnmeCXRIPG3sTxJTcTeazRlDRQH+9hM09TzLc3uR4dvmpHCSiUs
         k8YYREVYes5ery4soBaLlAuVOd397jlZhJ/GQtruYnctBfs+dTNiF0C/UGvtksNwCSXH
         ksftEZ3j9yOk29Nrg/m5NsMbAV7rQzw7mQlpEjoRRPsObAOmC4NUgd40k1mhRcLYJ4mB
         6nyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9GMxjTuLZKlFe6ydRMWnN07NzQnOnkhLvwidrdTJ3o8=;
        b=r96ckAxgluTkMCzafdB5dOyuP7IXFMAeglgfr+EWrXqzpvmnm+jcbICkDHUGcGa9wl
         hLld/AW/YBCVjDJ6pt2GIsKQiLBnxtsHvZz+EG7PtZxv/7dhQaXrvGcREeNf08OcFNWu
         db2qk9L43gpJWsTdbysaEXZn5lxN1Osj1Ou1RXEV00ikse5hcS25CeBfHWI5GajCa2xv
         NJJkauHQBbQTL/N3yR7nOWtsXb79LxA4qbmyuw2BvgFxm9zOnkv3iDO7/66ROdIom0pJ
         lNrAItHcBVIfJEENqgx5DPkexJCQWNUBW8WYCZzVutO2fAhWR/yxIZeq8dSmqrJSBqdc
         DAow==
X-Gm-Message-State: AA+aEWY3Q6XCF5/9Ai9Ov6NjUnEIYvmOSGpdIqAEtL0NNdUcFxf7iLW7
        16p6VsF6TRRZEAkvpiPNlb8=
X-Google-Smtp-Source: AFSGD/Ww/5GmbeomgqiX1ueQHxEg3j9LkCUaL7wyEaUKKAVqfFX2ndFFtcGzaqw4ogtmViBsRodUPg==
X-Received: by 2002:adf:ea81:: with SMTP id s1mr10768608wrm.309.1542916404491;
        Thu, 22 Nov 2018 11:53:24 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:55f4:efb4:8b34:37bb? (p200300EA8BCFE30055F4EFB48B3437BB.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:55f4:efb4:8b34:37bb])
        by smtp.googlemail.com with ESMTPSA id h67-v6sm8855069wma.10.2018.11.22.11.53.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 11:53:23 -0800 (PST)
Subject: Re: Issue with RTL8111 NIC after upgrade to kernel 4.19
To:     Marc Dionne <marc.c.dionne@gmail.com>
Cc:     andrew@lunn.ch, norbert.jurkeit@web.de, nic_swsd@realtek.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        michael.wiktowy@gmail.com, jcline@redhat.com
References: <d0a53002-bf14-6cd9-ab0f-5d3f9aa395ce@web.de>
 <38dad61b-bc7f-7038-6d1b-f5c4afe3841c@gmail.com>
 <20181121202034.GA10697@lunn.ch>
 <eda84d0b-2d9f-07ae-34a1-767bc5200964@gmail.com>
 <6aeba3d6-2292-1221-9be7-1c0bb7cbc203@gmail.com>
 <7d6362e1-e197-d338-d6b0-9036c3802e2c@gmail.com>
 <CAB9dFdvw8QqzaVYV3bOMGtACyvqWnE9uy96m1tu2C+jjzQR9_Q@mail.gmail.com>
 <a995b6f6-c5b1-877c-581c-39c0897e7703@gmail.com>
 <CAB9dFdsq7EBNm1Y1nK2tqOvg5ikyTm4ZGTQddsNAp1BaA0J_XQ@mail.gmail.com>
 <d38a9ed9-b801-5622-1d3a-1b9620ed9d8d@gmail.com>
 <CAB9dFdvscM_vjhautiNc6yNZ4_aMQOkcGeKmAyRv4E191q9jaQ@mail.gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <d5eab5e6-c538-ba4b-ea6b-21874c95f45e@gmail.com>
Date:   Thu, 22 Nov 2018 20:53:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <CAB9dFdvscM_vjhautiNc6yNZ4_aMQOkcGeKmAyRv4E191q9jaQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.11.2018 20:29, Marc Dionne wrote:
> On Thu, Nov 22, 2018 at 2:17 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>> Thanks a lot for testing. Could you please test also the following
>> as an alternative to the delay?
>>
>> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
>> index 55202a0ac..aeccb2323 100644
>> --- a/drivers/net/phy/phy_device.c
>> +++ b/drivers/net/phy/phy_device.c
>> @@ -2254,6 +2254,7 @@ int phy_driver_register(struct phy_driver *new_driver, struct module *owner)
>>         new_driver->mdiodrv.driver.probe = phy_probe;
>>         new_driver->mdiodrv.driver.remove = phy_remove;
>>         new_driver->mdiodrv.driver.owner = owner;
>> +       new_driver->mdiodrv.driver.probe_type = PROBE_FORCE_SYNCHRONOUS;
>>
>>         retval = driver_register(&new_driver->mdiodrv.driver);
>>         if (retval) {
> 
> That also gets me network reliably, switching between a kernel where
> it fails (distro 4.19 kernel) and the custom kernel with the patch.
> 
Thanks again for the very quick response. The result is good and bad
news at once: good because it seems we have a fix, bad because we
don't understand the root cause of the issue yet.

>>> There's a side issue that network startup is taking a full minute
>>> longer than it should, but that's possibly unrelated.
> 
> BTW that's an unrelated rng issue, for which I have a workaround.
> 
Indeed totally unrelated, but sounds familiar. I had the same issue
on a headless system which therefore generates very little entropy.
I fixed it by setting CONFIG_RANDOM_TRUST_CPU=y

>>>
>> Thanks, Heiner
> 
> Marc
> 
Heiner
