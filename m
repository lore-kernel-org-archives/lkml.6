Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D71C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE4E2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dm5C3WkO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE4E2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbeLEOSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:18:42 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35309 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbeLEOSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 09:18:39 -0500
Received: by mail-wr1-f65.google.com with SMTP id 96so19900570wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 06:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d+v3GEO//5kRm7NztQUilc6HTvrBQp4n3LI8qgKauaI=;
        b=Dm5C3WkOHeZ3lSdSBXdyyyYoY1PjHKdWNRttRsI3EO4hvpQ3o44t1Aj0L0IAL6BF9j
         bMq+TiYe372xqAQ5sEVNcMTclU7zIDDg53EGXYzrWMf41FqP0E6xAH8xVCDRIhX82pub
         LZPmf/I3C8mna90TM/L9Sgmo8bIBZuKhsTE1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d+v3GEO//5kRm7NztQUilc6HTvrBQp4n3LI8qgKauaI=;
        b=TLKg97WWr2KnbQoZxkVLPzsfjmdhNQrVeOvW4hzdUeP0y6Csg1UUWftyozU+698FeO
         WA58myBNaeQSi2QpZEgHevPo/zR9mF69fs2J9l53DGwIuCo6E7GCI0wOIlZecbxujSnk
         O1lL9JWoj4TFpbOg5Weck3RXzlvlu6IEY+C/lB69vd5AnrAMCJlVT7LhtCcNmCPWbuPO
         q3VF0Yu+vQF2XH0ORxb7dQz9RA3RxScSlZ7rK+2WykHJLmuDYLS3p2yC1+NTncwHmkrF
         DpnNEKVDswZe582bYmcUQPOOvv2l/UJsIGeBe7NMifVgGtn5XCtbH/3jAdS+ZYk7qcg1
         j2gQ==
X-Gm-Message-State: AA+aEWa06pAOaHvVWVpk28Yu5qUSkPo3Ygify4RVH27YBl7HDrv8NUcN
        V0mHhdeZxyptQFO415Sbc8Zu4A==
X-Google-Smtp-Source: AFSGD/Wh3d0/RDnIXt4fBeEeEGs/WsxsAamGe+bAOBS4HSwwXjaEEo7SiG1T6h/dxe+6N8eQl7qMAg==
X-Received: by 2002:a5d:61c4:: with SMTP id q4mr20963798wrv.308.1544019517551;
        Wed, 05 Dec 2018 06:18:37 -0800 (PST)
Received: from [192.168.86.29] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id n6sm10208821wmk.9.2018.12.05.06.18.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 06:18:36 -0800 (PST)
Subject: Re: [alsa-devel] [PATCH v2 3/5] ASoC: sdm845: Add TDM configuration
 for speaker
To:     Cheng-Yi Chiang <cychiang@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     alsa-devel@alsa-project.org, tzungbi@chromium.org,
        Mark Brown <broonie@kernel.org>,
        Rohit kumar <rohitkr@codeaurora.org>, dgreid@chromium.org
References: <20181128090037.257359-1-cychiang@chromium.org>
 <20181128090037.257359-3-cychiang@chromium.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <98cfc753-86cc-e3df-4997-522cf2cf7796@linaro.org>
Date:   Wed, 5 Dec 2018 14:18:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181128090037.257359-3-cychiang@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/11/18 09:00, Cheng-Yi Chiang wrote:
> Set TDM time slots and DAI format for speaker codec.
> 
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
