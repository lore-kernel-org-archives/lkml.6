Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40605C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 08:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EF1C21720
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 08:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbeLZIVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 03:21:06 -0500
Received: from mga01.intel.com ([192.55.52.88]:19494 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbeLZIVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 03:21:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Dec 2018 00:21:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,400,1539673200"; 
   d="scan'208";a="103379561"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.239.13.104])
  by orsmga006.jf.intel.com with ESMTP; 26 Dec 2018 00:21:02 -0800
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     qemu-devel@nongnu.org, pbonzini@redhat.com, rkrcmar@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com,
        yu-cheng.yu@intel.com, yi.z.zhang@intel.com, hjl.tools@gmail.com
Cc:     Yang Weijiang <weijiang.yang@intel.com>
Subject: [Qemu-devel][PATCH 0/4] This patch-set is to enable Guest CET support.
Date:   Wed, 26 Dec 2018 16:25:16 +0800
Message-Id: <cover.1545806972.git.weijiang.yang@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Control-flow Enforcement Technology (CET) provides protection against
return/jump-oriented programming (ROP) attacks. To make kvm Guest OS
own the capability, this patch-set is required. It enables CET related
CPUID report and xsaves/xrstors support etc in qemu.

Yang Weijiang (4):
  Add CET xsaves/xrstors related macros and structures.
  Add CET SHSTK and IBT CPUID feature-word definitions.
  Add hepler functions for CPUID xsave area size calculation.
  Report CPUID xsave area support for CET.

 target/i386/cpu.c | 67 ++++++++++++++++++++++++++++++++++++++++++++---
 target/i386/cpu.h | 36 ++++++++++++++++++++++++-
 2 files changed, 99 insertions(+), 4 deletions(-)

-- 
2.17.1

