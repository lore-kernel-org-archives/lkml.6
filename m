Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747BBC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 364BC20827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="du9Ccq8Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 364BC20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbeKJGFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 01:05:12 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38802 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725752AbeKJGFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 01:05:11 -0500
Received: by mail-wr1-f65.google.com with SMTP id e3-v6so3177000wrs.5;
        Fri, 09 Nov 2018 12:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Tzw7XxNzOvzzI83AkRjhtf6psNIz8Jv5U1UJ9mHemmY=;
        b=du9Ccq8YF4uG8pWIawb6BPoL4aILQ5KARL5P2Qr/iQZWmC3RL19Va9jPtpIpL1YeMa
         JAzHReqHIwzneOZzN7C87rS2UIDxacGNVVzJ+QpghQiSjeWwqXiDLeTfzDiIub2RCd/j
         trK9wJVPTWZJSZ6kLpdw7X93H2ReL3k5NpFpQlxIGkmVyUTGfWBJJk9/uWqjEOFIXNb7
         /etcL30EojRN8fW8aPOBdo4XpzwC8CNZK46PQ/ZIm1E/aAgNNGAeuhLzSG7gqhEVYSGT
         Kpb9g+lEM3zF6BaAl2ZydqX/CfWpQ8hIiNSZ7n8qyvTKuJSZj2ZLC871caszU1W+mn41
         rEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tzw7XxNzOvzzI83AkRjhtf6psNIz8Jv5U1UJ9mHemmY=;
        b=ACKQK0WgkFdfxVpbahbDvPAUTQHa2Qg3Va6ZWE1wAf56Y9T+DE/zSbO1D2jjnFvdv5
         m6N0XCQjxSP1QUzv23QWCCJb58nAwsFewwnV3W8v4ur3K0uRcHkw5y6AmDNQ2clIty6Q
         SbBywuan/f33HT2s+pfMxhSq0VYIUgYcRfhdllAWWxF6GFzwT4h//qDzZZW1Tzd2XRXr
         3zC09gs9UxasPACleBCeUKaMaMR1Yjr+bcOPZsjFnlR5zFHYslZE9VkpjyLpP8MaGohy
         Awuhk5YYqf1XZvN94MeqOthWcssgGPDYDtwAHxYFoWYCzpu1U9ILc4+OxdH+qEkC0LgJ
         fJLg==
X-Gm-Message-State: AGRZ1gKCLXG4r9HvfTdbFuNrLajv5ZK030cTL1aw7ZNt0wVNdbN7p2B3
        2fAAOgBMhdntkhsvL4iwJpU=
X-Google-Smtp-Source: AJdET5d3h0I/hGOfd1ItZ11vDiduBKee77LqanJUmZ/JbCtnxVJIneX+NiQUWlul2C4hvsgjLpivFQ==
X-Received: by 2002:a05:6000:1202:: with SMTP id e2mr8789561wrx.315.1541794980247;
        Fri, 09 Nov 2018 12:23:00 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:28f6:f26:503:ad45? (p200300EA8BCFE30028F60F260503AD45.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:28f6:f26:503:ad45])
        by smtp.googlemail.com with ESMTPSA id w18-v6sm17645428wrn.66.2018.11.09.12.22.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 12:22:59 -0800 (PST)
Subject: Re: [PATCH net-next v3 1/2] net: phy: replace PHY_HAS_INTERRUPT with
 a check for config_intr and ack_interrupt
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        David Miller <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "maintainer:BROADCOM BCM63XX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM63XX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson SoC support" 
        <linux-amlogic@lists.infradead.org>
References: <203c4d9e-f39a-7a08-46c3-4ee6e61f181e@gmail.com>
 <fd9674b3-4033-95c6-a93e-10c8b5ba2e6a@gmail.com>
 <20181109201307.GV5259@lunn.ch>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <44b503b8-9f2a-50ac-c4c9-d25258d98ef5@gmail.com>
Date:   Fri, 9 Nov 2018 21:22:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181109201307.GV5259@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.11.2018 21:13, Andrew Lunn wrote:
> Hi Heiner
> 
>> +static bool phy_drv_supports_irq(struct phy_driver *phydrv)
>> +{
>> +	return phydrv->config_intr || phydrv->ack_interrupt;
>> +}
> 
> Should this be && not || ? I thought both needed to be provided for
> interrupts to work. 
> 
> 	   Andrew
> 
I've seen at least one driver which configures interrupts in
config_init and doesn't define a config_intr callback
(ack_interrupt callback is there)
Intention of this check is not to ensure that the driver defines
everything to make interrupts work. All it states:
If at least one of the irq-related callbacks is defined, then
we interpret this as indicator that the PHY supports interrupts.

Heiner
