Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2243538-1518720489-2-17264718123660444390
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518720489; b=WiDcP19+hPrTL2PmNF4k5bb5IxHiP9zr91Yf5bh/Y1ET8Ib
    N3Ubftb36yNfvoDLMSL582dN28QBlcepOnS7Dbhiq9fv+GdtZLNpczYViQcg4v1v
    JDKrgoOWFwI0NhFOy2U0hLgl9o0K7jnyQWbB+DGBJt8tMaoJclE5ik8rCec7omTE
    L67JKl3pxIPrXCtyATgz08Ee+0MAHvedTzjZF5KX3wRaATeOvm78F+v6EvfmQ+WZ
    gxlP5FVsuWsxTRSU/lExNwH5kImAGzurIPD7tjtbsJ1hyc8fFkEJu9+MgThVvfvk
    c243ScLhVNE+z7QF/VOqz3esIDr8Ga8zK3nAbLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518720489; bh=0ZuzqmVGs0vUeezeQrb4cw1QHh
    Qb3uLVhl7/hG4Cxh4=; b=CTsEifYcYSIZdUHsS5C1lup0ZVQExhsZtN0AZwI+Bm
    maL7K/usQTjlNfnJ0ZXkeXHpGjcZ8zVWj1BuKwd9Fp2oCOqTuZDYKuPFrGZZMsBV
    Eenmh2G/25A71qC+qMil1XJp7X2cavO5f9RCAiUUi+9ICllQxw4UcA8vWglOtpZb
    9nB2f7XyFkGmT7oBZy4s2y067gIgfCExsQI6otgtO4JRh4bM8H+c6wXkc8auqM6y
    OhSM6Q0Wzba5GulaBETVyLaPYp4oKA/cEDnrQiIVK+JWo4ndRrcYoxtMXzv8OQKj
    gN9Mogdad3NWxPNSbZ+VoN2ZmuLngW1mh35bP0XLbaVQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162454AbeBOSrx (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 13:47:53 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:49426 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162248AbeBOPWM (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:22:12 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Suchanek <msuchanek@suse.de>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.4 039/108] powerpc/pseries: include linux/types.h in asm/hvcall.h
Date: Thu, 15 Feb 2018 16:16:36 +0100
Message-Id: <20180215151227.896813714@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Suchanek <msuchanek@suse.de>

commit 1b689a95ce7427075f9ac9fb4aea1af530742b7f upstream.

Commit 6e032b350cd1 ("powerpc/powernv: Check device-tree for RFI flush
settings") uses u64 in asm/hvcall.h without including linux/types.h

This breaks hvcall.h users that do not include the header themselves.

Fixes: 6e032b350cd1 ("powerpc/powernv: Check device-tree for RFI flush settings")
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/include/asm/hvcall.h |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -298,6 +298,7 @@
 #define H_CPU_BEHAV_BNDS_CHK_SPEC_BAR	(1ull << 61) // IBM bit 2
 
 #ifndef __ASSEMBLY__
+#include <linux/types.h>
 
 /**
  * plpar_hcall_norets: - Make a pseries hypervisor call with no return arguments
