Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877E6C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 11:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36E632064D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 11:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LzDSs2U0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36E632064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729227AbeJASYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 14:24:24 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43929 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729111AbeJASYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 14:24:24 -0400
Received: by mail-io1-f67.google.com with SMTP id y10-v6so9084851ioa.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 04:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SmKDpSKzy6pm1UpRQBxN8nBMekx7lYvGqZ8aGwNSwPs=;
        b=LzDSs2U0lwoBKan1dIrLylmNIpdWrMyM2p3Zos7LFbkFFSaxWe0bZp+n0JQCbhwdpa
         OlqOVYxBfe9vxhT7iGylT2Ch0sIjDGKE0FGhFFj+ZNWXgisrVOPfrv6QBPUGVMAECu9N
         SCTsPUgAr17A7LKJzh1eje/kv202/X4E9BMFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SmKDpSKzy6pm1UpRQBxN8nBMekx7lYvGqZ8aGwNSwPs=;
        b=KFD/rIBcEOphcyijeAFKrV+/MUa8dDgbbDR1qPaXryTVgDnnO9qvclhknWzK/TSdtr
         /tCarepgmFAH3p8d2qYe8M9M9KtfkregfvVgVBk52NuZJ2/orSEJCC5cRu5rrWfyPcDC
         3nfjQ/vkGtyp21/qlO9bgCC/piSKkMB9SM7NKC3YoJN2cMbd2E+NjbXNMCRe4RIug5Gi
         p1egxuyb23NCMG4STN2aaB2lVIU2ZdWkv+BDkc58x93/gBFZZMEkdo2hKvGmy3pAJRE0
         T3W/VsYlMYndePAoQhpVaW9aANuC8r9+8e1Y7uIAG/Tt1kOaZHJa6Rgj5T3JNUf+2UTg
         R5GA==
X-Gm-Message-State: ABuFfojXuio7nreAsDOxu+FT+KVYK7gfwptKqaesX3JTXFq+ohljea+O
        b/QxJaOv8vl0uX+H1lqjJB1e4HZ1d6ubWFzXcRTo2Q==
X-Google-Smtp-Source: ACcGV60z+monhNWxmX7SiJXkpdhJDt+opl51QF3YYaAhhdnvjOnT0ZDeQZhytIBOAzaRZCb/8oOcUKB4IcEqeEWf2Po=
X-Received: by 2002:a6b:630a:: with SMTP id p10-v6mr6662955iog.175.1538394420080;
 Mon, 01 Oct 2018 04:47:00 -0700 (PDT)
MIME-Version: 1.0
References: <1538212015-10374-1-git-send-email-yanjiang.jin@hxt-semitech.com> <1538212015-10374-2-git-send-email-yanjiang.jin@hxt-semitech.com>
In-Reply-To: <1538212015-10374-2-git-send-email-yanjiang.jin@hxt-semitech.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 1 Oct 2018 13:46:48 +0200
Message-ID: <CACRpkdYG6FK4h8_ZLCWkHSreZPRewEjysiMNtDV2pa4AykuHsw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: core: make sure strcmp() doesn't get a null parameter
To:     yanjiang.jin@hxt-semitech.com
Cc:     jinyanjiang@gmail.com, yu.zheng@hxt-semitech.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 29, 2018 at 11:07 AM Yanjiang Jin
<yanjiang.jin@hxt-semitech.com> wrote:

> Some drivers, for example, QCOM's qdf2xxx, set groups[gpio].name only
> when gpio is valid, and leave invalid gpio names as null.
> If we want to access the sys node "pinconf-groups",
> pinctrl_get_group_selector() -> get_group_name() may return a null
> pointer if group_selector is invalid, then the below Kernel panic
> would happen since strcmp() uses this null pointer to do comparison.
>
>  Unable to handle kernel NULL pointer dereference at ss 00000000
> el:Internal error: Oops: 9600000[ 143.080279]
> SMP
>  CPU: 19 PID: 2493 Comm: read_all Tainted: G O
> .aarch64 #1
>  Hardware name: HXT Semiconductor HXT REP-2 System
>  PC is at strcmp+0x18/0x154
>  LR is at pinctrl_get_group_selector+0x6c/0xe8
>  Process read_all (pid: 2493, stack limit =
>  Call trace:
>  Exception stack
>   strcmp+0x18/0x154
>   pin_config_group_get+0x64/0xd8
>   pinconf_generic_dump_one+0xd8/0x1c0
>   pinconf_generic_dump_pins+0x94/0xc8
>   pinconf_groups_show+0xb4/0x104
>   seq_read+0x178/0x464
>   full_proxy_read+0x6c/0xac
>   __vfs_read+0x58/0x178
>   vfs_read+0x94/0x164
>   SyS_read+0x60/0xc0
>   __sys_trace_return+0x0/0x4
>  --[ end trace]--
>  Kernel panic - not syncing: Fatal exception
>
> Signed-off-by: Yanjiang Jin <yanjiang.jin@hxt-semitech.com>

Good catch!

Patch applied.

Yours,
Linus Walleij
