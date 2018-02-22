Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-488377-1519314257-2-16455977242425886215
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519314256; b=YTJmvCyEdK3J5lleTHZ/jQtoMPawTB/QkcXmjc218PvFfgR
    Hi2FawgvFmokMFjDrjab2L5Tc4qC/opEHfGBosKvBLmZ1ahIGyhOzGabMcK4F2NN
    lWLzjoK5jC+9bQGYpJ1mjTqeEI6vvJOUiHAnzmKEzGxc+NwY0u62Iug4/wzUmuM+
    N8NfsM2bqX39ldyurxC7a7YOTK6dEdonyGVS6Gn6ttP0MKL5Uay18pEnW9ER4Gi1
    gl0JxzkIkPJwUzq/D5iBAg4k7SQXDemf0qWqlA5ePVP46TtGrDv8/xDXVWU4GyxN
    N2wYw01eZR3An0BC38MA22UV+tZOdZoaqd0sAHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1519314256; bh=4wAIGqHHgnJBJMLHvAno01K4oL
    hWtZvTp/7J53D5oWY=; b=hsGg0QpVPaCVgHWZLfj3DFfbvUnMFrY7uqbkHnMrrD
    DGXMdSevLbCSNCSYe/uWC6+fldf+E+4zk8bU1Fw8jwJ+STNYw0Y8Q4Gir/KAUzIS
    ODL3glYT7iCkVWY3ULzhqBYeyYuNX0U9E5AMkna6mXmGtR3XHZTD6MK0jMZlbk8e
    qcGs3pdDdbQIjOmslZFIHuqmZHC2U/QvWi3HRALCWWVWBoKT0WK01Qt9Z/klsw0n
    LOs5SvulUMgYV7BvPGFgIWoOthbb5QccU8fx7HJy67Q50UZDR7Q++zST4q2D297t
    ACKdM8WlVycv8EVe8+oKN5EK80IioTA088nG8BWWdxUA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=fh0ZgC8r x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JSrH09ng;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=fh0ZgC8r x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JSrH09ng;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933012AbeBVPnY (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Feb 2018 10:43:24 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54132 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932902AbeBVPnX (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Feb 2018 10:43:23 -0500
X-Google-Smtp-Source: AH8x227R2aMg3dk4WMs2oKUE2uDdHJC64uRU4j1y18RuEY9+IrXQmcbczZF3MDV8NSh4ChsiNeM9aw==
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: x86@kernel.org,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Jim Mattson <jmattson@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, stable@vger.kernel.org
Subject: [PATCH v2 0/2] x86/pti: KVM: fixes and optimizations for IBRS
Date: Thu, 22 Feb 2018 16:43:16 +0100
Message-Id: <20180222154318.20361-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.14.3
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Two tiny patches for the IBRS code.  They should go in
through the x86/pti tree and should apply to both 4.9 and 4.14 trees.

Thanks,

Paolo

v1->v2: remove patch 2, the same bug has already been fixed

Paolo Bonzini (3):
  KVM: x86: use native MSR ops for SPEC_CTRL
  KVM: VMX: mark RDMSR path as unlikely

 arch/x86/kvm/svm.c |  9 +++++----
 arch/x86/kvm/vmx.c |  9 +++++----
 2 files changed, 10 insertions(+), 8 deletions(-)

-- 
1.8.3.1
