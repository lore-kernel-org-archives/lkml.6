Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1797899-1518707854-2-9824452808064944325
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
    t=1518707853; b=l8NY+mPJc35PqF/ziZnINTwF9M2y75+4cK87SzL7i5pu+a7
    cE3/Sph+YdPe/Tzbrb9ZOIB3rmbkOluKvZvJ1J2J94yhrfoHwmdGQjKWKveM3TIN
    YyJiUR6L2TOnPSv/U/dBP6nPH7NNUcszVS4VR4ArmzPzP6YAnvuGYyCM1CRAUG/v
    HzuEXiEz4X0bMqpqZt8YwoRixa35R4ZVxRBpTmuVc4B71rSLrcdHJ4VtY/j9wf9A
    VGqcbUiorBubHFGx2IEMIp37aPOX5A2j9MJHLAQjOolMxmsOzGVCfmYC768IKwiK
    nW3t6TSz2HW/wAyMEcofFBTJzfERoo3npsTIGRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1518707853;
    bh=6fZQWwXNgoKldEK81nRIh9exMF0Gby73+ZdE/s0PjM0=; b=pBb88XxAhCTA
    k57L/iucb+PfFxZICtGNcLcLR1Ct86DoUBbiIi0g793eKuix4HpJVF13XR1C0uXV
    V2xMtR8AaEdEW5UhGdojJCHSS1+e1AsNBtOmYmPp2I0fQwfsfPd+OZU4fqKoX0PA
    8WH0r7LwnpPV+iwtucpV5nwJM//IR6BEr+arbD0HAT1abtnxIXSwzSDVsa2iGEPH
    ugogBYdiu4AFCynhkppXiiWrOZkMe074TJIB0Wm2mWk/qP4arTgtqwHenRDsJiRx
    6p6I7UgU6kPDSQYMEUgSotmn52gHzR38QXJSmKeeJJQ+yzmoybGqpwm75siFJvqa
    +/K1M6wweA==
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
        id S1033584AbeBOPRa (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:17:30 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:39797 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033088AbeBOPR3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:17:29 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: stable@vger.kernel.org
Cc: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hugh Dickins <hughd@google.com>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] [stable-4.9] x86: fix build warnign with 32-bit PAE
Date: Thu, 15 Feb 2018 16:16:57 +0100
Message-Id: <20180215151710.1473117-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180215151710.1473117-1-arnd@arndb.de>
References: <20180215151710.1473117-1-arnd@arndb.de>
X-Provags-ID: V03:K0:ZNEkpV+/34a5mlinGmWrfrlUi1bGOknfRjdA77UbQDa2uH/i4Ut
 YVnSnSvm1zVSZmd+q1Oki0n5u6trO1LhVxJcX2QxSEM2TRvDtzplT5iSoBB7ZMY1l7q265Q
 JyQ8oAg943pkonpdXoEaNm2itwd5urm042Cu+ofd8oQAQc9++0SUMWp7f1/0lp5ZqvcO9Gy
 eewWVWJUuSQ4cPuIVm6Xw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rrq9rkZDoqw=:BPNt7asxlwirS73qWWlyug
 nUPxa1m9ApVs4VDMe45tljT9SwWQclGYHhPwXyUWy0F5iQKCk71pExzcuml2qXb2sG+9oPF6d
 RsoMBAM+Fwc7YGJ0GEWUh6h/0ArPmfOl+Yvv0WI9gzIJ0VSlY1cdqSpKjeEazmA19kDO5I1qZ
 Bt9HNydGFYU+reugr8xwtQtSETf6hpPUPhQYpvIq+4u7uO5VT25rS1HDEEcAtuyCeVq7U+Hfs
 d7O9gXFFigdSBjbiz8fEuwAlSKAinFerrCQVm2uWRlmychdzR5zc+zjDdCPwixchCsIqUmi/E
 JVHfxHb/D9locM1XJ4K5jc7vohmhlfGhITO5fQCs6N0mwYa4W9UybuCrbzs4M0+zWUcxRlGpd
 5G8ESyVQw7SVDMUp0uGWJa79n2hrjkAFhFQsxh6mv7hT6ZCKTQcmp9XxXDyDEF3S9j9NE3+SV
 kWu+ZyFBPny4c7geh8lOHyKvYF34SQQ8B7qK63J4zg/SQIIC+3y+4/be4lC780yCMYXROOVRQ
 9uAPYCS7ewghwf8tbKvNbwhkfE8C1JdFknmwCrW0CO9eNelXVuapp/FgBl55dD56q6368O3mZ
 tQE9LXqFAVAkOoOgSMoz07BJMklJpMLJoPodpJgNFZJI3GT8P0lUyHcVHZRMxPmNWiF2UzAmL
 1RSOD5cwcvi7VRg600Dpdp0IqxuHyryCG9WielweezgVW9O+IpEHQriruO7lDcu8ANDd9fDvd
 MRysy63bmgTkwcd1+YbP9XxZo5ICUfDyogrxSw==
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I ran into a 4.9 build warning in randconfig testing, starting with the
KAISER patches:

arch/x86/kernel/ldt.c: In function 'alloc_ldt_struct':
arch/x86/include/asm/pgtable_types.h:208:24: error: large integer implicitly truncated to unsigned type [-Werror=overflow]
 #define __PAGE_KERNEL  (__PAGE_KERNEL_EXEC | _PAGE_NX)
                        ^
arch/x86/kernel/ldt.c:81:6: note: in expansion of macro '__PAGE_KERNEL'
      __PAGE_KERNEL);
      ^~~~~~~~~~~~~

I originally ran into this last year when the patches were part of linux-next,
and tried to work around it by using the proper 'pteval_t' types consistently,
but that caused additional problems.

This takes a much simpler approach, and makes the argument type of the dummy
helper always 64-bit, which is wide enough for any page table layout and
won't hurt since this call is just an empty stub anyway.

Fixes: 8f0baadf2bea ("kaiser: merged update")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Hugh Dickins <hughd@google.com>
---
 include/linux/kaiser.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kaiser.h b/include/linux/kaiser.h
index 58c55b1589d0..b56c19010480 100644
--- a/include/linux/kaiser.h
+++ b/include/linux/kaiser.h
@@ -32,7 +32,7 @@ static inline void kaiser_init(void)
 {
 }
 static inline int kaiser_add_mapping(unsigned long addr,
-				     unsigned long size, unsigned long flags)
+				     unsigned long size, u64 flags)
 {
 	return 0;
 }
-- 
2.9.0
