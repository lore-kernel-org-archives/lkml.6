Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DD5ECDFBD
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D91E120652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D91E120652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390246AbeGTNbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:31:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54158 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390236AbeGTNbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:31:42 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B82A4D29;
        Fri, 20 Jul 2018 12:39:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.17 061/101] x86/kvm/Kconfig: Ensure CRYPTO_DEV_CCP_DD state at minimum matches KVM_AMD
Date:   Fri, 20 Jul 2018 14:14:07 +0200
Message-Id: <20180720121425.824594413@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121422.837870592@linuxfoundation.org>
References: <20180720121422.837870592@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>

commit d30f370d3a4998c13ed3e5c8ef607d05be0a987a upstream.

Prevent a config where KVM_AMD=y and CRYPTO_DEV_CCP_DD=m thereby ensuring
that AMD Secure Processor device driver will be built-in when KVM_AMD is
also built-in.

v1->v2:
* Removed usage of 'imply' Kconfig option.
* Change patch commit message.

Fixes: 505c9e94d832 ("KVM: x86: prefer "depends on" to "select" for SEV")

Cc: <stable@vger.kernel.org> # 4.16.x
Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Reviewed-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -85,7 +85,7 @@ config KVM_AMD_SEV
 	def_bool y
 	bool "AMD Secure Encrypted Virtualization (SEV) support"
 	depends on KVM_AMD && X86_64
-	depends on CRYPTO_DEV_CCP && CRYPTO_DEV_CCP_DD && CRYPTO_DEV_SP_PSP
+	depends on CRYPTO_DEV_SP_PSP && !(KVM_AMD=y && CRYPTO_DEV_CCP_DD=m)
 	---help---
 	Provides support for launching Encrypted VMs on AMD processors.
 


