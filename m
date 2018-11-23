Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618CBC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 17:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0736A20824
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 17:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0736A20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440715AbeKXDrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 22:47:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36364 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391367AbeKXDrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 22:47:19 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 79E543154861;
        Fri, 23 Nov 2018 17:02:16 +0000 (UTC)
Received: from doriath (ovpn-116-114.phx2.redhat.com [10.3.116.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6BAC7648BA;
        Fri, 23 Nov 2018 17:02:15 +0000 (UTC)
Date:   Fri, 23 Nov 2018 12:02:14 -0500
From:   Luiz Capitulino <lcapitulino@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     babu.moger@amd.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: VMX: re-add ple_gap module parameter
Message-ID: <20181123120214.174457a4@doriath>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Fri, 23 Nov 2018 17:02:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Apparently, the ple_gap parameter was accidentally removed
by commit c8e88717cfc6b36bedea22368d97667446318291. Add it
back.

Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
---
 arch/x86/kvm/vmx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 4555077d69ce..be6f13f1c25f 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -174,6 +174,7 @@ module_param_named(preemption_timer, enable_preemption_timer, bool, S_IRUGO);
  * refer SDM volume 3b section 21.6.13 & 22.1.3.
  */
 static unsigned int ple_gap = KVM_DEFAULT_PLE_GAP;
+module_param(ple_gap, uint, 0444);
 
 static unsigned int ple_window = KVM_VMX_DEFAULT_PLE_WINDOW;
 module_param(ple_window, uint, 0444);
-- 
2.17.2

