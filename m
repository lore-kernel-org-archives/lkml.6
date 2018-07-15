Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A42ECDFB3
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 22:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84ABF2089D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 22:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zm5hkkrB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84ABF2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbeGOXXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 19:23:23 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50256 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeGOXXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 19:23:22 -0400
Received: by mail-wm0-f65.google.com with SMTP id v25-v6so13351598wmc.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 15:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R0HTxfQLHIGBhGHQdcDuF2WSlfyWyL5x5araBZcNpdI=;
        b=Zm5hkkrBdIOw79lSob5l4p5Yi5AgU1vl/ATLexCeDdqCnN63D+JRgfpwvBQxPXaHJA
         SyorjluQ5D9zsW5E2OEK0RqLFlO5bHD3kdE0oGM5xhcKfDHA1ugi32YLFgm14J58Ntvz
         79P9B/NsIg6Q3oMEmUiJzu9Ivtfor0m+bTk69AhUXdc/VTsCm1Rm7zhYnOWkHLjQr062
         yR9+pThiYwmIMLLZjRM/prQGIc4wA9nwZmicKCHe/rv2qSxlDJrrqHOGAt6ZC2oxVNw/
         yVdfh6ObTdqOP8+P+bsXgV5GmFxvjjBU8CLQqhP5yTLSKcC9B1M/pbHBl//Mqqubog2P
         DfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=R0HTxfQLHIGBhGHQdcDuF2WSlfyWyL5x5araBZcNpdI=;
        b=hmMVv8okHTo8kv5dWSanFyInYr2XwL7Yqx2WAtdkuaLEPSXM6xF/e/mYx8hokxJZBz
         OuzekXxmPsrnhauLk9t2m4LXilpkdFVOixBzWVLWpBJHSuo8jEAFvSq0jECpSJCNxv+Q
         Aic2R6K3PDsoHGyAayvjdNmNUdsDAW/LPCzVFLdbNz2BOF73CDzGfJ70+Ge3WZuLzDNo
         yYcVHWM8ycfBrIffAMbznG1gqnUSF3TEnAYdvnk3J08Q+jxKU8v45xLWohe192nRMriL
         08C3Wu5CzCrHcfbisZf0f8dtrXhE68pebajwejcxSFmL0MGVbleN9AW4qmPeZ3jlymNY
         IHfA==
X-Gm-Message-State: AOUpUlGEPrJNxPjcm2EzNMXr/tmykDR8NGQvtD9t9YX7MR/W52ExSyDL
        D3xtkoZ4pGgZgchLnn4Zdto=
X-Google-Smtp-Source: AAOMgpdHs6fqiw4kWcdyWnf8OU4aFtfbOfR3DCfNq2DJXSolnAeN+1Y52eSbEAsRHtjUQ3GlpeEiHQ==
X-Received: by 2002:a1c:dc89:: with SMTP id t131-v6mr8916686wmg.50.1531695532003;
        Sun, 15 Jul 2018 15:58:52 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id e12-v6sm25530223wrt.29.2018.07.15.15.58.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Jul 2018 15:58:51 -0700 (PDT)
Date:   Mon, 16 Jul 2018 00:58:49 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Dirk Gouders <dirk@gouders.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/boot: Fix if_changed build flip/flop
Message-ID: <20180715225849.GB30102@gmail.com>
References: <20180715025626.GA48623@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180715025626.GA48623@beast>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Kees Cook <keescook@chromium.org> wrote:

> The if_changed kbuild function can only be used once per target. If not
> it will effectively always trigger, flipping back and forth between the
> two commands getting recorded. Instead, merge the two commands into a
> single function to get stable build artifacts (i.e. .vmlinux.cmd).
> 
> Reported-by: Dirk Gouders <dirk@gouders.net>

What actual symptoms does this bug have?

I.e. it would be nice if the changelog started with such an explanation:

  Dirk Gouders reported that .... <bad stuff happens during kernel build> ... 
  and bisected it back to:

    98f78525371b ("x86/boot: Refuse to build with data relocations")

  The root cause of the bug is that the if_changed kbuild function ...

Or something like that.

Thanks,

	Ingo
