Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BA0C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F13020827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDRZ0HgR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F13020827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbeKJGPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 01:15:49 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45400 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbeKJGPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 01:15:49 -0500
Received: by mail-pl1-f196.google.com with SMTP id r3-v6so688446pls.12;
        Fri, 09 Nov 2018 12:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BwrMNtAA6mO3OzBPLAJAm9CAtyskIPpAB+l5y1I2LXE=;
        b=bDRZ0HgR2CNX4G5JZi6pbzH71yeDs92YEpV9mtd8lOb6ETxaGB3ottpJUKipofZ5ip
         jqkBMgUdS2MSA2fEi7X+qZebXdtws3vehfwTbVkuvnacZPqIcdjVqEtyh2CCxoF3IpbN
         2yWARS1qS5Y7hQnb9Ih4h6l3+3TxlYzjE9VavM3K/Fkj4TKhx1I19d4LaQEeD7T1Zh1m
         VBH1sCKuD5snwAaTywgV0MsM1S+QAqHF/7+meMFB3frIm1Nvh1xzl/YB1o4F2WdF99zR
         MRLQWznsKznKkFSPjf7h6fKbNs0hCh7GMbhjc3pioyurAC7bUxJCw0yvLlPuUoLYMM7I
         4UAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=BwrMNtAA6mO3OzBPLAJAm9CAtyskIPpAB+l5y1I2LXE=;
        b=I4KvaeGn0koWxtlfAA7oMqGi+JyNCyxa01G89SybqdB+S8V6GCsliYn3nF9Kkkn+i5
         VsL0DPpHVXfg5WedSIK7F1bnu/Kl42xfO2DLa/RV4KULG62Q9o+DoI4IolXyJDB+lfIr
         6iDJUm6iu7N8CT7u9ljh3wR+gPed6yX4hJAh6fZU/JU9rjU2J1frnKahT2PGQs4FFZ4e
         fcy2tuh94zSKgGuTynJVTCZegau4SnSh302TPII8Pnzr/AUIUgfKslQMCK1Fe1KzKkR3
         GGYvtwc/pb0cbJGVdfzRf1A0s2aa5ga3M8+78j3qZdSWJehLVKYEUPQb7EVTOnipotK+
         20dA==
X-Gm-Message-State: AGRZ1gLeWVa2LiokhVoyuCYh/LNb1WqzuAZB0kOI5ekEfaN5I2UlZ9D3
        MMIgyNxdxSKTO8dBBNHXRpw=
X-Google-Smtp-Source: AJdET5fvNMT/dC8pfs3fq7MEax57mw2ONM7nhrj8BzYBPA7Tk69GYdnGaxicovtzrNHt0UjSw7eknA==
X-Received: by 2002:a17:902:6e17:: with SMTP id u23-v6mr10538629plk.127.1541795616809;
        Fri, 09 Nov 2018 12:33:36 -0800 (PST)
Received: from [10.67.49.62] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id r4sm9079377pgn.54.2018.11.09.12.33.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 12:33:35 -0800 (PST)
Subject: Re: [PATCH net-next v3 1/2] net: phy: replace PHY_HAS_INTERRUPT with
 a check for config_intr and ack_interrupt
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>
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
 <44b503b8-9f2a-50ac-c4c9-d25258d98ef5@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <4330cb5b-b1a5-5004-af51-39199943639d@gmail.com>
Date:   Fri, 9 Nov 2018 12:33:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <44b503b8-9f2a-50ac-c4c9-d25258d98ef5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/18 12:22 PM, Heiner Kallweit wrote:
> On 09.11.2018 21:13, Andrew Lunn wrote:
>> Hi Heiner
>>
>>> +static bool phy_drv_supports_irq(struct phy_driver *phydrv)
>>> +{
>>> +	return phydrv->config_intr || phydrv->ack_interrupt;
>>> +}
>>
>> Should this be && not || ? I thought both needed to be provided for
>> interrupts to work. 
>>
>> 	   Andrew
>>
> I've seen at least one driver which configures interrupts in
> config_init and doesn't define a config_intr callback
> (ack_interrupt callback is there)

That driver should probably be fixed, while it most likely does not make
any significant difference during probe/connect, since config_init() and
config_intr() are virtually happening at the same time, this is not
necessarily true when disconnecting from the PHY where we really want
config_intr() to effectively disable the interrupts and not leaving
something enabled that would now become unmaskable, because no more
driver attached.

> Intention of this check is not to ensure that the driver defines
> everything to make interrupts work. All it states:
> If at least one of the irq-related callbacks is defined, then
> we interpret this as indicator that the PHY supports interrupts.

I agree with Andrew here, that this should be an AND here, both
callbacks must be implemented for interrupts to work correctly.
-- 
Florian
