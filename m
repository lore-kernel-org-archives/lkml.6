Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7207C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C63D20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfAQRMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 12:12:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50968 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfAQRMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 12:12:15 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BB91BD792C;
        Thu, 17 Jan 2019 17:12:15 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B8E1817D86;
        Thu, 17 Jan 2019 17:12:11 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, Liran Alon <liran.alon@oracle.com>
Subject: [PATCH 0/2] x86/kvm/hyper-v: fix KVM_CAP_HYPERV_ENLIGHTENED_VMCS
Date:   Thu, 17 Jan 2019 18:12:08 +0100
Message-Id: <20190117171210.9493-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 17 Jan 2019 17:12:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e2e871ab2f02 ("x86/kvm/hyper-v: Introduce nested_get_evmcs_version()
helper") broke KVM_CAP_HYPERV_ENLIGHTENED_VMCS: the returned evmcs version
is always zero now. Fix the issue and add a check to evmcs selftest.

The offending commit is in 5.0-rc1, it would be great if the fix could be
queued before 5.0.

Vitaly Kuznetsov (2):
  x86/kvm/hyper-v: nested_enable_evmcs() sets vmcs_version incorrectly
  KVM: selftests: check returned evmcs version range

 arch/x86/kvm/vmx/evmcs.c                        | 7 ++++---
 tools/testing/selftests/kvm/x86_64/evmcs_test.c | 6 ++++++
 2 files changed, 10 insertions(+), 3 deletions(-)

-- 
2.20.1

