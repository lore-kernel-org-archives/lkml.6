Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348841625709
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E665120881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:38:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E665120881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731597AbeG3TO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:14:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54821 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbeG3TO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:14:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6UHcQGT2388628
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 30 Jul 2018 10:38:26 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6UHcQ7q2388625;
        Mon, 30 Jul 2018 10:38:26 -0700
Date:   Mon, 30 Jul 2018 10:38:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dou Liyang <tipbot@zytor.com>
Message-ID: <tip-1088c6eef261939bda8346ec35b513790a2111d5@git.kernel.org>
Cc:     pasha.tatashin@oracle.com, pbonzini@redhat.com, mingo@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        rkrcmar@redhat.com, douly.fnst@cn.fujitsu.com, kvm@vger.kernel.org,
        hpa@zytor.com
Reply-To: hpa@zytor.com, kvm@vger.kernel.org, douly.fnst@cn.fujitsu.com,
          rkrcmar@redhat.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, pbonzini@redhat.com, mingo@kernel.org,
          pasha.tatashin@oracle.com
In-Reply-To: <20180730075421.22830-3-douly.fnst@cn.fujitsu.com>
References: <20180730075421.22830-3-douly.fnst@cn.fujitsu.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/kvmclock: Mark kvm_get_preset_lpj() as __init
Git-Commit-ID: 1088c6eef261939bda8346ec35b513790a2111d5
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

Commit-ID:  1088c6eef261939bda8346ec35b513790a2111d5
Gitweb:     https://git.kernel.org/tip/1088c6eef261939bda8346ec35b513790a2111d5
Author:     Dou Liyang <douly.fnst@cn.fujitsu.com>
AuthorDate: Mon, 30 Jul 2018 15:54:21 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 30 Jul 2018 19:33:35 +0200

x86/kvmclock: Mark kvm_get_preset_lpj() as __init

kvm_get_preset_lpj() is only called from kvmclock_init(), so mark it __init
as well.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: <hpa@zytor.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc:   Radim Krčmář<rkrcmar@redhat.com>
Cc:  <kvm@vger.kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: kvm@vger.kernel.org
Link: https://lkml.kernel.org/r/20180730075421.22830-3-douly.fnst@cn.fujitsu.com

---
 arch/x86/kernel/kvmclock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 91b94c0ae4e3..d2edd7e6c294 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -145,7 +145,7 @@ static unsigned long kvm_get_tsc_khz(void)
 	return pvclock_tsc_khz(this_cpu_pvti());
 }
 
-static void kvm_get_preset_lpj(void)
+static void __init kvm_get_preset_lpj(void)
 {
 	unsigned long khz;
 	u64 lpj;
