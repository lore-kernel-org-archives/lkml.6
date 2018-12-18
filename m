Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E0EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B0C921873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lP/NX9sW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbeLRTkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 14:40:24 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32992 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbeLRTkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 14:40:23 -0500
Received: by mail-pg1-f194.google.com with SMTP id z11so8284823pgu.0;
        Tue, 18 Dec 2018 11:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TUW7JqMm/20Ve1m4CrpEQUQb3YihKsE0PnwO35c3oY4=;
        b=lP/NX9sW5V/T1Si/tQftCb0yJ6lVyUpwU06O2dM04fXoIZITq3AUBggPdVe8p9KZ6r
         HozC783vaxcpI2UguP6uUwejtf9gqNCL5gRLHfhVrV69Pg5cKhwceJH9BXN1sQadBYfZ
         UcnBHjATQ89X6VglXhMg72II+A/W+ZBUrqjZs/lPKTEcWY5P+Pi1o5mFfoPyo5OOhiW3
         3BqQ0aTPA1OZqTwn8zC+FnS22Kdg+X3N3YkLEIgt0RmsW8/7/YQqZqpwAja+ZpHK+hwz
         pvgneHjOz0d3RcI11WXS5G7IoHkBLCbm0V6HQc1tpdSwqn5bz9nR8I2Rg0aE/vy+mzWZ
         hmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TUW7JqMm/20Ve1m4CrpEQUQb3YihKsE0PnwO35c3oY4=;
        b=UPuJR7WuEDzC2RhLIh2hseojPMHyjSwMq94+qsV88TiPiG67mDgGBGBnci9jkF2tMH
         nOQGI4ffqwKklHb78xGWo6XFNXKltiLc94EwHNwgWCZUrfeJsAHY5G0ul2CZsYaud6H4
         f+9N35lwrnm3E9UB70ZVVYyTeXb3hXPTuCeNsyVTefrgQVKe54gQ8AT4kl1ASGdAJIaz
         EmbRwLWxPRJEfPIJrNdC+vRfohujGc89/0n1iMzRak25uH0VfAdi5qW2hvPvASVF7qql
         qGI1h5DrEr8g+/pR0AlwTeJ+7LMDgvWuA1GlBO9AucNBQWcyNr/fjxlAsLRJNZuVpK8I
         18Hw==
X-Gm-Message-State: AA+aEWZkXzEkhjaF8PJPkO0FxZgOe/HKZeNhi4NvvhvghwlJk8CworrS
        Cn5T0gE30M/UqdLcMpHnFnE=
X-Google-Smtp-Source: AFSGD/XG1c7tF/edMTT9V+SwV6crMZ3Y8dH6GPUw9//UJzH1/n3tsTrBJB79R6KGZgi1OOR2Jgt/CA==
X-Received: by 2002:a62:1043:: with SMTP id y64mr18117460pfi.78.1545162023096;
        Tue, 18 Dec 2018 11:40:23 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id b202sm29493069pfb.88.2018.12.18.11.40.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Dec 2018 11:40:22 -0800 (PST)
From:   frowand.list@gmail.com
To:     robh+dt@kernel.org, Michael Bringmann <mwb@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
        Juliet Kim <minkim@us.ibm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] of: phandle_cache, fix refcounts, remove stale entry
Date:   Tue, 18 Dec 2018 11:40:01 -0800
Message-Id: <1545162003-11577-1-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Non-overlay dynamic devicetree node removal may leave the node in
the phandle cache.  Subsequent calls to of_find_node_by_phandle()
will incorrectly find the stale entry.  This bug exposed the foloowing
phandle cache refcount bug.

The refcount of phandle_cache entries is not incremented while in
the cache, allowing use after free error after kfree() of the
cached entry.

Changes since v2:
  - patch 2/2: add temporary variable np in __of_free_phandle_cache_entry()
    to improve readability
  - patch 2/2: explain reason for WARN_ON() in comment
  - patch 2/2: add Fixes tag in patch comment

Changes since v1:
  - make __of_free_phandle_cache() static
  - add WARN_ON(1) for unexpected condition in of_find_node_by_phandle()
  
Frank Rowand (2):
  of: of_node_get()/of_node_put() nodes held in phandle cache
  of: __of_detach_node() - remove node from phandle cache

 drivers/of/base.c       | 101 ++++++++++++++++++++++++++++++++++++------------
 drivers/of/dynamic.c    |   3 ++
 drivers/of/of_private.h |   4 ++
 3 files changed, 83 insertions(+), 25 deletions(-)

-- 
Frank Rowand <frank.rowand@sony.com>

