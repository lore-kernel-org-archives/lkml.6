Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC74ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B802820858
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="1q3QWf8M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B802820858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kapsi.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389825AbeIUQYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:24:30 -0400
Received: from mail.kapsi.fi ([91.232.154.25]:46429 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727554AbeIUQYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 12:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=a8IA34wmYB8AEBehNeHKtHVDVpBmHq9BGpyi+/Fop28=; b=1q3QWf8MKs0QWp2jHUWFIb6ytk
        7AySfeGtJOBAIMeuvcHeAz+a/h/znoZgxoM9cxk+DVPkUxVf3j+xdelWilXca9KUWBD+rE41NKbSQ
        cbvBJvS4MWFiKqBNF1Pb12WLpECxO94QpcFMR6GQFfj86ME585bwje8yn+WjLOiciqv+f67Ek9C9O
        5vE+FJJHybx/rqyasR8Ol8Zs27F/TuPYiUkOC4RQa2vVW7ZwlBCXyWZa1XKs85qBPFvxV0k9pioog
        9rlEpirZs1ED7iVOpoKXhssbgIEYeJSU5hgltdKDTQUK/po+kl+gu7QSCOP6WhnUgO09+FkN+z9Xj
        dP0BiEFQ==;
Received: from [39.110.237.146] (helo=[10.19.62.132])
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <cyndis@kapsi.fi>)
        id 1g3InC-0005eJ-8a; Fri, 21 Sep 2018 13:36:10 +0300
Subject: Re: [PATCH 3/9] soc/tegra: pmc: Add wake event support
To:     Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180921102546.12745-1-thierry.reding@gmail.com>
 <20180921102546.12745-4-thierry.reding@gmail.com>
From:   Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <62b40f71-a731-24d5-14c9-c3bdb4305695@kapsi.fi>
Date:   Fri, 21 Sep 2018 19:35:59 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180921102546.12745-4-thierry.reding@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 39.110.237.146
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2018 19.25, Thierry Reding wrote:
> ...
> +	/* route wake to tier 2 (XXX conditionally enable this) */
> +	value = readl(pmc->wake + WAKE_AOWAKE_TIER2_CTRL);
> +	writel(0x1, pmc->wake + WAKE_AOWAKE_TIER2_CTRL);

This doesn't seem right

Cheers,
Mikko
