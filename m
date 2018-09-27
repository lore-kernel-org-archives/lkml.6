Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2D5C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ABCE215F0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mS6yY4Qf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ABCE215F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbeI1B0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:26:55 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37159 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbeI1B0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:26:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id u12-v6so3799285wrr.4;
        Thu, 27 Sep 2018 12:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9OB8nt5MW0fTK6C64eP4f/FNxkt9laP2yrv+Zcm+y4w=;
        b=mS6yY4QffUGmg1szGlptCeErI7CpDyw1ti0PEOuQFdmebmMNmSTy3FXz6ZgqPaokN1
         R4QivsAT2yFIxbggXPrApnwrSeXKAezBYZfkFWNH0zMlnyNL0PZ3A6FXSh5dSlJSyNc9
         TUpT+EAjowLicOHHVWI3bhpVCBc6HUq3V+7cGxQMqf3u/vonBzG8GhckalywrCOvSuJs
         dOhOb3E+Ro5QAK2rRqGTx8CDtxIjIdRhECdHHa6yoZ1BneMycJfVBoxXcLi83BBLlL1R
         O7+yJ7HoWUFQ5YZwe5bjha66idTf0+xlHf9tNUjytDBSU4G28/AXb7+lDxrBgJJaovyC
         8qaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=9OB8nt5MW0fTK6C64eP4f/FNxkt9laP2yrv+Zcm+y4w=;
        b=l179rp3GPClvByBPJT3+uAHVj5/BmhooygjimIfiUSj2FDvjrjOeUgDYcyfjy5xJpC
         jgyE+Gy9Ht33uyc2tKUkdsxrcKxIlRwLyy2JoCAnvBGNaB0YhtS+yZutaudLcUSdNZP7
         di56CTteEqoFgOe5fQ7P1asPeZ6BxH9dC8xAZFC9gRmXa6LqDAyiWBXpvCN/HedC4lnR
         HBUS8K4dxVYJUbIX2lmbuPnsZaBdbaW8GZpOJgFJKTGATw63ueeBPTTsHqaIXm20q+EM
         K17EeBa8Row+6Pun3FmapwLhIudNtgz8cHFZ2fdJ0KlJqyETSx41THMuzrD8LwXXQYYz
         DK5w==
X-Gm-Message-State: ABuFfohlXb+HJY3j3pSj/FXA8F6+wlTtsNicOG8W21NN+rL9PLiXLtmI
        XZuMKGeLLv8U6aZBGYeHStc3QmHM
X-Google-Smtp-Source: ACcGV61/VlUa7uzWEjA77eqVWrA/xGlaJJW7/vj9GGeS9ARzeIfCPc5CIB3tvBFNv7K5NvsyrQ3a0w==
X-Received: by 2002:a5d:608b:: with SMTP id w11-v6mr10384292wrt.193.1538075230378;
        Thu, 27 Sep 2018 12:07:10 -0700 (PDT)
Received: from [10.67.50.87] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id y12-v6sm2001874wrq.33.2018.09.27.12.07.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 12:07:09 -0700 (PDT)
Subject: Re: [PATCH net-next] net: dsa: b53: Fix build with B53_SRAB enabled
 and B53_SERDES=m
To:     Arnd Bergmann <arnd@arndb.de>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180927100244.692546-1-arnd@arndb.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <c0af4a4c-6656-e014-a4bb-0bacfbe1d468@gmail.com>
Date:   Thu, 27 Sep 2018 12:07:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180927100244.692546-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/27/2018 03:02 AM, Arnd Bergmann wrote:
> When B53_SERDES is a loadable module, a built-in srab driver still
> cannot reach it, so the previous fix is incomplete:
> 
> b53_srab.c:(.text+0x3f4): undefined reference to `b53_serdes_init'
> drivers/net/dsa/b53/b53_srab.o:(.rodata+0xe64): undefined reference to `b53_serdes_link_state'
> drivers/net/dsa/b53/b53_srab.o:(.rodata+0xe74): undefined reference to `b53_serdes_link_set'
> drivers/net/dsa/b53/b53_srab.o:(.rodata+0xe88): undefined reference to `b53_serdes_an_restart'
> drivers/net/dsa/b53/b53_srab.o:(.rodata+0xea0): undefined reference to `b53_serdes_phylink_validate'
> drivers/net/dsa/b53/b53_srab.o:(.rodata+0xea4): undefined reference to `b53_serdes_config'
> 
> Add a Kconfig dependency that forces srab to also be a module
> in this case, but allow it to be built-in when serdes is
> disabled or built-in.
> 
> Fixes: 7a8c7f5c30f9 ("net: dsa: b53: Fix build with B53_SRAB enabled and not B53_SERDES")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks!
-- 
Florian
