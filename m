Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF47C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2AED20685
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLDFhd4u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2AED20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438354AbeKWG3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 01:29:40 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33111 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731237AbeKWG3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 01:29:40 -0500
Received: by mail-wm1-f68.google.com with SMTP id 79so10218149wmo.0;
        Thu, 22 Nov 2018 11:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8DGlOGaFGOGKyJgM3H/RAsAAvCfhFLhuJQcKhv0nm6Q=;
        b=RLDFhd4uk109wIKnwr5elfbDvK3txH6IcRGaewj7PDkbcAFDvz8LD/MelVxzQNZU/n
         1NsAimTYqTPcigjSADW+BOSq3+Pe5UUHdQBTeK760UiNlnidPpY+aITKOLcqlUzgX1WV
         lgkXaAK5jbsVjZBaEFQECTjmzn7KoE7EHSgk3hYSgqFhZJFI9ca73gRZaj6Pp7e3BsAJ
         xRIYQ+WAC5stbUqCV47XEeVSS7edAI+K4v8ch8B1dkLcEup9+//j4XHuvZLMYpRD/t/U
         pUeER5vYw6exH07Y4vQsQsQlIs/Uoog3CMm8/wEGA+OgaJ+EMAQ7TAQsJXzbZ+tqvXc+
         OoiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8DGlOGaFGOGKyJgM3H/RAsAAvCfhFLhuJQcKhv0nm6Q=;
        b=rp/X3xOxSLXxqpLnulY2x5copYx7J+r5QqF1mHxHEjFrpnYn4Lq5EJWHfIGg4PAEir
         CyaBuZQguR1yKBwZRbwuifoMO22jcpOgqq5WikzMwyUURErK/07GO+khGmlZEcag832L
         IED/h5I4Kctf6lJuGD6kNP2X55VJ0GkqG4/nu5+ACeHhd9ybSQhSZkeqkhi/Gk9ddIjF
         silaVFAsoyyiOg3ehSZCOH1D6zy4etZ8AOy1kA2gN76xoCcNKFTjDo6wphVJLSbICAVB
         0BCcRixEp69DoO8QtwIpjguM70FuQxmwYvR0C+tsABmPfzuyPJi7C7R2apcIiLkzZX2r
         /sEA==
X-Gm-Message-State: AGRZ1gJ3o82xT+0/Di9Na4pT2hatfMQGOvoWsiMmE2B/+duvlRPJn8zA
        5i53HaJvYsleliXG/I5IJUc=
X-Google-Smtp-Source: AJdET5cCoCs2fPTiJ2QDy5e9hPNu1dj4FYkXimmZ1bNNJS5lAIpCK0ti4Iq+qwoyr8WVYcUsNhLFdw==
X-Received: by 2002:a1c:8791:: with SMTP id j139mr10626441wmd.86.1542916127391;
        Thu, 22 Nov 2018 11:48:47 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:55f4:efb4:8b34:37bb? (p200300EA8BCFE30055F4EFB48B3437BB.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:55f4:efb4:8b34:37bb])
        by smtp.googlemail.com with ESMTPSA id 184-v6sm5977120wmh.36.2018.11.22.11.48.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 11:48:46 -0800 (PST)
Subject: Re: Issue with RTL8111 NIC after upgrade to kernel 4.19
To:     Andrew Lunn <andrew@lunn.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Marc Dionne <marc.c.dionne@gmail.com>, norbert.jurkeit@web.de,
        nic_swsd@realtek.com, Florian Fainelli <f.fainelli@gmail.com>,
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
 <20181122185705.GG10697@lunn.ch>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <097161f8-8744-cc1c-88e9-8884304037ea@gmail.com>
Date:   Thu, 22 Nov 2018 20:48:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181122185705.GG10697@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.11.2018 19:57, Andrew Lunn wrote:
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
> 
> Humm, maybe i don't understand the issue correctly.
> 
> When the MDIO bus is registered, we scan the bus looking for PHYs.
> When we find a PHY, we call phy_device_create(). That will then
> trigger the loading of the kernel module which should driver this phy.
> 
> Sometime later, the PHY driver module gets loaded and calls
> phy_drivers_register() to register the list of IDs it supports.  The
> driver core will then call phy_bus_match() to see if the newly loaded
> driver matches to a device we have created. If so, the driver will be
> associated to the device.
> 
request_module() is synchronous and should return only once the init
function of the loaded module has been executed. Means in case of
phylib: all PHY drivers of the module have been registered

> Sometime later, the MAC tries to attach to the phy using
> phy_attach_direct(). If there is no driver associated to the device,
> we use the generic PHY driver.
> 
> I thought the issue was the race condition between loading the module
> and the MAC attaching to it? We are getting the generic driver because
> the specific driver is still loading?
> 
No. The issue happens before: For whatever reason the PHY driver doesn't
bind to the PHY device, even though they match. Therefore
phy_attach_direct() then binds the genphy driver.

In theory it shouldn't make a difference whether device or driver is
registered first. When a driver is registered it checks all unbound
devices on the same bus for a match.

Standard is asynchronous driver probing, therefore in case of phylib
(in at least a lot of cases) the driver probes the devices on the bus
once the PHY device was registered. This seems to fail and I have no
idea why.

It has been reported that loading the PHY driver module upfront fixes
the issue. Therefore I assumed it may help to let the PHY driver probe
for devices earlier (even though the device isn't even registered yet).
And indeed (see mail just sent by Marc) using synchronous probing
fixes the issue.
It seems to me that probing triggered from device registering and
probing triggered from driver registering somehow interfere.

Of course it's not very satisfying to have a fix but to not understand
the root cause of the issue. I add Greg and Rafael as maintainers of
the driver core to the discussion. Maybe they can shed some light on
the situation.

> If that really is the issue, i think phy_attach_direct() should try
> loading the module again, doing it synchronously. Only when it fails
> should the generic driver be associated to the device.
> 
>        Andrew
> 
> 
Heiner

