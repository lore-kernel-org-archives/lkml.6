Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E335EC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 00:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 718852156D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 00:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvfD09jP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 718852156D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbeI0Ga5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 02:30:57 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43476 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbeI0Ga4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 02:30:56 -0400
Received: by mail-ed1-f65.google.com with SMTP id u23so3435582edx.10;
        Wed, 26 Sep 2018 17:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7tls2+wp1bdQDQCH7hfD+8KOzJaX1rMWH029p/SOz1s=;
        b=kvfD09jP4cqlBWbv1gbn6PVefG8aGVTo6GZcW2qM4v4yzuTCnOyt6v19k66/PkB/aE
         aEPodB6aiookRQl09imoxgjRhK63TSYM6xvJ73dWDvKZUKcTdarMuzEVENKpHCPYvpdd
         as3ADV/Fwlbt8pWWhbhgRM8sAwakgLOp/28T7NqM7L67nWk2NjBgF8Js5rS7gvE4OUsu
         sQmvMf49xc6UH19AalUpBihVhiI4ETLpLWCyFrTtFOsF+L5s33H2cPNOhdx5mR8hwkVP
         CAY3q0f+yDrrhB9ju7FqiOi1JcF9p9jSunjDRFbI4siRTXFVw9694e/EoiKV3rNM3du3
         O44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7tls2+wp1bdQDQCH7hfD+8KOzJaX1rMWH029p/SOz1s=;
        b=Z1Of9vp/mnZ9FKz7t/NOFbWpA2fw6qVAyuKT+7xZ96oyJOfssyKPHUCwRz62h5x1t9
         g+G5+4mm5dGcEd7mFsin2gZ9ZYB5TW4h3GEVH1Mqobo1vhlZz1V/Ut7csG52Bv5sU5f+
         1VqkJRDjejadsDH7k44Q/7+G5W8Re0O7LelV6rUosAiWskg8IoQSFAojBemxI5wrBrpC
         TSRxu8TyHa1cbqJJmFHbaGsh3yqLJfdNgecg0Gm3uUStnM+nU61FQibFFHhNukS2LBPf
         Km710H2PTelwFVruO0HdVbjA3nZ5eYDOlOGOPrTlHrIO/65xtc617cCnBXI2HVNfIQZi
         RFDg==
X-Gm-Message-State: ABuFfojaJd6PLc63P452dKYDZHBN2ETrhOa+PO6fxBVTxp4gg+5hVYcA
        OwpWCp1NSifDozJ7ssO5cU35D2Yk
X-Google-Smtp-Source: ACcGV61N5FYBp23I1AyW0WCSdOx4vvJSFOKoHRG0NqydqjgU8dKTINTvR1c6urvIGfbYTufVmUCyFQ==
X-Received: by 2002:a50:f69b:: with SMTP id d27-v6mr13495863edn.103.1538007326027;
        Wed, 26 Sep 2018 17:15:26 -0700 (PDT)
Received: from [10.67.50.87] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id j14-v6sm393617edq.25.2018.09.26.17.15.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 17:15:25 -0700 (PDT)
Subject: Re: [PATCH net 0/7] net: usb: Check for Wake-on-LAN modes
To:     David Miller <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, woojung.huh@microchip.com,
        UNGLinuxDriver@microchip.com, steve.glendinning@shawell.net,
        keescook@chromium.org, akurz@blala.de, hayeswang@realtek.com,
        kai.heng.feng@canonical.com, grundler@chromium.org,
        zhongjiang@huawei.com, bigeasy@linutronix.de, ran.wang_1@nxp.com,
        edumazet@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180924205420.31309-1-f.fainelli@gmail.com>
 <20180926.171218.1890476375628867560.davem@davemloft.net>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <2b56866a-e230-6f89-661f-36dcf8a47930@gmail.com>
Date:   Wed, 26 Sep 2018 17:15:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180926.171218.1890476375628867560.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/26/2018 05:12 PM, David Miller wrote:
> From: Florian Fainelli <f.fainelli@gmail.com>
> Date: Mon, 24 Sep 2018 13:54:13 -0700
> 
>> Most of our USB Ethernet drivers don't seem to be checking properly
>> whether the user is supplying a correct Wake-on-LAN mode to enter, so
>> the experience as an user could be confusing, since it would generally
>> lead to either no wake-up, or the device not being marked for wake-up.
>>
>> Please review!
> 
> I saw some discussion on patch #3, is there going to be a new version
> of this series or should I apply this one?

I will be sending a v2, please discard this one, thanks!
-- 
Florian
