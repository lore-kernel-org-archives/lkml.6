Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,GUARANTEED_100_PERCENT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F7AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 18:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1AB2206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 18:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgTt5Rsy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1AB2206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438228AbeKWE6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 23:58:00 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36934 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbeKWE57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 23:57:59 -0500
Received: by mail-wm1-f68.google.com with SMTP id p2-v6so9921875wmc.2;
        Thu, 22 Nov 2018 10:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9NcZ1mQmJqAhwC9FiCdmn0qreBttSANTFtMFgxlu92Y=;
        b=PgTt5RsywP7maaaH+f0uWZoOgNjpYXE2L3oNvmyYl2w5yxav7MiiEfbaKsn+TQgGtx
         2oU/i6mfJerC1a4+aoKyy4Qymxzi+HwqC2CmeGxeTkQJla02IaH2Ae6lytk1XJAlnsm2
         1soGbITFjszVgMi1e1symNrxIm1l7gz7VnUuzRI1JZK/TUvSI9nb50PfP7AcQ/8C34X6
         /s7i45cPQ7MmlXX2MVHmSLtXhT0aYGkHqkhM6Ilqq8kmwtrqppp3o+szxseYGwTV4RxB
         ocOHHZp+pmapYts2WCyswAr9bazFYKQP2xUFDJ84eM748FKv6TJo1zZBDv32yEeI3H6Z
         Mbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9NcZ1mQmJqAhwC9FiCdmn0qreBttSANTFtMFgxlu92Y=;
        b=XtUp3oGJge05KXcsWsgacqZ4HlY6cbdwExPZoc6ofObPKH79Xoos2CacWU+rdmCkEy
         wo4hYsgaJZzfPrBYT3Xh8zeB3WL9mdonvkf5G6sLMnBUW16RuZGCRQXI8sWEJpq3R7Rt
         Qgq5ZIjjUhDUoKrx87w6OTBumQqf/m0L+/gkvJX6jmaJxEWhwmB/l2z9MMex5tu8JaM8
         pQasx2MQOePZIqTvv1p6lfVRAI3plNcPrhDhG6if+QAothp0I1hLTz9ZDv7WbpVJkrNr
         sh9YHxd0difeJskFUIwTegK9gxIUFYfOChX8V+dyDHCso9iGFZ80VoeWLjPx//HRMK38
         Q5Gw==
X-Gm-Message-State: AA+aEWaLPnzoDc+ld3iEpOrB2jjFtowPlXcSOCFF7w95a4k+WHu9rh/H
        g/BSgeSHdxooIxqaehsaTOc=
