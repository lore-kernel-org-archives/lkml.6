Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C88C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDE3C20652
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fc/MoYro"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDE3C20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbeJKVsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 17:48:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46078 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbeJKVsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 17:48:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id q5-v6so9898867wrw.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 07:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gh65zLZ8kt+XvoxgymWv+iw25VnC+zsGy7PDIYCdEtw=;
        b=Fc/MoYro393LiWJVpxbn3FRaRA3eYhscztvP+8GHRV9sfX9qL8Olv88uxHUJru58x+
         qiiw2XFKxLVDqzBnErNyt0y44ARA6UP4KYJtm7F1dDp6t6RyTkLPzkeB2rrzI9PmBGxl
         HZxHvZu4castYAjjM+g6INk5Y5TB9vZ6kog+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gh65zLZ8kt+XvoxgymWv+iw25VnC+zsGy7PDIYCdEtw=;
        b=onsBPD9EKIk10z7eRib1wTTiW+rkUVJbRq3RvZacpEPdDxhTu0rIp5GHwp2BqBQLtW
         LyvWW8eetksCtWMNzWj5IoWA+Z4zMqwbyElTB/11sWYJjr4RGO1lO0pHVoJoQbbRdQXR
         P6eJRS4pp65YDPWdZK5KwX2+7sxaIrRYL57mct2lqJkbMWUTRsyZnCgBWIqKbzoZojK2
         SHfCSz5Xq+qaUK3cp4EmwF873GuHLM/LkR8bpuYMZYzZqmTMybuilJGh73tdZ9G9eQWZ
         oh8gbMHZQlJu8wlJPSOdb2bXxVX6/0XOBeaHR9+ORTI0FCg+FU20Yowpy24Ykf2T6SDq
         VZeg==
X-Gm-Message-State: ABuFfogAskoQ/88fswCNy1NIMXKuQFADDAy2hBQkDXb9wPFq+ePXZpka
        V4nXwEQGkcoqxe4H4gBqf4CNPfUTfYk=
X-Google-Smtp-Source: ACcGV618yLvnwNbVlk2SzljGE5Ts8/38w36iYN/n1U4bn7FLjlXYrXR1wNG/WPEIt7gf4a/d05637g==
X-Received: by 2002:adf:a29d:: with SMTP id s29-v6mr1836238wra.100.1539267651840;
        Thu, 11 Oct 2018 07:20:51 -0700 (PDT)
Received: from [192.168.0.40] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id n11-v6sm32818331wra.26.2018.10.11.07.20.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 07:20:51 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: Assign myself as a maintainer of ARM/LPC18XX
 architecture
To:     Arnd Bergmann <arnd@arndb.de>, Vladimir Zapolskiy <vz@mleia.com>
Cc:     arm@kernel.org, Joachim Eastwood <manabian@gmail.com>,
        Olof Johansson <olof@lixom.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181011123116.24885-1-vz@mleia.com>
 <CAK8P3a3pbpEX1BjKvn179pTYtYEtiQnd=SmD5NYkAtpdZAonkA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <5bd0530d-13d9-d25d-d0f4-f48e39174991@linaro.org>
Date:   Thu, 11 Oct 2018 16:20:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3pbpEX1BjKvn179pTYtYEtiQnd=SmD5NYkAtpdZAonkA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2018 16:11, Arnd Bergmann wrote:
> On 10/11/18, Vladimir Zapolskiy <vz@mleia.com> wrote:
>> To all appearance Joachim Eastwood abandoned the maintenance of NXP
>> LPC18xx/LPC43xx archtecture about two years ago, and for me it would be
>> possible to continue the support, fortunately the quality of platform
>> drivers written by Joachim is exceptionally high.
>>
>> The change is based on https://lkml.org/lkml/2018/9/24/1398 discussion.
>>
>> At the same time two redundant explicit driver file paths are dropped
>> from the list, clk-lpc18xx* drivers are covered by "lpc18xx" search
>> pattern and timer-lpc32xx driver is covered by "lpc32xx" pattern and it
>> goes into ARM/LPC32XX entry, which is also under my wing, in other words
>> LPC18xx/LPC43xx clocksource and CCF drivers will remain maintained.
>>
>> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
>> Cc: Joachim Eastwood <manabian@gmail.com>
>> ---
> 
> I could not automatically apply this with 'git am', not sure what the
> problem was, but I managed to apply it by patching the file manually.
> 
> Thanks for taking over the platform!

Yes, thanks !

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

