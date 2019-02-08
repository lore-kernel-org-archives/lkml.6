Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1432C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A008320823
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tHMN6Tbq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbfBHKbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 05:31:37 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42189 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbfBHKbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 05:31:36 -0500
Received: by mail-pl1-f196.google.com with SMTP id s1so1490562plp.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 02:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jQnRx3jx5kYsooGE4xB5m6f/htvos/xPbonT7mCMh08=;
        b=tHMN6Tbqvn21LH6TvA+OkWD7py028QbowNl4w8mKnkh61EBxige+sFElIajBUP1dhb
         CFhGa7KzOQ/aUoVM/jSiySREUTIGsw1cbnN6gi3zLFEwMCdt/72kvG95r1PEWA4lxjio
         oujexO60Hxw4/s4VhV71msA19nl5SnsQ7RRUxqa8OsG+X/3c/WoBnKoDJiDIBIsEr84l
         WBQaBe9AFgM0l/96A61eQRQzPWiX+IXJ/Ru5m1WwcmXejaN1cKxKdp8iWmqmuqiuEh8M
         4zZOrJO1fT6mxWFAgW8qSXXfVwZoZJi9Pohju7Jei2oUV0pRw7b7mavplc+YVBt1fBSw
         G0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jQnRx3jx5kYsooGE4xB5m6f/htvos/xPbonT7mCMh08=;
        b=jOG+xlmqwItBNpXcC7gE3+iJHznaZ8ECKHwTK3+1LDrf7RQe10oalxqXrlDxfzEz9f
         ORbWRAeQo9mt09b3Z3MJfXfFY+NzGP7DTrQ3hpxMIwPvmIMF0juK15qks51/vi5IU9h0
         r2BU4kod614mqu5XifH2/VrhmFRdAb5KZSYDFLVjj4bTO5USojOw/KVjn/2eCCbaK4Hb
         gA/m2jtgaSDtS5SxY6QbkfLFT2EnPpuM31uGbzA7J5jrdo5LWdzvhB3GeaDMMz4Bj4P+
         pvGHVMKKZmCWuYV1N/uyjFmFLdHrHzmwkcKTvVOBPr4gvjaZ7/Ul0xXv57865G6OIA42
         otMQ==
X-Gm-Message-State: AHQUAuYMRyeUPnhUmpaWitVsSb+p6jXKQj97vOL9xQOjj08vgnObErPk
        E//xxh1uPTzO/ituTf7uccedkBTLRts=
X-Google-Smtp-Source: AHgI3Ib1aZZDD+M8dZcbzo29u3xbWG68tp+SRgg7Q45p/vDqZ1JOTyKgPuHmK1XGGF/4se9xpO+CWg==
X-Received: by 2002:a17:902:1aa:: with SMTP id b39mr18960186plb.244.1549621896209;
        Fri, 08 Feb 2019 02:31:36 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id y5sm4786244pge.49.2019.02.08.02.31.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 02:31:35 -0800 (PST)
Date:   Fri, 8 Feb 2019 16:01:33 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/2] cpufreq/opp: rework regulator initialization
Message-ID: <20190208103133.ysvaroyniuc3k4i5@vireshk-i7>
References: <CGME20190207122255eucas1p1cdebed838c799eca46cce6a654a26187@eucas1p1.samsung.com>
 <20190207122227.19873-1-m.szyprowski@samsung.com>
 <20190208064957.zhyue42kpgaoslwm@vireshk-i7>
 <CAJZ5v0iU1+YdAqHai+r_ubC1FarC2JWBuc98MG58n+y9=1WB=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iU1+YdAqHai+r_ubC1FarC2JWBuc98MG58n+y9=1WB=A@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-02-19, 11:22, Rafael J. Wysocki wrote:
> There are cpufreq driver suspend and resume callbacks, maybe use them?
> 
> The driver could do the I2C transactions in its suspend/resume
> callbacks and do nothing in online/offline if those are part of
> system-wide suspend/resume.

These are per-policy things that we need to do, not sure if driver
suspend/resume is a good place for that. It is more for a case where
CPU 0-3 are in one policy and 4-7 in another. Now 1-7 are
hot-unplugged during system suspend and hotplugged later on. This is
more like complete removal/addition of devices instead of
suspend/resume.

-- 
viresh
