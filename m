Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19FEC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 18:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9C0218EA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 18:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXaO0Zu5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbeLZSQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 13:16:11 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40967 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbeLZSQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 13:16:10 -0500
Received: by mail-wr1-f66.google.com with SMTP id x10so16266201wrs.8;
        Wed, 26 Dec 2018 10:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O4nzTdeynF2BCZlbeVhH6INHfnlXqVmpSeFhse+cBps=;
        b=HXaO0Zu56IJPBxPMg9qWEkknneZkuNJgHLXDBMt4aimx45OfbtLPTcgjSTju19m+aF
         IXoNg6vs8yrdWfQ9gP9Tc1QI7txZjigSTWGS/CBwvv+N/gR/eoxkJAoaKjGMQDf3Uhe9
         erMz0nPwpf1vIym05G0wQmHzhGg+CCQOwfblwLzjK8p+KdOvHIHbgyp9HrhrjxG42uh2
         29NANbNapSSlJHVQJqYHcjZIxbu3LIo2xaC+Ng/h/9Xyh1NPKUA9BnWf0nPjWmR30h95
         i3UDyt59pgvdPzVPdnY/yP+19LYuSqbPl2Gw0FZEoSytABQR17xcgsPgCq0ZGCkgiCJC
         q0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O4nzTdeynF2BCZlbeVhH6INHfnlXqVmpSeFhse+cBps=;
        b=gQdd/VFIx/9RYRQxyQpW/NaPO1Rv+4pYWBj9sfBoLjuQ9sjNR/npu+2Xeu/RuxoWS3
         lBTly9IP0aj99T0cb0x1dpkqcEbUXK7LJR7xCE/huQuZi9s9LgZMQJsMZcYcPKXMmU39
         v9YxBFESBnJktWBV4heWqa+RcacPIHjlsczmHe3ergz7ypXJ6JYrCJppHW+kiCiC/MM/
         Sh5yxpCbVvhFrRTjiGid6Ap5gw8NGpGeYqnVbMuI19AZWRzaogDK6MG3+jSyXNgUbP3F
         7oLXexlGXQne54UIwF9tHZxLz0wXWEXuGG2Etxi7OZ0d8PkHVyMclOSF6+NaT/0SXAEj
         beoQ==
X-Gm-Message-State: AJcUukesg3x7OVEo+ot/BtNEthBwVECAB84bxZarQ5zhzLG8oWaHFJsd
        e46r5Bcf6sgNOjuWJi6mTQQ02LUo
X-Google-Smtp-Source: ALg8bN7L0cNAG6meRgRqkudjjVlQl18aWbO1tyLd4qlGw2ThHNj+R0dzBpXEfoYYqknXjVUSdpg1jA==
X-Received: by 2002:a5d:5443:: with SMTP id w3mr18187581wrv.4.1545848167955;
        Wed, 26 Dec 2018 10:16:07 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:6194:598:7f5e:b2e? (p200300EA8BCFE300619405987F5E0B2E.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:6194:598:7f5e:b2e])
        by smtp.googlemail.com with ESMTPSA id l14sm67698909wrp.55.2018.12.26.10.16.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Dec 2018 10:16:07 -0800 (PST)
Subject: Re: [PATCH] net: phy: phy: check return value of bus write
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181226180406.7881-1-pakki001@umn.edu>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <b608130d-0d97-4408-853b-1e04366215b1@gmail.com>
Date:   Wed, 26 Dec 2018 19:16:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20181226180406.7881-1-pakki001@umn.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.12.2018 19:04, Aditya Pakki wrote:
> phy_mii_ioctl() could fail when writing to the bus via
> mdiobus_write(). The fix adds a check and returns an error in case
> of failure.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/net/phy/phy.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
This file belongs to phylib, not to a specific driver.
"net: phy: phy:" in the subject doesn't make sense, it should be
just "net: phy:". You can see this in the history of the file.

And as commented on another patch of yours:
net-next is closed currently.

Your efforts are appreciated, however you should start with
reading the following:
https://www.kernel.org/doc/Documentation/networking/netdev-FAQ.txt

Heiner
