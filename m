Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B87C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 23:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F47720836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 23:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wgr4XP0W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F47720836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752901AbeFSXiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 19:38:17 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42229 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750805AbeFSXiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 19:38:14 -0400
Received: by mail-pf0-f195.google.com with SMTP id w7-v6so615849pfn.9;
        Tue, 19 Jun 2018 16:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r/cZu9pFdZHlS5ducw00AC6tVJ0DLs44sOH/cUyeU10=;
        b=Wgr4XP0WszXIRSbW2uvhhoH/0XFeEY4xP6S1ZQ6cE7b8MpPwt0liSGgnBrqmCVkrM+
         +X4QPTEbPySIErGJ00/YQMHRCX8PV0RKYTmp/8/whrSq8D293bxpPwL8+edDxLysXvBh
         C4nCYmSYHfVd9/cAOeC9PWOADPHPia6SZH2YIPtSNsG1PHSBDf1pLliSboTh7mFDc1Ll
         9yspkhzlIdBXHNIoitGttIqy9t+0OiImaWvkXFnX9evJT1PU2NP6GVsOgrSo/D36Ea6r
         8hM+ZKD9wNDt/Tta8cFpsAyorTYOSWwXqluw+hf/7zBjWi/s6GMyfZGKZkB4PI3dzch/
         lt5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r/cZu9pFdZHlS5ducw00AC6tVJ0DLs44sOH/cUyeU10=;
        b=CfdsO3j5iiFTymCk5jqgPBJr2y8OJoLaB1i346ZF6TDg9V+DHGDjcGPKhaPrRwm8oN
         5dNgg4vNs4FR2dyCOQQAHEMHBEI4LdL2fxD7UmYZliJRwT9jVre4lW3eKDSFjg7AMhJz
         hUI+5WdggEK22VjTLGJmtPkrJ+Y/Pof1ccgt7uE8DA3R7opXmhnqEIJhHRXvHPQd1kMA
         Z8psVE7uilo4AACivpnc+w6vWn3xk/iodC0AaXTjfqeFzFPmynlY7N1IBwH/Odt4Rap1
         Se3TYnNZDzMdZ3JTYKZ6xCf8tpuEIL2OeCFKw5W+zFMrF9ulpFIYnuoiTxb/YaJmAAsL
         +qzw==
X-Gm-Message-State: APt69E17egE1dIxnzhAkDku+bbhnO7bsWDNHkBKMYmRX9f4oeMlKNy95
        SjhVSDglO1ykSi/mLheNMvsjKk27
X-Google-Smtp-Source: ADUXVKLNw3wXoFDF+pgEVzmq8j/H6/HKMee+clwIO2fL0W+4tKwT15uDH3JzEVI/CNqgBni7c+W1xw==
X-Received: by 2002:a62:ecdb:: with SMTP id e88-v6mr20443101pfm.16.1529451493577;
        Tue, 19 Jun 2018 16:38:13 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id d22-v6sm1092916pfk.126.2018.06.19.16.38.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 16:38:12 -0700 (PDT)
Subject: Re: [PATCH] [net-next, v2] tcp: use monotonic timestamps for PAWS
To:     Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc:     y2038@lists.linaro.org, Harsh Jain <harsh@chelsio.com>,
        Atul Gupta <atul.gupta@chelsio.com>,
        Michael Werner <werner@chelsio.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Yuchung Cheng <ycheng@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Florian Westphal <fw@strlen.de>,
        Christoph Paasch <cpaasch@apple.com>,
        Lawrence Brakmo <brakmo@fb.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20180619123724.2535981-1-arnd@arndb.de>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <e3552cdb-a22c-5577-42a0-0f695e42e784@gmail.com>
Date:   Tue, 19 Jun 2018 16:38:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180619123724.2535981-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/19/2018 05:36 AM, Arnd Bergmann wrote:
> Using get_seconds() for timestamps is deprecated since it can lead
> to overflows on 32-bit systems. While the interface generally doesn't
> overflow until year 2106, the specific implementation of the TCP PAWS
> algorithm breaks in 2038 when the intermediate signed 32-bit timestamps
> overflow.
> 
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: use time_before32()/time_after32() everywhere as suggested
>     Eric Dumazet


Thanks a lot Arnd.

Signed-off-by: Eric Dumazet <edumazet@google.com>

