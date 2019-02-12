Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2571C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A46C920869
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWv1bpsh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbfBLR5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:57:16 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38076 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbfBLR5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:57:15 -0500
Received: by mail-pg1-f195.google.com with SMTP id g189so1594991pgc.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 09:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=okXsoq+U9IeaU0VkH1d2ZCj70CXHgmSj7Z/Roa4I0YU=;
        b=cWv1bpsh0BQ+ZGN8tDbP9K4zEswvZNXfg/nITJ2zYAx6pHZWuhWnaevWJ/bVgLbzdU
         f1Z8jpU9lOf3yl8JFg2jtgfHYDTwT3U1SfNSHPnimlhk3Z29LecBm7cCq5fIKtDLG7lh
         ga7Dm5nDKaZgcDB2jqJyvMUuvvlw2MB4BTprxZ+0Cfi9ajbkcVB0IZOkhUtIhe5ylV9i
         /f7VmNF+Oq6WBUUrzrbqn7UL+Rc/l+ymJkQmi9Vyp1hKY384k/CCGLGoDr84qYeb9Xai
         +ZP7p8q/0g+zv3YXjKzkB/c0ovG/1sapvI6u8/ocqTp9f1gbMKSVIeVEBDEqxB+tknPz
         BCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=okXsoq+U9IeaU0VkH1d2ZCj70CXHgmSj7Z/Roa4I0YU=;
        b=FPvVFGz/fEJCdjiXM4KjP3tad3dSXidZZ7ySsTi47G/cgIhjyqMjh9Hh17Md4luE4U
         cCEVPdPTft9+Yr5kelaIGBn3sjYF5dQnPNwhcZ1tBPbh0rHFtSmwn0TfukckC/AXR5PI
         EKT3w42r/kFebrnsCFahNiG5ymXi/oGCAQyfx7H3C6TkIsJx73oNAc/qVoefxY4F89Bd
         ruW5bw4XVaYRCcTzp1VDkSrEVXNQ6INn9bJdGAD1Zd7YsU3mQ0Mz2NjsZonO2MQe5U8y
         ctPLyNRdJ3dF+URqz80cZ8YJ7NPxmLM1F3fXd+e4gWNya5cfMvgg5LnS1yqBxjxSOuGj
         XGrg==
X-Gm-Message-State: AHQUAua3UC65x1goJvP2J6MkEPzypsGFNi3DNTy/rOkHpMsXFlDAOEKg
        b9YgMYSOD0A4Meo5pJ8a3Eg=
X-Google-Smtp-Source: AHgI3IaQzDGTUcSHrJMGIIbl5On/Asyf02rHV2C6kaTrOmWnxvGkafqrxzUumtO/1Cj61Ra2JdTwhw==
X-Received: by 2002:a63:516:: with SMTP id 22mr4528109pgf.353.1549994235050;
        Tue, 12 Feb 2019 09:57:15 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::5:4d62])
        by smtp.gmail.com with ESMTPSA id z186sm18608427pfz.119.2019.02.12.09.57.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 09:57:14 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>, kernel-team@fb.com,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>
Subject: [PATCH v2 0/3] vmalloc enhancements
Date:   Tue, 12 Feb 2019 09:56:45 -0800
Message-Id: <20190212175648.28738-1-guro@fb.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset contains few changes to the vmalloc code, which are
leading to some performance gains and code simplification.

Also, it exports a number of pages, used by vmalloc(),
in /proc/meminfo.

Patch (1) removes some redundancy on __vunmap().
Patch (2) separates memory allocation and data initialization
  in alloc_vmap_area()
Patch (3) adds vmalloc counter to /proc/meminfo.

v2->v1:
  - rebased on top of current mm tree
  - switch from atomic to percpu vmalloc page counter

RFC->v1:
  - removed bogus empty lines (suggested by Matthew Wilcox)
  - made nr_vmalloc_pages static (suggested by Matthew Wilcox)
  - dropped patch 3 from RFC patchset, will post later with
  some other changes
  - dropped RFC

Roman Gushchin (3):
  mm: refactor __vunmap() to avoid duplicated call to find_vm_area()
  mm: separate memory allocation and actual work in alloc_vmap_area()
  mm: show number of vmalloc pages in /proc/meminfo

 fs/proc/meminfo.c       |   2 +-
 include/linux/vmalloc.h |   2 +
 mm/vmalloc.c            | 113 +++++++++++++++++++++++++++-------------
 3 files changed, 79 insertions(+), 38 deletions(-)

-- 
2.20.1

