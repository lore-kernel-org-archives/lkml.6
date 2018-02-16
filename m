Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-431449-1518795396-2-17382871650564911538
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518795395; b=bnCuFJzpM66f/9hI/kYnOm6wrA1N4/23+X0EPYEW5zqyycX
    b/UyWBjoWQ4H0/95iLXPfDFH2GamdheIc1zUcYEmaxxYdtbJ8nOFqL/AtPFRRPmf
    Jj+aPLISw+he1BvwA/aiWagFlmpBpZm1SEPKSFF4VeUY7pyk49m1d+RxRawR+w6T
    +1Ki+akZXvBPBVd0/R9+VQKce0pyzqiWyp0P91YWKEWpvEN/Fs+Ljn9tfeygyj+X
    BcRzqSHjqKlMu7MKwttRc4MdrWWfdQI5tbqKfmtcuFFkO0Kbaeoq4DVJY+kl921/
    rR2N/9L4BPxEw1p5KXlUh2Otepw7Z2P2UNQR7KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1518795395; bh=TE4we2vt1aCBqSv3levjeSoKfP
    9Ywa4y16v0Oe5iJZc=; b=dlppkNIPeskoGwDcQdhjSoJYSzWj321MC9UFPVkOB/
    Y+4jk+xKJg8WySF6o+8ukoDb4RuTD9ULr+vwwuN6jzhrF55KDTEUtpa/N8bRruZZ
    kYgqLMJ/vzJJ5EaAE69BC6z27IbuE6Q3GZ7SvBqr14WTy02UZFoTREgSWF2+CB3l
    7mu21g7rBHxymJ2vJ2Tpqg7DeU2rfBsWm56tWL6sT6NtZ1JlXD24nrLuNvhowpV7
    ack5j+lUzncFfHljNv6lFI7GNn+ZqBYxGqPETfwgPntg/ndxVNb9IYiQ5ww1PWIg
    qdAupw/mlQbEkqhz8g+6d7k6xBVnCLiRpmZ3mj8tllaw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756191AbeBPPgc (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 10:36:32 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:47535 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752865AbeBPPgb (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Feb 2018 10:36:31 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org,
        Roy Pledge <roy.pledge@nxp.com>,
        Ioana Radulescu <ruxandra.radulescu@nxp.com>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH] staging: fsl-mc: fix build testing on x86
Date: Fri, 16 Feb 2018 16:36:04 +0100
Message-Id: <20180216153621.1632630-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:vOFOYvKQedDoV0J66f+YRVfqvYu0rRpE+B7GNSL5bGpVP8GjmEF
 tzqVpUKIegdRKScprViIuP7HO1Jm6qCkmt4Pv4raP58wXFhpQC1SJoMVKG0P72kUPsF4TXE
 oydTlVseGihCaQmYYS8TJIfI7A657UBd3PGVBoKVcfYqF0XrHV1jgVOz3fZRcY5iHWRakRm
 hOXpfE8zR52QFmHqtWzFg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Y2rNLQv91Js=:vSEkLS4+9rqcS/r+T/H/pg
 3b2nPwDeTdfcTU6mOPvFbIiRJGRywZa5qyAqPWWmsWMM9tootVgW3M6Aujv5IBLEJSWLbVlLz
 ShNnZ0aTSc3n/cLGLUskByEs68otjgPCWi82f1cK4eLmEMRE9Nw9w+W+9y4Kvz6oD9pRyRDmw
 p87pjfg39EG/PlIOLjwd0OpH7qxFiQiN4HO+Cl/IfDJYtO4KGPhdgYHvBLTB49nEMtUSH/Ebk
 pTgkJXVYeu+Hwh6BNzYPcrkwGd69kyv3MyrKx7acSNeneZZjmfAbUQXOwuIKyvDNPgPm3afCh
 jvQBxR7i2zgu8TA12o6we17tVSIYOL/nDNyY07rHcyycGtf89GuS6JSUD/xqOS0QcvHMzXTI3
 HweNTOmHxCEBrDZZqL6JE3N5ser6Q0FQXQyNAYjs2JFRF/hUf9FVAY0vhaVLIXhBXYjC0dFHm
 Ms/bR0AHlg/8F7O5rE/6GT5UolPWs2lG6Jz5iV1FpPSMELH1Pfc1+5UGSvKE2K3Y6h7X8Mc3J
 j+8YalsUMW5j+sY2mRLQ+kUNOotgHZ3INatZt/TrjmphJ7noLHQwhyVmOe2smhSiIebyt1jW1
 QQterQHqzeIhW+Rf4EUoZwYpNJP9HK1/BBseK1KBbGkUtH2o7hP+7yg7I0hbD+eQQQKgoM3qd
 HxpyvMelLZCVL2kErN9e1unbLWdh+janjj/qPwX4gm7+rA3NZ+hpOG1U5e7oTIHF81cwV/4rT
 r2vXgq0eAqxsm3sSNmZaun2Zeq7SqqU0+lWOWA==
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Selecting GENERIC_MSI_IRQ_DOMAIN on x86 causes a compile-time error in
some configurations:

drivers/base/platform-msi.c:37:19: error: field 'arg' has incomplete type

On the other architectures, we are fine, but here we should have an additional
dependency on X86_LOCAL_APIC so we can get the PCI_MSI_IRQ_DOMAIN symbol.

Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/fsl-mc/bus/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fsl-mc/bus/Kconfig b/drivers/staging/fsl-mc/bus/Kconfig
index 504c987447f2..eee1c1b277fa 100644
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
-- 
2.9.0
