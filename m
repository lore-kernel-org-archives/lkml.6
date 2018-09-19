Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAA8C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F3E2150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMTdzrjp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28F3E2150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732880AbeISWwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 18:52:21 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40711 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731056AbeISWwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 18:52:20 -0400
Received: by mail-pg1-f195.google.com with SMTP id l63-v6so3049329pga.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 10:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=jy6d3cNHaAj0k3hJSAqse7S/J2hsaWUKxm6K1qEw9tY=;
        b=TMTdzrjpVtzJnKqxUNI6zk3qjuh07qfBWvivTqxV8BadBtOAlit+x7XQhsWgUhGC1c
         103yVPjH4MTRcKhAbrzBjOKW8pZYp3leBcezOLQkgg0gckmIeUYwE1MvkblPeKsOdrY5
         +fq4jKbxyXLytU6r5ZxO+3gKM7vM1yziml2tjpy5A2pESg+t3ZWhYoPgei4TBhXATJlP
         uOoqqBz7FN6skWwNUq5THyxhoO5qqWU9MQz0E3c0gYYVvbUfzq/sMpSEy/cEoXxuYSAg
         A6eu0Y1L0t2qoH3Zq4KiBGSh3+h4ViHj6lCsBiios3zl3MXXTF3N/IkEPa8wFtZxHZje
         jDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=jy6d3cNHaAj0k3hJSAqse7S/J2hsaWUKxm6K1qEw9tY=;
        b=otihDhKCgqh+3w1tPrN55+Oor/6So+IGIiugoSuut0VzeiSfwJG+4QQWourqrIGszS
         Z5v1g8aKej0iKWH1HykFq56le4GNA1eihcjLOVJe6nJRQMSxuzTL3Q+GNKtpgtAr3mdC
         01Xz5Y8S7hu3jo+5I6LKoMX92WVeF8/ITfwCjKdjzor3q+iGbvXZ9h987bzfP3z3EXNw
         G4bTZPnpvEZmENVw5VEqv96rO0BHhBzUrlK47IdVaQgv6+1+fX1Ucb8SlBEY8ZXpTNsY
         LkKuUCHQoxT7C4nawJusu5YY0/W2tPCzB8cB1ARVbP4MYO8fdJ8vR2FP10bt+85XDnIn
         LRUw==
X-Gm-Message-State: APzg51D1mDNdF4x3CP7NTcUe1ZQ6rkK+ZZ5uI4H5V9QmTAeB5HRvofGU
        sVsIrH7x4IAdJszPYYsZcfg=
X-Google-Smtp-Source: ANB0VdZ0VYMN6fGZ/odNHjmpY5YULMwhq0Rl68+fgJkf7zbsY69IDOQoTUNe1NxFLymHlNWK2WlatA==
X-Received: by 2002:a63:481:: with SMTP id 123-v6mr33913549pge.129.1537377209505;
        Wed, 19 Sep 2018 10:13:29 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id n79-v6sm44524355pfh.2.2018.09.19.10.13.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 10:13:28 -0700 (PDT)
Date:   Wed, 19 Sep 2018 22:43:22 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joe Perches <joe@perches.com>, NeilBrown <neil@brown.name>,
        devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v8 0/1] staging: mt7621-mmc: Fix debug macros and their usages
Message-ID: <cover.1537376030.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the debug macro IRQ_MSG().
It deletes IRQ_MSG() and all its users as currently it is a no-op.

Changes in v8:
  - Remove unnecessary {} for single statement if

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
 drivers/staging/mt7621-mmc/sd.c  | 24 ++----------------------
 2 files changed, 2 insertions(+), 34 deletions(-)

-- 
2.17.1

