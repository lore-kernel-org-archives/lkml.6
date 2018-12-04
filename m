Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D5FC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B0B220834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/yjiSON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B0B220834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbeLDTth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:49:37 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43158 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbeLDTtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:49:36 -0500
Received: by mail-pf1-f193.google.com with SMTP id w73so8732425pfk.10;
        Tue, 04 Dec 2018 11:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AYukJDlNUAL+GLJBpuiQp0mZcMh2C2I69MgWjZ0KKy0=;
        b=g/yjiSONRqt3y95tf7t6DB8YTXxL4E7v5GEx5mhy2+TaScfqwJm4OFMVmbRcdASNF4
         ziKbwoFECPfrSeGuPOfHjDT5u2hx2jXE1bdzsbChOhCqAQo45wltGFow7sHa6sNmJdzg
         O3zfdztcR77AV9gxh9U7vvsnA21uNJTTraQOef1Rww9ZqmfkUTWqHAtkigVN4H9Mh+ca
         omNKo2mxQdawhGV2Xluu19CioQch/bea9zCA1Fm2HGTtQHr+Pyhim9oAlj9s9bUmDghH
         A1YvklxYLgSZ3pp92PK++obHE7HHyG4dZih8e5VLX7yaKfayErphkgLu7CxFJl48JSnI
         r5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=AYukJDlNUAL+GLJBpuiQp0mZcMh2C2I69MgWjZ0KKy0=;
        b=VT0JWCyahZRKn/s+3Grh/bj/QTVzD6klFy1RJ8/BivcvptHSqgFtczQWFLLVs07HOr
         v2NmNgIcliKGnhzGegg3HA/XC8tvxh4hZbPVMHeie3cPudA/at++5Pk89ZFVaqpMZynr
         ey1hi+GN0HSTjpvS3JVLOLcFJW8I+EuM+sszXKllNP4Y+5swpC/Ykc+eR5oxU9I2lQH/
         rW3VtJrdzeJ9oowIOJUS+rWARMC3rEnw7TQb9cNFQSic9GZZGd7lAmuHRLrmZ4wjLSZV
         4V9U9cnj4valXtgPtLCQEvL6BXN/nlS/2J6JJtnl/jwI2jBaqgC1CjnrzUNXzBOUjbza
         BM1A==
X-Gm-Message-State: AA+aEWZwCnPgUx6lTeiIOYCI6aBuWPVK2YbJ14dCdH9j0m/GQUaiPRDj
        7VJecAfhhAqF+9kOTO0z4Pw=
X-Google-Smtp-Source: AFSGD/WJiYmFSRXkvSd427K7r6ij7o+z2v8A41Sl6cBr+Fv7BINQbTU0ux1ywEMHzvPdCFlFro+urg==
X-Received: by 2002:a63:f710:: with SMTP id x16mr16737798pgh.322.1543952975356;
        Tue, 04 Dec 2018 11:49:35 -0800 (PST)
Received: from [10.67.49.9] (igp-prod-emp-gw.vpn.broadcom.com. [192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id 69sm16862650pgg.86.2018.12.04.11.49.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 11:49:34 -0800 (PST)
Subject: Re: [RFC PATCH net-next 2/5] net: 8021q: vlan_dev: add vid tag for uc
 and mc address lists
To:     davem@davemloft.net, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiri@mellanox.com, andrew@lunn.ch
References: <20181203184023.3430-1-ivan.khoronzhuk@linaro.org>
 <20181203184023.3430-3-ivan.khoronzhuk@linaro.org>
 <b2a7baa7-b334-0f6f-c119-a2f30ac68c7b@gmail.com>
 <20181203235119.GF23230@khorivan>
 <35479973-2d2d-d673-f7ab-54d6369ce3d1@gmail.com>
 <20181204185720.GI23230@khorivan>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <756cbb25-3062-91e8-0613-66bb887f937e@gmail.com>
Date:   Tue, 4 Dec 2018 11:49:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181204185720.GI23230@khorivan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/18 10:57 AM, Ivan Khoronzhuk wrote:
> On Mon, Dec 03, 2018 at 03:57:03PM -0800, Florian Fainelli wrote:
>> On 12/3/18 3:51 PM, Ivan Khoronzhuk wrote:
>>> On Mon, Dec 03, 2018 at 02:17:00PM -0800, Florian Fainelli wrote:
>>>> On 12/3/18 10:40 AM, Ivan Khoronzhuk wrote:
>>>>> Update vlan mc and uc addresses with VID tag while propagating address
>>>>> set to lower devices, do this only if address is not synched. It
>>>>> allows
>>>>> on end driver level to distinguish address belonging to vlans.
>>>>
>>>> Underlying driver for the real device would be able to properly
>>>> identify
>>>> that you are attempting to add an address to a virtual device, which
>>>> happens to be of VLAN kind so I am really not sure this is the right
>>>> approach here.
>>>>
>>>> From there, it seems to me that we have two situations:
>>>>
>>>> - each of your network devices expose VLAN devices directly on top of
>>>> the real device, in which case your driver should support
>>>> ndo_vlan_rx_add_vid and ndo_vlan_rx_kill_vid to know when VLAN devices
>>>> are create and maintain a VLAN device to VID correspondence if it needs
>>>> to when being called while setting the addresses
>>>>
>>>> - you are setting up a bridge that is VLAN aware on one of your bridge
>>>> ports, and there you can use switchdev to learn about such events and
>>>> know about both addresses as well as VIDs that must be programmed into
>>>> your real device
>>> No limits to have any "middle" device between real end device and
>>> virtual one, not only a bridge, but also other kind. And as it's generic
>>> change, it should cover all such cases, the simplest example is:
>>> real_dev/macvlan/vlan.
>>
>> It is not generic if the additional information is a VLAN ID, that
>> construct does not apply to all types of virtual devices, that is part
>> of my issue with the extra VID that is being added. If this was a void *
>> priv and any virtual device could pass up/down information that might be
>> more acceptable.
> 
> You mean to create smth like common struct pinned to "an address" and
> pass information not only like vid, but in parallel what ever user wanted.
> Even if pass vlan device pointer it still considered like an address
> continuation and same sync method is used w/o modification. And here vid
> is considered as part of address, by a big account address+vid it's a
> separate address, same happens with the pointer, address+pointer it's
> still separate address.

That depends on the HW implementation, some switches do individual VLAN
learning (IVL) and some do shared VLAN learning (SVL) so whether the VID
becomes part of the address resolution logic is HW dependent, obviously
the more capable, the better (IVL).

> 
> I was thinking also about pinned list of vlans to the address, but in
> this case this information also has to be synced by members of device
> chain,
> because it can be modified on any device level and it looks not very
> friendly,
> and at the end address space has addresses with pinned lists of vlans with
> their pointers. But keeping this stuff in sync is not simplest decision.
> 
> 

I really think we are not communicating properly, it really seems to me
that if you had the information about the upper device trying to add an
address to the lower device filter's either through notification or call
to ndo_set_rxmode, you could be solving your problems. What are we
missing here?
--
Florian
