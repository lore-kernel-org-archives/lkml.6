Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612B4C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2300220855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zvp30cs6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2300220855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbeKJGVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 01:21:43 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:43176 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbeKJGVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 01:21:42 -0500
Received: by mail-qk1-f201.google.com with SMTP id z126so5792279qka.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 12:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=NWa7fS++m02mUdorr1OZ28RtYO0ZyNnH1VedLowKjpk=;
        b=Zvp30cs6sWWTO/IAq6ubugC4eVLbuxnn8YjARzPhQ0LkGsKc3l49btvffII7EnE7ja
         tdgz7mILWWkXYsM/UCJyaKdS5+wr7XkjS0K8bTRaK0Bpq9kWZRJOTCKvD4CqX1fCOtjo
         Slc2CCDFNbMRXM+zjIrb9KJg1jzRoQao04Whd2xpADOXrloFjUz19k14iXIu3uxIjnZY
         hZd7Lh2p17ld03AGL7jPhbTBzjmQMHW8JbMzGlkpvjLmfzOXmlb5+kpZ8RhDAJxKn6ct
         2sWkUXF2FNoNrBAEnHi6EEGt2QCNXKCtMdyGfR7TOXjt/eFt7yW3OJl+lB3em8JNsZGv
         LBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=NWa7fS++m02mUdorr1OZ28RtYO0ZyNnH1VedLowKjpk=;
        b=JFyeJ8JY0J7U33iYqzCgOKyGd82rTrjan0DFc7o3sFbMZK3zs2ohmBUFJSp/WtTGhW
         TYR083R/LEOFNwmjVautX/dCaed7XkwDFIRKAUVhp8m2iE79fTj07hRrT10OGqxTZXz1
         uhDB5g87kk1r+V2VAWAgVvI3d+yb6hwqgmyPWFnqxTxGhqf789nMOn7DEYbyUuan/ZyD
         jtfX29abn+V0hoP3v2kxKrSIEVMyBg+wuFm+SZmV/d20r+nNZoEj6bmN0aICuav0SBNq
         lK+9ixLoLNjBKETlXM7HSOLqheFMuIWkniJemw2SGdHjX7+Z/lNxHKGM//v2oulfGxgW
         fafQ==
X-Gm-Message-State: AGRZ1gKS10EAgpX85MP2JBBuMpQwUjGq34JI+8Vc7XQDTxQauqXhRWhF
        LDot5PGxNdqDHEieMO2U20wGq3jh
X-Google-Smtp-Source: AJdET5doxj4D8s2TzmznxTnlzfek7zkmnd0hZx3drKbOZVe+citbmZouKJxbMQ3GSPvxbC7+kflRNJi3
X-Received: by 2002:ac8:1b55:: with SMTP id p21mr2169782qtk.16.1541795969398;
 Fri, 09 Nov 2018 12:39:29 -0800 (PST)
Date:   Fri,  9 Nov 2018 15:39:19 -0500
Message-Id: <20181109203921.178363-1-brho@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
Subject: [PATCH 0/2] kvm: Use huge pages for DAX-backed files
From:   Barret Rhoden <brho@google.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?=" <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, yu.c.zhang@intel.com, yi.z.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series depends on dax pages not being PageReserved.  Once
that is in place, these changes will let KVM use huge pages with
dax-backed files.  Without the PageReserved change, KVM and DAX still
work with these patches, simply without huge pages - which is the
current situation.

RFC/discussion thread:
https://lore.kernel.org/lkml/20181029210716.212159-1-brho@google.com/

Barret Rhoden (2):
  mm: make dev_pagemap_mapping_shift() externally visible
  kvm: Use huge pages for DAX-backed files

 arch/x86/kvm/mmu.c  | 34 ++++++++++++++++++++++++++++++++--
 include/linux/mm.h  |  3 +++
 mm/memory-failure.c | 38 +++-----------------------------------
 mm/util.c           | 34 ++++++++++++++++++++++++++++++++++
 4 files changed, 72 insertions(+), 37 deletions(-)

-- 
2.19.1.930.g4563a0d9d0-goog

