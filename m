Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F742C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 18:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E5120881
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 18:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6Hd6Sy7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7E5120881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbeIOABw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 20:01:52 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43997 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeIOABw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 20:01:52 -0400
Received: by mail-lj1-f195.google.com with SMTP id m84-v6so8319541lje.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 11:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zKTwIreWqmApK+L597Db5HxDZrMwXzxRIyA1x8anV/M=;
        b=e6Hd6Sy7e52ET/vp2WL1Ltw1y0z5xQMx1QtKHaPygBo30dAqpejbGWVFET9s+KPnMl
         5iv1DsPARPkvseNNUk2TA/K22cEiyKHGjqWZKqVMRhJ+wuqTZ5PNyWsWXmiG2p2BXIZd
         28h80pSu1JlGqABFwX9g2bsVnKC2wZsL/p978dekUy3YmY6g1BHnpvr6od1NWllcO/2D
         hnRBdmELhAcnl2OG8MzbK4ZnUIZcRhguRcgFTLqbk9TDe9IAA3xEgkfGONxQSt8xDRx3
         bEe98fcimL/++PLuhrIv/1vjCI3nl9CgmfwpHRUc8kX9lnlivYlgslH3zOu5pC6nbxOs
         4lrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zKTwIreWqmApK+L597Db5HxDZrMwXzxRIyA1x8anV/M=;
        b=RAghVqr7bkdnnsaW11H/F7W41ijwIOLNbz/zvJbGqQrmDqEgLT4Kxb4oac2k/RPw6E
         whdyU1S/SW4Gxz7JorOQQKSvoRqnIddxBzVJEeNyaO9CDJydEJldJe9Wxh+rf4uSq/z4
         YvOQ1OUSaIR/DWTZOGteJ20qJata82NgomZPG/iYsZmakiGA0aUEntMYOJ7kqUOVUH1L
         5LuzM2BuOeNmgYIlgnXrmXifruL0V5tXf+Grw9RkDv/gLKK/ihdv1sbZ5Xlt3ZiO5wVh
         ZvKW6cOs9O09WclznMSSUSct6CpqTyx0jARPPLFOfjaKXG9y33c0BbL1amGIkSpjZSPw
         wlMg==
X-Gm-Message-State: APzg51C1OuQHxP/f641P4zXbUbekw78IFek4FsjXLIPy70oHUvHIru0F
        Zrz2B5n8dWmBfH4HBC9Ehpd2fYZj
X-Google-Smtp-Source: ANB0VdbiG1aRJnr6oHglhIw2j4QehzREpICqS8ZEj/acPKnySSdf5ncn9WZfVH5e3mvty1YgWx69eg==
X-Received: by 2002:a2e:860d:: with SMTP id a13-v6mr9037306lji.43.1536950766727;
        Fri, 14 Sep 2018 11:46:06 -0700 (PDT)
Received: from octofox.cadence.com (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
        by smtp.gmail.com with ESMTPSA id x8-v6sm1297134lji.53.2018.09.14.11.46.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 11:46:05 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 0/3] xtensa fixes for v4.19
Date:   Fri, 14 Sep 2018 11:45:48 -0700
Message-Id: <20180914184548.19187-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the following batch of fixes and cleanups for the Xtensa
architecture:
The following changes since commit 57361846b52bc686112da6ca5368d11210796804:

  Linux 4.19-rc2 (2018-09-02 14:37:30 -0700)

are available in the git repository at:

  git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20180914

for you to fetch changes up to 4a7f50f78c221aac7253ea7059e1986eb622b0e5:

  xtensa: enable SG chaining in Kconfig (2018-09-11 22:12:59 -0700)

----------------------------------------------------------------
Xtensa fixes and cleanups for v4.19:

- don't allocate memory in platform_setup as the memory allocator is not
  initialized at that point yet;
- remove unnecessary ifeq KBUILD_SRC from arch/xtensa/Makefile;
- enable SG chaining in arch/xtensa/Kconfig.

----------------------------------------------------------------
Masahiro Yamada (1):
      xtensa: remove unnecessary KBUILD_SRC ifeq conditional

Max Filippov (2):
      xtensa: ISS: don't allocate memory in platform_setup
      xtensa: enable SG chaining in Kconfig

 arch/xtensa/Kconfig               |  1 +
 arch/xtensa/Makefile              |  4 ----
 arch/xtensa/platforms/iss/setup.c | 25 +++++++++++++++----------
 3 files changed, 16 insertions(+), 14 deletions(-)

Thanks.
-- Max
