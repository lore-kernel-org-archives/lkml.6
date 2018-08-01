Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E0FC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3167620844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="w+Nyr9O1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3167620844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732287AbeHBAjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 20:39:49 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:44276 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbeHBAjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 20:39:48 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 42DD15C0B27;
        Thu,  2 Aug 2018 00:51:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1533163902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ZcLYMbT/8EIYDmG+W3shvRTH3od4ZvdIV+KGDf7g74=;
        b=w+Nyr9O1fPtY/IxGHzL8xnLbh5TrMI5qmHf66YYVf5GiUNrRk299HOysCPDgEO8ekvtH3/
        GDy9PH1pGE0kDHYAXP+VX4CVJOjhiKN4SeeqZRcwMCDAJ/Tzj8QJJBiwtzqzjS0Vjoq18z
        RsiU8Tjuczbw9Si208hhJn+E9df7ElE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Thu, 02 Aug 2018 00:51:42 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linus.walleij@linaro.org, pdeschrijver@nvidia.co,
        marcel.ziswiler@toradex.com, keescook@chromium.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: tegra: readd gpio-ranges properties
In-Reply-To: <2326493.bQHeyqsldt@dimapc>
References: <20180726154025.13173-1-stefan@agner.ch>
 <20180726154025.13173-2-stefan@agner.ch> <2326493.bQHeyqsldt@dimapc>
Message-ID: <17f1c1b1c6d3a83dd1df130420057d3b@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.08.2018 22:51, Dmitry Osipenko wrote:
> On Thursday, 26 July 2018 18:40:25 MSK Stefan Agner wrote:
>> The properties have been commented out to prevent a regression a
>> while ago. The first regression should be resolved by
>> commit 44af7927316e ("spi: Map SPI OF client IRQ at probe time").
>>
>> The second regression is probably addressed by
>> commit 494fd7b7ad10 ("PM / core: fix deferred probe breaking suspend resume
>> order") and/or maybe others. Readd the gpio-ranges properties to see
>> whether regressions still get reported.
>>
>> This reverts commit 4f1d841475e1f6e9e32496dda11215db56f4ea73
>> ("ARM: tegra: Comment out gpio-ranges properties").
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
> 
> Unfortunately the second regression hasn't been addressed yet, this patch 
> still breaks wake-up using GPIO key. BTW, better to spell "readd" as "re-add".

You do have the hardware and could test it?

Hm, that is unfortunate. I think this was the patch which should address
the issue:
https://lkml.org/lkml/2015/9/10/218

--
Stefan
