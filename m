Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,GUARANTEED_100_PERCENT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDF3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31072206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="omGHOlLA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31072206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390092AbeKVJEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 04:04:48 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53227 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731518AbeKVJEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 04:04:48 -0500
Received: by mail-wm1-f66.google.com with SMTP id r11-v6so7031421wmb.2;
        Wed, 21 Nov 2018 14:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z4E6MGK7lBjNf+leUOXzciChTB018DGDlsQnJtL4j9A=;
        b=omGHOlLAYuXWMa+fFSaqegt1973KZh5Ru/K75xL58dGms3DgFtYrvxL7EVRw70vrFG
         V50lBzIc4+SSuYBYyVnHqIcVRo/iY/XKNXD05qZ8D33ChxAP0EdbVYCbZ22tRWH7OIbn
         tzAeEcAgj52B8S1ZoYuO5Cj92vdtEMnAXyrSurBUcUQbutherM9nDh3I4bXFtlDUvBIn
         opFFYejRNsAYUp45YCwuvxhYbst/P48+QAM3eQ7R4+UM2SmT/O+FNkobs3yzZ7BVgY3x
         vTMggfHz4I8VqJgj7z5xxjVfMu8FtJJDh7ElFin9GsZnCxqUTbx3SgNFv4v0iMHBvU1G
         baLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z4E6MGK7lBjNf+leUOXzciChTB018DGDlsQnJtL4j9A=;
        b=rI3q/GYlhyu2vxg9wkbLhp7JLawcBzjU0U5UeqYO6nmKNdhf7oWw3oXWzhQUSK4Ud7
         4Ge+wDjVyCY98/KN+yuRzvHYmjY0mGupjHMc7yrfH9lK4/EnJoGOhO7zkr+IE51JsfUI
         fqUCAGgXNucU35aIBNzc42suPaffvoSyderpKqYXXissXRtrcse+53v1jWmPK8Hh3+U4
         jRED7gH270/3+43Zf1AYv5tuQJ0GYrKBHRs5tLnXKjfvGxeTcmP+oY3uE2k0PAWj5iHm
         JmMrrzHcQ6YkH25CDVj7Z8155HOnfltd7SVS7inyNF19Pu3Kel5mtsyj63fw+U2+BJXP
         4lbg==
X-Gm-Message-State: AGRZ1gJgOl1VPqENRM6mz4KD2RAfHhvuTPYmt41YNWxm8lSm5ck85UNM
        Hh9R1I7w0P2Y+Zv8XbKa05I=
X-Google-Smtp-Source: AFSGD/XkiBc7HPnlyNY7ojdXqL55f+URtted/qDcfNMa/38Ti6CQMoGhkN/kwq5ajtNdqqUzgqRmXQ==
X-Received: by 2002:a1c:27c5:: with SMTP id n188-v6mr7696223wmn.88.1542839307630;
        Wed, 21 Nov 2018 14:28:27 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:14d:188e:adb0:9ba6? (p200300EA8BCFE300014D188EADB09BA6.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:14d:188e:adb0:9ba6])
        by smtp.googlemail.com with ESMTPSA id c188-v6sm1167551wma.39.2018.11.21.14.28.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 14:28:26 -0800 (PST)
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
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <a995b6f6-c5b1-877c-581c-39c0897e7703@gmail.com>
Date:   Wed, 21 Nov 2018 23:28:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <CAB9dFdvw8QqzaVYV3bOMGtACyvqWnE9uy96m1tu2C+jjzQR9_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.11.2018 22:53, Marc Dionne wrote:
> On Wed, Nov 21, 2018 at 4:52 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> On 21.11.2018 21:49, Heiner Kallweit wrote:
>>> On 21.11.2018 21:32, Heiner Kallweit wrote:
>>>> On 21.11.2018 21:20, Andrew Lunn wrote:
>>>>>> request_module() is supposed to be synchronous, however after some
>>>>>> reading this may not be 100% guaranteed. Maybe the module init
>>>>>> function on some systems isn't finished yet when request_module()
>>>>>> returns. As a result the genphy driver may be used instead of
>>>>>> the PHY version-specific driver.
>>>>>
>>>>> Hi Heiner
>>>>>
>>>>> That would be true for all PHYs i think. We would of noticed this
>>>>> problem with other systems using other PHY drivers.
>>>>>
>>>>>     Andrew
>>>>>
>>>> It could be a timing issue affecting certain systems only. At least
>>>> for now I don't have a good explanation why loading the module via
>>>> request_module() and loading it upfront manually makes a difference.
>>>>
>>>> One affected user just reported the PHY to be a RTL8211B. This is
>>>> what I expected, because this PHY crashes when writing to the MMD
>>>> registers (the MMD registers are used otherwise by this PHY).
>>>> See also commit 0231b1a074c6 ("net: phy: realtek: Use the dummy
>>>> stubs for MMD register access for rtl8211b").
>>>>
>>>> Let's see whether the other affected systems use the same PHY
>>>> version.
>>>>
>>> Next report is also about a RTL8211B and as I assumed:
>>> - W/o manually loading the realtek module the genphy driver is used
>>>   and network fails.
>>> - W/ manually loading the realtek module the proper RTL8211B PHY
>>>   driver is used and network works.
>>>
>>> So it seems that even after request_module() the PHY driver isn't
>>> yet available when device and driver are matched.
>>>
>>> If further reports support this (pre-)analysis, then indeed it
>>> seems to be a timing issue and a proper fix most likely is
>>> difficult. As a workaround I could imagine to add a delay loop
>>> after request_module() checking for a Realtek PHY driver via
>>> driver_find(). When adding one small delay after this we should
>>> be sufficiently sure that all Realtek PHY drivers are registered.
>>>
>> Uups, no. We talk about phylib here, not about the r8169 driver.
>> So we need a different solution.
>>
>>>> Heiner
> 
> Thanks for the explanation, better than my crude attempt at
> understanding what was going on.
> 
> If you have any proposed fixes or diagnostic patches based on current
> mainline I can quickly compile and test them here on an affected
> system.  It doesn't fail consistently for me (as others have
> reported), but that could be because it depends on the timing.
> 

Thanks for the offer. Can you try the following diagnostic patch
and check whether it helps?

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 55202a0ac..84f417f8b 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -607,6 +607,8 @@ struct phy_device *phy_device_create(struct mii_bus *bus, int addr, int phy_id,
         */
        request_module(MDIO_MODULE_PREFIX MDIO_ID_FMT, MDIO_ID_ARGS(phy_id));

+       msleep(1000);
+
        device_initialize(&mdiodev->dev);

        return dev;


> Marc
> 

