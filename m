Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F00C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E39206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRM4BTVd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21E39206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbeLCWZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 17:25:52 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32910 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbeLCWZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 17:25:48 -0500
Received: by mail-pg1-f193.google.com with SMTP id z11so6382134pgu.0;
        Mon, 03 Dec 2018 14:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rIL7cRHE1sj8KS5yamF6GytIwUJNcT0vzZS80yaWvpk=;
        b=mRM4BTVdNB6cguQ1zSwUOmyg7ygQ8+O6IIpDVSvOXgCSSqKkBl9NJkiRJTrwmMTiCp
         b1wH3/mYlRrixchVGbR+JGzvLRhavo7a6zf5nuT4cIrcyhxRGjssSfn7QoJVphPI23/U
         AxpTrRLzZoHUi0awwPabiw0sSDgAR3JfKBKLSmzMF2PUW+98q67YB+RztXxD06IzLCY3
         QHKieFOaKi6fP+T4+FTVk03tyeOQ7Jey+9ZzQ3UjCvaHkVRdq/cW1FDPWGRX9JQSAIqm
         yCP+xZWlwC0ekr3GOOcSkr+oCmqJDk19q5kygK4QhDWg+r1uSGw/opUqXu47jCy/M6Ak
         t7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=rIL7cRHE1sj8KS5yamF6GytIwUJNcT0vzZS80yaWvpk=;
        b=ttDGvTMzIqxE05twc9g0o0pIVz7Ss445FSAoPS4Cg56G2MGYhVzoGXP7de54SUrE4f
         5r9p0lRLc0kl4a1PaEBETp7PdQ6D3J0ysQh/dV16AN2dbeQ85ap2PP257ismWuMbp3u3
         sv7V3RLxE9p4Ys4wHBHbkobm8fafU1d3SvXE3TVsqia+Pp2E9e58hbj4AaL0jdPDGI+w
         DkaYXgdaWeLqEJniE1bPbmttBX7uWrzkCVYYzM92vfllzpmMgtZ7aFQ0+w2GPzjZQG2Q
         NKLyEaKprWnrbUyBps6mSc+c57DOYklyJz+qWtjYH044+/vhlBR6WqBMzJSvEcV805Lj
         YLNA==
X-Gm-Message-State: AA+aEWZT7CJrkEqj905l0rXUlrhONWS7J/nRBPuVEeWIE8ai/U0M3KOU
        PFjhuHrs2I50n0M5qrfa1M0=
X-Google-Smtp-Source: AFSGD/WisXSfiIWmUvOOARfiJ6//hKe97Fhw72eb2EQ9aJwRHfmUKZIfHZWGZkB6qZYiCfjaDJQfhQ==
X-Received: by 2002:a62:6143:: with SMTP id v64mr17642725pfb.142.1543875947607;
        Mon, 03 Dec 2018 14:25:47 -0800 (PST)
