Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227D5C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9AFB208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXscFqfP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9AFB208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388811AbeG0Q0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 12:26:04 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33678 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732059AbeG0Q0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 12:26:03 -0400
Received: by mail-pf1-f194.google.com with SMTP id d4-v6so1598470pfn.0;
        Fri, 27 Jul 2018 08:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3o6+2iqcmZF94OVFcnWYrc1u56Jdq9CoimG+M+2Buwk=;
        b=nXscFqfPg7tprg2ZacOOeEb6nHC7DEvk91FC1SuK3KyZY2q/f7m+qouMXI8v7ukIXz
         I3pFnSa9TAzpiuBbeIHBRouGmQlub3uB8ETYfzcmrI7w5k1C4h0Mfzl/gAnc/kCkBJh/
         05yN0ZyGvzLAZW95P8GJfcm5E4K5w28H46pBJGfBKT9Fvo8puL5wi/OilfBYGiV5GnTZ
         b7bN/EwDc/UmFYFzlt28wD/jgtgTVkJCzfyyEEBN1iXnr8/NpD+mwDoTu0vP10JJvZoq
         NAicBGwgOH5sgzISawjJ3xfp6h2Z/qTLYsmbMlA5NVBN0s5JAqm+eyXc0zhr1SWRZItQ
         j0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3o6+2iqcmZF94OVFcnWYrc1u56Jdq9CoimG+M+2Buwk=;
        b=cNzctaRYZrsR/E3zWFTxPylf1hE7pN0/xKnGC6elCJnXbxIMRu6Q/A48PRxk1u9ro+
         BjRyJ4ezUDGg+j70ECDAaqPFvVo7Q7bdoJ0aGun4YkmNbmo48fAASnSSQ3UEpXBMLEXa
         /FbdIL/fdw1Mu+blw8t7xXVFTkTjrxJVRTwp7yMeJIhplO5/Kh5gC1ju+bmtdDHqbLYe
         LU9PnjNI0JlURNLR8sL35bz2CGAh56FvlERO92LPrLZx3laTPloZxSXoLJ7qwbpljHSA
         YdRdwtTJ1Li6CgNG9r8EvKNAv2RyjgCfioJ2Co5a3Azq1pbBkSl/hH5P3PIDHvqIgSDh
         1QUQ==
X-Gm-Message-State: AOUpUlHI8+pqhwO9vwqB3AHu8mx74WJ0u4aKtOPQAzI1T/Ie/86MkFE6
        ievwtdzLICuB6e/47+GEfpPpTiyZ
X-Google-Smtp-Source: AAOMgpdTJc1vSXqd1CuTsqd7tN5IvMHeiJBMyhwuQ5ODNdB9qPls3Aa1OQ1joA04BFzM7gbmqh5/PA==
X-Received: by 2002:a62:464f:: with SMTP id t76-v6mr7071080pfa.118.1532703824324;
        Fri, 27 Jul 2018 08:03:44 -0700 (PDT)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id o3-v6sm5011553pgp.3.2018.07.27.08.03.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 08:03:43 -0700 (PDT)
Subject: Re: [PATCH] net/rds/Kconfig: Correct the RDS depends
To:     Anders Roxell <anders.roxell@linaro.org>,
        santosh.shilimkar@oracle.com, davem@davemloft.net,
        eric.dumazet@gmail.com
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
References: <20180727131849.18488-1-anders.roxell@linaro.org>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <3872d906-99fe-b310-7d5e-ff0ef31de1e2@gmail.com>
Date:   Fri, 27 Jul 2018 08:03:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180727131849.18488-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/27/2018 06:18 AM, Anders Roxell wrote:
> Remove prefix 'CONFIG_' from CONFIG_IPV6
> 
> Fixes: ba7d7e2677c0 ("net/rds/Kconfig: RDS should depend on IPV6")
> Reported-by: Eric Dumazet <eric.dumazet@gmail.com>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---

SGTM, thanks !

Reviewed-by: Eric Dumazet <edumazet@google.com>

