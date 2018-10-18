Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BE4C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF6D20658
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2UVvSYq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DF6D20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbeJSEoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 00:44:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40185 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbeJSEoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 00:44:08 -0400
Received: by mail-wm1-f68.google.com with SMTP id z204-v6so1630859wmc.5;
        Thu, 18 Oct 2018 13:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kw9GgrypJValWF3bQPyc/d4Jfb9yswoPSCYhO88Iyno=;
        b=C2UVvSYqRCQeA1zLwik7vEMrsAMe6ThYhieKI5ohzXwOWesM5i2k8zc7EchgWUr5ls
         FfjfkFDsnRDp2i/+NiATv1m2zri/EaPNltn7D3p3PE+yEFgQW6XvyvgrDt0Ywo9gY4g1
         9iIfM5DGhQWJ8FLCvG0zIh5kRQ3NHc7hZoAzxKctcqHbZey1cSt4rUp8YZ1/BE77Tt8R
         wrf8E9vpDO4OsG4Uz5GSCPR24GeySI+UXMM1rfMZRVkVq5LBmzJOTGBsug/40kXnJZM0
         RGJyktWOjMAKZEXu0RqAfZfBiRm92YRqVzlVege6Zvn3hkSM1nwh+Po1mHthZwGzy2Kt
         6uxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kw9GgrypJValWF3bQPyc/d4Jfb9yswoPSCYhO88Iyno=;
        b=QEypmLSNx4/gzCj4LCcpjZyWNSY2xx+iyIA3DugAEcAP+Me8HKjsNNSs2ryeFWXrkx
         Uplq3Bu7ESHpDPNmvCwUN1o8ATgG6woVKaw3rW2+/5ZL7gcEwzOYKhfgah0PhL9IH1Ld
         LuR2HxdKPEhhV5VG0MI6ZE8203rw/TwJKsz0eRfR9Y6CGjtdE9kwt/vJwFp6CiddWmrQ
         mMW01HLqSJ7fbMhzcKg5ayB7zXtb2ovNllsRaHJyB3pIL6kioNa435FqQuY9RF4fQSB2
         hruT0b77tsqsJQpSk2M4zI65kv8x+kLM45AhOkd17RT2ET/7HNV2U/cTVAbBe6rR+i1B
         MQRQ==
X-Gm-Message-State: ABuFfoiFDi4rsUQaSSw4DJ6CCC0zUsNRzVI+LfMz1KQopBAbtfg2W+Ju
        6UnyeCeytCkHKhgVniDSaJu1WgKSXHY=
X-Google-Smtp-Source: ACcGV60b1uRXYIUdIuYvbMtJJRMGAQu9uPS2dsxcMxlkH6Td1lqLymZkaNqr1QfL27Nvt0ZVTZeGhQ==
X-Received: by 2002:a1c:6a18:: with SMTP id f24-v6mr1818391wmc.150.1539895279685;
        Thu, 18 Oct 2018 13:41:19 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:3f00:bc84:89cc:d913:5704? (p200300EA8BD43F00BC8489CCD9135704.dip0.t-ipconnect.de. [2003:ea:8bd4:3f00:bc84:89cc:d913:5704])
        by smtp.googlemail.com with ESMTPSA id t77-v6sm1873723wme.18.2018.10.18.13.41.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 13:41:19 -0700 (PDT)
Subject: Re: [PATCH] net: ethernet: fec: Add missing SPEED_
To:     Florian Fainelli <f.fainelli@gmail.com>,
        LABBE Corentin <clabbe@baylibre.com>
Cc:     andrew@lunn.ch, davem@davemloft.net, fugang.duan@nxp.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <1539875100-11121-1-git-send-email-clabbe@baylibre.com>
 <2621cbc9-47ed-ce2a-b7ee-262f17dc138f@gmail.com> <20181018184715.GA31736@Red>
 <d1461619-1344-e581-4eef-35cf8bbb5336@gmail.com> <20181018191612.GB31736@Red>
 <5cb0731b-83c5-5ed5-d022-98f8627d1737@gmail.com> <20181018195909.GA11317@Red>
 <1b784f69-3ec2-feb2-81e1-9a335cf477c3@gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <f1933c0a-d124-a7ac-afab-2fa8f88907ab@gmail.com>
