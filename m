Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516909-1519834127-2-17104990845576021661
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519834127; b=shZ22H6x4lgBLDwQGIpDjcaiiQPJcNj1N7sBXzjpRcP9g3F
    kj+9pDhBAh1eCi+JZQ3uxqcKEAUXQup5XT59ImYZjGap6UjmEaViUPFIPRlE9Svn
    p1rVDPrJ2uU2GLec7Z72lLM5gn7SB16J6KRT3pdsrka+l2Sti1a8u4Ek2HtmxMAU
    jMspCdmxhbBcInoWFRFx61t517qgzAYyYan2B58NSkCSy1c5g/D4xXbKe8/CQlyi
    IdkTZX4l8oXPEr0EAUHoFu+J2u2b2LwVxS0kcITJQj+6d5dqkZ9RlJwZ0otaCOYL
    FuucV0Dc0AwRxTt9IwWXNXjQ611K5TgOleHZZiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519834127; bh=PilCS8QiKdKJKAqkkPM
    XHIDOyjtYc1C1pTfn8IbQBY4=; b=pucM7vtVn/RXsRy2WoB2XShCyM75GH+B+LY
    eE4tiiPmznEYtxscyZIE3lAIRKBO7+X4EKs87cEqL8rYV8FjJNWlvD3jqt56elY7
    BaSFLl+mfPaO/K6EDJOIvNd8w+qJzSyz0pzyUwZPTjuj/gNfWeGwfUJlhiDcc44O
    JpwB787TbMUJWww2GrEg4FbU7EaU1jvUGlX7SiJeA8WikojtE9skPjagz/OzZyWW
    3+zxxjevMJaDBoQphhytf+kbfIptsPK4IkaF3RC7w0XM0qFpQBkCi2HVs4uR9D5U
    KN0vgKHoBwSfoP74vW9WRbwQWVlApHVRn6UwCwtfKh6uNlsyf/A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933238AbeB1QIp (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:08:45 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34961 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934474AbeB1QIo (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:08:44 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Christoffer Dall" <christoffer.dall@linaro.org>,
        "Marc Zyngier" <marc.zyngier@arm.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.218667704@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 208/254] arm64: KVM: Fix SMCCC handling of
 unimplemented SMC/HVC calls
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>

commit acfb3b883f6d6a4b5d27ad7fdded11f6a09ae6dd upstream.

KVM doesn't follow the SMCCC when it comes to unimplemented calls,
and inject an UNDEF instead of returning an error. Since firmware
calls are now used for security mitigation, they are becoming more
common, and the undef is counter productive.

Instead, let's follow the SMCCC which states that -1 must be returned
to the caller when getting an unknown function number.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
[bwh: Backported to 3.16: use vcpu_reg()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/arm64/kvm/handle_exit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -34,7 +34,7 @@ static int handle_hvc(struct kvm_vcpu *v
 
 	ret = kvm_psci_call(vcpu);
 	if (ret < 0) {
-		kvm_inject_undefined(vcpu);
+		*vcpu_reg(vcpu, 0) = ~0UL;
 		return 1;
 	}
 
@@ -43,7 +43,7 @@ static int handle_hvc(struct kvm_vcpu *v
 
 static int handle_smc(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
-	kvm_inject_undefined(vcpu);
+	*vcpu_reg(vcpu, 0) = ~0UL;
 	return 1;
 }
 
