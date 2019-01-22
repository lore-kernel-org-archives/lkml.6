Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892B0C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D87621721
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EVNV3Kf4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbfAVOP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:15:26 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35526 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728509AbfAVOPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:15:25 -0500
Received: by mail-lj1-f196.google.com with SMTP id x85-v6so20784993ljb.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 06:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Op3moRbjYhsjbDcDIGxabNze9TBnhI+Sx/SlKViaMAk=;
        b=EVNV3Kf4LxpYivUE3cLu0RzRwLUvS+lyWRL+YtfhvBPXd8FPGwV2Di39Hon+B5sdQ4
         GvCobKfVI1lS0+IJDRZhFRntsDFBhv2aTSTSo9kZPq3x8IErD+gADgdufsIuihy+5j60
         5i/YIAuiOduLyFmK3UssUqtajxgHjl3ihTkk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Op3moRbjYhsjbDcDIGxabNze9TBnhI+Sx/SlKViaMAk=;
        b=b35e/YEUjoLXSzqaF1DSzQ6knMoJ/JDhkY6dOkEP2cKjEt65oQG3LPNpDGOqXDfzx7
         GJrW3TWxU16fjh3IzAPtl4sP3sxEwGW9hvORkdQCDFdGWSbyEKZbXJ3fzhGZ7M3tMbCQ
         lzo7qQeGYSrwBGgyOlnlmc8dQ4q+bn0WTABrJCxJIWrt/KjxDiaCuhHJWs8RJFD21dr0
         YhqZ6TnwkxcSYPCsqRcAcwHYTlgZrmBsN6K2L7mxpBM//vb4xPnbx+kiwS21or2keKZn
         hsXmIe5QMCw2CjC356Dz9WaU1VHf18sjKWYvBr4tGjJxGiOSdvO+faxA28wW53WDQF8I
         cxow==
X-Gm-Message-State: AJcUukf9rn2Yu8/8UJbpT20qEaDRLe0T8RmMuM1yO+P10dLdZVih7aWL
        pD+77zpmQZBQ6LuFuqvyuhVQag==
X-Google-Smtp-Source: ALg8bN4Ds7GdM9NpyQsc1ckCCSz9K3Ax3CyV/eU4+5osYpD67iSSAC6SEBQHH1vCwYsQL1eh93o11w==
X-Received: by 2002:a2e:302:: with SMTP id 2-v6mr19683577ljd.137.1548166523570;
        Tue, 22 Jan 2019 06:15:23 -0800 (PST)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id 185-v6sm24895ljj.49.2019.01.22.06.15.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 06:15:22 -0800 (PST)
Date:   Tue, 22 Jan 2019 16:15:20 +0200
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     davem@davemloft.net, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiri@mellanox.com, andrew@lunn.ch, idosch@mellanox.com
Subject: Re: [RFC PATCH net-next 2/5] net: 8021q: vlan_dev: add vid tag for
 uc and mc address lists
Message-ID: <20190122141519.GA3009@khorivan>
Mail-Followup-To: Florian Fainelli <f.fainelli@gmail.com>,
        davem@davemloft.net, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiri@mellanox.com, andrew@lunn.ch, idosch@mellanox.com
References: <20181203184023.3430-1-ivan.khoronzhuk@linaro.org>
 <20181203184023.3430-3-ivan.khoronzhuk@linaro.org>
 <b2a7baa7-b334-0f6f-c119-a2f30ac68c7b@gmail.com>
 <20181203235119.GF23230@khorivan>
 <35479973-2d2d-d673-f7ab-54d6369ce3d1@gmail.com>
 <20181204185720.GI23230@khorivan>
 <756cbb25-3062-91e8-0613-66bb887f937e@gmail.com>
 <20181205000450.GB3507@khorivan>
 <1dd05b34-e275-d67c-df30-e3694d90e9cc@gmail.com>
 <2d27812c-333f-7dd6-eb31-6fdc15300ae0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d27812c-333f-7dd6-eb31-6fdc15300ae0@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 10:21:25AM -0800, Florian Fainelli wrote:
>On 1/7/19 9:01 PM, Florian Fainelli wrote:
>> Le 12/4/18 à 4:04 PM, Ivan Khoronzhuk a écrit :
>>> On Tue, Dec 04, 2018 at 11:49:27AM -0800, Florian Fainelli wrote:
>>>
>>> ...
>>>
>>>>>
>>>>> I was thinking also about pinned list of vlans to the address, but in
>>>>> this case this information also has to be synced by members of device
>>>>> chain,
>>>>> because it can be modified on any device level and it looks not very
>>>>> friendly,
>>>>> and at the end address space has addresses with pinned lists of vlans
>>>>> with
>>>>> their pointers. But keeping this stuff in sync is not simplest decision.
>>>>>
>>>>>
>>>>
>>>> I really think we are not communicating properly, it really seems to me
>>>> that if you had the information about the upper device trying to add an
>>>> address to the lower device filter's either through notification or call
>>>> to ndo_set_rxmode, you could be solving your problems. What are we
>>>> missing here?
>>>
>>> Sry, missed this one. The problem in getting  the owner of address.
>>> Just simple case: vlan/macvlan/real_dev or vlan/.../.../real_dev
>>>
>>> The real dev hasn't simple way to get vid the address belong to, or it has?
>>
>> Humm looks like your right, by the time the address lists are
>> synchronized (e.g: from = vlan_dev, to = real_dev), we lost that
>> information. It looks like I just managed to find such an use case
>> myself with VLAN filtering enabled on a bridge (so switch is VLAN aware)
>> and a VLAN device created on the bridge (br0.42) but with IGMP snooping
>> turned off (so we don't get HOST_MDB notifications with correct VLAN ID).
>>
>> Maybe keeping the "from" net_device within the address list that is
>> processed by ndo_set_rx_mode() will do the job though?
>>
>> Then you can do things like:
>>
>> if (is_vlan_dev(ha->dev) && ha->dev != dev)
>> 	vid = vlan_dev_vlan_id(ha->dev);
>>
>> and it should scale to any type of stacked device, regardless of VID or
>> something else that we need?
>>
>> Can you remind me of your use case again? Is it because your switch has
>> VLAN filtering enabled and you need to make sure that MC addresses on
>> VLAN device get programmed into the switch's multicast database with
>> correct VID?
>
>Ivan, can you see if the following would work for you:
>
>https://github.com/ffainelli/linux/commit/19e173ebdcdd32f5f5b5ef29049e35d33ad058f2
>
>this should be more scalable approach in that we can support HOST_MDB
>notifications from the bridge, the same way we would get notified about
>IGMP snooping from the bridge and this does not impact any other driver
>than those that elect to receive switchdev object notifications, which
>cpsw should really implement by now...

Sorry missed 2 last comments and seems like it's clear now.
I need to be in TO or CC list my filters can parse it, probably I need
to create more smart filters.

>-- 
>Florian

-- 
Regards,
Ivan Khoronzhuk
