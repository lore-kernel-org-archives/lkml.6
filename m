Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA8EC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 03:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF4AD20869
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 03:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t94qJQtV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfBADuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 22:50:50 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36785 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbfBADuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 22:50:50 -0500
Received: by mail-pl1-f195.google.com with SMTP id g9so2508805plo.3;
        Thu, 31 Jan 2019 19:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Rxc6XIuLgKipN/MDw7z2TriwSKDKs0MP6yMMcpijx3s=;
        b=t94qJQtVJ/xk4WXM6xdrEz6kuNA0cp6VkRd+MBXBpXMGdDYRZmPYr6cmkLIe0nrXeT
         Xx3WZW3twLYqD8of8oWoKFmDX+emNlxWe887N7m+c26FtR163n5suViYzZVrEoNFSQue
         ooddMVdT4M6qjQiWhH+el5yHgy8TG+RWwbbAWSS02vqeCCjeUiX2CX9VTcezADFau9f6
         uGR07pF0XYmQFya3mx+a8PJPfcam7+sBIP+hPXAlGz5VsKemW8dnguFtwHk/yRRnWEf6
         U1ojziAk9KF3+4Xr1CcwFCpw4KPdPVuO/mrPmlI08KMJ4kBXodEL6PDFKdCF0Zm4UpZr
         73Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rxc6XIuLgKipN/MDw7z2TriwSKDKs0MP6yMMcpijx3s=;
        b=h0qxjSMNEnXekpGy2XBNXlsTK5srRUrH/cp+lANMzjAd62KFEoaZq/CzyDtKB7prRR
         FDKjpkYdYAaRj7DVFhQ6qsBFc3apflDeKsEv2BXl4bILob7ZiFMuS7XH3pfhGy2yMs4S
         PSjr4SspXdTm1YssWwDHI5A4y7LujedufCPUY1pp2iRro+1d2K+tnwYwzIk1h4Sph+Q8
         uGx0OhXdyttE8Ut+xMC9gRAb0dOU4VBD/9op5/zCGJ3WS1SO2TRXB7zdCpODA+IDhLUH
         TgukCfg5GNNPjnOLd18ZhUMc3SidK8arIM6RvK0zxzgKj50uU9ffZ3yw3NRhKpuU/7ev
         rfng==
X-Gm-Message-State: AJcUukeC1PnODl1fUPnBkd/LspI0bmbCWRD3K6T97zFPp+D0jNSsfVn5
        Y39X83vjVG8l9E9IHyqV7wk=
X-Google-Smtp-Source: ALg8bN6eXEYbx7cir6Q5O6sN+v3TMwGA66sMwIubbT9UTM2pROWTQUI4pb9Cyw3vRXsjrsl+DYannA==
X-Received: by 2002:a17:902:5a5:: with SMTP id f34mr37804917plf.161.1548993048501;
        Thu, 31 Jan 2019 19:50:48 -0800 (PST)
Received: from [10.0.2.15] (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id f62sm7594390pgc.67.2019.01.31.19.50.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 19:50:47 -0800 (PST)
Subject: Re: [PATCH net-next 06/10] net: introduce a net_device_ops macsec
 helper
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     davem@davemloft.net, sd@queasysnail.net, andrew@lunn.ch,
        hkallweit1@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, quentin.schulz@bootlin.com,
        allan.nielsen@microchip.com
References: <20190123155638.13852-1-antoine.tenart@bootlin.com>
 <20190123155638.13852-7-antoine.tenart@bootlin.com>
 <6ebf0541-0830-3df9-121f-ac560822bf1c@gmail.com>
 <20190124092349.GE3662@kwain>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <7e0ae386-c4fc-f4da-1ff9-06fe855b07c3@gmail.com>
Date:   Thu, 31 Jan 2019 19:50:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190124092349.GE3662@kwain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/24/19 1:23 AM, Antoine Tenart wrote:
> Hi Florian,
> 
> On Wed, Jan 23, 2019 at 12:16:08PM -0800, Florian Fainelli wrote:
>> On 1/23/19 7:56 AM, Antoine Tenart wrote:
>>> This patch introduces a net_device_ops MACsec helper to allow net device
>>> drivers to implement a MACsec offloading solution.
>>>
>>> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
>>> ---
>>>  include/linux/netdevice.h | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>>
>>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>>> index e675ef97a426..ee2f40dca515 100644
>>> --- a/include/linux/netdevice.h
>>> +++ b/include/linux/netdevice.h
>>> @@ -53,6 +53,10 @@
>>>  #include <uapi/linux/pkt_cls.h>
>>>  #include <linux/hashtable.h>
>>>  
>>> +#ifdef CONFIG_MACSEC
>>> +#include <net/macsec.h>
>>> +#endif
>>
>> You can provide a forward declaration for struct netdev_macsec and not
>> have to include that header file.
> 
> OK.
> 
>>> +
>>>  struct netpoll_info;
>>>  struct device;
>>>  struct phy_device;
>>> @@ -1441,6 +1445,10 @@ struct net_device_ops {
>>>  						u32 flags);
>>>  	int			(*ndo_xsk_async_xmit)(struct net_device *dev,
>>>  						      u32 queue_id);
>>> +#ifdef CONFIG_MACSEC
>>> +	int			(*ndo_macsec)(struct net_device *dev,
>>> +					      struct netdev_macsec *macsec);
>>
>> You would really want to define an API which is more oriented towards
>> configuring/deconfiguring a MACsec association here, e.g.: similar to
>> what the IPsec offload ndos offer.
> 
> This means mostly moving from a single function using a command field to
> multiple specialized functions to add/remove each element of MACsec
> configuration.
> 
> I don't have strong opinion on the single helper vs a structure
> containing pointers to specialized ones, but out of curiosity what's the
> benefit of such a move? Future additions and maintainability?

Having multiple operations typically allows for better granularity when
you have HW that may not be capable of offloading an entire protocol
that way you can easily implement fallbacks within the core of that
protocol handling in Linux.

Maybe if you just rename this netdev_macsec_context that will make it
clearer what this does.

> 
>> It is not clear to me whether after your patch series we still need to
>> create a macsec virtual device, and that gets offloaded onto its real
>> device/PHY device, or if we don't need that all?
> 
> After this series, we will still need the virtual MACsec interface. When
> using hardware offloading this interface isn't doing much, but it's the
> interface used to configure all the MACsec connexions.

By not doing much, you mean its data path is basically unused? That
would be quite a deviation from any other type of offload that Linux has
AFAICT, for instance on VLAN devices you still have some amount of data
on the VLAN net_device, etc.

> 
> This is because, and that's specific to MACsec (vs IPsec), a software
> implementation is already supported and it's using a virtual interface
> to perform all the MACsec related operations (vs hooks in the Rx/Tx
> paths). I really wanted to avoid having two interfaces and ways of
> configuring MACsec depending on if the offloading is used.

The virtual network device makes sense when there is some special
treatment (encap/decap, encryption/decryption) that must happen before
sending a frame/PDU onto the wire. It's the same thing here AFAICT, but
since the HW supports doing it in the PHY directly, it's a tough one.

> 
> This should also allow in the future to disable at run-time the
> offloading on a given interface, and to still have MACsec working in
> software (or the opposite, with extra work). For this to work, the
> virtual interface still has to provide an Rx and a Tx functions so that
> programs can bind onto the same interface, regardless of if the
> offloading is enabled.

It would really be good to hear from Sabrina since she authored support
for MACsec to begin with.
-- 
Florian
