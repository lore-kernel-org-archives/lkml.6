Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3EEC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80FEB20850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80FEB20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbeLCMg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 07:36:56 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35006 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbeLCMg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 07:36:56 -0500
Received: by mail-lj1-f196.google.com with SMTP id x85-v6so11211861ljb.2;
        Mon, 03 Dec 2018 04:36:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=e2ZZboa0/S/88d4dippsMLvu2YeLmEySoB3OrVg1YKY=;
        b=OZEk6QKU1yyfpc+vhOaDsy2y5zdj2ut5wTD/7xJIPep9/317+OLGgfasa4nLuA+UEo
         i8jPNVV17hNJQ6Vqwfo72lxDeOnC3mjtvsOZXFIyasFBeYpklNQTs+KSrZoBRjPrpiUg
         sWUDOJ4x6mWXOIP5LJpSz0+FtE7Q/aopPu90ENnVkTTHwLGjrluDCVUTRxCgJmkgikzH
         svJrYAxLeQ15REs7eSLMClcsiBewretplO2CNAW5+GKDPj6eybzNZe3F0e4ZbqgKW7YV
         tqo/TdS09VNaDhIcTWySkC4mXRpkw5HYkJ4AD38/F9L6fYKU4paMfFO68iJZZodpngFL
         WWNg==
X-Gm-Message-State: AA+aEWZzYojkShypd0zs8Tp4ob2XeDbuWvdtRJXUc0mGwYdz9NbddKHd
        tXTYl/4MfXDu7S2OqrKzT84=
X-Google-Smtp-Source: AFSGD/WKno3TzxpUH7ftPXIf+DzVWej+ReIKPP9GyBzEhXJ/k3E7jhAK8oueeTkplgNWzkYjFRh8jg==
X-Received: by 2002:a2e:5dd9:: with SMTP id v86-v6mr10566492lje.86.1543840561860;
        Mon, 03 Dec 2018 04:36:01 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 4-v6sm2417282ljw.84.2018.12.03.04.36.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 04:36:01 -0800 (PST)
Date:   Mon, 3 Dec 2018 14:35:58 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     mazziesaccount@gmail.com, mturquette@baylibre.com,
        sboyd@kernel.org, cw00.choi@samsung.com, krzk@kernel.org,
        b.zolnierkie@samsung.com, linux@armlinux.org.uk,
        andy.gross@linaro.org, david.brown@linaro.org, pavel@ucw.cz,
        andrew.smirnov@gmail.com, pombredanne@nexb.com,
        sjhuang@iluvatar.ai, akshu.agrawal@amd.com, djkurtz@chromium.org,
        rafael.j.wysocki@intel.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 0/9] clk: clkdev: managed clk lookup and provider
 registrations
Message-ID: <20181203123558.GD15388@localhost.localdomain>
References: <cover.1543837442.git.matti.vaittinen@fi.rohmeurope.com>
 <20181203121951.GP26661@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181203121951.GP26661@dell>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi de Ho Lee,

On Mon, Dec 03, 2018 at 12:19:51PM +0000, Lee Jones wrote:
> > Series add bd71837/bd71837 PMIC clock support + managed interfaces
> 
> You've send me a cover letter and no patches.
I am afraid the patches may be still on their way... I added recipients
to git format-patch via command-line so you are probably included also
in patch mails :(

> 
> I suggest that I should not be on the addressee list at all for this.

I'm terribly sorry for spamming! I must've done some mistake with the
get_maintainer.pl as I copied the recipients from that output. I may
have accidentally included some old patch to maintainer query.

> 
> -- 
> Lee Jones [李琼斯]
> Linaro Services Technical Lead
> Linaro.org │ Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog

-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
