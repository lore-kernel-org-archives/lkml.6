Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-497764-1524652713-2-10113712004589589845
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524652713; b=OXs1PsKD+tDAyU1fH75JpC7zxB96hEVVdRVtoSV2kSlAghUhfJ
    Kdoeu9tmb+AtSzqPGMQ0YGKZGho2Lz3dl+rRzdHq/Anx5MOqaOCDlJHalZwv4iPW
    GwjweCvfmOF7YnF1srfPUhYCYJ4D+mu/uQoqAfQ1B1TWrLDAAPiecfVUTy6kjYe2
    NeewIYCv7D85rWQzE8PodG0OGn6CcwB4Oi2kOKu3Z68ZnYDS2bUvg8UfynGbIww+
    Cmczw/rjMS1RwbKcAXuKyaH9N4SVrgufihqxTZKuo9Jx/9/TcflTLTK0Qmm2Qa5Z
    AEO8Trj+jhTSKdWZZRk/Xaj9QclsjU/AFxPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524652713; bh=7TkSUAjN+138uB22XeC1TLwNAxGTcO
    YZ+u+7hVrcZN4=; b=YXPz/IfP1n0P1CaZG/RRje1AgO3so4JDnZpQ/oKJAWK6kO
    Ai2BPGX972g7S92yvs3HMk+qYkQ5HKhFE1ugPcfs46OswjYnJJVN/UCzkO+900vH
    TV6H/w8MqeN5EbIPU7KFlgPYI552sztcRrRyvpdE1Vr7tzz24QP4t+0Y1/5/0q67
    kHr4G+/+3tjA2hudq1RJF9AAP3sMJ5ltdnz1H88O9WtJ+7C+c9vSZ/8YnBAOHkGj
    B47iseKsmivje2lfczZ2KvdycGDKVNvaOgAyLHkwt2reVTXPafi3z/w9fJQzRjkf
    I4NE7pn928JZt9QceOZw04+zYmH1shCTmtWmDuCg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDMzaoEpM0STxkIdA6MUoCfDAu/FUw3u/b7S8tnn2sXZ3I8pe9zy9xaqbwiNmSWkZ7M23Gapb/ApZpuguupCPAk5EFpJTONL1iqWu6eEAb33RNVMeZjA
    rUlYs3Rhtf2AfLaQ8Y+A8ECTYrpBqW+7LWWL0GEnfsKKxxE7CYGbhQfKzysZh409UBUDSeVVuSJ58G/qfW5jstNxbDbDpeFNB+BZGLnCpu0BdCe2l7JpUAVF
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=dtcjQaNrXMv9M4JicLcA:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752902AbeDYKi3 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:38:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51312 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753407AbeDYKiN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:38:13 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Halil Pasic <pasic@linux.vnet.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 027/183] KVM: s390: use created_vcpus in more places
Date: Wed, 25 Apr 2018 12:34:07 +0200
Message-Id: <20180425103243.690185380@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Borntraeger <borntraeger@de.ibm.com>


[ Upstream commit 241e3ec0faf5ab1a0d9b1f6c43eefa919fb9c112 ]

commit a03825bbd0c3 ("KVM: s390: use kvm->created_vcpus") introduced
kvm->created_vcpus to avoid races with the existing kvm->online_vcpus
scheme. One place was "forgotten" and one new place was "added".
Let's fix those.

Reported-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Fixes: 4e0b1ab72b8a ("KVM: s390: gs support for kvm guests")
Fixes: a03825bbd0c3 ("KVM: s390: use kvm->created_vcpus")
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/kvm/kvm-s390.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -601,7 +601,7 @@ static int kvm_vm_ioctl_enable_cap(struc
 	case KVM_CAP_S390_GS:
 		r = -EINVAL;
 		mutex_lock(&kvm->lock);
-		if (atomic_read(&kvm->online_vcpus)) {
+		if (kvm->created_vcpus) {
 			r = -EBUSY;
 		} else if (test_facility(133)) {
 			set_kvm_facility(kvm->arch.model.fac_mask, 133);
@@ -1121,7 +1121,7 @@ static int kvm_s390_set_processor_feat(s
 		return -EINVAL;
 
 	mutex_lock(&kvm->lock);
-	if (!atomic_read(&kvm->online_vcpus)) {
+	if (!kvm->created_vcpus) {
 		bitmap_copy(kvm->arch.cpu_feat, (unsigned long *) data.feat,
 			    KVM_S390_VM_CPU_FEAT_NR_BITS);
 		ret = 0;
