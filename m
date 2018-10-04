Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524C6C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0990420854
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0990420854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbeJEEfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 00:35:25 -0400
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:36352 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725997AbeJEEfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 00:35:25 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud8.xs4all.net with ESMTPA
        id 8BLigGwMl0ZZE8BLmgm5pi; Thu, 04 Oct 2018 23:40:07 +0200
Subject: Re: [PATCH 1/2] media: add SECO cec driver
To:     ektor5 <ek5.chimenti@gmail.com>
Cc:     jacopo mondi <jacopo@jmondi.org>, luca.pisani@udoo.org,
        jose.abreu@synopsys.com, sean@mess.org,
        sakari.ailus@linux.intel.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Todor Tomov <todor.tomov@linaro.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
References: <cover.1538474121.git.ek5.chimenti@gmail.com>
 <c212cb1142a412f980176b9c86fa7f6c96092cb1.1538474121.git.ek5.chimenti@gmail.com>
 <20181003093532.GF20786@w540>
 <c2bfdb30-e8ed-7a4e-422d-ca852db988e9@xs4all.nl>
 <20181004213150.rdqhwpmtza3ez57p@Ettosoft-T55>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <bc3fae06-80fb-06a2-339d-cd8c23a30906@xs4all.nl>
Date:   Thu, 4 Oct 2018 23:39:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181004213150.rdqhwpmtza3ez57p@Ettosoft-T55>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfIUoiX88yabwY9Cg7RLzy7jM2UjA8NJ2sgNWy2ewYWCSBDiMZ3bjFN131L5I1aFIWdyWnKy5kt4RP8vJR+dODFQoFsPCqDNZWPBL+84FvNj//mKwDYya
 6QkWLCLvM9IypBRCOg/V5Fc3DT1CiE/7ncjLqQaVwZbFH9EzxSQlLVs0DFE3OQhArZerfrCdc6je1vpQqoNE0jZ6VgrTjiwVTAMvqZWogXVjHwZ10PDKJkr2
 XnfRgkZ1iZe7D6JpdtXtoSAF5PF4YYqpbz8PceiYkzm/5CX8NOB4W9vC6+bPV6dUCUE/fDjvpEe0NQOmbyF62ljoEKD4Xd6AvJRBEd/L4UbM10Y1J9oDhwON
 RtVEGW8udU4xJzIJrFgKM6acUjeeKuUZB672ZUFBW4ALHhcmSOj+78MzvvRdboaiAAzovaAXvgIdFI6jYBfI9SPNzrdpACLkD/xVJd8aNGWVY11g77V791v/
 2hCAsrV2Bst4F6HvSILGoFQTc1evYD4rYskcJXtSQfsd1xsPCPThiMKXBJH07Np8wjCD12Xo/IA+8fgKM7ce4+Qxm0qdL0aVtM4W0uRCkU/DGqyWnygwRxiR
 eEHVg0N+aVZwsHgbdkkAvKP41hyGMQtAy6LHMmn4ybCzimsVtLANpkqM1/xZoAVou4zJN7BvHvtKGZhNyH4PYL839x5gJODj9BcvyOadWHZTlEWsqfI5jfv9
 l/3UG0yblkojMbCxIj5RvMbffDrvmzCSamzZO/CBeqqLvcH4kWeywD522OnxPdiU3sqnjtmsDFcJUDZ+mO5o1AofBv+ZAnW42hZkmr67D7H9aTYLspRMbu2P
 NCusVEY0IZ6G6zBVZaw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/2018 11:31 PM, ektor5 wrote:
> Hi Hans,
> 
>>>> +static int secocec_cec_get_notifier(struct cec_notifier **notify)
>>
>> If you compare this driver with cros-ec-cec.c, then you'll see that
>> there this function is under "#if IS_ENABLED(CONFIG_PCI) && IS_ENABLED(CONFIG_DMI)".
>>
>> I think you should do the same and (just like cros-ec-cec.c) add a dummy function
>> in the #else part.
> 
> I'm not sure about this. Doing so, compiling without CONFIG_PCI or
> CONFIG_DMI, it will fail later when no notifier is found (now it will
> probably fail at compile time). Should I select them in the Kconfig or
> it is better to eventually disable the notifier and go on adding
> CEC_CAP_PHYS_ADDR to device capabilities?

After thinking about this some more, you can just add:

depends on PCI && DMI

in the Kconfig.

Much easier, really.

Regards,

	Hans
