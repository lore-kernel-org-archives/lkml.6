Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62D0C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CCD420878
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvCD1blb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CCD420878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731674AbeG2Aid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 20:38:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41243 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731476AbeG2Aib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 20:38:31 -0400
Received: by mail-wr1-f66.google.com with SMTP id j5-v6so8713517wrr.8;
        Sat, 28 Jul 2018 16:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1XPI82+EjefEHs/WUh8QKH10Gy/6FHGlAufvQWv9+7A=;
        b=JvCD1blbUMsT75DWwv6EW5QuVFIvAzHlviPP41YkjbcJ3RtRlryVRNhKcBUazIdJQP
         BBo+4SXLWeH/HMTZg6uZTw7p2kn+zHQedwB27v1wabtRlw6HRvKvM6KXknmyOQaLb5UF
         MCWXhi1r55z9ZChHvXs79pPx0/FuSaO59j6mM5i8rspH+0EYdGRHXF+0eXFslb7tDbgj
         zdruz+ZI2hAF495ET7lVmpQ503J+8kYUMl74f93uuAt0bH5P5JKN76oPdZ1+0aln31oo
         3yeMTzRRIa02P7QDumPKOxgIdbTH4bwblEnucs+XCzCbbhCiO4khC5SNkxjAh+qBsFC7
         trMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=1XPI82+EjefEHs/WUh8QKH10Gy/6FHGlAufvQWv9+7A=;
        b=ZIlqCJQTDEBYo7s2kF2QcKesB0SJds549/9DrWQI73oFy1/tX2SSQixo4ZzPoXVlyw
         CIWiW9qWM7gTw6+z9bQGNkuRVavFWIM9l7+wFyUbnpVhgIS64uUMfMnKlzEoP0V97g4A
         lwWZ5xfyIZElVRm2tYCPRrizUEPhIQuPvK1cIJ0v5Esla2hFVvNOeYFaHKpSp7fkcpPQ
         oLsrN44Ii9sJudILQ+GOiC2MbaJnAW4GZQ1YhO6nrwfAEs4yVdflCyFVnGcqigVFtd8m
         2cysnsW49d96Mw/eZ0c64rzfxWtMiaJRG8e1uNYxt2mnjxORHpYfTuqoGGu+Wrazu+NR
         hFJg==
X-Gm-Message-State: AOUpUlG2vcqr+bEdAtxnF0RkelIty/t49hMX/4sPMeMfp2MJly4pmGFH
        XgYijOi5BdU6Ct/LcqLaJIUZa3d8
X-Google-Smtp-Source: AAOMgpegQ0QSM7ZZl6SFUTokgpCW9EIXVJArsp01gdCsJ6tCpSddou9yGtpLQEGZ9GRQ+hHPdxBDUA==
X-Received: by 2002:adf:e584:: with SMTP id l4-v6mr10332670wrm.190.1532819420966;
        Sat, 28 Jul 2018 16:10:20 -0700 (PDT)
Received: from 640k.lan (94-36-184-250.adsl-ull.clienti.tiscali.it. [94.36.184.250])
        by smtp.gmail.com with ESMTPSA id j6-v6sm6190725wro.13.2018.07.28.16.10.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 16:10:20 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Liran Alon <liran.alon@oracle.com>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        Jim Mattson <jmattson@google.com>, rkrcmar@redhat.com
Subject: [PATCH 04/10] kvm: selftests: ensure vcpu file is released
Date:   Sun, 29 Jul 2018 01:10:06 +0200
Message-Id: <1532819412-51357-5-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1532819412-51357-1-git-send-email-pbonzini@redhat.com>
References: <1532819412-51357-1-git-send-email-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The selftests were not munmap-ing the kvm_run area from the vcpu file descriptor.
The result was that kvm_vcpu_release was not called and a reference was left in the
parent "struct kvm".  Ultimately this was visible in the upcoming state save/restore
test as an error when KVM attempted to create a duplicate debugfs entry.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 610d1326f03d..163482873363 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -238,8 +238,12 @@ struct vcpu *vcpu_find(struct kvm_vm *vm,
 static void vm_vcpu_rm(struct kvm_vm *vm, uint32_t vcpuid)
 {
 	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
+	int ret;
 
-	int ret = close(vcpu->fd);
+	ret = munmap(vcpu->state, sizeof(*vcpu->state));
+	TEST_ASSERT(ret == 0, "munmap of VCPU fd failed, rc: %i "
+		"errno: %i", ret, errno);
+	close(vcpu->fd);
 	TEST_ASSERT(ret == 0, "Close of VCPU fd failed, rc: %i "
 		"errno: %i", ret, errno);
 
@@ -295,6 +299,10 @@ void kvm_vm_free(struct kvm_vm *vmp)
 	TEST_ASSERT(ret == 0, "Close of vm fd failed,\n"
 		"  vmp->fd: %i rc: %i errno: %i", vmp->fd, ret, errno);
 
+	close(vmp->kvm_fd);
+	TEST_ASSERT(ret == 0, "Close of /dev/kvm fd failed,\n"
+		"  vmp->kvm_fd: %i rc: %i errno: %i", vmp->kvm_fd, ret, errno);
+
 	/* Free the structure describing the VM. */
 	free(vmp);
 }
-- 
1.8.3.1

