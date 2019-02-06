Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70B5C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF6520821
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHYmHtn3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbfBFNGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:06:01 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39134 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbfBFNGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:06:00 -0500
Received: by mail-lf1-f68.google.com with SMTP id m11so1688102lfc.6;
        Wed, 06 Feb 2019 05:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ytyhnuAAxEqtjR/4kVZZNOTlPvluOYJpvBdb0h8TdMQ=;
        b=XHYmHtn3BqTcaE9O58/5J0C15aGVL6AlDcDBsMawO8XQOoijozai0G4fMCEipKqpaD
         mKRob3NBifarjj0vDRa64+IPaR1tfTAe43k0WAqDdFmYvh/EI96oJPp9VqG+jimeWDgC
         k91/5V/1MV5erIwR9rwMnJwO5g0OkEq+MIkp6ttedK5+YS2Zfi+P+5BE7RkDBLthILMw
         7Qr1ef0+MVj0TDj89IVXUpC3AO3PHvkXMm8jcAvwaKJ/+5WLGVkCMjhGEdlZWwJY6KRj
         7yljIozCdCn5U91c7kiDhRHzNO8ROZPCCPlZDJpSgLXLEJ/xi3q9r2ixUlTea9zLo+dV
         p+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ytyhnuAAxEqtjR/4kVZZNOTlPvluOYJpvBdb0h8TdMQ=;
        b=DPNSslrAWPAK4W8qmoO3Fqu6ij732qWzuHTXDG+EXieePaViEYyy12pwQIEfOd6xd+
         PWq0aaMEaEwoyLdaVW9Fnm7Uk4ontZrhySpMKIh3FBNgAorhi9+mSq9uDnjGXVf5peut
         Mi95gu5CPyk5QDI8IdG2A1/PQhdfQdNVSuey1LHAqMIw4VfRv7OWp6/pOX2Sa/hqAKpN
         VS3Y0N+Gyjpomsw5+sReMVY/BaL34l/5hTVzDDDclgibiU9b7/2afWCZbOEUJwlGBqq8
         3Db4QL07AViToXMvOzTPr4sQbgXcZWFnIQbOzzBzYdzhfkg6CPyhjqlpk6/7CtbTOVAP
         c1cA==
X-Gm-Message-State: AHQUAubcmbVrLldkn/zAW1yJYC3iO9isU0DY7jG9dHanzGGU2b0v97T2
        y/ibjyCOWxAI4udjMb0l92BTnv5m
X-Google-Smtp-Source: AHgI3IYFjApmp1l4z5ET7Yn3VaYmaP7b6xMz2gU8Ap/eoicjjmn2DlJkEgi1UOewhRTSUPS/yAByxg==
X-Received: by 2002:ac2:4432:: with SMTP id w18mr6899251lfl.140.1549458357827;
        Wed, 06 Feb 2019 05:05:57 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id m12sm4268972lfc.30.2019.02.06.05.05.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 05:05:57 -0800 (PST)
Subject: Re: [PATCH V12 3/5] i2c: tegra: Add DMA support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>
Cc:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
References: <1549406769-27544-1-git-send-email-skomatineni@nvidia.com>
 <1549406769-27544-3-git-send-email-skomatineni@nvidia.com>
 <85b77477-3175-0501-8753-f39d3b60538e@gmail.com>
 <c4f67e39-df72-cc56-216b-8e6014891b52@gmail.com>
 <BYAPR12MB3398E50ED1C6909D6BCB0DDFC26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <304c1916-e836-fa95-5cec-887fef8f3eb2@gmail.com>
Date:   Wed, 6 Feb 2019 16:05:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB3398E50ED1C6909D6BCB0DDFC26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

06.02.2019 16:03, Sowjanya Komatineni пишет:
>> BTW, I'm seeing "atmel_mxt_ts 0-004c: Warning: Info CRC error - device=0xF436DC file=0x000000" whithout making any modifications to the original patch as well and it shall not happen, hence there is bug somewhere. Probably FIFO triggers are still not set up correctly... ?
>>
>>
> In snippet you sent, I see you are forcing dma_burst to 1 always which is what set for fifo trigger levels as well and also you are forcing dma all the time.
> So always it will be 1 word dma burst and 1 word trigger level and that should not be an issue.
> 

I reverted that snippet, this log is collected with the yours original patch.
