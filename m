Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC32C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC82820821
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgtSR0cI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbfBDTaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 14:30:13 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54238 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbfBDTaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 14:30:12 -0500
Received: by mail-wm1-f68.google.com with SMTP id d15so1132642wmb.3;
        Mon, 04 Feb 2019 11:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=30rTweGu/A2k229xFhoMXG2vERxeCqi+YvZV+i1eKzc=;
        b=YgtSR0cIJfX6MTfnJ9MJQIo1nfeIAsB59z0IiepQdXn0KhmgDrZ9EIh8VHxSOqv4UF
         gRVt47sWXTPrqn8YtQ2k8fA4QeUu7gLrewykqffx70m2uLvdwlQ2LFnWVURPupYpwAF3
         leYB9/19smiYDR85Z4zjeMPK5h7GQfT8C44p02OnauEug0/woq3m/0ptWFKmvd7iTxU8
         fctyVgGA3N17yJjoezyrKODIFMeGQ1ldyN+omw091aA7yewxrEyYzWFqMwA56rJ/3iMs
         ZPf8gpLv18RhgA0+PmsA4V8qwET31cFf7i7zKoJT/KHMLRYGCaT+V5KORQoWGVV7k9VN
         5PUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=30rTweGu/A2k229xFhoMXG2vERxeCqi+YvZV+i1eKzc=;
        b=FulwFdSqHTuJMlKjuGuRIBqgbrNcXdhsAxkzcmzFKtUEjIpRCNz9vPyYPEi3l+QM7k
         VEiHFI2cukHNj5spV7z9pUfVANL4kgWTWgh+NCVik7naWxvDhcZALUVGTeF/jYdMNfI8
         cJDJRNbAVkXUC3fyXTwDwHjCEgBsVQD3hazD3PRmBSa8VFNBp3zaYZqPXE2gjQlM/UsB
         pv1Jeu0bqUMhSeC8XuhPga9YOyuX0DnV8TS9boor6Hs6uVNYpmuamwb1qd9guV86XsBQ
         W90PGt1lwUAxcWwvWD5/fMmXWEVd6ymvWs9SCTUcsb68Xu/TvhR8YvPcgxFHL9PYzq9R
         uMYw==
X-Gm-Message-State: AHQUAuYwW7x9Dv5RZmLqxkm0G8L3ONrFcbEJ2hRc+dWMx1TN16PgkQwE
        iCi4DEvAclOVf197d6yaPP68pcs/
X-Google-Smtp-Source: AHgI3Ia4AiyGHhURjxTE56+nYKTsWXenSQbeSU7/fONEJCEV7hizf36OEI18GZp7sPbUD8VrKH5r5Q==
X-Received: by 2002:a1c:4d12:: with SMTP id o18mr711497wmh.71.1549308610346;
        Mon, 04 Feb 2019 11:30:10 -0800 (PST)
Received: from ?IPv6:2003:ea:8bf1:e200:79d1:9f16:256f:82a8? (p200300EA8BF1E20079D19F16256F82A8.dip0.t-ipconnect.de. [2003:ea:8bf1:e200:79d1:9f16:256f:82a8])
        by smtp.googlemail.com with ESMTPSA id x15sm36035971wrs.27.2019.02.04.11.30.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 11:30:09 -0800 (PST)
Subject: Re: [PATCH v2 1/2] r8169: Load MAC address from device tree if
 present
To:     Thierry Reding <thierry.reding@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20190204164213.30727-1-thierry.reding@gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <b18567da-110e-ddb9-c9cf-9c7bdf922500@gmail.com>
Date:   Mon, 4 Feb 2019 20:30:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190204164213.30727-1-thierry.reding@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.02.2019 17:42, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> If the system was booted using a device tree and if the device tree
> contains a MAC address, use it instead of reading one from the EEPROM.
> This is useful in situations where the EEPROM isn't properly programmed
> or where the firmware wants to override the existing MAC address.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>

