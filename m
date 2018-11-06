Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D613C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 06:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60ED52081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 06:01:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60ED52081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbeKFPYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 10:24:55 -0500
Received: from mga04.intel.com ([192.55.52.120]:36463 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729326AbeKFPYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 10:24:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2018 22:01:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,470,1534834800"; 
   d="scan'208";a="271698783"
Received: from optiplex-7050.sh.intel.com ([10.239.161.26])
  by orsmga005.jf.intel.com with ESMTP; 05 Nov 2018 22:01:20 -0800
From:   Liu Jingqi <jingqi.liu@intel.com>
To:     pbonzini@redhat.com, rkrcmar@redhat.com, tglx@linutronix.de,
        mingo@redhat.com
Cc:     bp@alien8.de, hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, tao3.xu@intel.com,
        Liu Jingqi <jingqi.liu@intel.com>
Subject: [PATCH v2 0/2] KVM: x86: expose direct stores instructions into VM.
Date:   Tue,  6 Nov 2018 13:55:26 +0800
Message-Id: <1541483728-7826-1-git-send-email-jingqi.liu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Direct stores instructions MOVDIRI and MOVDIR64B will be available in
Tremont and other future x86 processors,
and need to be exposed to guest VM.

The release document ref below link:
https://software.intel.com/sites/default/files/managed/c5/15/\
architecture-instruction-set-extensions-programming-reference.pdf

This series expose movdiri and movdir64b features to guest VM.

Changelog:
v2:
	Separated from the series https://lkml.org/lkml/2018/7/10/160
	since umonitor/umwait/tpause instructions patches are not ready yet.
v1:
	Sent out with umonitor/umwait/tpause instructions patches.

Liu Jingqi (2):
  KVM: x86: expose MOVDIRI CPU feature into VM.
  KVM: x86: expose MOVDIR64B CPU feature into VM.

 arch/x86/kvm/cpuid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.7.4