Received: from [10.67.49.9] (igp-prod-emp-gw.vpn.broadcom.com. [192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id 78sm19606755pft.184.2018.12.03.14.25.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 14:25:46 -0800 (PST)
Subject: Re: [RFC PATCH net-next 0/5] net: allow hw addresses for virtual
 devices
To:     Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, davem@davemloft.net,
        grygorii.strashko@ti.com
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiri@mellanox.com, andrew@lunn.ch
References: <20181203184023.3430-1-ivan.khoronzhuk@linaro.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <ec39f484-0fec-0721-f944-01e3a552a667@gmail.com>
Date:   Mon, 3 Dec 2018 14:25:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181203184023.3430-1-ivan.khoronzhuk@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/18 10:40 AM, Ivan Khoronzhuk wrote:
> One of the reasons of this proposition is safety and performance -
> host should not receive traffic which is not designated for it.
> 
> Some network devices can hold separate address tables for vlans and
> real device, but for some reason there is no possibility to apply it
> with generic net addressing scheme easily. At this moment the fastest
> solution is to add mcast/ucast entries for every created vlan
> including real device. But it also adds holes in the filtering and
> thus wastes cpus cycles.
> 
> This patchseries tries to correct core to assign mcast and ucast
> addresses only for vlans that really require it and as result an end
> driver can exclusively and simply set its rx filters. As an example
> it's implemented on cpsw TI driver, but generic changes provided by
> this series can be reused by other ethernet drivers having similar
> rx filter address possibilities.
> 
> An address+vid is considered as separate address. The reserved device
> address length is 32 Bytes, for ethernet devices it's additional
> opportunity to pass auxiliary address info, like virtual ID
> identifying a device the address belongs to. This series makes it
> possible at least for ETH_P_8021Q, but can be easily extended for ab.
> Thus end real device can setup separate tables for virtual devices
> just retrieving VID from the address. A device address space can
> maintain addresses and references on them separately for each virtual
> device if it needs so, or only addresses for real device (and all its
> vlans) it holds usually.
> 
> A vlan device can be in any place of device chain upper real device,
> say smth like rdevice/bonding/vlan or even rdevice/macvlan/vlan.
> Similar approach can be used for passing additional information for
> virtual devices as allmulti flag or/and promisc flag and do this per
> vlan, but this is separate story and could be added as a continuation.
> 
> I was biased by try to add exclusive mcast and ucast support for vlans
> and now have same with small generic correction and mostly locally in
> the cpsw driver:
> https://git.linaro.org/people/ivan.khoronzhuk/tsn_kernel.git/log/?h=ucast_vlan_fix
> https://git.linaro.org/people/ivan.khoronzhuk/tsn_kernel.git/log/?h=mcast_vlan
> and can say it looks better with generic changes provided by this patchset,
> that's why this RFC. Above links can be used as fallback.
> 
> This series is verified on TI am572x EVM that can hold separate tables
> for vlans. Potentially it can be easily extended to netcp driver for
> keystone 2 boards (including k2g) and also new am6 chipsets. As a
> simple test case, different combinations of vlan+macvlan, macvlan+vlan
> were used and tested as with unicast as multicast addresses.

I think I get what you want to do, which is make sure that on per VID
basis, only the necessary UC and MC addresses are programmed into the
respective filters, when each of your network ports operate in what cpsw
calls "dual emac"? Which is really something that should be called "NIC"
mode, and/or is analogous to how we bring up ports in DSA: each of them
acts as a separate network device. Speaking of the later, we have some
known issues in unmanaged mode with MC addresses which I am working on
addressing.

It seems to me, as replied in patch 2, that what you are missing is the
source of the address programming request, and therefore either you pass
an additional "source net_device" to functions like dev_{uc,mc}_sync(),
or you pass a well defined structured that can encode the address as
well as the interface type, but the approach you have right now, where
the address storage is extended to include the VID is both extremely
specific to VLAN devices, as well as not scaling particularly well. With
your patches we have VLAN devices covered, but what about MACVLAN, bond,
team or anything that needs to look at specific MAC addresses to be
filtered to make management decisions?

Also imagine being able to store up to 4K MAC addresses for a total of
4K VLANs, this would have occupied 4K * sizeof(some structure) and now
it's 2 bytes bigger...

> 
> Based on net-next/master
> 
> Ivan Khoronzhuk (5):
>   net: core: dev_addr_lists: add VID to device address space
>   net: 8021q: vlan_dev: add vid tag for uc and mc address lists
>   net: 8021q: vlan_dev: add vid tag for vlan device mac address
>   net: ethernet: add default vid len for all ehternet kind devices
>   net: ethernet: ti: cpsw: update mc vlan and add uc vlan support based
>     on addr vids
> 
>  drivers/net/ethernet/ti/cpsw.c |  86 +++++++++++++++++++----
>  include/linux/if_vlan.h        |   1 +
>  include/linux/netdevice.h      |   7 ++
>  net/8021q/vlan.c               |   3 +
>  net/8021q/vlan_core.c          |  10 +++
>  net/8021q/vlan_dev.c           | 103 ++++++++++++++++++++++-----
>  net/core/dev_addr_lists.c      | 124 +++++++++++++++++++++++++++------
>  net/ethernet/eth.c             |  15 +++-
>  8 files changed, 290 insertions(+), 59 deletions(-)
> 


-- 
Florian
