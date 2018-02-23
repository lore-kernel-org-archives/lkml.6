Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3684173-1519414239-2-17427250758380678236
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
    t=1519414238; b=M4xHwEw6I2YZB8G2Zq4vr5oiOeh/k593HWU2TlYhVDHSzG9
    ZRjulS/kigidOQhiHYJIa9m7Cd46U/KOndtzUr+MpAtyfZbWZLD5gHIc0F6IoVc0
    c6MBtC6h4evL8Vm3X4Lc8GzIKUsI/BLJOqL6yY22/sdcqoL/kbEu2cUM9SnQN6aU
    YJWDzki3yrp0nJJl0V98RH1zHgNCz/999uTY+wqLIam00bWa0Y6XxwHhdfeFMPqT
    AopMSQCpdueAnon5mpdKHl1rYOG5er0PJY7Coqe31kTuSIm2r4XHtvSEFqQ8CIr6
    CEFNZJXXgsYs0k+6VtehBSHtup4Aytb6+tBs+1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519414238; bh=EwaN7Vf3Z3S1mjGISLhjTT5Sf2
    SzyCiJXA29GMfhJWQ=; b=K/N7dvDkaug8EcQRb73AeZLqNDOGFSiG2cUnuHUtd6
    TOdgPxo1uU6OYXnibbYt7JOzfHpqunNxWr7ABq3mnrtT1vBVyDL/rT/7njrVwjj5
    khpUkjUBIRE0ZTtkZ2UrFbBvQPl0olNGTR7RMmfQUrZJajDD6+YSXwR01S5yIjEQ
    b6sT0Vk4Lo3vJfLCHdKRe7jiE7GPM6fb1/2eGVFWlj5YyTYgoGRSrVPD9LMW/uvO
    PEuNhNcYJMab1JMtE19ifngqayOngHAxBi42xcCktsPbooINHzGeLcVBEKBB+aOn
    jgPGgR/X1tmNwdMV/3UEahUFfycYXTUQ2JRJTAs8BSMQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754683AbeBWTag (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 14:30:36 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:46064 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934670AbeBWSvl (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:51:41 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.14 055/159] staging: fsl-mc: fix build testing on x86
Date: Fri, 23 Feb 2018 19:26:03 +0100
Message-Id: <20180223170750.276376545@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>

commit 02b7b2844c2ffd3b614ec2b9293e8c7f041d60da upstream.

Selecting GENERIC_MSI_IRQ_DOMAIN on x86 causes a compile-time error in
some configurations:

drivers/base/platform-msi.c:37:19: error: field 'arg' has incomplete type

On the other architectures, we are fine, but here we should have an additional
dependency on X86_LOCAL_APIC so we can get the PCI_MSI_IRQ_DOMAIN symbol.

Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/fsl-mc/bus/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/fsl-mc/bus/Kconfig
+++ b/drivers/staging/fsl-mc/bus/Kconfig
@@ -8,7 +8,7 @@
 
 config FSL_MC_BUS
 	bool "QorIQ DPAA2 fsl-mc bus driver"
-	depends on OF && (ARCH_LAYERSCAPE || (COMPILE_TEST && (ARM || ARM64 || X86 || PPC)))
+	depends on OF && (ARCH_LAYERSCAPE || (COMPILE_TEST && (ARM || ARM64 || X86_LOCAL_APIC || PPC)))
 	select GENERIC_MSI_IRQ_DOMAIN
 	help
 	  Driver to enable the bus infrastructure for the QorIQ DPAA2
