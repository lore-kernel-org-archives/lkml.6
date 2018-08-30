Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4685C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 09:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CEC120838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 09:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="T8xmV8HX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CEC120838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbeH3Nak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 09:30:40 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40575 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbeH3Naj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 09:30:39 -0400
Received: by mail-wm0-f65.google.com with SMTP id 207-v6so1252794wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 02:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M3LlBKJpsV0fxAwGY9zscr/Njx0BkR/tSy3GlaVcKe8=;
        b=T8xmV8HXbj/3G47E7h1FaCEnVmbxdRL3v2HsSeI2afOXmL8ZGNtjNm/h8e9ErL32R7
         V/A5+KexpdWCdDHSbpurLDrT1zm/ZHHFYcaAjcGnPjOKEQtOaF7HNa1EJfXphURCg9gy
         avvup9omHop93Y1hQjrtpOhCkjAv4zqdInV9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M3LlBKJpsV0fxAwGY9zscr/Njx0BkR/tSy3GlaVcKe8=;
        b=ipwnK3lC+e/J7be1uoMCHGsufWhkIa6zUf316p9ikLEWsdwRc44g/4ovkn2vFvo40v
         sSXznWxXDpjdsxpsvTvVuLb4AzLHy5OT1NpY5jHancDxRnf5ffaM22TCmWFe7GVLkGh9
         VrekyhH38cPnWHF2y8MoID6gj2/B1/ccMZl6EJyF3Is5S/EGvs+WuFKlgOBB28cMkuwy
         pGjyGo0aNhmVqS5oxNwyzC5crx9rXOybAQWFtJNZiREj556jAMoJONW4R9/eYMclsiz1
         i/r4guz9y75jNjQFTCCnKORfDd6vUGjc+TnaBr+aPCCj9N8aVZoQ0geb16774Ui8Sf0v
         5wxA==
X-Gm-Message-State: APzg51CXd/zorxMI6KmQ9cTO+eDRoXwIM+lg5gX/Im5r1QU5HRuRoeUp
        HCMeiokaHmOjRaE3KVc6/Rz1T4jOToc=
X-Google-Smtp-Source: ANB0VdY8DnRJouaS2fcMf5Klrib/fbuGuL0+UHX87NOlvK/+msOPURsCUzxBTHPWEC2Azwle4+M2oA==
X-Received: by 2002:a1c:8c0b:: with SMTP id o11-v6mr1147147wmd.11.1535621364192;
        Thu, 30 Aug 2018 02:29:24 -0700 (PDT)
Received: from [192.168.0.40] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id y206-v6sm1569792wmg.14.2018.08.30.02.29.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 02:29:23 -0700 (PDT)
Subject: Re: [PATCH 0/4] clocksource: convert to SPDX for Renesas
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
References: <87a7pff8jq.wl-kuninori.morimoto.gx@renesas.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <3fd74aa2-9025-7163-a408-cb2c8a76aec2@linaro.org>
Date:   Thu, 30 Aug 2018 11:29:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87a7pff8jq.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2018 04:25, Kuninori Morimoto wrote:
> 
> Hi Daniel, Thomas
> 
> These convert license to SPDX style on clocksource for Renesas
> 
> Kuninori Morimoto (4):
>   clocksource: renesas-ostm: convert to SPDX identifiers
>   clocksource: sh_cmt: convert to SPDX identifiers
>   clocksource: sh_mtu2: convert to SPDX identifiers
>   clocksource: sh_tmu: convert to SPDX identifiers
> 
>  drivers/clocksource/renesas-ostm.c | 11 +----------
>  drivers/clocksource/sh_cmt.c       | 10 +---------
>  drivers/clocksource/sh_mtu2.c      | 10 +---------
>  drivers/clocksource/sh_tmu.c       | 10 +---------
>  4 files changed, 4 insertions(+), 37 deletions(-)

Series applied for 4.20

nit: in the future can you stick to the format:

clocksource/drivers/<timer>: [A-Z].*

Thanks

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

