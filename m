Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD78C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5BE820851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQHlCc9E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5BE820851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbeLDL3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:29:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:42072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726856AbeLDK5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:57:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82691214DE;
        Tue,  4 Dec 2018 10:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921075;
        bh=LCn1xWwtdbBk7Y7HD3/DOyoVv29B36dXrWCYR/EqLmA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vQHlCc9EKis7WS6fGjaxiSInAC/q8nFTRhC3CQcBiT74DZZeERngomMe9QHX45Mmj
         PwSqhOqJqT/+9IzjvwDVApG7iOoCAMS/kT+2PXDOnslSRMGCsoUAk+XCHiXfg0z0Ev
         f5TWH2uNH55jnU6uomHJatAV1yyj7nEX0E2SUDJQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Luiz Capitulino <lcapitulino@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.19 069/139] KVM: VMX: re-add ple_gap module parameter
Date:   Tue,  4 Dec 2018 11:49:10 +0100
Message-Id: <20181204103652.898835287@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luiz Capitulino <lcapitulino@redhat.com>

commit a87c99e61236ba8ca962ce97a19fab5ebd588d35 upstream.

Apparently, the ple_gap parameter was accidentally removed
by commit c8e88717cfc6b36bedea22368d97667446318291. Add it
back.

Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
Cc: stable@vger.kernel.org
Fixes: c8e88717cfc6b36bedea22368d97667446318291
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -170,6 +170,7 @@ module_param_named(preemption_timer, ena
  * refer SDM volume 3b section 21.6.13 & 22.1.3.
  */
 static unsigned int ple_gap = KVM_DEFAULT_PLE_GAP;
+module_param(ple_gap, uint, 0444);
 
 static unsigned int ple_window = KVM_VMX_DEFAULT_PLE_WINDOW;
 module_param(ple_window, uint, 0444);


