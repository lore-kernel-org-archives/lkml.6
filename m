Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1431546-1518324426-2-374780316531690611
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518324425; b=MYO6APSvhRNyeZY/UDOOhRsN7gr70IYTF2C7T4xl2octdVQ
    7FG/KfrB48dXHGeeoOPTSWucGL9VPRgaR7PDg7ch2KPIVvs0W3vEHpxZL2s3DeOe
    eMWbe5btI575KLpVq28rqkK//ykJxGwshOg8qwjxjkNgUSAAy2Ti4yjpgjaYLVwz
    pHKpA4QAdsu+j9AeWzkQdKKWHhr6pplLZB51L9n534kTmDRwyLxWlN0HxA3H6s6v
    EhW2WZ+NeV5fO00/v+pyaj6VmChOo6nVwSIV8cBEyPqfIPcGev21HAPIhbNEIchI
    PMPTfkrxIxcJjU2HFfvXEnZzH0VgE68qacQmxeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324425; bh=N7IDqcmr5QT30VatQmi
    vXet/0Urb3ZvN5XtNRG6GbJY=; b=TdLKvFaaJAhs22E3KxiRQwhogEpSZn34+Fk
    nAhbQnXMXOhf1ANWxwMg7QVtb2h9wdH4hcBDZFuNBlQtwultZToEoUs160PWfq5o
    ukTxPg/CaCV+Yl5u79CBGjMi/9aMbP1qdVSq3EfCD6r/3+S1LrJdZ2xlPUFfmPyJ
    3FOdc69x93xAvDQjTyu8D/pE0WfgID37AAhTo9QihEm12snWF7McBr0+fSKk7rH+
    MoFzlqUgxgFDVCOd31MS7UmBi0l8892Lum5i5WklhZr9GjIQSx13QJ/PTeRoqvVs
    kkzqy0nMyXQ3/mbTbYrKse5FJSPbz91ZvrQCk9rO/TdBlqQBUhg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753085AbeBKEpO (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:45:14 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41848 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752854AbeBKEd6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:58 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Neil Dick" <neil@cog.systems>,
        "Russell King" <rmk+kernel@armlinux.org.uk>,
        "Philip Derrin" <philip@cog.systems>,
        "Kees Cook" <keescook@chromium.org>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.993322817@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 102/136] ARM: 8721/1: mm: dump: check hardware RO bit
 for LPAE
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Philip Derrin <philip@cog.systems>

commit 3b0c0c922ff4be275a8beb87ce5657d16f355b54 upstream.

When CONFIG_ARM_LPAE is set, the PMD dump relies on the software
read-only bit to determine whether a page is writable. This
concealed a bug which left the kernel text section writable
(AP2=0) while marked read-only in the software bit.

In a kernel with the AP2 bug, the dump looks like this:

    ---[ Kernel Mapping ]---
    0xc0000000-0xc0200000           2M RW NX SHD
    0xc0200000-0xc0600000           4M ro x  SHD
    0xc0600000-0xc0800000           2M ro NX SHD
    0xc0800000-0xc4800000          64M RW NX SHD

The fix is to check that the software and hardware bits are both
set before displaying "ro". The dump then shows the true perms:

    ---[ Kernel Mapping ]---
    0xc0000000-0xc0200000           2M RW NX SHD
    0xc0200000-0xc0600000           4M RW x  SHD
    0xc0600000-0xc0800000           2M RW NX SHD
    0xc0800000-0xc4800000          64M RW NX SHD

Fixes: ded947798469 ("ARM: 8109/1: mm: Modify pte_write and pmd_write logic for LPAE")
Signed-off-by: Philip Derrin <philip@cog.systems>
Tested-by: Neil Dick <neil@cog.systems>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/arm/mm/dump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm/mm/dump.c
+++ b/arch/arm/mm/dump.c
@@ -126,8 +126,8 @@ static const struct prot_bits section_bi
 		.val	= PMD_SECT_USER,
 		.set	= "USR",
 	}, {
-		.mask	= L_PMD_SECT_RDONLY,
-		.val	= L_PMD_SECT_RDONLY,
+		.mask	= L_PMD_SECT_RDONLY | PMD_SECT_AP2,
+		.val	= L_PMD_SECT_RDONLY | PMD_SECT_AP2,
 		.set	= "ro",
 		.clear	= "RW",
 #elif __LINUX_ARM_ARCH__ >= 6
