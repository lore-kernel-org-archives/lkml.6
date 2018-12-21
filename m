Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D49C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 21:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB58121929
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 21:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387883AbeLUVg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 16:36:59 -0500
Received: from mga14.intel.com ([192.55.52.115]:6014 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbeLUVg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 16:36:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Dec 2018 13:36:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,383,1539673200"; 
   d="scan'208";a="112483875"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.154])
  by orsmga003.jf.intel.com with ESMTP; 21 Dec 2018 13:36:58 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v3 0/2] x86/fault: Further improve #PF oops messages
Date:   Fri, 21 Dec 2018 13:36:55 -0800
Message-Id: <20181221213657.27628-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rework the messages printed for #PF oopses to display more detailed
information about the fault in human readable form and to avoid
conflicting messages and/or statements that may not always be accurate.

v3:
  - Prepend a patch to reword the initial BUG message
  - Add sample output in the changelogs
  - Swap the order of the #PF lines.  For most cases the three main lines
    show up in reverse fir-tree ordering and the cause of the fault is
    easy to pick out since it's the last thing highlighted by pr_alert
    (excepting when dumping the IDT, GDT, etc...).

v2:
  - Explicitly call out protection keys violations
  - "Slightly" reword the changelog

v1: https://lkml.kernel.org/r/20181207195223.23968-1-sean.j.christopherson@intel.com
v2: https://lkml.kernel.org/r/20181207184423.1962-1-sean.j.christopherson@intel.com

Sean Christopherson (2):
  x86/fault: Reword initial BUG message for unhandled page faults
  x86/fault: Decode and print #PF oops in human readable form

 arch/x86/mm/fault.c | 51 +++++++++++++++------------------------------
 1 file changed, 17 insertions(+), 34 deletions(-)

-- 
2.19.2

