Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E2EC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2FC9208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fq2KFFgk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732424AbfACQxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 11:53:49 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:41013 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730564AbfACQxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 11:53:49 -0500
Received: by mail-ot1-f52.google.com with SMTP id u16so29875541otk.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 08:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=9HetobJ2I1SFgAdtFTpBsa5bVtw6e77ye3OO0zrcWT4=;
        b=fq2KFFgk0gAxDttQby3mse7ckY++OM46n2teYr77nitp+azwX7IF7t5ea2x4vmJTZh
         BqjXeT/n+5JP/gfQ8aG9FLydp0dvL5bceTxMVyY6sJCNOHGAAn1R8j5V9Hb1Ql3A9H+T
         QBhXKfyg0j2SLKtTjJasJV0ON5Tb1Hl/RPbEPZlK4DAloY/Gz1B6Q/xXXe/U9kKJZHTg
         wjRWswbWpoa/yfovqyHnXfkPvFOR4uli/Qw8Pe0+zYSr8q6eboD2jLQmBMEtkC+fzyi9
         xOwXX0XImKPihL0DL7/dGNMdnc8QwWCxBq4jto2obAjBiJVrX4LRvNSRl+v/PPLKcpWe
         FkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=9HetobJ2I1SFgAdtFTpBsa5bVtw6e77ye3OO0zrcWT4=;
        b=WrP78ZRC9h40qEunoZLXp0GnyKh2jGrybYlPB4seiZcf0VCBoZVp3anDRVwghyT4kM
         XecsvXnClSjiGps0jxt9kbIHa/TPz4hefKqhOD0i9KH65Cps+8CgA5Tfy5zGk4r/3kb4
         wtUuTEc+aFHkihFSMS3avPQPIikpPCqB+QD9Si/xW4EsVI4qCJO/n4Zke4HxAfRYbcrf
         PHCshZxEnLgyqAGePuWG6Q9ntjPypNM12tlyY6IOjs9ag947jYfAeRnMDQolcGfkfq/6
         OEeLfDZf1zWHAzXepMV6M3Bn/8/08RwZgiM8BmCDYXg50YPqqBfU3JChrY/PTF/IrXIs
         cUiQ==
X-Gm-Message-State: AJcUukcptCV6KJXMu8ggO/loPa0IGPtT9YMLa8ZiU2oG+7R7/PPhoGDN
        GR+P1XGuLs251b95epl8BInApBij14ADfFnhw4fDbFnC
X-Google-Smtp-Source: ALg8bN6Rj+g3c7zO0QGHCCkvgTGxLRVlGXE96vNRQ94po/R0wAp/8iEceluUHKPcRq+HVOre4gun1jw8GGqxfbUTnRY=
X-Received: by 2002:a9d:4b17:: with SMTP id q23mr34002991otf.121.1546534427291;
 Thu, 03 Jan 2019 08:53:47 -0800 (PST)
MIME-Version: 1.0
References: <CAMe9rOq0K62wcXC76xn10Rb+Ry1p+M4wB5MCNA5QF9oUGZJZSA@mail.gmail.com>
In-Reply-To: <CAMe9rOq0K62wcXC76xn10Rb+Ry1p+M4wB5MCNA5QF9oUGZJZSA@mail.gmail.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Thu, 3 Jan 2019 08:53:11 -0800
Message-ID: <CAMe9rOpvs4-06unwnkPaMuAR6Ks4N4UwfkzmxLBSU0Q_4cRAww@mail.gmail.com>
Subject: Re: commit 0e334db6bb4b1fd1e2d72c1f3d8f004313cd9f94 breaks timer
To:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 30, 2018 at 6:07 PM H.J. Lu <hjl.tools@gmail.com> wrote:
>
> On 4.19 branch,
>
> commit 82c8dbb376b9fa9b831c157cbb15664cb4a343e3
> Author: Thomas Gleixner <tglx@linutronix.de>
> Date:   Mon Dec 17 13:31:05 2018 +0100
>
>     posix-timers: Fix division by zero bug
>
>     commit 0e334db6bb4b1fd1e2d72c1f3d8f004313cd9f94 upstream.
>
>     The signal delivery path of posix-timers can try to rearm the timer even if
>     the interval is zero. That's handled for the common case (hrtimer) but not
>     for alarm timers. In that case the forwarding function raises a division by
>     zero exception.
>
>     The handling for hrtimer based posix timers is wrong because it marks the
>     timer as active despite the fact that it is stopped.
>
>     Move the check from common_hrtimer_rearm() to posixtimer_rearm() to cure
>     both issues.
>
> caused:
>
> https://bugzilla.redhat.com/show_bug.cgi?id=1662602
>

I opened:

https://bugzilla.kernel.org/show_bug.cgi?id=202123

-- 
H.J.
