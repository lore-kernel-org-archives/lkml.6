Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3810FC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16EEC218FC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387464AbfAaNY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:24:59 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43924 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbfAaNY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 08:24:58 -0500
Received: by mail-lf1-f66.google.com with SMTP id x201so1000237lff.10;
        Thu, 31 Jan 2019 05:24:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e1Bd1cCVqTtCOw27nTYpAu2mxybnfDj+re/fe+Iiy0g=;
        b=ME5eEY6nCZC2oPejOU4yDsYSJCxawItY4vnpOinPdu62rWytQ5mUBztKap4MojBHyg
         9VV0tv99pTPqCS7o9A/QfLgqvw7ukhLdfffB17DMMPET/DsxT53Ts/w+biuZlP5aws/w
         73xXJ/6OlcSuE7T+IH4LF54/KRHs/LTOBQrrWgj0rZ3Mr1UMuaF42Spqi6vToIVMJ+Fv
         4mEdq2zZG0QtIFSXPFf20t/e32t1apW2kVyQapzRztPVlescxKYRgTZAQ5ivX4XNg4/z
         xbnzA7NiTj/4HQiiavVfDGu7FCeYirrZTAKZ8KQvabIJu6tRZue3omYn6jlyuAaacXnL
         bB0A==
X-Gm-Message-State: AJcUukd8YsNUSeZ5Zsy8YpQEnEWoceeY8zni6s/cZwI6FaOQP1s1yWar
        qgRfa/7WYYc47RADFhlersI=
X-Google-Smtp-Source: ALg8bN4efzqtBk1zd7HtH/kCne6U5aCoxdZyUXqayOQqlVDcECcmH/i/TG1Cqmbq+QuGZ7JWafBieA==
X-Received: by 2002:a19:e601:: with SMTP id d1mr29038753lfh.71.1548941096383;
        Thu, 31 Jan 2019 05:24:56 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id a2-v6sm803332lji.13.2019.01.31.05.24.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 05:24:55 -0800 (PST)
Date:   Thu, 31 Jan 2019 15:24:52 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com, corbet@lwn.net, cw00.choi@samsung.com,
        krzk@kernel.org, b.zolnierkie@samsung.com, mturquette@baylibre.com,
        sboyd@kernel.org, linux@armlinux.org.uk, pombredanne@nexb.com,
        sre@kernel.org, vkoul@kernel.org, linux@roeck-us.net, pavel@ucw.cz,
        sjhuang@iluvatar.ai, andrew.smirnov@gmail.com,
        djkurtz@chromium.org, akshu.agrawal@amd.com,
        rafael.j.wysocki@intel.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 0/3] clk: clkdev add managed lookup registrations
Message-ID: <20190131132452.GD23791@localhost.localdomain>
References: <cover.1544177090.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1544177090.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

On Fri, Dec 07, 2018 at 01:09:00PM +0200, Matti Vaittinen wrote:
> Series adds managed clkdev lookup interfaces and cleans few drivers
> 
> Few clk drivers appear to be leaking clkdev lookup registrations at
> driver remove. The patch series adds devm versions of lookup
> registrations and cleans up few drivers. Driver clean-up patches have
> not been tested as I lack the HW. All testing and comments if
> driver/device removal is even possible for changed drivers is highly
> appreciated. If removal is not possible I will gladly drop the patches
> from series - although leaking lookups may serve as bad example for new
> developers =)
> 
> Changed drivers are:
> clk-max77686 and clk-st
> 
> Please note that the patch #2 requires this change to work correctly:
> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/commit/?h=clk-next&id=05502bf9eb7a7297f5fa6f1d17b169b3d5b53570

I guess the dependency mentioned abowe is already in (most) of the
trees. (I can't say for sure as I don't know what is the correct tree
for clkdev - is it linux-arm.git as Russel is maintaining clkdev? If
yes, then the commit 05502bf9eb7a7297f5fa6f1d17b169b3d5b53570
"clk: of-provider: look at parent if registered device has no
provider info" seems to be sitting in maser branch).

So should I rebase this series to some other tree and resend? Or is this
something that is not wanted?

Br,
	Matti Vaittinen