X-Google-Smtp-Source: AFSGD/XzHzfvjADgXP9pbzD47boxeht7VkseQkn6rfmFJqJfM+Sh5if9VxibSQV92gADJb+vziNVag==
X-Received: by 2002:a1c:e1d5:: with SMTP id y204mr10518668wmg.65.1542910646666;
        Thu, 22 Nov 2018 10:17:26 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:8cae:5d18:de41:45b6? (p200300EA8BCFE3008CAE5D18DE4145B6.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:8cae:5d18:de41:45b6])
        by smtp.googlemail.com with ESMTPSA id w8sm15707544wrv.7.2018.11.22.10.17.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 10:17:25 -0800 (PST)
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
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <d38a9ed9-b801-5622-1d3a-1b9620ed9d8d@gmail.com>
Date:   Thu, 22 Nov 2018 19:17:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <CAB9dFdsq7EBNm1Y1nK2tqOvg5ikyTm4ZGTQddsNAp1BaA0J_XQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.11.2018 00:13, Marc Dionne wrote:
> On Wed, Nov 21, 2018 at 6:28 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> On 21.11.2018 22:53, Marc Dionne wrote:
>>> On Wed, Nov 21, 2018 at 4:52 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>>>
>>>> On 21.11.2018 21:49, Heiner Kallweit wrote:
>>>>> On 21.11.2018 21:32, Heiner Kallweit wrote:
>>>>>> On 21.11.2018 21:20, Andrew Lunn wrote:
>>>>>>>> request_module() is supposed to be synchronous, however after some
>>>>>>>> reading this may not be 100% guaranteed. Maybe the module init
>>>>>>>> function on some systems isn't finished yet when request_module()
>>>>>>>> returns. As a result the genphy driver may be used instead of
>>>>>>>> the PHY version-specific driver.
>>>>>>>
>>>>>>> Hi Heiner
>>>>>>>
>>>>>>> That would be true for all PHYs i think. We would of noticed this
>>>>>>> problem with other systems using other PHY drivers.
>>>>>>>
>>>>>>>     Andrew
>>>>>>>
>>>>>> It could be a timing issue affecting certain systems only. At least
>>>>>> for now I don't have a good explanation why loading the module via
>>>>>> request_module() and loading it upfront manually makes a difference.
>>>>>>
>>>>>> One affected user just reported the PHY to be a RTL8211B. This is
>>>>>> what I expected, because this PHY crashes when writing to the MMD
>>>>>> registers (the MMD registers are used otherwise by this PHY).
>>>>>> See also commit 0231b1a074c6 ("net: phy: realtek: Use the dummy
>>>>>> stubs for MMD register access for rtl8211b").
>>>>>>
>>>>>> Let's see whether the other affected systems use the same PHY
>>>>>> version.
>>>>>>
>>>>> Next report is also about a RTL8211B and as I assumed:
>>>>> - W/o manually loading the realtek module the genphy driver is used
>>>>>   and network fails.
>>>>> - W/ manually loading the realtek module the proper RTL8211B PHY
>>>>>   driver is used and network works.
>>>>>
>>>>> So it seems that even after request_module() the PHY driver isn't
>>>>> yet available when device and driver are matched.
>>>>>
>>>>> If further reports support this (pre-)analysis, then indeed it
>>>>> seems to be a timing issue and a proper fix most likely is
>>>>> difficult. As a workaround I could imagine to add a delay loop
>>>>> after request_module() checking for a Realtek PHY driver via
>>>>> driver_find(). When adding one small delay after this we should
>>>>> be sufficiently sure that all Realtek PHY drivers are registered.
>>>>>
>>>> Uups, no. We talk about phylib here, not about the r8169 driver.
>>>> So we need a different solution.
>>>>
>>>>>> Heiner
>>>
>>> Thanks for the explanation, better than my crude attempt at
>>> understanding what was going on.
>>>
>>> If you have any proposed fixes or diagnostic patches based on current
>>> mainline I can quickly compile and test them here on an affected
>>> system.  It doesn't fail consistently for me (as others have
>>> reported), but that could be because it depends on the timing.
>>>
>>
>> Thanks for the offer. Can you try the following diagnostic patch
>> and check whether it helps?
>>
>> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
>> index 55202a0ac..84f417f8b 100644
>> --- a/drivers/net/phy/phy_device.c
>> +++ b/drivers/net/phy/phy_device.c
>> @@ -607,6 +607,8 @@ struct phy_device *phy_device_create(struct mii_bus *bus, int addr, int phy_id,
>>          */
>>         request_module(MDIO_MODULE_PREFIX MDIO_ID_FMT, MDIO_ID_ARGS(phy_id));
>>
>> +       msleep(1000);
>> +
>>         device_initialize(&mdiodev->dev);
>>
>>         return dev;
> 
> I was not able to get it to fail with that extra delay; hard to be
> 100% sure but the network starts even when switching over from the
> distro kernel after a boot where network failed to start.
> 
Thanks a lot for testing. Could you please test also the following
as an alternative to the delay?

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 55202a0ac..aeccb2323 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2254,6 +2254,7 @@ int phy_driver_register(struct phy_driver *new_driver, struct module *owner)
        new_driver->mdiodrv.driver.probe = phy_probe;
        new_driver->mdiodrv.driver.remove = phy_remove;
        new_driver->mdiodrv.driver.owner = owner;
+       new_driver->mdiodrv.driver.probe_type = PROBE_FORCE_SYNCHRONOUS;

        retval = driver_register(&new_driver->mdiodrv.driver);
        if (retval) {

> There's a side issue that network startup is taking a full minute
> longer than it should, but that's possibly unrelated.
> 
> Marc
> 
Thanks, Heiner
