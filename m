Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D8BC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 21:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0ED62175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 21:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="CoGlOMn7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbfA1V0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 16:26:35 -0500
Received: from mail-yw1-f52.google.com ([209.85.161.52]:33671 "EHLO
        mail-yw1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbfA1V0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 16:26:35 -0500
Received: by mail-yw1-f52.google.com with SMTP id p65so7371087ywe.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 13:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=doeprTD75a3wN3TW5uXx5DNXAT9rchfp4Kk5IuJTQxU=;
        b=CoGlOMn7uIwWJDcMJfm+Rj/Qm/gD747PAjoLMDuaAsDCqLhZQSn/JpFhVuDGuDVsjF
         ZCc8zkEIpRrNHtUDlnkc1025YEepn5whj5fHLPPzwg/nGaOXJ4pD5bxCR2wI5TuxUC48
         BWSV8pZ8PCO4Myh5kKyI+tOm9WAx/oi7OMNMgHZUxJn7ycktWfXZZsol5OtiRFtjo1HM
         WCiToVrQxB7D49DqB2cfga9Imv1GfrUhMWjHVChx4ubG1zTMX4qOhNIsAbTi2dC5vikw
         xTOivor07e6gs17gDt22abifNO9qMz2FPPi8SCfL2ZFPvFyjHEY7VVO+xC22K209SvVq
         OA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=doeprTD75a3wN3TW5uXx5DNXAT9rchfp4Kk5IuJTQxU=;
        b=uX5/ojJPSKd4K5L2N9xbxIPiD9/1pZXmCwHtGE5vVViLDDpvXn4+sJccfquCIi6dWN
         hijqMnLKeOj4S7AflGzqjmXNgPfqFmBJMEinEUcRGpOu9VyxPDynTlniCdO0vl3SUEdB
         k5N5SmK5GjnR4H2Gjy02Z8p74z38eSdGXSbBKcVk2N43JAXQp/ooc06y9wzDadXCjbMd
         4dVRPTDRjsm/BuTDOcoL9E84DrmtiBmm0FDqd/5tTzBNrKZCIMruz7kByJyISSvuP8mn
         La5ZTKvge2mDbdRYM+klhWEQ3nnSMPe3NS0htsMDk/5njWzcxYEgd87Eg/+7ipzqGq+D
         DGKQ==
X-Gm-Message-State: AJcUukfcUhXHdGtXNE+BulQJ5omSpcHUYIdeGF3BU7IEH7yTMhBOj9X7
        RPbRc7blv6Egwccvh1f2Yg7Fsw==
X-Google-Smtp-Source: ALg8bN44vJXUgSafJIwnnLviacYE7rvHH/Jn6crYS91qDV9NBrrZWH6O6kmvBO1Sv1E4zJ1C7+B4zg==
X-Received: by 2002:a81:3d3:: with SMTP id 202mr22391227ywd.18.1548710793942;
        Mon, 28 Jan 2019 13:26:33 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::5:42c8])
        by smtp.gmail.com with ESMTPSA id e3sm14662632ywe.63.2019.01.28.13.26.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 13:26:33 -0800 (PST)
Date:   Mon, 28 Jan 2019 16:26:32 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     gregkh@linuxfoundation.org, tj@kernel.org, lizefan@huawei.com,
        axboe@kernel.dk, dennis@kernel.org, dennisszhou@gmail.com,
        mingo@redhat.com, peterz@infradead.org, akpm@linux-foundation.org,
        corbet@lwn.net, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v3 5/5] psi: introduce psi monitor
Message-ID: <20190128212632.GD1416@cmpxchg.org>
References: <20190124211518.244221-1-surenb@google.com>
 <20190124211518.244221-6-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124211518.244221-6-surenb@google.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One thought on the v3 delta that I missed earlier:

On Thu, Jan 24, 2019 at 01:15:18PM -0800, Suren Baghdasaryan wrote:
> +/*
> + * psi_update_work represents slowpath accounting part while psi_group_change
> + * represents hotpath part. There are two potential races between them:
> + * 1. Changes to group->polling when slowpath checks for new stall, then hotpath
> + *    records new stall and then slowpath resets group->polling flag. This leads
> + *    to the exit from the polling mode while monitored state is still changing.
> + * 2. Slowpath overwriting an immediate update scheduled from the hotpath with
> + *    a regular update further in the future and missing the immediate update.
> + * Both races are handled with a retry cycle in the slowpath:
> + *
> + *    HOTPATH:                         |    SLOWPATH:
> + *                                     |
> + * A) times[cpu] += delta              | E) delta = times[*]
> + * B) start_poll = (delta[poll_mask] &&|    if delta[poll_mask]:
> + *      cmpxchg(g->polling, 0, 1) == 0)| F)   polling_until = now + grace_period
> + *    if start_poll:                   |    if now > polling_until:
> + * C)   mod_delayed_work(1)            |      if g->polling:

With the polling flag being atomic now, this "if g->polling" line
isn't accurate anymore. Since this diagram is specifically about
memory ordering, this should move the g->polling load up to where
delta is read and then refer to unordered local variables down here.
