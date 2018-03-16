Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3552852-1521221479-2-7845206125386911945
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521221478; b=OTl0lBMvmiN/2wKuij+8dQI0uQ0cDttFd1mthSyY9ExG3Gl
    Ufnp63dKWLqsNqWDp9gtb7c7LkEdWm16wWx1oV6E0kNJnURlQMuyRhY2iR4/L8HW
    SHPzLQ9292amlWSmUPnCBegXifWQdmOeJDCzPvShYNXj3K/KrI0bxBNOB+z8FDnv
    IfpDusVjLzeaOcEDV/6dd/1PozPRav/DeNiHCy1Cl2f7qheaioDkKDSqYg0UK7Cw
    WqLE1LJCDdibShcA+7f4TVVwUbJ3bA/zAeGyTx6ihFK5MEFJFGC6VAjbcEnN+3BH
    rSkDCQGwlYiTs3fchoDVaqL9f/uDv9dGo6njMhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521221478; bh=+hBBXVKk4rkUXn6ETSBQG1K1ga
    m5OX1a+60TWuPbxiE=; b=VeSi1GLkREaR0PP+bWSKrXPdsb+fub7m0cMGE3r2YI
    miHQX/q2DXJJjTUod0RSdVBdC/bfDQ0JMku329jPYj+SH11mSRCfAwKWLbcJhc2P
    9pISPhUAZ2xqUP5XoU389YVW1jeSInIjHcfLYupCyMKsSBPs0IeS0rChF0dsEUUT
    J8Lc/4aVIV4/qIwWEUiBDsjYgTr1pUiEIc26aXa8phvHlR+i+G6v2x0k6e1nsYLE
    Eyzyn70Gc3TnfZirH3nEuD5FPQtkGuVchrnUjGnr6Ax8o3Ac8KwmBWRuzQ2cyuAN
    bO0QArv89IYnegG+ptd3Wip0zYQaOSF8sv0GbcbqyfIg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752562AbeCPRbE (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 13:31:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34858 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754022AbeCPP1z (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:27:55 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Dan Murphy <dmurphy@ti.com>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.4 31/63] ARM: omap2: hide omap3_save_secure_ram on non-OMAP3 builds
Date: Fri, 16 Mar 2018 16:23:03 +0100
Message-Id: <20180316152303.485447004@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152259.964532775@linuxfoundation.org>
References: <20180316152259.964532775@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 863204cfdae98626a92535ac928ad79f4d6b74ff upstream.

In configurations without CONFIG_OMAP3 but with secure RAM support,
we now run into a link failure:

arch/arm/mach-omap2/omap-secure.o: In function `omap3_save_secure_ram':
omap-secure.c:(.text+0x130): undefined reference to `save_secure_ram_context'

The omap3_save_secure_ram() function is only called from the OMAP34xx
power management code, so we can simply hide that function in the
appropriate #ifdef.

Fixes: d09220a887f7 ("ARM: OMAP2+: Fix SRAM virt to phys translation for save_secure_ram_context")
Acked-by: Tony Lindgren <tony@atomide.com>
Tested-by: Dan Murphy <dmurphy@ti.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/mach-omap2/omap-secure.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm/mach-omap2/omap-secure.c
+++ b/arch/arm/mach-omap2/omap-secure.c
@@ -73,6 +73,7 @@ phys_addr_t omap_secure_ram_mempool_base
 	return omap_secure_memblock_base;
 }
 
+#if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_PM)
 u32 omap3_save_secure_ram(void __iomem *addr, int size)
 {
 	u32 ret;
@@ -91,6 +92,7 @@ u32 omap3_save_secure_ram(void __iomem *
 
 	return ret;
 }
+#endif
 
 /**
  * rx51_secure_dispatcher: Routine to dispatch secure PPA API calls
