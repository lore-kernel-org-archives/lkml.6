Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC805C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E3D20685
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPfUh8dR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbfAHSVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 13:21:38 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37822 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729261AbfAHSVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 13:21:38 -0500
Received: by mail-ed1-f66.google.com with SMTP id h15so5174679edb.4;
        Tue, 08 Jan 2019 10:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZQFNjaAg8KBMNArzEbUH1JlYMYJJusXEq+8ErNmPcKQ=;
        b=iPfUh8dRD+rKtndZqyYPhN2m4d7bXsIGuNydZKEYL4XKKLPmROzgGU7saJrwW4HPbh
         LeQbA3ek+tSrXYPu3oWvR1wkXW7nepCtTEHB2MCiGGkpbm3dxw9G175Ugdqwwsccc+v0
         Gk6sZKQXz9z6KU11aU/clAm7uTLPS9gXrp3Ss6ntGfHfQdvnHY0Kl1JvVbziyVFXlTpk
         Sj/Dl2ed/bap6Nmh+4lZUnWJ/EFNPNSvKF2PgF3ZZ4/b+N72mDNfef8LhJ3WCu+zHXm4
         sxBu7EHkDL3OQ6WEcrQa9+6ZRIbyLRhCqWQLcz0dp47nxb0eQ1tC1FSUgfHhED/DR99v
         oOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ZQFNjaAg8KBMNArzEbUH1JlYMYJJusXEq+8ErNmPcKQ=;
        b=hK7+t9qMgzoU9aIMdKs+WCD7J5jZAO5J5cRCVkE0pNBIFlj3gGrlUa177z572/4uGP
         6eAbpr0KW82uIJ8BxqLD+/NawHbsWCvygddMvOHwCz/sR948ZSnWu63+78+wgVeuUJx8
         G6BkQEQ0/h+xDRVyqPHPaK/L1CcXSpqH2QrfzWVH6KFDZbmz0IUUETkAZzn++J3cAjfw
         Sl7tvdH3b6sqIrCDh9383hc5DNsY3xJLCLHLXgf84HsYSDPgYNrzigq/IVhFVyunWLTr
         /W6tK9AOTfWves5zCtzYck1svGO3/L5P75VAteEK42BPJzpUn4bKnc9J3gwcJCKuk39O
         oHsg==
X-Gm-Message-State: AJcUukdRFt8M57CGFOHVMcx1LbX4zv7Hv90kJa0e1x4odlgDNgGmHzT3
        9HpNqx7scUIFMVuve1UY/oSwQwft
X-Google-Smtp-Source: ALg8bN5m5RXnhj6cdvnaS6CgfsogekBcsapBHIeQhoXk9jm9VbM87O+4kZNQOgRZzmKIKWCr8XN5yw==
X-Received: by 2002:aa7:d817:: with SMTP id v23mr3118105edq.255.1546971694314;
        Tue, 08 Jan 2019 10:21:34 -0800 (PST)
Received: from [10.67.49.9] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id o37sm247281edc.32.2019.01.08.10.21.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 10:21:33 -0800 (PST)
Subject: Re: [RFC PATCH net-next 2/5] net: 8021q: vlan_dev: add vid tag for uc
 and mc address lists
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     davem@davemloft.net, linux-omap@vger.kernel.org,
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
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <2d27812c-333f-7dd6-eb31-6fdc15300ae0@gmail.com>
Date:   Tue, 8 Jan 2019 10:21:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1dd05b34-e275-d67c-df30-e3694d90e9cc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/19 9:01 PM, Florian Fainelli wrote:
> Le 12/4/18 à 4:04 PM, Ivan Khoronzhuk a écrit :
>> On Tue, Dec 04, 2018 at 11:49:27AM -0800, Florian Fainelli wrote:
>>
>> ...
>>
>>>>
>>>> I was thinking also about pinned list of vlans to the address, but in
>>>> this case this information also has to be synced by members of device
>>>> chain,
>>>> because it can be modified on any device level and it looks not very
>>>> friendly,
>>>> and at the end address space has addresses with pinned lists of vlans
>>>> with
>>>> their pointers. But keeping this stuff in sync is not simplest decision.
>>>>
>>>>
>>>
>>> I really think we are not communicating properly, it really seems to me
>>> that if you had the information about the upper device trying to add an
>>> address to the lower device filter's either through notification or call
>>> to ndo_set_rxmode, you could be solving your problems. What are we
>>> missing here?
>>
>> Sry, missed this one. The problem in getting  the owner of address.
>> Just simple case: vlan/macvlan/real_dev or vlan/.../.../real_dev
>>
>> The real dev hasn't simple way to get vid the address belong to, or it has?
> 
> Humm looks like your right, by the time the address lists are
> synchronized (e.g: from = vlan_dev, to = real_dev), we lost that
> information. It looks like I just managed to find such an use case
> myself with VLAN filtering enabled on a bridge (so switch is VLAN aware)
> and a VLAN device created on the bridge (br0.42) but with IGMP snooping
> turned off (so we don't get HOST_MDB notifications with correct VLAN ID).
> 
> Maybe keeping the "from" net_device within the address list that is
> processed by ndo_set_rx_mode() will do the job though?
> 
> Then you can do things like:
> 
> if (is_vlan_dev(ha->dev) && ha->dev != dev)
> 	vid = vlan_dev_vlan_id(ha->dev);
> 
> and it should scale to any type of stacked device, regardless of VID or
> something else that we need?
> 
> Can you remind me of your use case again? Is it because your switch has
> VLAN filtering enabled and you need to make sure that MC addresses on
> VLAN device get programmed into the switch's multicast database with
> correct VID?

Ivan, can you see if the following would work for you:

https://github.com/ffainelli/linux/commit/19e173ebdcdd32f5f5b5ef29049e35d33ad058f2

this should be more scalable approach in that we can support HOST_MDB
notifications from the bridge, the same way we would get notified about
IGMP snooping from the bridge and this does not impact any other driver
than those that elect to receive switchdev object notifications, which
cpsw should really implement by now...
-- 
Florian
