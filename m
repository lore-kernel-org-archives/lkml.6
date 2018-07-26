Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CF9C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 11:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4391B20883
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 11:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hbm7upEH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4391B20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbeGZMnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 08:43:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44110 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729107AbeGZMnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 08:43:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id r16-v6so1343104wrt.11;
        Thu, 26 Jul 2018 04:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=akcDNKmORlo5rC65czF7FwKplqI1nFhh8rI+M2m9tU8=;
        b=Hbm7upEHmMLkvCqFmBI3+HqEQvhD9b7fYCDRR3O7entAJPPVUMSYzVdfJzldh9d3Mn
         MaiL2W18xQxuJ1CzjZ+T6c/4NwfNvh2+/Ssp1I/oagYu90F+hh8NmP/o0n+FDtRmiXfo
         Cmu98lkvMuVQDIrwErjDzfZvBoTSHSFL8+UgWi7ZyQJNV1yh/rZpHC0Wm3y+E6WqmtDo
         ZGpUpWnP6imF6KCx+V/Iu5jBjDTcZTBqWz885pDlHYKHvUbFoNFq5PkTkLCycMC2sx7f
         3QeauGpcG8jAnBB26b0pqBoQVFNQlmBmD5EV8Er+fLt7O3+6Ol9eBOIM7vkGipJV2yEW
         0TEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=akcDNKmORlo5rC65czF7FwKplqI1nFhh8rI+M2m9tU8=;
        b=H+9n/fhS7CDpGbpr5s1m3VLenmq7rkvhtIadmiQR0pkOICrwb/9bxV+pm6Gbge+UVi
         lZrKL2wkaMAN3VfL2ZxtF5pwbV+gdWRMBgIM6tQU0WLHZZ/tRLCiEFX/1Lhm+TPEYv2/
         bc3Nf9webtf1NPaVqzXFKqGE/w/iU31OAUxbe5gvXbthkQNkpPnKK+ijCCkCXmL2CEw0
         /YxfzZR1Crow0Sg63bcXGpzQWNgVoasJhRbWyhP4t/0blyDx2FlCXjx7fRtvX0lMacK/
         1Sd75R/hQrRVp61hkXz6mpHqS+c5olCold7a2cte2USW1mtA8tDhUtfZvtoaYbYDRs9X
         /ECA==
X-Gm-Message-State: AOUpUlE4N8ZMz3HEvumsYSKe1nMnje8juckO0wGO/YfztnfkpLyxKujy
        lbwNgu0GiBgysni2tsyivGpo3kgY
X-Google-Smtp-Source: AAOMgpfXxe6aF2b94FmW3yBuoa7C4wN14441diR+KW2VSjf8hLIHWwP/xIHZ9mvq/Xw28QPlMi5NQg==
X-Received: by 2002:adf:aa0b:: with SMTP id p11-v6mr1231568wrd.220.1532604411900;
        Thu, 26 Jul 2018 04:26:51 -0700 (PDT)
Received: from donizetti.lan (94-36-184-250.adsl-ull.clienti.tiscali.it. [94.36.184.250])
        by smtp.gmail.com with ESMTPSA id t70-v6sm1793683wmt.30.2018.07.26.04.26.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 04:26:51 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     KarimAllah Ahmed <karahmed@amazon.de>,
        Jim Mattson <jmattson@google.com>
Subject: [PATCH 2/3] kvm: selftests: ensure vcpu file is released
Date:   Thu, 26 Jul 2018 13:26:46 +0200
Message-Id: <20180726112647.6272-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180726112647.6272-1-pbonzini@redhat.com>
References: <20180726112647.6272-1-pbonzini@redhat.com>
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
index 37e2a787d2fc..4930b1bdce62 100644
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
2.17.1


