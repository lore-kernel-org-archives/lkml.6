Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA073C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE9A208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="IcADuw+7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE9A208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933457AbeGIVrf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 17:47:35 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38665 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933118AbeGIVrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 17:47:33 -0400
Received: by mail-pl0-f66.google.com with SMTP id b1-v6so6627010pls.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 14:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=Rofgg6LyOlxz1yL9uitpAah5tKtuLU66A3CJlqSriT0=;
        b=IcADuw+7lXK4HXGnNrYUU7tOE6HaxJXVmZrGnfw5Snec92j61L4GUfD1iimb+ZyfzN
         0gyfzpxEPIF5KGBbJaYwQPvK4hkCXb/XueA3VarrhXAOGRppwskMb9RzRoZkus+LL3G6
         jcEumO+M0d5W6Fy4BDTpbE+RmbCPhMLguBGZCPJRn+GehgszDcdNBAzpUTPWahXn/p5I
         gsHBDY3tRM1egBvH6d4wQSQjj7phWzVamORmLsbJE1ETucMs7qeLpypxpgbOXKoSSi2/
         RWE3j6Ec9wAb/lSpqiwWrCzaU828O7QfHdF9O4DD8TggH7mm3ddHropA1ixtGH/9aBt2
         q1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:organization:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Rofgg6LyOlxz1yL9uitpAah5tKtuLU66A3CJlqSriT0=;
        b=kHdyK9+2vpZXPQljK0n7cmuUF/3/o6s4iLiV2bmvQ1ZAAFa/4zfs7wCXO+0ZrzbsvL
         BCR83VDGmoDB/PX1pXc+WRMdFPw/JDn6DU93aOzcESn1pmMN0zM0uqAMfhXb//I/xBjs
         1p4jCZCq3huF5gZxZClvtauUey4SJ6dlYSpFU1bGJskyGklOCGBeMUwhdlwn9ww7bg3Z
         i/hbFY0Mjsvoy4W7t/YuXEmFqew4Tsrn1Ffms/oilms2HsG0DKY+i+lIIHq0yIcM8GZC
         6SDMcYzGKSSbtKMts6VsjSPJjWAtXAXxYibx2uQ2ZeQcrTweaFg0ZEdN8xMc4hT5qSdg
         ZeWw==
X-Gm-Message-State: APt69E3ajrhux9n/KraTpQVV8AqK+Ge6dV3+XupXET3P6BaLhNMrbdn2
        BgqFwGfKJU+5UrnCEX3AqyKblw==
X-Google-Smtp-Source: AAOMgpez4f2YRTn+UJcMDhUUKcshkCROx5PxgvkaPanxJh/3xZtXfaKCRf1u7wijZ6zM0q7pg8Nf6w==
X-Received: by 2002:a17:902:8c84:: with SMTP id t4-v6mr22550583plo.100.1531172852447;
        Mon, 09 Jul 2018 14:47:32 -0700 (PDT)
Received: from localhost ([98.237.141.101])
        by smtp.googlemail.com with ESMTPSA id k13-v6sm45191605pfg.130.2018.07.09.14.47.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 14:47:31 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Yixun Lan <yixun.lan@amlogic.com>
Cc:     Xingyu Chen <xingyu.chen@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2] ARM64: dts: meson-axg: add saradc support
Organization: BayLibre
References: <20180702222515.13924-1-yixun.lan@amlogic.com>
Date:   Mon, 09 Jul 2018 14:47:31 -0700
In-Reply-To: <20180702222515.13924-1-yixun.lan@amlogic.com> (Yixun Lan's
        message of "Mon, 2 Jul 2018 22:25:15 +0000")
Message-ID: <7hmuv0nkss.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yixun Lan <yixun.lan@amlogic.com> writes:

> From: Xingyu Chen <xingyu.chen@amlogic.com>
>
> Add the DT info for SAR ADC of the Amlogic's Meson-AXG SoC.
>
> Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
> Hi kevin
>   I just re-send this patch which rebased to your khilman/v4.18/integ branch
>   Thanks
> Yixun
>
> nothing changed since patch v1 [1]:

Applied to v4.19/dt64,

Thanks,

Kevin
