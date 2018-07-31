Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6EEC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B86E920841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ufczw9ZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B86E920841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732488AbeGaRNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 13:13:34 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39018 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732448AbeGaRNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 13:13:33 -0400
Received: by mail-ed1-f67.google.com with SMTP id h4-v6so5530690edi.6;
        Tue, 31 Jul 2018 08:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/dgRG+yFP0KMGios3G0rp8jmG803soLS1lB3z+Hq8Tc=;
        b=ufczw9ZVHKw5M2IOZdWRmBLZ01rB0+E8Pk+eEJg6A8c2j4KuSeRlQZd7/a27NQI9hf
         /OeeQ03p0z7cm7IUD5NvUrUM0eFpa1jYXMUh/zrPUoPhYZRKbjfHaL7ae+nH5eillwJL
         SyFoOTv0vuLLbI7ke+4+3DrnvpkzTStyZNJqlxnsnGNsY+0zQHi9pgKjt8TAmaiIuHNs
         U+IwNRIH6ci33mNOnuDHkmVlSUwaqM5EPh9KRLCZpNNyYjmR/JsFxl0sj0UwqjxW0LyF
         BJCABw6xLv7JvOl7j4ElDguAXEJM0BKZiyQALLgChGFIDOcTiM5kFfTxwJp0VX8xNyCC
         Kx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/dgRG+yFP0KMGios3G0rp8jmG803soLS1lB3z+Hq8Tc=;
        b=I29ftsO6yz/E2w/xYyMT4RDb9+xzdmCuVM9oR3XQ4x20lZhtPtQv2fRaE1v7FvbzH/
         tsdcIPu97yU1Swv6zu+VyF6fekiog8GLn6s/IHF5v84+iNleW/MoqVGU0+3q7t1+DMNQ
         XW8k3DYnLszLeKWbC3DWA/iL09cJIGjXuS2EzpoHzd/E8FntGnH0ex+jwdCQi1hp1raJ
         x0lcUAXkKLZ6xzNCvf0lrZW5RO52swiFYp8LupDVH4s4mlASFrPjaJWZD+1tHovxp6iT
         0T363ohImu5sg8dBL0jjQkX9+MTTbFktoMAG/7zk4WtlOLZ50ch/vmHuwDHkDDq1BTHb
         RnqQ==
X-Gm-Message-State: AOUpUlFjo3qMXyFFjJGE610BUQschvFDV8Lntyl++TD18Kzo4uvTKCUw
        v+DmVlU9n6qZEQAa6VvdaBE=
X-Google-Smtp-Source: AAOMgpex9tYApXEWWdjV6DnAoaktaGsXLHAj5mI+ryw6ObHWeJoey/1JiCFXV2SwJXVcEeskrcV4/Q==
X-Received: by 2002:a50:b6e3:: with SMTP id f32-v6mr156223ede.147.1533051160991;
        Tue, 31 Jul 2018 08:32:40 -0700 (PDT)
Received: from dimapc.localnet (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id s41-v6sm7878210edd.61.2018.07.31.08.32.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 08:32:40 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-tegra@vger.kernel.org, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] media: staging: tegra-vde: Replace debug messages with trace points
Date:   Tue, 31 Jul 2018 18:32:38 +0300
Message-ID: <5286387.GJUI5Hs7VI@dimapc>
In-Reply-To: <1779889.gZoAajBteF@dimapc>
References: <20180707162049.20407-1-digetx@gmail.com> <20180724213733.6c8b6b4b@coco.lan> <1779889.gZoAajBteF@dimapc>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 25 July 2018 04:20:29 MSK Dmitry Osipenko wrote:
> On Wednesday, 25 July 2018 03:37:33 MSK Mauro Carvalho Chehab wrote:
> > Em Wed, 25 Jul 2018 01:38:37 +0300
> > 
> > Dmitry Osipenko <digetx@gmail.com> escreveu:
> > > On Wednesday, 25 July 2018 01:06:52 MSK Mauro Carvalho Chehab wrote:
> > > > Em Sat,  7 Jul 2018 19:20:49 +0300
> > > > 
> > > > Dmitry Osipenko <digetx@gmail.com> escreveu:
> > > > > Trace points are much more efficient than debug messages for
> > > > > extensive
> > > > > tracing and could be conveniently enabled / disabled dynamically,
> > > > > hence
> > > > > let's replace debug messages with the trace points.
> > > > 
> > > > This patch require some work:
> > > > 
> > > > $ make ARCH=i386  CF=-D__CHECK_ENDIAN__
> > > > CONFIG_DEBUG_SECTION_MISMATCH=y
> > > > C=1
> > > > W=1 CHECK='compile_checks' M=drivers/staging/media
> > > > 
> > > > ./include/linux/slab.h:631:13: error: undefined identifier
> > > > '__builtin_mul_overflow' ./include/linux/slab.h:631:13: warning: call
> > > > with
> > > > no type!
> > > > fixdep: error opening file: drivers/staging/media/tegra-vde/trace.h:
> > > > No
> > > > such file or directory
> > > > 
> > >   CHECK   drivers/staging/media/tegra-vde/tegra-vde.c
> > > 
> > > /bin/sh: compile_checks: command not found
> > > 
> > > Upstream kernel doesn't have "compile_checks" script and I can't find it
> > > anywhere else.
> > 
> > This is just a call for smatch/sparse:
> > 
> > #!/bin/bash
> > /devel/smatch/smatch -p=kernel $@
> > # This is too pedantic and produce lots of false-positives
> > #/devel/smatch/smatch --two-passes -- -p=kernel $@
> > /devel/sparse/sparse $@
> > 
> > However, the problem here is that you're doing a 64 bits division.
> > That causes compilation to break with 32 bits. you need to use
> > do_div & friends.
> 
> The tegra-vde driver code is fine, it is a known issue with the kernels
> checker [0]. Unfortunately the patch for the checker haven't been applied
> yet.
> 
> [0] https://www.spinics.net/lists/kernel/msg2824058.html

Mauro, are you going to un-reject patch [0] and apply it or there is some 
action needed from my side now?

[0] https://patchwork.linuxtv.org/patch/51002/


