Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529DEC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39CE20659
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:55:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F39CE20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404998AbeKWIhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 03:37:09 -0500
Received: from terminus.zytor.com ([198.137.202.136]:37651 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730054AbeKWIhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 03:37:09 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAMLqrSf3948247
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 22 Nov 2018 13:52:53 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAMLqrU33948243;
        Thu, 22 Nov 2018 13:52:53 -0800
Date:   Thu, 22 Nov 2018 13:52:53 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Babu Moger <tipbot@zytor.com>
Message-ID: <tip-1f8251d3bfadf42357cf6c3eebb5cda6cd3987b5@git.kernel.org>
Cc:     rafael@kernel.org, linux-doc@vger.kernel.org, arnd@arndb.de,
        dima@arista.com, hpa@zytor.com, chang.seok.bae@intel.com,
        jpoimboe@redhat.com, gregkh@linuxfoundation.org,
        dwmw2@infradead.org, mchehab+samsung@kernel.org,
        pombredanne@nexb.com, vkuznets@redhat.com, peterz@infradead.org,
        sherry.hurwitz@amd.com, mingo@redhat.com, jroedel@suse.de,
        mingo@kernel.org, reinette.chatre@intel.com,
        suravee.suthikulpanit@amd.com, xiaochen.shen@intel.com,
        akpm@linux-foundation.org, corbet@lwn.net, pbonzini@redhat.com,
        kstewart@linuxfoundation.org, Thomas.Lendacky@amd.com,
        kirill.shutemov@linux.intel.com, luto@kernel.org,
        Babu.Moger@amd.com, babu.moger@amd.com, tglx@linutronix.de,
        fenghua.yu@intel.com, linux-kernel@vger.kernel.org, bp@suse.de,
        puwen@hygon.cn, jannh@google.com, qianyue.zj@alibaba-inc.com,
        rian@alum.mit.edu, davem@davemloft.net, tony.luck@intel.com,
        brijesh.singh@amd.com
Reply-To: mingo@kernel.org, jroedel@suse.de, mingo@redhat.com,
          sherry.hurwitz@amd.com, peterz@infradead.org,
          vkuznets@redhat.com, mchehab+samsung@kernel.org,
          pombredanne@nexb.com, gregkh@linuxfoundation.org,
          dwmw2@infradead.org, jpoimboe@redhat.com,
          chang.seok.bae@intel.com, hpa@zytor.com, dima@arista.com,
          linux-doc@vger.kernel.org, arnd@arndb.de, rafael@kernel.org,
          davem@davemloft.net, tony.luck@intel.com, brijesh.singh@amd.com,
          qianyue.zj@alibaba-inc.com, rian@alum.mit.edu, bp@suse.de,
          puwen@hygon.cn, jannh@google.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, fenghua.yu@intel.com,
          Babu.Moger@amd.com, babu.moger@amd.com,
          kirill.shutemov@linux.intel.com, luto@kernel.org,
          Thomas.Lendacky@amd.com, kstewart@linuxfoundation.org,
          corbet@lwn.net, akpm@linux-foundation.org, pbonzini@redhat.com,
          xiaochen.shen@intel.com, suravee.suthikulpanit@amd.com,
          reinette.chatre@intel.com
In-Reply-To: <20181121202811.4492-14-babu.moger@amd.com>
References: <20181121202811.4492-14-babu.moger@amd.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] MAINTAINERS: Update resctrl filename patterns
Git-Commit-ID: 1f8251d3bfadf42357cf6c3eebb5cda6cd3987b5
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

Commit-ID:  1f8251d3bfadf42357cf6c3eebb5cda6cd3987b5
Gitweb:     https://git.kernel.org/tip/1f8251d3bfadf42357cf6c3eebb5cda6cd3987b5
Author:     Babu Moger <Babu.Moger@amd.com>
AuthorDate: Wed, 21 Nov 2018 20:28:49 +0000
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 22 Nov 2018 20:16:20 +0100

MAINTAINERS: Update resctrl filename patterns

The file nameswith intel_rdt* have been moved to the new directory
arch/x86/kernel/cpu/resctrl/. Update to reflect the changed files and
documentation.

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
Link: https://lkml.kernel.org/r/20181121202811.4492-14-babu.moger@amd.com
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b755a89fa325..b7d596e66ae6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12545,9 +12545,9 @@ M:	Fenghua Yu <fenghua.yu@intel.com>
 M:	Reinette Chatre <reinette.chatre@intel.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
-F:	arch/x86/kernel/cpu/intel_rdt*
-F:	arch/x86/include/asm/intel_rdt_sched.h
-F:	Documentation/x86/intel_rdt*
+F:	arch/x86/kernel/cpu/resctrl/
+F:	arch/x86/include/asm/resctrl_sched.h
+F:	Documentation/x86/resctrl*
 
 READ-COPY UPDATE (RCU)
 M:	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
