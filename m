Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9235AC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42DC62080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i+/YFwdD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42DC62080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbeJ2WKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 18:10:19 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33400 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbeJ2WKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 18:10:19 -0400
Received: by mail-vs1-f65.google.com with SMTP id 125so5201825vsi.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 06:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rWirhtKcMKmvjZeoLSoMY+H/UBnDbrqsTL5eaRAtbbg=;
        b=i+/YFwdDAWLMWttljofE0hQ7eTR9nlDUVDOc1W47u2qDyMcRDUKnNenZ5of5S2P4Uy
         1pBSJPsV3rztN86yJyNF9zXyeK0FHnhN0hrFKSJaSld7Yn24lCguoA+cX6fNTSLBgjsq
         54sYMiqel3GS2nCw8RVfaiLhlWBLn+usg9iQKgz22XTUVE8GaaQUyR7JItNNx50mE1d8
         M0VP9vOPpPLJcqjgcrNHa1lRQALs+YTRsBDxc2U7CaalpsQYZOQud3v5KHrpUkrs0h5h
         FEjEvmx6ON0DHNTEX7a+Ns4ayS/ba/FZUXUeJYue7J/En2VvNAWNEXouq3xsg0IpZf5f
         JvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rWirhtKcMKmvjZeoLSoMY+H/UBnDbrqsTL5eaRAtbbg=;
        b=DwVh5vwBgRfwqqzLV8G3R0YDx5LN9LP/M+wsLVo52u2d9cXH6uLtf56GwxROuJWseb
         XkEj1UZ88rbSmdYW2ZzQ7VwuAfmk/k1cXKU/fKdP8Tea6PRpSkY5OKhsq+atTuQCQLPT
         FsD8nwXypKINMvf2IJ+OjyD/1BJu1j1/F4aipEZEKkvungn59rXSYk3AG65S78/8YYbu
         FfhcP1wkFfdd4RHLEd8u7rNRtHV2H+Uw9RL8GevsByJFdbNfaivTSR3qm9l40NW47jCm
         TTrEspGCBdtjvY8brbOuFS+z4gceUta3vMYF7YECDKBHpjgYAvXvEBF0Nm1ZbFq8CRZi
         m6Lw==
X-Gm-Message-State: AGRZ1gJ3nFo4l5FinjzmkgB+JSBbegKySEkiX+YDNOF+o9J6YaQmj5Q1
        uZjmZXtf2iSH+FF1dBHRdZ9mAPGbM9aIR4hC285bpw==
X-Google-Smtp-Source: AJdET5d1kbsDsn+iFSDaUQsy8W7WmkXoLAfF0BHqb99mkjZrvFTVI3aG759UfU3j2aTR5zrUF+V4SBj55Kdd2QADjqo=
X-Received: by 2002:a67:7082:: with SMTP id l124mr373572vsc.62.1540819298635;
 Mon, 29 Oct 2018 06:21:38 -0700 (PDT)
MIME-Version: 1.0
References: <20181022202901.1654-1-zwisler@google.com> <20181024072227.achkbix2ndef2ule@vireshk-i7>
In-Reply-To: <20181024072227.achkbix2ndef2ule@vireshk-i7>
From:   Ross Zwisler <zwisler@google.com>
Date:   Mon, 29 Oct 2018 07:21:26 -0600
Message-ID: <CAGRrVHw=Hkch+U9Unrw0DCOWxddCx239hSEbvQTM=xrto1ekoA@mail.gmail.com>
Subject: Re: [PATCH] thermal: add ratelimited thermal and power logging
To:     viresh.kumar@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ricky Liang <jcliang@chromium.org>,
        amit.kachhap@gmail.com, daniel.lezcano@linaro.org,
        edubezval@gmail.com, javi.merino@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, Stephen Barber <smbarber@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 1:22 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 22-10-18, 14:29, Ross Zwisler wrote:
> > From: Ricky Liang <jcliang@chromium.org>
> >
> > Add thermal logs in devfreq_cooling and cpu_cooling.
>
> Why should we add them ?
>
> > Also add logging to
> > power_allocator when it starts to control power.
> >
> > These changes can lead to excessive log spam when running up against
> > thermal limits, so have this logging ratelimited to allow only 1 log each
> > 30 seconds from each of those subsystems.
>
> What's the use of these logs when we are going to print them only once every 30
> seconds ?
>
> I recently extended thermal sysfs support to share more stats.
>
> commit 8ea229511e06 ("thermal: Add cooling device's statistics in sysfs")
>
> Will that be helpful in your case ?
>
> Otherwise we should probably add trace points instead.

Thank you for the review.  Basically we use these prints to get a
notification when a system is having thermal issues.  It's easy to
look in dmesg and see the prints and know that something temperature
related is going on.

However, I agree that the current solution is a bit hacky, and in
looking at it a bit further we don't even cover all the paths that we
need to.  The processor_set_cur_state()  function in
drivers/acpi/processor_thermal.c, for example, is used on the x86_64
systems I'm testing with and wasn't augmented with prints.

I'm going to take a step back and try and find another solution.  The
info you added to sysfs looks very promising, thank you for pointing
it out.
