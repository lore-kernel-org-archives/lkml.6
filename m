Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF338C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CEE8222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jxjIdIau"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731745AbfBLRQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:16:22 -0500
Received: from mail-pf1-f177.google.com ([209.85.210.177]:46833 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729211AbfBLRQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:16:21 -0500
Received: by mail-pf1-f177.google.com with SMTP id g6so1576221pfh.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 09:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=uCIi1jYyV2+K3lPUo87+afVGlzj4vdPTBOejQeoNlOI=;
        b=jxjIdIausF1wkO2dP18o+1u0aV2nKICvDEvW5GLEbt4Uuvq26IoXj8ArQbQPHiFOcD
         DNWHLVQ+AhVZrCAAwM540jrJvEBICkr5lfKuNZYB87yQUQUhUgvEqJudrEiag19BToXk
         Mhk1vMZZM5zcm94KM4/KvySTBp7xr0q2mOGQYzZZu04YLortxuQG70qf0GLwI4/0YMPr
         bBh18tUHPGLbp16EyeCTDT7uOSbEbUcg0dbSdAFgRJWBwOEtx4VZqzLtf9WKhulR2QJO
         PnKMAoef/rE0HlsO+Jr6QIxJ3fFUmvKtHP+7svPOcFuPjBOFnUqVxawH67sHRSaSn0wc
         mLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uCIi1jYyV2+K3lPUo87+afVGlzj4vdPTBOejQeoNlOI=;
        b=Wq6KcGfyTaIf3UfgMugBbh7x25n1rRAyeWXaNJlsYHeX84gq/m/lXOjW+etoXI8pcO
         gX/y6AHWYVyO6gUmphcIzNXa58Dia+y88d3DcLBM+ujZyqF5VNGHAC7GSFtxKeJNa5ad
         plFP1Cw0GuW/Nf2f5wsaA+s+wtpma3IUDN1oBTZrygMCtKk88jlTgH1H/OOVtFz8MfLJ
         XJrDW2z8EXY/arm/i3WcnlzaztFLtCoFSfd7uOXw6z2xmvetcf01QT9TZ2pe6jZXUhUd
         s6OEvvM7mtEJvaKZgAMyF8Wylb8rYERcW8MF2l+66wI5kkuoCzt/8dmueZlQrTvaccBj
         oDIg==
X-Gm-Message-State: AHQUAuYu6og1abmlrexDXnbric59D7g0C5G4LRyqUyRYUqu1EaYWtfp7
        67Hhe+wlEP9yNnkgBL2nfCkzAA==
X-Google-Smtp-Source: AHgI3IYLBLGhooRv3SeD7y+NFfWYi7EdH+lkTiA4OomWI+pPf664Tmy9jLG4ZZy+2uihUcUuFr68uQ==
X-Received: by 2002:a63:515d:: with SMTP id r29mr4452257pgl.350.1549991780302;
        Tue, 12 Feb 2019 09:16:20 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id z4sm8659231pgu.10.2019.02.12.09.16.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 09:16:19 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org
Cc:     suzuki.poulose@arm.com, mingo@redhat.com, peterz@infradead.org,
        jolsa@redhat.com, leo.yan@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/13] perf tools: CoreSight code cleanup and refactoring
Date:   Tue, 12 Feb 2019 10:16:05 -0700
Message-Id: <20190212171618.25355-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day Arnaldo,

The only reason I'm sending this set so late in the cycle is that it does
absolutely nothing other than cleaning up and refactoring code - not a
single new feature is added here.

As such if my colleagues on CoreSight get to review it fast enough I leave
it entirely to you to decide if you want to queue it for the 5.1 merge
window.  If that is not enough time then ignore the whole thing and I will
resend when a new rc1 has been released.

Thank you for your time,
Mathieu 

Mathieu Poirier (13):
  perf tools: Remove unused structure field "state"
  perf tools: Remove unused structure field "time" and "timestamp"
  perf tools: Fix wrong return values in error path
  perf tools: Introducing function cs_etm_decoder__init_dparams()
  perf tools: Fix memory leak in error path
  perf tools: Introducing function cs_etm__init_trace_params()
  perf tools: Fix erroneous comment
  perf tools: Cleaning up function cs_etm__alloc_queue()
  perf tools: Rethink kernel address initialisation
  perf tools: Make cs_etm__run_decoder() queue independent
  perf tools: Modularize main decoder function
  perf tools: Modularize main packet processing loop
  perf tools: Modularize auxtrace_buffer fetch function

 .../perf/util/cs-etm-decoder/cs-etm-decoder.h |  10 +-
 tools/perf/util/cs-etm.c                      | 457 ++++++++++--------
 tools/perf/util/cs-etm.h                      |   4 +-
 3 files changed, 262 insertions(+), 209 deletions(-)

-- 
2.17.1

