Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C6DECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A12FB2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFhtO6Cr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A12FB2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbeJSENV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 00:13:21 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:35321 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725735AbeJSENV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 00:13:21 -0400
Received: by mail-yb1-f195.google.com with SMTP id k132-v6so1236050ybc.2;
        Thu, 18 Oct 2018 13:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=heyJuYdIkfQECBaZpsMDnQkWeA4y+aZXqva3uUO6Qtk=;
        b=dFhtO6CrgzeDs0x4RnqmT6Rh3WTshRfE0BXbNHVWN6vAtLQHsoxMWPyZW9yOI4aTtd
         FI/aVwiUuKQ1G/EmpSEpCTxfSImwqtgUGM70VprkgHJo3+5Xi1vEE/y63AzUZkYiHRFo
         bsjotB1Kk8mvXMITJo5MIPFbphaCxU8SzT2LyiygOnpXUt1febV93/D0iNKPjoRs1IgA
         aCs4pC27qKgGwrkYFuBJWXs9/RGxUHgIbw42ruUmRLU5ZK7S/9mQt3hfrjLWbMrmjEc7
         L9ipxEy0Xlia0OoBzmuRPm8D2g8fXTrJgFK42Me89PWoxTVOpfglhUa5+OwZ5NYFeC0d
         7PCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=heyJuYdIkfQECBaZpsMDnQkWeA4y+aZXqva3uUO6Qtk=;
        b=ApfLVB/6cGL00giDG/2C07zi89z4h9JZnHjVg4BxZtbJph8z8ydMq6QFZ//Qm0tiJj
         ZYu9lkm11p/Z5OHg7t3H8Zs/H5fnserrmyX0dYEg2LN1Z+xqqRhzAdr0R8YuOI/fPpLD
         5YIr0kgTF+bUsRfdO8WezlhXYt3chqCjVHnxgcmhNVTpKgUekbh78EpXbbKIRNmZTAO4
         TY5e2uAfZwpgazE4DGmVjhDHzMZExw5v7bwQO+0BfoN8etXhBB0TID8JTkFHwcc5af9z
         vD/vSADLwXbkz6kU93xfiFbtuipVLeUk6Lwc+RNYn906ybmVyupzmEH6rQYOOrO+mvO+
         VMFA==
X-Gm-Message-State: ABuFfojfF+i4mHeOrOnX0jw2LNuNzdx9QUXrIfp1X6GCZFJ/tJoE/+JR
        rvPnQDQ/Or1fGw9rmFtT41cTVOq7
X-Google-Smtp-Source: ACcGV606Rjy9eJaks/1kcAhBjP/UTHDIpDKwLl1O6EF0eEEOCZjfuxlPZCIJVvAsgiOebfkibG1T4g==
X-Received: by 2002:a25:1289:: with SMTP id 131-v6mr19838334ybs.122.1539893441899;
        Thu, 18 Oct 2018 13:10:41 -0700 (PDT)
Received: from [10.67.48.209] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id k2-v6sm5750843ywh.52.2018.10.18.13.10.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 13:10:40 -0700 (PDT)
Subject: Re: [PATCH] net: ethernet: fec: Add missing SPEED_
To:     LABBE Corentin <clabbe@baylibre.com>, hkallweit1@gmail.com
Cc:     andrew@lunn.ch, davem@davemloft.net, fugang.duan@nxp.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <1539875100-11121-1-git-send-email-clabbe@baylibre.com>
 <2621cbc9-47ed-ce2a-b7ee-262f17dc138f@gmail.com> <20181018184715.GA31736@Red>
 <d1461619-1344-e581-4eef-35cf8bbb5336@gmail.com> <20181018191612.GB31736@Red>
 <5cb0731b-83c5-5ed5-d022-98f8627d1737@gmail.com> <20181018195909.GA11317@Red>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <1b784f69-3ec2-feb2-81e1-9a335cf477c3@gmail.com>
