Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E648DC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2119C20877
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="d8m5/QEC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2119C20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933283AbeGJKCp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 06:02:45 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34519 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933187AbeGJKCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 06:02:42 -0400
Received: by mail-wm0-f67.google.com with SMTP id s13-v6so12193690wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 03:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=z55mf4Qbs2R5uhvsiQ7bknoEjOY0CV4eH8JkMTeyJoE=;
        b=d8m5/QECDRY5b0idXHq8QMYlDv9XuJBeeXVYmhbS7+UW3Qb6jv+GaBRRz6YZPQKOJL
         ypm/n4iufq6Ed3SOtv9EJJ08H09FTzr8ulxxnqWPRZeTU+OsRihXNmbM8yavOZwNDGrI
         JvSJymAdzqDPlW/zMR1PiBPo9mHv39fKq+YyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=z55mf4Qbs2R5uhvsiQ7bknoEjOY0CV4eH8JkMTeyJoE=;
        b=qYBKAQ8UgexsbQ4LYuhybfwzXe2+/z1OtZ3oWmRsZ9+wDuUT2Offht/+nwdf451m4y
         AlT02iE7oD7sMHDnK6qYZtvV8qZUXQvkVwiJItHTZIaqEvsYegJ0wIDrNZX1jJOpwEr7
         9TXfiUradKUvCOOPKSr4NNLpHqhPCGkjSsHPRaX0QccrcdE4lUdLJenmU8mGgyH/c5JA
         FGpP2D+h7I46/hOLKAej1b3sieupRqSQPhd8fla9z2GSDuRVQY5pXzJwCPr+gE5mkOqz
         z3VSbaCky0RiBXzyPp2gKNPEn3ktd5kBG9eB2XsvMJEdBQUQTsVAtQcNn8qqRrdN5jHn
         MPQQ==
X-Gm-Message-State: APt69E0wBBkTK8RldmAIXTZSEDX+OnihYcd4I31N46zSx9PcQUaSv1jC
        IVkHD5q+ESGPA12NeQqDUldckQ+h
X-Google-Smtp-Source: AAOMgpe0XxkFmwVdpPEtbE1Cpve/oTFBhlB7jVFSfFKlZ9lshAjIKWTo+j9RzTqDTbX/t2pIQ1JMtA==
X-Received: by 2002:a7b:c01a:: with SMTP id c26-v6mr14981556wmb.33.1531216961155;
        Tue, 10 Jul 2018 03:02:41 -0700 (PDT)
Received: from andrea.amarulasolutions.com (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id f133-v6sm18539320wme.42.2018.07.10.03.02.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jul 2018 03:02:40 -0700 (PDT)
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] doc: Replace smp_cond_acquire() with smp_cond_load_acquire()
Date:   Tue, 10 Jul 2018 12:02:23 +0200
Message-Id: <1531216943-6382-1-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amend commit 1f03e8d2919270 ("locking/barriers: Replace smp_cond_acquire()
with smp_cond_load_acquire()") by updating the documentation accordingly.

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Daniel Lustig <dlustig@nvidia.com>
Cc: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/memory-barriers.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 0d8d7ef131e9a..987a4e6cc0cd8 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -471,8 +471,8 @@ And a couple of implicit varieties:
      operations after the ACQUIRE operation will appear to happen after the
      ACQUIRE operation with respect to the other components of the system.
      ACQUIRE operations include LOCK operations and both smp_load_acquire()
-     and smp_cond_acquire() operations. The later builds the necessary ACQUIRE
-     semantics from relying on a control dependency and smp_rmb().
+     and smp_cond_load_acquire() operations. The later builds the necessary
+     ACQUIRE semantics from relying on a control dependency and smp_rmb().
 
      Memory operations that occur before an ACQUIRE operation may appear to
      happen after it completes.
-- 
2.7.4

