Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3759000-1519415258-2-509468500979646739
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519415257; b=ICqADkiIkfqdIPQMujbor2tRdddeVkN2bVNH/dSydbFv+XT
    j1bD4nKmulkyek408glqv4EiTQw/xQWoA0Lg/+bxAkP7bF1Vb/VfykcQwllbg4WX
    E+NZyKvEYcutFJpQ5dhuvOjbVHYmvfYavXYe7M0/le0sp6PIHu+86g1zEMD4onqL
    Y4JhrItv+7XZRbx8XoG7x68tWZ6OjhfBD0hIU/5UpIX67GYLOmhH6OEz2fydNxw1
    PhkBw5GV4mygR9vnL5CXer1pzyLwQvHZ+fsZPOb3lyiCZEpTjHnKZRLQHwhhfEmx
    29urROlphq25gMEpnlJzvu6nLyIo0QrGOf9swFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415257; bh=7A8K6ItwbcIaYBW9SJlCSCB9kS
    yb4XyJ4hnGKYP8jxk=; b=V+p22jFYBlH62TA1lBwIfsnx9gNl8u9Z6gB5gueW1Q
    njFgHEc937VOrDI5tvmFds7iBCClqtH/ckbSG1dSl/EJgSWRKIaLK22W+oi0Ma1+
    woKCSm65W3stYxVkFO9uFRHS/4C/vezkvpCVuK/oLc/6GAhRbim3jSA67sE6qaAs
    WiB1ozXxz41eeTtDtRZMDS/egdXgdsAUoCG0rITDVePC66Lzt1Ic9hl5ujTjIrBO
    t2GBGQEPvFUeaVvi5Y/wvZQvGOCAbPSPNvl/DBOaVvTV/LvkuK2YYpax3ZPpfio+
    N21qtZrDDhkTCBYsFkIPMAH9qkG9sojNY2emebTKMp7g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934168AbeBWSr2 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:47:28 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44550 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933859AbeBWSrZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:47:25 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.9 113/145] x86/platform: Add PCI dependency for PUNIT_ATOM_DEBUG
Date: Fri, 23 Feb 2018 19:26:59 +0100
Message-Id: <20180223170739.449671175@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit d689c64d189e43d782fec5649fb0afe303c5b3f9 upstream.

The IOSF_MBI option requires PCI support, without it we get a harmless
Kconfig warning when it gets selected by PUNIT_ATOM_DEBUG:

  warning: (X86_INTEL_LPSS && SND_SST_IPC_ACPI && MMC_SDHCI_ACPI && PUNIT_ATOM_DEBUG) selects IOSF_MBI which has unmet direct dependencies (PCI)

This adds another dependency to avoid the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20170719125310.2487451-8-arnd@arndb.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/Kconfig.debug |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -352,6 +352,7 @@ config X86_DEBUG_FPU
 
 config PUNIT_ATOM_DEBUG
 	tristate "ATOM Punit debug driver"
+	depends on PCI
 	select DEBUG_FS
 	select IOSF_MBI
 	---help---
