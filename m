Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B27C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DD4D20818
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:50:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD4D20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407687AbeKWIbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 03:31:38 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54675 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731179AbeKWIbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 03:31:37 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAMLnNlF3947609
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 22 Nov 2018 13:49:23 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAMLnNc63947605;
        Thu, 22 Nov 2018 13:49:23 -0800
Date:   Thu, 22 Nov 2018 13:49:23 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Babu Moger <tipbot@zytor.com>
Message-ID: <tip-580ebb66cbb3de979adb4becbad7bd383746f162@git.kernel.org>
Cc:     brijesh.singh@amd.com, linux-doc@vger.kernel.org,
        gregkh@linuxfoundation.org, dwmw2@infradead.org,
        pombredanne@nexb.com, davem@davemloft.net, pbonzini@redhat.com,
        rian@alum.mit.edu, chang.seok.bae@intel.com, jpoimboe@redhat.com,
        puwen@hygon.cn, mingo@redhat.com, bp@suse.de, rafael@kernel.org,
        qianyue.zj@alibaba-inc.com, babu.moger@amd.com, hpa@zytor.com,
        tony.luck@intel.com, vkuznets@redhat.com, Thomas.Lendacky@amd.com,
        suravee.suthikulpanit@amd.com, reinette.chatre@intel.com,
        akpm@linux-foundation.org, fenghua.yu@intel.com,
        kirill.shutemov@linux.intel.com, dima@arista.com,
        peterz@infradead.org, tglx@linutronix.de, sherry.hurwitz@amd.com,
        jroedel@suse.de, Babu.Moger@amd.com, linux-kernel@vger.kernel.org,
        jannh@google.com, luto@kernel.org, mingo@kernel.org,
        xiaochen.shen@intel.com, corbet@lwn.net, arnd@arndb.de,
        kstewart@linuxfoundation.org, mchehab+samsung@kernel.org
Reply-To: xiaochen.shen@intel.com, mingo@kernel.org,
          kstewart@linuxfoundation.org, mchehab+samsung@kernel.org,
          corbet@lwn.net, arnd@arndb.de, peterz@infradead.org,
          dima@arista.com, jroedel@suse.de, sherry.hurwitz@amd.com,
          jannh@google.com, luto@kernel.org, Babu.Moger@amd.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          fenghua.yu@intel.com, kirill.shutemov@linux.intel.com,
          tony.luck@intel.com, vkuznets@redhat.com,
          Thomas.Lendacky@amd.com, suravee.suthikulpanit@amd.com,
          reinette.chatre@intel.com, akpm@linux-foundation.org,
          qianyue.zj@alibaba-inc.com, hpa@zytor.com, babu.moger@amd.com,
          bp@suse.de, rafael@kernel.org, chang.seok.bae@intel.com,
          pbonzini@redhat.com, rian@alum.mit.edu, mingo@redhat.com,
          puwen@hygon.cn, jpoimboe@redhat.com, brijesh.singh@amd.com,
          linux-doc@vger.kernel.org, dwmw2@infradead.org,
          gregkh@linuxfoundation.org, davem@davemloft.net,
          pombredanne@nexb.com
In-Reply-To: <20181121202811.4492-8-babu.moger@amd.com>
References: <20181121202811.4492-8-babu.moger@amd.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/resctrl: Add vendor check for the MBA software
 controller
Git-Commit-ID: 580ebb66cbb3de979adb4becbad7bd383746f162
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

Commit-ID:  580ebb66cbb3de979adb4becbad7bd383746f162
Gitweb:     https://git.kernel.org/tip/580ebb66cbb3de979adb4becbad7bd383746f162
Author:     Babu Moger <Babu.Moger@amd.com>
AuthorDate: Wed, 21 Nov 2018 20:28:37 +0000
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 22 Nov 2018 20:16:19 +0100

x86/resctrl: Add vendor check for the MBA software controller

MBA software controller support is available only on Intel.

Suggested-by: Fenghua Yu <fenghua.yu@intel.com>
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
Link: https://lkml.kernel.org/r/20181121202811.4492-8-babu.moger@amd.com
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index cf159095b612..fada488069cb 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1878,7 +1878,10 @@ static int parse_rdtgroupfs_options(char *data)
 			if (ret)
 				goto out;
 		} else if (!strcmp(token, "mba_MBps")) {
-			ret = set_mba_sc(true);
+			if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+				ret = set_mba_sc(true);
+			else
+				ret = -EINVAL;
 			if (ret)
 				goto out;
 		} else {
