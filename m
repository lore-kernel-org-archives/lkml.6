Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22ABC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 672B821934
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550196683;
	bh=fk+BTELCR16rNQEvd7Q18bf6WcfziqbdP/6EenzKSiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BZPAZxx/oDTQs8Q3tH2gdmTvfGiPiTs+ew5DZX5/EB5EVrhlzAR+Agz08zB6DHSH8
	 dJ7WWkYl1VAayss206qODbcvauQednwqoXeaJlkKRsR6AbFY2LNkyBjPPwwr+a09FT
	 FdDuDwDo3aD+j3oulzawmEPuYxH7oR1c0l09C22w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732227AbfBOCLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:11:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:51358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbfBOCLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:11:20 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA05A206BA;
        Fri, 15 Feb 2019 02:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196679;
        bh=fk+BTELCR16rNQEvd7Q18bf6WcfziqbdP/6EenzKSiM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gr0dQEoqMIrHL+kQxK1By9yWH/HRwAp9aLj/lt/l0CB3374k75oIvDRBtFo8vVNul
         vGzrHGnUzXWybjhhwoxl+w9MmSENn6UyguS5ok5yk30B8Ido28dFrHo/ZeJhu2Lc9V
         OZdc05PZn683qk31y1nXX2VLgYxkdmfQifKVkWng=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 76/77] KVM: selftests: check returned evmcs version range
Date:   Thu, 14 Feb 2019 21:08:54 -0500
Message-Id: <20190215020855.176727-76-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215020855.176727-1-sashal@kernel.org>
References: <20190215020855.176727-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com>

[ Upstream commit 35b531a1e7fc30ac8c62e5ac1794eb1460da614e ]

Check that KVM_CAP_HYPERV_ENLIGHTENED_VMCS returns correct version range.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/kvm/x86_64/evmcs_test.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/evmcs_test.c b/tools/testing/selftests/kvm/x86_64/evmcs_test.c
index 92c2cfd1b182..5d89b30ddde2 100644
--- a/tools/testing/selftests/kvm/x86_64/evmcs_test.c
+++ b/tools/testing/selftests/kvm/x86_64/evmcs_test.c
@@ -103,6 +103,12 @@ int main(int argc, char *argv[])
 
 	vcpu_ioctl(vm, VCPU_ID, KVM_ENABLE_CAP, &enable_evmcs_cap);
 
+	/* KVM should return supported EVMCS version range */
+	TEST_ASSERT(((evmcs_ver >> 8) >= (evmcs_ver & 0xff)) &&
+		    (evmcs_ver & 0xff) > 0,
+		    "Incorrect EVMCS version range: %x:%x\n",
+		    evmcs_ver & 0xff, evmcs_ver >> 8);
+
 	run = vcpu_state(vm, VCPU_ID);
 
 	vcpu_regs_get(vm, VCPU_ID, &regs1);
-- 
2.19.1

