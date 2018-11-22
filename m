Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F772C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61DFD20659
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61DFD20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407737AbeKWIef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 03:34:35 -0500
Received: from terminus.zytor.com ([198.137.202.136]:57533 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730054AbeKWIee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 03:34:34 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAMLqJp13948188
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 22 Nov 2018 13:52:19 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAMLqJLF3948184;
        Thu, 22 Nov 2018 13:52:19 -0800
Date:   Thu, 22 Nov 2018 13:52:19 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Babu Moger <tipbot@zytor.com>
Message-ID: <tip-a6f771c9bf4eea2da1516e70c283ede61a7d666f@git.kernel.org>
Cc:     mingo@kernel.org, puwen@hygon.cn, sherry.hurwitz@amd.com,
        jpoimboe@redhat.com, reinette.chatre@intel.com,
        pombredanne@nexb.com, bp@suse.de, tony.luck@intel.com,
        Thomas.Lendacky@amd.com, kirill.shutemov@linux.intel.com,
        akpm@linux-foundation.org, xiaochen.shen@intel.com,
        linux-doc@vger.kernel.org, dwmw2@infradead.org,
        davem@davemloft.net, pbonzini@redhat.com,
        gregkh@linuxfoundation.org, dima@arista.com, hpa@zytor.com,
        jannh@google.com, luto@kernel.org, mingo@redhat.com,
        brijesh.singh@amd.com, jroedel@suse.de, corbet@lwn.net,
        linux-kernel@vger.kernel.org, babu.moger@amd.com, arnd@arndb.de,
        qianyue.zj@alibaba-inc.com, chang.seok.bae@intel.com,
        tglx@linutronix.de, mchehab+samsung@kernel.org,
        vkuznets@redhat.com, kstewart@linuxfoundation.org,
        fenghua.yu@intel.com, rafael@kernel.org, rian@alum.mit.edu,
        suravee.suthikulpanit@amd.com, peterz@infradead.org,
        Babu.Moger@amd.com
Reply-To: linux-kernel@vger.kernel.org, jroedel@suse.de, corbet@lwn.net,
          qianyue.zj@alibaba-inc.com, babu.moger@amd.com, arnd@arndb.de,
          dima@arista.com, gregkh@linuxfoundation.org, hpa@zytor.com,
          pbonzini@redhat.com, brijesh.singh@amd.com, mingo@redhat.com,
          luto@kernel.org, jannh@google.com, fenghua.yu@intel.com,
          rafael@kernel.org, rian@alum.mit.edu, Babu.Moger@amd.com,
          peterz@infradead.org, suravee.suthikulpanit@amd.com,
          vkuznets@redhat.com, mchehab+samsung@kernel.org,
          tglx@linutronix.de, chang.seok.bae@intel.com,
          kstewart@linuxfoundation.org, bp@suse.de, tony.luck@intel.com,
          pombredanne@nexb.com, puwen@hygon.cn, sherry.hurwitz@amd.com,
          mingo@kernel.org, reinette.chatre@intel.com, jpoimboe@redhat.com,
          xiaochen.shen@intel.com, linux-doc@vger.kernel.org,
          akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
          davem@davemloft.net, dwmw2@infradead.org, Thomas.Lendacky@amd.com
In-Reply-To: <20181121202811.4492-13-babu.moger@amd.com>
References: <20181121202811.4492-13-babu.moger@amd.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] Documentation: Rename and update intel_rdt_ui.txt
 to resctrl_ui.txt
Git-Commit-ID: a6f771c9bf4eea2da1516e70c283ede61a7d666f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  a6f771c9bf4eea2da1516e70c283ede61a7d666f
Gitweb:     https://git.kernel.org/tip/a6f771c9bf4eea2da1516e70c283ede61a7d666f
Author:     Babu Moger <Babu.Moger@amd.com>
AuthorDate: Wed, 21 Nov 2018 20:28:47 +0000
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 22 Nov 2018 20:16:20 +0100

Documentation: Rename and update intel_rdt_ui.txt to resctrl_ui.txt

Rename intel_rdt_ui.txt to generic resctrl_ui.txt and update the
documentation for AMD.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: David Miller <davem@davemloft.net>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Dmitry Safonov <dima@arista.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Pu Wen <puwen@hygon.cn>
Cc: <qianyue.zj@alibaba-inc.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Rian Hunter <rian@alum.mit.edu>
Cc: Sherry Hurwitz <sherry.hurwitz@amd.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Lendacky <Thomas.Lendacky@amd.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: <xiaochen.shen@intel.com>
Link: https://lkml.kernel.org/r/20181121202811.4492-13-babu.moger@amd.com
---
 Documentation/x86/{intel_rdt_ui.txt => resctrl_ui.txt} | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/x86/intel_rdt_ui.txt b/Documentation/x86/resctrl_ui.txt
similarity index 99%
rename from Documentation/x86/intel_rdt_ui.txt
rename to Documentation/x86/resctrl_ui.txt
index 52b10945ff75..d9aed8303984 100644
--- a/Documentation/x86/intel_rdt_ui.txt
+++ b/Documentation/x86/resctrl_ui.txt
@@ -1,4 +1,7 @@
-User Interface for Resource Allocation in Intel Resource Director Technology
+User Interface for Resource Control feature
+
+Intel refers to this feature as Intel Resource Director Technology(Intel(R) RDT).
+AMD refers to this feature as AMD Platform Quality of Service(AMD QoS).
 
 Copyright (C) 2016 Intel Corporation
 
@@ -6,8 +9,8 @@ Fenghua Yu <fenghua.yu@intel.com>
 Tony Luck <tony.luck@intel.com>
 Vikas Shivappa <vikas.shivappa@intel.com>
 
-This feature is enabled by the CONFIG_INTEL_RDT Kconfig and the
-X86 /proc/cpuinfo flag bits:
+This feature is enabled by the CONFIG_RESCTRL and the X86 /proc/cpuinfo
+flag bits:
 RDT (Resource Director Technology) Allocation - "rdt_a"
 CAT (Cache Allocation Technology) - "cat_l3", "cat_l2"
 CDP (Code and Data Prioritization ) - "cdp_l3", "cdp_l2"