Date:   Thu, 18 Oct 2018 22:41:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1b784f69-3ec2-feb2-81e1-9a335cf477c3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.10.2018 22:10, Florian Fainelli wrote:
> On 10/18/2018 12:59 PM, LABBE Corentin wrote:
>> On Thu, Oct 18, 2018 at 12:38:32PM -0700, Florian Fainelli wrote:
>>> On 10/18/2018 12:16 PM, LABBE Corentin wrote:
>>>> On Thu, Oct 18, 2018 at 11:55:49AM -0700, Florian Fainelli wrote:
>>>>> On 10/18/2018 11:47 AM, LABBE Corentin wrote:
>>>>>> On Thu, Oct 18, 2018 at 11:39:24AM -0700, Florian Fainelli wrote:
>>>>>>> On 10/18/2018 08:05 AM, Corentin Labbe wrote:
>>>>>>>> Since commit 58056c1e1b0e ("net: ethernet: Use phy_set_max_speed() to limit advertised speed"), the fec driver is unable to get any link.
>>>>>>>> This is due to missing SPEED_.
>>>>>>>
>>>>>>> But SPEED_1000 is defined in include/uapi/linux/ethtool.h as 1000, so
>>>>>>> surely this would amount to the same code paths being taken or am I
>>>>>>> missing something here?
>>>>>>
>>>>>> The bisect session pointed your patch, reverting it fix the issue.
>>>>>> BUT since the fix seemed trivial I sent the patch without more test then compile it.
>>>>>> Sorry, I have just found some minutes ago that it didnt fix the issue.
>>>>>>
>>>>>> But your patch is still the cause for sure.
>>>>>>
>>>>>
>>>>> What you are writing is really lowering the confidence level, first
>>>>> Andrew is the author of that patch, and second "just compiling" and
>>>>> pretending this fixes a problem when it does not is not quite what I
>>>>> would expect.
>>>>>
>>>>> I don't have a problem helping you find the solution or the right fix
>>>>> though, even if it is not my patch, but please get the author and actual
>>>>> problem right so we can move forward in confidence, thanks!
>>>>
>>>> Sorry again, I wanted to acknoledge my error but I did it too fast and late.
>>>> And sorry to have confound you with Andrew.
>>>
>>> No worries, here to help, let us know what your bisection points to. THanks
>>
>> I have added printing of phydev->supported
>> My working kernel (on top of 58056c1e1b0e + revert patch) got:
>> [    5.550838] fec_enet_mii_probe 2ff (gbit features)
>> [    5.555848] fec_enet_mii_probe 2ef (without 1000baseT_Half)
>> [    5.561620] fec_enet_mii_probe 22ef final (after pause)
>> [    5.566914] Micrel KSZ9021 Gigabit PHY 2188000.ethernet-1:06: attached PHY driver [Micrel KSZ9021 Gigabit PHY] (mii_bus:phy_addr=2188000.ethernet-1:06, irq=POLL)
>> [    8.730751] fec 2188000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx
>> [    8.788311] Sending DHCP requests ., OK
>> [    8.832357] IP-Config: Got DHCP answer from 192.168.66.1, my address is 192.168.66.58
>>
>> the non-working kernel (next-20181015)
>> [    7.308917] fec_enet_mii_probe 62ff after phy_set_max_speed
>> [    7.314545] fec_enet_mii_probe 62ef after phy_remove_link_mode
>> [    7.320418] fec_enet_mii_probe 62ef after pause
>> and then no link
>>
>> So it seems that phy_set_max_speed adds bit 14 (ETHTOOL_LINK_MODE_Asym_Pause_BIT)
> 
> It's not masking it so it must be coming from phy_probe().
> 
See df8ed346d4a8 ("net: phy: fix flag masking in __set_phy_supported").
phy_set_max_speed() used to (unintentionally) mask the pause bits
and it seems that the fec driver used this bug as a feature.

>>
>> I have patched by adding:
>> phy_remove_link_mode(phy_dev, ETHTOOL_LINK_MODE_Asym_Pause_BIT);

Instead of programmatically removing the feature bit it should be
possible to do this in the PHY driver configuration. See also
this part of phy_probe().

	if (phydrv->features & (SUPPORTED_Pause | SUPPORTED_Asym_Pause)) {
		phydev->supported &= ~(SUPPORTED_Pause | SUPPORTED_Asym_Pause);
		phydev->supported |= phydrv->features &
				     (SUPPORTED_Pause | SUPPORTED_Asym_Pause);
	} else {
		phydev->supported |= SUPPORTED_Pause | SUPPORTED_Asym_Pause;
	}

>> and got:
>> [    7.310559] fec_enet_mii_probe 62ff after phy_set_max_speed
>> [    7.316221] fec_enet_mii_probe 22ef after phy_remove_link_mode
>> [    7.322128] fec_enet_mii_probe 22ef after pause
>> [    7.326681] Micrel KSZ9021 Gigabit PHY 2188000.ethernet-1:06: attached PHY driver [Micrel KSZ9021 Gigabit PHY] (mii_bus:phy_addr=2188000.ethernet-1:06, irq=POLL)
>> [    7.611276] Waiting up to 3 more seconds for network.
>> [    7.881278] Waiting up to 2 more seconds for network.
>> [    8.131277] Waiting up to 2 more seconds for network.
>> [    8.401169] Waiting up to 2 more seconds for network.
>> [    8.671269] Waiting up to 2 more seconds for network.
>> [    8.941274] Waiting up to 1 more seconds for network.
>> [    9.211181] Waiting up to 1 more seconds for network.
>> [    9.481274] Waiting up to 1 more seconds for network.
>> [    9.751275] Waiting up to 1 more seconds for network.
>> [   10.021281] Waiting up to 0 more seconds for network.
>> [   10.291274] Waiting up to 0 more seconds for network.
>> [   10.381282] Sending DHCP requests .
>> [   10.473000] fec 2188000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx
>> [   12.861267] ., OK
>> [   12.903405] IP-Config: Got DHCP answer from 192.168.66.1, my address is 192.168.66.58
>>
>> So at least I got a link, but the link is still late to got
> 
> The delay is likely something entirely different, it could be some of
> Heiner's recent changes to PHYLIB, Heiner do you have access to a system
> that polls the PHY?
> 
I don't think there's anything wrong with phylib. Time difference
between the fec_enet_mii_probe messages and the "link up" message
is little bit more than 3s in both cases.
For a reason not visible here the fec_enet_mii_probe messages
come 2s later in the second case.
What happens after the "link up" message is out of control of phylib.
