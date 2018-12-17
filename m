Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456B4C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB092133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="MO4LbbBb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731938AbeLQLVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 06:21:12 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39479 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbeLQLVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 06:21:12 -0500
Received: by mail-wr1-f68.google.com with SMTP id t27so11862690wra.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 03:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r3ZtV6/3p8+1zZTRGIE7ARCZeIbcdQoYiizKfuD75Jk=;
        b=MO4LbbBbq4JzbydvtrYTcQtiwwYiG8Ic8e/iV/5DQ1g48PQ9YvG7ZHSuBXTjJB3yur
         IRNgONxFFNCl2z44BLosagqSDwWWTrNUNE+OVYntZJCuxSlKRHmtmVaN9zQ3ZCitaVHG
         vOXKZVQrakuW4bozhtZfnLFOnzMelorZZYJ98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r3ZtV6/3p8+1zZTRGIE7ARCZeIbcdQoYiizKfuD75Jk=;
        b=Xj1wSnwBx3erONX/7Fqlna6YTXVb5E7vhd0wquNCB0N01Ki9Q1P6ffjPYrFwjbBWN+
         1Z4VoJxRqCHOAizuauspmNFQO05MiEEUdJbYH9uo+Rof6xpclbLnyunhC6KnydHqjdZH
         ymz6ofhbKruU41g67MM5SAijIx9UBiKEf9dx21qJwvUY1nASYTHHAwnuE/p6S304oZ4n
         ObPsOzd+ICk/B2f2SWdjUQH692TN5pfqmKZej/tp/+eh7LgMEJ9Qj/M/1qFhcELdeqFg
         RY8MWJvSWhjvEDFm818vASpigeTTK1RBE3N+PtwBkAM+Cu3ewRf1nfJ8Sil2EudVVTYL
         BatA==
X-Gm-Message-State: AA+aEWbaLi1xA1MV4E3f6EVKhKrEzaCamkdJt/uXaKVfVwLTLyEJ2yeD
        ISa/Md/9vOCTGLKFn0zObly5rg==
X-Google-Smtp-Source: AFSGD/Vqv6Xms9LUmLlJFDRqwdP8EUeaCwUrU+Lr7ObTDk/jkJDmv8mlUOyeou72QGPOQMqVWfSrzA==
X-Received: by 2002:a5d:51ca:: with SMTP id n10mr9636198wrv.316.1545045670638;
        Mon, 17 Dec 2018 03:21:10 -0800 (PST)
Received: from ?IPv6:2001:470:1f0a:1832::2? (nikaleksandrov-1-pt.tunnel.tserv6.fra1.ipv6.he.net. [2001:470:1f0a:1832::2])
        by smtp.gmail.com with ESMTPSA id x3sm24407941wrd.19.2018.12.17.03.21.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 03:21:10 -0800 (PST)
Subject: Re: [PATCH net-next] net: bridge: remove unneeded variable 'err'
To:     YueHaibing <yuehaibing@huawei.com>, davem@davemloft.net,
        roopa@cumulusnetworks.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bridge@lists.linux-foundation.org
References: <20181217094623.32668-1-yuehaibing@huawei.com>
 <e9b1e56e-4c37-aff4-b855-2523eae1ef49@cumulusnetworks.com>
 <d0c9ac6a-5c23-84dc-f45f-28bc2a3d20fe@huawei.com>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <1ea956e2-ea17-2fb4-30c4-194e438514a6@cumulusnetworks.com>
Date:   Mon, 17 Dec 2018 13:21:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <d0c9ac6a-5c23-84dc-f45f-28bc2a3d20fe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/12/2018 13:16, YueHaibing wrote:
> On 2018/12/17 17:51, Nikolay Aleksandrov wrote:
>> On 17/12/2018 11:46, YueHaibing wrote:
>>> function br_multicast_toggle now always return 0,
>>> so the variable 'err' is unneeded.
>>> Also cleanup dead branch in br_changelink.
>>>
>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>> ---
>>>  net/bridge/br_multicast.c | 3 +--
>>>  net/bridge/br_netlink.c   | 4 +---
>>>  2 files changed, 2 insertions(+), 5 deletions(-)
>>>
>>
>> That is correct, but in such case just make it void.
> 
> In net/bridge/br_sysfs_br.c:
> 
> static ssize_t multicast_snooping_store(struct device *d,
>                                         struct device_attribute *attr,
>                                         const char *buf, size_t len)
> {
>         return store_bridge_parm(d, buf, len, br_multicast_toggle);
> }
> 
> and store_bridge_parm need the returned err.
> 

That can be worked-around with a set option that returns 0 but it's not that
important.

Fair enough,
Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