Date:   Thu, 18 Oct 2018 13:10:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181018195909.GA11317@Red>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/2018 12:59 PM, LABBE Corentin wrote:
> On Thu, Oct 18, 2018 at 12:38:32PM -0700, Florian Fainelli wrote:
>> On 10/18/2018 12:16 PM, LABBE Corentin wrote:
>>> On Thu, Oct 18, 2018 at 11:55:49AM -0700, Florian Fainelli wrote:
>>>> On 10/18/2018 11:47 AM, LABBE Corentin wrote:
>>>>> On Thu, Oct 18, 2018 at 11:39:24AM -0700, Florian Fainelli wrote:
>>>>>> On 10/18/2018 08:05 AM, Corentin Labbe wrote:
>>>>>>> Since commit 58056c1e1b0e ("net: ethernet: Use phy_set_max_speed() to limit advertised speed"), the fec driver is unable to get any link.
>>>>>>> This is due to missing SPEED_.
>>>>>>
>>>>>> But SPEED_1000 is defined in include/uapi/linux/ethtool.h as 1000, so
>>>>>> surely this would amount to the same code paths being taken or am I
>>>>>> missing something here?
>>>>>
>>>>> The bisect session pointed your patch, reverting it fix the issue.
>>>>> BUT since the fix seemed trivial I sent the patch without more test then compile it.
>>>>> Sorry, I have just found some minutes ago that it didnt fix the issue.
>>>>>
>>>>> But your patch is still the cause for sure.
>>>>>
>>>>
>>>> What you are writing is really lowering the confidence level, first
>>>> Andrew is the author of that patch, and second "just compiling" and
>>>> pretending this fixes a problem when it does not is not quite what I
>>>> would expect.
>>>>
>>>> I don't have a problem helping you find the solution or the right fix
>>>> though, even if it is not my patch, but please get the author and actual
>>>> problem right so we can move forward in confidence, thanks!
>>>
>>> Sorry again, I wanted to acknoledge my error but I did it too fast and late.
>>> And sorry to have confound you with Andrew.
>>
>> No worries, here to help, let us know what your bisection points to. THanks
> 
> I have added printing of phydev->supported
> My working kernel (on top of 58056c1e1b0e + revert patch) got:
> [    5.550838] fec_enet_mii_probe 2ff (gbit features)
> [    5.555848] fec_enet_mii_probe 2ef (without 1000baseT_Half)
> [    5.561620] fec_enet_mii_probe 22ef final (after pause)
> [    5.566914] Micrel KSZ9021 Gigabit PHY 2188000.ethernet-1:06: attached PHY driver [Micrel KSZ9021 Gigabit PHY] (mii_bus:phy_addr=2188000.ethernet-1:06, irq=POLL)
> [    8.730751] fec 2188000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx
> [    8.788311] Sending DHCP requests ., OK
> [    8.832357] IP-Config: Got DHCP answer from 192.168.66.1, my address is 192.168.66.58
> 
> the non-working kernel (next-20181015)
> [    7.308917] fec_enet_mii_probe 62ff after phy_set_max_speed
> [    7.314545] fec_enet_mii_probe 62ef after phy_remove_link_mode
> [    7.320418] fec_enet_mii_probe 62ef after pause
> and then no link
> 
> So it seems that phy_set_max_speed adds bit 14 (ETHTOOL_LINK_MODE_Asym_Pause_BIT)

It's not masking it so it must be coming from phy_probe().

> 
> I have patched by adding:
> phy_remove_link_mode(phy_dev, ETHTOOL_LINK_MODE_Asym_Pause_BIT);
> and got:
> [    7.310559] fec_enet_mii_probe 62ff after phy_set_max_speed
> [    7.316221] fec_enet_mii_probe 22ef after phy_remove_link_mode
> [    7.322128] fec_enet_mii_probe 22ef after pause
> [    7.326681] Micrel KSZ9021 Gigabit PHY 2188000.ethernet-1:06: attached PHY driver [Micrel KSZ9021 Gigabit PHY] (mii_bus:phy_addr=2188000.ethernet-1:06, irq=POLL)
> [    7.611276] Waiting up to 3 more seconds for network.
> [    7.881278] Waiting up to 2 more seconds for network.
> [    8.131277] Waiting up to 2 more seconds for network.
> [    8.401169] Waiting up to 2 more seconds for network.
> [    8.671269] Waiting up to 2 more seconds for network.
> [    8.941274] Waiting up to 1 more seconds for network.
> [    9.211181] Waiting up to 1 more seconds for network.
> [    9.481274] Waiting up to 1 more seconds for network.
> [    9.751275] Waiting up to 1 more seconds for network.
> [   10.021281] Waiting up to 0 more seconds for network.
> [   10.291274] Waiting up to 0 more seconds for network.
> [   10.381282] Sending DHCP requests .
> [   10.473000] fec 2188000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx
> [   12.861267] ., OK
> [   12.903405] IP-Config: Got DHCP answer from 192.168.66.1, my address is 192.168.66.58
> 
> So at least I got a link, but the link is still late to got

The delay is likely something entirely different, it could be some of
Heiner's recent changes to PHYLIB, Heiner do you have access to a system
that polls the PHY?
-- 
Florian
