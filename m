Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FF5C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D1092184B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWz7ODWJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfBEXta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 18:49:30 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46791 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbfBEXt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 18:49:29 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so2097379pgp.13;
        Tue, 05 Feb 2019 15:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N4wOipzkCSIyo2C5ZbXO3shYgkTZDlfFF5yXa/fbo30=;
        b=hWz7ODWJazbVBxt/3cwdBuj4PFV8acej4b+aBCJ+0cLaKP4s96zjkW2OUK/LAaRGAZ
         agKuKh9iW888J70IjGWbZRz6eMP+3eqWck9PP/AOYWXi3y1c4ebx9KveBh5G+vZ9xOtu
         ThlwmPuXzaVkRTty/UTB+O0wVaGvyrTKr3Snhg54RtM1nrCGHfvuMcmHVZJHVEcSeyRh
         gzMq1uGnFLb4hp9oHBgSbvukctk5gAcoVVX4yiosmN260WtOS3MSCJPLGeZRoD74XN/W
         y8qdESg6JEBR+Q1UZB3sT0vluPkJz4lAQiSyUB5/pNsPjNYzG4vBLl6EWbX/EV0YJ84k
         52CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N4wOipzkCSIyo2C5ZbXO3shYgkTZDlfFF5yXa/fbo30=;
        b=Cl40Kt/W7YMWtCJXddON5ncQSeVRabQ0+RwY7NMXmWhMpnmpWH36MIRYh4WA+jNPCJ
         HT+9wAbuXYs99lHzDSQDlKi58zefqhIqCKmvFpMx/rwG5LvRJ4hZVbOIOh8DMjfK+GY0
         DHa67GFfOLqTD9KnS/nPj7ZSc6i4o2LX19sLJ+p7GYx+fQEoSUQphK/siY5VVGVHor1l
         KY9Wsrn+aykkFumLcNhk7KpevtQkD0SGloY5kXCSzYZ4sd2HAR3GoeEdjdJyzOvOT83N
         eHowH1NCkd7jcW6rc9tCJkpvl4U8zAeSX7dF/EsEziNV//EfPfJe4ogj8BEBvIEiVI1g
         TvMg==
X-Gm-Message-State: AHQUAuYlNrbv3l8HPu8txiuj/8hhsmIrfl1DDNYgPAIOuZjJD8/CXB2F
        h5Kloxf16qufiBFzSxgzq5Y=
X-Google-Smtp-Source: AHgI3IayUi5VvnX6xVDxGsd2YfgP/cKHPOK8r0pPbxHLlXL6ohcXCiHlHC6dFi4TlSUfafSL07cQlQ==
X-Received: by 2002:a62:64d7:: with SMTP id y206mr7622609pfb.84.1549410569048;
        Tue, 05 Feb 2019 15:49:29 -0800 (PST)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id s84sm12725535pfi.15.2019.02.05.15.49.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 15:49:28 -0800 (PST)
Date:   Tue, 5 Feb 2019 15:49:26 -0800
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v1 0/2] thermal: trivial fixes to error messages
Message-ID: <20190205234925.GB4768@localhost.localdomain>
References: <cover.1548063429.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1548063429.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 03:12:21PM +0530, Amit Kucheria wrote:
> Fix up a couple of error messages
> 
> Amit Kucheria (2):
>   thermal: of-thermal: Print name of device node with error
>   thermal: cpu_cooling: Clarify error message
> 
>  drivers/thermal/cpu_cooling.c | 2 +-
>  drivers/thermal/of-thermal.c  | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Collecting these.

> 
> -- 
> 2.17.1
 
