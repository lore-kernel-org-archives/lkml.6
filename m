Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CF5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DDEE2184A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRwkmpTX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbfB0Spz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 13:45:55 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39571 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbfB0Spz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 13:45:55 -0500
Received: by mail-wm1-f65.google.com with SMTP id z84so6571841wmg.4;
        Wed, 27 Feb 2019 10:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AvE0YZ8/C3LZ5MC8ecgEQSaPWlcQ5omXmqao7RCo9Kc=;
        b=JRwkmpTXvwvPexM/0tix/I/jeZ9VfNRUS6P6Tnj8U1ZzH5/9FN9BTuhCwkBN9AHg/B
         kHr/z2I97pSPt2LcX5En2W8d7uCt0QWUFakvbeqMehcJ6G5Y0uadndwKtI7CskCkYlI8
         FCl15qOYk4NkdrlT69zwabTvPBLF04CkWTrBs2bsAvhU4euoPpIe3mecGDOx/3S3gU3P
         +XK5W7fj0xqWK+qamEZfVXQfSus+tTzCWE2hWrR3jBWibdCUc87mqClZPalYB8/wOrs1
         TDwYeteuSV109RVgld0UiyVW9FZOrBDB+b/AFpwIMBsbSyWA6qsPWdD6BEaBHiAV1Pqj
         0Olw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=AvE0YZ8/C3LZ5MC8ecgEQSaPWlcQ5omXmqao7RCo9Kc=;
        b=VLcMhxsiioWcIjcszArMm6v8dWNcAP4mE22D0hdq14AbP12V/4UifdBcx8XGwvoIHq
         SWVEhJIYpOLXN7W+zrUhv04/EtjPiYv2Lju2HP4ZBDapgXEkipEeKW4ryTaKfelc5gqC
         qeYa5RllwK/9TFHBqyMrtthCwzqLSkdLx2mRARXjf4q5fBMTgFJqQDY8YA4JxjRHOQwF
         WlDXamktVQ4vjhrlTz37pURU/d+UujlaPC1vkNAkfa2iDB+LXmPEnM8olcPbwACuMdSG
         6kVWk6t592cZVDjxtP+nTSh+tB+NbBQokQvaPaNaXNU/jfy184BD3k5YIYbeXJ5S2T9n
         C9zg==
X-Gm-Message-State: APjAAAU/0m8M1kEZ+zeJSI+F4GGbwywWz3lVJsy5do94LsFYvEMMt8SV
        PjZ/eIweqkgXChzOEFqWuk8=
X-Google-Smtp-Source: AHgI3Ib6RjP41xco5I4kC3Jyyb7ISCDUkvRjraoQbu4Hn9rXYFtHnUxMk++Ixo1CnGXcJHcxkpaf3Q==
X-Received: by 2002:a1c:4009:: with SMTP id n9mr422834wma.132.1551293151692;
        Wed, 27 Feb 2019 10:45:51 -0800 (PST)
Received: from [10.67.50.0] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id r63sm4352524wmr.32.2019.02.27.10.45.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 10:45:50 -0800 (PST)
Subject: Re: Request for suggestion on net device re-naming/re-ordering based
 on DT alias
To:     Stephen Hemminger <stephen@networkplumber.org>,
        Harini Katakam <harinik@xilinx.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        David Miller <davem@davemloft.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Harini Katakam <harini.katakam@xilinx.com>,
        Harini Katakam <harinikatakamlinux@gmail.com>
References: <CAFcVEC+8P25MKWhizUUEuamikaZYUOjpppV=59=W3POTEfQqXw@mail.gmail.com>
 <20190227104028.707a75e2@shemminger-XPS-13-9360>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <9a07d721-7ea8-03a0-d10b-5fdf2bfd9217@gmail.com>
Date:   Wed, 27 Feb 2019 10:45:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190227104028.707a75e2@shemminger-XPS-13-9360>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/19 10:40 AM, Stephen Hemminger wrote:
> On Wed, 27 Feb 2019 17:24:03 +0530
> Harini Katakam <harinik@xilinx.com> wrote:
> 
>> Hi,
>>
>> We've had some users requesting control over net device name order
>> when multiple ethernet devices are present on a system. I've tried a
>> few solutions to this and looked it up on forums. But I apologize if
>> I have missed something.
>>
>> I know that the current system allocates eth<n> as per probe order
>> but that is obviously not stably controlled by user (tried DT
>> re-ordering and defer probe). One solution is to use DT alias names
>> to write to (net_device)->name as follows:
>> Devicetree:
>> aliases {
>>    ethernet0 = &mac1;
>>    ethernet1 = &mac0;
>> };
>> Driver probe:
>> +       /* Read ethernet DT alias id and assign to right device name*/
>> +       id = of_alias_get_id(np, "ethernet");
>> +       if (id < 0) {
>> +               dev_warn(&pdev->dev, "failed to get alias id (%u)\n", id);
>> +               return id;
>> +       }
>> +       snprintf(dev->name, sizeof(dev->name), "eth%d", id);
>> +
>>
>> These three drivers seem to have something similar for mdio/phy bus IDs:
>> drivers/net/ethernet/broadcom/genet/bcmmii.c:409: id =
>> of_alias_get_id(dn, "eth");
>> drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c:43: plat->bus_id =
>> of_alias_get_id(np, "ethernet");
>> drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c:404:
>> plat->bus_id = of_alias_get_id(np, "ethernet");
>>
>> Drawback: This approach will break if alias is not provided for one
>> of the interfaces on board. Not to mention, there could be systems
>> with multiple ethernet makes (for ex. Cadence macb and Xilinx axienet)
>> If one of the drivers does not have an alias read mechanism, it is
>> possible to have clashing ID assignments. Is there any way this
>> solution can be changed to be stable/acceptable?
>>
>> One other alternative I've tried is netdev kernel bootargs but this
>> device name was not being picked by the kernel:
>> https://www.kernel.org/doc/html/v4.19/admin-guide/kernel-parameters.html
>> netdev= <mac1’s interrupt id>, <mac1’s base address>, eth0
>> netdev=<mac0’s interrupt id>, <mac0’s base address>, eth1
>>
>> Could you please suggest any alternatives?
>> Thanks!
>>
>> Regards,
>> Harini
> 
> Device naming is a hard problem, and there is no perfect solution.
> 
> Device tree should be providing hints to userspace policy for naming, not
> trying to do it in the kernel. 

And Device Tree does already, if you look at the uevent attributes that
the kernel sends, there should be ample information to uniquely
determine which physical network device the network device maps to, e
for instance:

cat /sys/class/net/eth*/device/uevent
DRIVER=brcm-systemport
OF_NAME=ethernet
OF_FULLNAME=/rdb/ethernet@9300000
OF_TYPE=network
OF_COMPATIBLE_0=brcm,systemportlite-v1.00
OF_COMPATIBLE_1=brcm,systemport
OF_COMPATIBLE_N=2
OF_ALIAS_0=eth0
MODALIAS=of:NethernetTnetworkCbrcm,systemportlite-v1.00Cbrcm,systemport
-- 
Florian
