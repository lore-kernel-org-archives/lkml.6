Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBBCC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D7732133D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JC6xbUYM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730382AbfB0NcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 08:32:09 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43005 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730264AbfB0NcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 08:32:02 -0500
Received: by mail-pg1-f193.google.com with SMTP id b2so7971396pgl.9;
        Wed, 27 Feb 2019 05:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xbEseNacy50dMLYxtJLe6gRrML5B5I7hT3fN3fbmwHc=;
        b=JC6xbUYM4JBEhX4Kjy+Qg7YxsdRFl1h287Y+qeC6hAINDR/rgaE8xHv5tgZz/7hjZ/
         9cwSjgp3pO6LmlHN7nZC/zMDvCoWMx+SX3Wfrk4Hzw7zO4yJDOzfwz0h3Y2LmlaCMqBe
         bChiMhnCRLn8poqMGZHyFEFr6Lmg2TePJh1/FZmH4LaLzyR/x6Lv8bThWnj4UGuGp0Gb
         V9mITmmbCQEZ9CGac2fYs4oI2c2VuzxpG4Rs10bNHDmDpeeqLcTZKJDnhCYR469HbR6z
         F46MISY/U61l7H3sGEvlKqjiDslOHabzg+Il5ZY8Ah4jkDpXp+XyR1goiSG4K+hBMcF/
         10DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xbEseNacy50dMLYxtJLe6gRrML5B5I7hT3fN3fbmwHc=;
        b=TUJ3ojYBwoDevsQnvyCHhovJjgRSBKU8m4UaFY7/59hmBDy/JZFMZJRgTp0iqVwfAC
         LZFZJ+QIEck0VK8+JdL9CDtqF0NqqqPe5o9IlcUO5Ve/dFvAnmiENPrEAMbawdaQD5KK
         YFmzbkjT5TvVpNCI3ScZd1fJznS8phiwgoJvKM1SnuaEgDGBlFuwP4His0JV5EjdR/B/
         Xy3Cx3HhbeYciQtdsAUSUH2a8bdnF69EczchJSqRpJwNDmbLDudEaViG8G7+g8DZebH6
         Em3j0uoZLyDyVyGW8ao7pvV0eq5DOdyx36CYnFLz6WNIF/bQvm7mZnM0w/+lv7NA1Io+
         SXwg==
X-Gm-Message-State: AHQUAuZpESlj57kgRb5fr+rWep0WiNhj7ngjjaPqLvsII5DVCuKIQPYp
        bjfuzRnFbu85Fk913OoOrHvfm+LU
X-Google-Smtp-Source: AHgI3Ib9qdcyGEDXBUZgvyw0O2TV8wUyksRE+dWP7vA2lOCdeS/dpyR22wCM4/NlgLHUtkgUP5lJvw==
X-Received: by 2002:a63:7909:: with SMTP id u9mr3040303pgc.243.1551274321359;
        Wed, 27 Feb 2019 05:32:01 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id a20sm38425337pfj.5.2019.02.27.05.31.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 05:32:00 -0800 (PST)
Subject: Re: [PATCH v3] ARM: tegra: enforce PM requirement
To:     Sameer Pujar <spujar@nvidia.com>, linux@armlinux.org.uk,
        jhogan@kernel.org, jonathanh@nvidia.com, treding@nvidia.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1551255628-4794-1-git-send-email-spujar@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <6e5bf310-12b5-26a3-f466-95cc56c6932a@gmail.com>
Date:   Wed, 27 Feb 2019 16:31:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1551255628-4794-1-git-send-email-spujar@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

27.02.2019 11:20, Sameer Pujar пишет:
> Currently runtime PM is enabled for Tegra HDA driver. One of the concern
> raised was about handling !PM case in HDA driver. In this case, there is
> a need to manage clocks and power explicitly in the driver and reviewers
> were not really convinced about this. The consensus at the end was to
> enforce PM requirement to keep things simple, rather driver mentioning a
> dependency on PM. This is how it is done for ARM 64-bit Tegra platforms
> and the same can be done for 32-bit Tegra platforms too.
> 
> Finally the objective is to remove dependency on PM availability for all
> Tegra drivers. The detailed discussion can be found in following patch,
> https://patchwork.ozlabs.org/patch/1031007/
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> Reviewed-by: Thierry Reding <treding@nvidia.com>
> Reviewed-by: Jonathan Hunter <jonathanh@nvidia.com>
> ---

The commit message is okay to me this time, thanks! I'm still not super-happy to lose the !PM option because of its value in regards to the PM debugging, but again we can just do something better in that regards later on if will be really needed.   

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
