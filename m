Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA6EECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 02:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68909208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 02:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLGnyrAy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68909208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbeIOINr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 04:13:47 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45128 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbeIOINr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 04:13:47 -0400
Received: by mail-pg1-f196.google.com with SMTP id x26-v6so5191366pge.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 19:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=UpuPYCfifF3M0rKb90jvnx5R/6vzxQw616ktKBqjF0Q=;
        b=VLGnyrAykq7EsgM9csP4n7d2NhE4SIs/UcRnJfT7YxYhMtjuU6bvYvd76SUQNx0jp9
         1tFbdY2ELB6g8LJwZp2fmeq8f+RDv8WVHyt3oyajqxp9TKzy69vguP+vHTEqk2Z6Zw22
         vdju+TXofq27YfJsaVtxw09/TBdxpksNS4Lfd7V2EkQVoblV3VTr3Si2UpmApCZJ8A1E
         T/06/uDPjbImKlhNXCfUaR6m5M8tTb3jjzPNYftpWY6AdyRTPP0mYT2eFSord8SIRadn
         h9epZssfFbLMPdKbFXSIewQv4c655bDa70AmvLnrDpBKn4dUJdNdpAV1+tlrox0Uaj5v
         YoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=UpuPYCfifF3M0rKb90jvnx5R/6vzxQw616ktKBqjF0Q=;
        b=lWkhk4qHjnh0M1mA8r99dDqlRNupNHaSaN64SjXkx3Ab3gQUn35cPYLwKLm1dyKnxl
         tqqGsgbf9QcxVqCiHlj68Xm/FfCBciw2BauQ8MbwtTlWPeG2IfpjdlMvSUZL74mbGEH0
         hHMRguzeZutmftKRsXeE1InLFZT7NWwbjYWQCIe54nswNFBiC4L4zf+KohKF3pkj7W9F
         WAYX/vAdj4kP44PpSdnHRkQUzc4x9ErlP3/uKUT/rVfeeytec5gB9PshtWc22Rh3TZMU
         tQ7XfEk/4k4CzPqzF7+gye17ygAIFQAo0S/RkTBoQadEn2/fXFaSY6sEelxy7jMTcvXD
         rRCA==
X-Gm-Message-State: APzg51DMh+0BTlT2+84BBwU+nPw3Q3f+DTLcxli+d4xlD7ymEySr54+t
        nGiiU0SaGBh0gBmmyWy6j0o4jRz2KfLCzg==
X-Google-Smtp-Source: ANB0Vda28LmZNUNW2tC4GzeXb3ywqE689dUyQ/vjutQB1qypnizZ9DDiJA23eDTln2pNKt8ZVEH1oA==
X-Received: by 2002:a63:c114:: with SMTP id w20-v6mr13679539pgf.234.1536980189300;
        Fri, 14 Sep 2018 19:56:29 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id i26-v6sm9965802pfo.107.2018.09.14.19.56.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Sep 2018 19:56:28 -0700 (PDT)
Date:   Sat, 15 Sep 2018 08:26:22 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joe Perches <joe@perches.com>, NeilBrown <neil@brown.name>,
        devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v7 0/1] staging: mt7621-mmc: Fix debug macros and their usages
Message-ID: <cover.1536978715.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the the debug macro IRQ_MSG().
It deletes IRQ_MSG() and all its users as currently it is a no-op.

Changes in v7:
  - Delete IRQ_MSG() macro and its users.
  - Patchset reduced to 1 patch as the patches fixing N_MSG() and ERR_MSG()
    have been accepted.

Changes in v6:
  - Delete N_MSG() macro and its users as it is a no-op.
  - Patchset reduced to 3 patches as the INIT_MSG patch is accepted.

Changes in v5:
  - Remove commented code for N_MSG().
  - Remove commented ERR_MSG() usages.
 
Changes in v4:
  - Create multiple patches, one for each type of macro being
    deleted/changed.

Changes in v3:
  - Replace usages of ERR_MSG and IRQ_MSG with dev_err() in code itself.
  - Remove all INIT_MSG usages.
  - Drop ERR_MSG, INIT_MSG and IRQ_MSG from dbg.h.

Changes in v2:
  - Replace printk with dev_<level>.
  - Remove __func__, __LINE__, current->comm, current->pid from arguments.
  - Remove the do {} while(0) loop from these macros.
  - Modify commit message to include other changes.

Nishad Kamdar (1):
  staging: mt7621-mmc: Delete IRQ_MSG() and its users

 drivers/staging/mt7621-mmc/dbg.h | 12 ------------
 drivers/staging/mt7621-mmc/sd.c  | 19 -------------------
 2 files changed, 31 deletions(-)

-- 
2.17.1

