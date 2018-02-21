Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2503644-1519249308-2-12206476026743235487
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519249308; b=Weya+iVIMncBTKQgSu/jXzQGYZzZt/kM3Y1UlicE4zDuDdP
    PoUUbGIWr6J8P8Vp/EnpiDYQgOXM+akAPSVVZU4ZmPmZdRn81hu7brwvXlbC8/OE
    Tya7DnCPbpTh3CZGbFCPjP3Af7IOMN0Rka9PFyRCI9xGF61+sb33+jjMdP5UmSS7
    GuDyGQj+Q44V6hcSvZp/LDmCWXuTEZLYZdJ8+ocPWLTQpTfSHKfHhOS/qJhP+6M6
    1RKMXkJwJ96KumxjRSac47bJnafMuChkAgCYKXyj9d11fBBUyKl+mP3RIcxHsK4G
    ygSlTdddcem2FkjCSoLWQl6j+2KnvStE6SF6Xrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=arctest; t=1519249308; bh=rzn/OvWCrHIy+q12kzHWP4mAat
    InSoLdTmvOmQ4eUdM=; b=Xozz6tzhgTb10kCnlqJcdXpyH4s55pKuFpQxTAjFs6
    CSx8QLFJ9o5gvnY+WraXXF0V+TJE1lW42hZTxP5o3ajIkFbl0Hui4NAKwCj2JUuL
    IgJ9bvXfRxx5yj3RvGG7lOyQSMbDjJcVdUlPH+P0XF2Gfpqexrvvmq8JNg6QaHxS
    fZnme1mIJOr336ivn+1QsT43y3AKwnFY6OUx7G1uG6NmaY2mn4yamZfo9E+YImQm
    kuGFAe/GC3tQ7Qt8g+a4AZCT2Cn4NlPBLVY24p7/33eR8aSTVdHGjMa3uPokdHt6
    ijTc+Gzk4z1kFS/lxFd/fkbt/wqykNc9K+M3hVyf4PXw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ht661+eC x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=dLTSLu0x;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ht661+eC x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=dLTSLu0x;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751119AbeBUVlp (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 16:41:45 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35949 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750805AbeBUVlo (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 16:41:44 -0500
X-Google-Smtp-Source: AH8x225oNxwNblsT5gXldGUxU6WyPTyoAyVmsEQXvNL4HpXkWtc8kBEVYgaH2c1JO63377aUOZw7Gg==
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: x86@kernel.org,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Jim Mattson <jmattson@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, stable@vger.kernel.org
Subject: [PATCH 0/3] x86/pti: KVM: fixes and optimizations for IBRS
Date: Wed, 21 Feb 2018 22:41:34 +0100
Message-Id: <1519249297-73718-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Three tiny patches fixing bugs and optimizing the IBRS code.  These
are all fairly obvious, but they escaped review.  They should go in
through the x86/pti tree and should apply to both 4.9 and 4.14 trees.

Thanks!

Paolo

Paolo Bonzini (3):
  KVM: x86: use native MSR ops for SPEC_CTRL
  KVM: nVMX: fix wrong condition for SPEC_CTRL and PRED_CMD MSRs
  KVM: VMX: mark RDMSR path as unlikely

 arch/x86/kvm/svm.c |  9 +++++----
 arch/x86/kvm/vmx.c | 15 ++++++++-------
 2 files changed, 13 insertions(+), 11 deletions(-)

-- 
1.8.3.1
