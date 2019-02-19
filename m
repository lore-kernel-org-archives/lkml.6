Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274CDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 22:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29E121479
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 22:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="jud1Wcqb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729868AbfBSWzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 17:55:37 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:40507 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbfBSWzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 17:55:37 -0500
Received: by mail-wr1-f42.google.com with SMTP id q1so23773864wrp.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 14:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=BrB8Q/eUpJDA/Zjf4iU7uKKPX52T9AWESmHfx6pF9L4=;
        b=jud1WcqbKLbtXBU7LLCUyqRDjUDZ87ElfoH4iQCr6+DlRA2PVwngmDC3oiR0zImm6u
         dIF9tHvFSUdrs4CNOv+AnlOyFR8VAnIEFYJJChM1PpBdpHGtUqfZPBGZpPJayyhOCsh/
         aJAVSuZ9rVpX0bsxm+weW9NC+zE2LLjCIPldU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BrB8Q/eUpJDA/Zjf4iU7uKKPX52T9AWESmHfx6pF9L4=;
        b=sCuDMo0scmo2RkGzOk5+8a1Ajub+GuuxFx9JWg4eZ8tvrpom2uwlfnmi4RplGOfV1+
         1bj1A3Of84ObXd8OaGK/G2hEG7QVl7MeE+TsqhwP2jVC6HJ+cnrR72GJ9Hh+M1CvlN8b
         WpWMmCm8i7v28Nh4NZnVtBnHCL/Mb7EBZ9Y+QL8FAGvlynhbsawetHzTJ6usXG1I5S3C
         wyiQfWAIzILK32Up/q50RJBkiug0uvuBwo9B3MkpuRhuHzVQKrq+/0J1vzMr+73/JXrS
         zZ9ZtqWD/cny1Ay8Mh+Yz5bHoWNAyp1Ziz/2JKIuINnIrbB+e+w70tQEPSv5HR1C/KFI
         tV2A==
X-Gm-Message-State: AHQUAualdjDX1TBXKf0iYZNzIpN1DeympmTuBc1ysBxeB5YOrHcXRP78
        nQCbIZPXGhofxdAKyBz7ACK3XzHCdEkKIA==
X-Google-Smtp-Source: AHgI3IZD7TFPlElGIAwXiBx9ilCw6zyTUm9jwuhyg+b2IfPZZpePg5oFZe/u5B5OCOb1g0TDUv9Aow==
X-Received: by 2002:adf:ee4d:: with SMTP id w13mr22603220wro.16.1550616934921;
        Tue, 19 Feb 2019 14:55:34 -0800 (PST)
Received: from localhost.localdomain ([89.22.71.151])
        by smtp.gmail.com with ESMTPSA id b3sm7073951wme.27.2019.02.19.14.55.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Feb 2019 14:55:34 -0800 (PST)
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>
Subject: [PATCH 0/2] tools/memory-model: Trivialities
Date:   Tue, 19 Feb 2019 23:55:21 +0100
Message-Id: <1550616923-4795-1-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes to inline comments, documentation, script usage.

Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Daniel Lustig <dlustig@nvidia.com>

Andrea Parri (2):
  tools/memory-model: Fix comment in MP+poonceonces.litmus
  tools/memory-model: Do not use "herd" to refer to "herd7"

 tools/memory-model/litmus-tests/MP+poonceonces.litmus | 2 +-
 tools/memory-model/litmus-tests/README                | 2 +-
 tools/memory-model/lock.cat                           | 2 +-
 tools/memory-model/scripts/README                     | 4 ++--
 tools/memory-model/scripts/checkalllitmus.sh          | 2 +-
 tools/memory-model/scripts/checklitmus.sh             | 2 +-
 tools/memory-model/scripts/parseargs.sh               | 2 +-
 tools/memory-model/scripts/runlitmushist.sh           | 2 +-
 8 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.7.4

