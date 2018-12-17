Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC839C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 07:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D024217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 07:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="syU1Hdqz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731574AbeLQH4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 02:56:54 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35627 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbeLQH4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 02:56:54 -0500
Received: by mail-pf1-f194.google.com with SMTP id z9so5966767pfi.2;
        Sun, 16 Dec 2018 23:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NWLPnNlHrvA2ehDLVEPouumgN3Xl/PWww3ilC7E/OyM=;
        b=syU1Hdqzs+6w7Cz4C1eaj3H8xojzO9kkmJ7WLGxaibg6CkG9dcfwyuJcddMjudA1dj
         vtTHHbWgKBmhhnhGIJL4vTLHQCUmpENSIidAJZzLbGDcDS7lEpQ2tyCGiwmMVXqVSfJQ
         ZXHuK9AlddjqY0q3ThbN/rlznJIEmcoClTVVrDYEJN5J8lJJ5RG0YG66QV0cJkCaImKe
         C23/DTGG9zZbudnNEtubNRubjV1vtpWPyvkAHw3GVuvD1fF+REaePF0dSvlzgcbGtOAg
         KVgTD0/XpQuIIOxnm2Efqone4ZsQxN9xnw8Rt8jDWveHndzmjHzqiEA3zjYmrPJX02Vx
         zovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NWLPnNlHrvA2ehDLVEPouumgN3Xl/PWww3ilC7E/OyM=;
        b=capGFAb4hc6B/z7QxkvJjAgo5y6LnaG841TXl31B8/zMhCb2PKZ2pGZupdVqtOiQE+
         oypZQkbn0tTWCC6ld3pXU2PJgD04555Hhr90SPXok7RZxKc0r83mN6SPXMdhEIFnUSZ1
         u4wGLuL7SoRsULIutBZaBQGXpA0mbqcAaaPXQDB/aa+deJEfJ/X66PvHh7GwR3O+zrdb
         vKgIGwpBOV43YD3tnviZ3U1tzYk5rQZsOM8qCNaWechyVoE8RbFyYyNk/KbAbmJASwts
         9kf5Mbi//IYUYgGaNNh2E7m9Sw9qADGCps5Gvl8XZHiTYuxuRtGQIFrkvTa9FBdcI6mN
         D8cw==
X-Gm-Message-State: AA+aEWZ5gHNPu4tHJDJ1RuKdQNVtxADIYYxy71ZyPXE+GAGNQt37fBd9
        exwpvvlHpY2h++WmHAC4byE=
X-Google-Smtp-Source: AFSGD/VJKRla6hz4SjCQHjQpp8LyQliqHcHwFd07BWwBNKQDP4JLjte2czE6YFO2c/dhAqQC6MX0YA==
X-Received: by 2002:a63:df13:: with SMTP id u19mr11346510pgg.294.1545033413247;
        Sun, 16 Dec 2018 23:56:53 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id r8sm14216610pgr.48.2018.12.16.23.56.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 16 Dec 2018 23:56:52 -0800 (PST)
From:   frowand.list@gmail.com
To:     robh+dt@kernel.org, Michael Bringmann <mwb@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
        Juliet Kim <minkim@us.ibm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] of: phandle_cache, fix refcounts, remove stale entry
Date:   Sun, 16 Dec 2018 23:56:34 -0800
Message-Id: <1545033396-24485-1-git-send-email-frowand.list@gmail.com>
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

Changes since v1:
  - make __of_free_phandle_cache() static
  - add WARN_ON(1) for unexpected condition in of_find_node_by_phandle()
  
Frank Rowand (2):
  of: of_node_get()/of_node_put() nodes held in phandle cache
  of: __of_detach_node() - remove node from phandle cache

 drivers/of/base.c       | 100 ++++++++++++++++++++++++++++++++++++------------
 drivers/of/dynamic.c    |   3 ++
 drivers/of/of_private.h |   4 ++
 3 files changed, 82 insertions(+), 25 deletions(-)

-- 
Frank Rowand <frank.rowand@sony.com>

