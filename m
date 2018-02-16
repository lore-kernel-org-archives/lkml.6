Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-399776-1518794898-2-17626464584312977908
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: cc='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518794898; b=dQ+Ry0c6QSgXWmccGB9N6t5L9JDsAiAgrnIGxo7MPgxpAWi
    38jVvMAS3xonFXU69oOtups6pdTYeSjwSzlE8NU/dP1uIHlazNQgztaqfWkujzo5
    YL4jQayempnfKLOAUXQ5rvcs1HeH+ymWYlyzkpqlIxwrq2Z6L8bUDJ+IDnghpoGx
    VReqB9Kt41zSOeBjuPBRNpeJCwxEmur+nqv2zrJONu8uRhOt3QVEUVZq45B8wT0a
    IrOy+c75nIZUkwQ2CYBdiIN4grCN45ac6xpp/mWFmovvvU3nkF7VR/ak+r/d6O77
    g2XROt8ps+IRbyfvJ5VKFno7rT8fa8x1a7WJc2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1518794898; bh=51cAjeMyYDmcAhz8+dnbMU9YsV
    uJq6UG9VKGNSWkcrI=; b=Qxj8yDvKDFz8Up+tE57eG/khB3SRIlQZbyN/egvOLr
    hIqL5TSPBWfWDHlfFo7BsOAtPY75w2+RpmIyAjknxEovBwKferqLy9K6NLd/B2xM
    lFqAjG30sa6t4XCB9C++ps6cttQipL+cNK3i8Q3wBCkPaa0Vt39ftGx6zZAfLVL0
    d6pfsmmDlgB1B/ecgJFKgqs1trHtdsgSKeo4lTSmknfl5S2786uP19S+fvwHsDYa
    oR+oOWxJIJYNIPqLYF7K33Cl9AU3NIPjkFkcnej1rJPCpxWc0wpgBbJ2T9LebMBy
    l2z3MNUywdTOoatwjeoZsQquuD7shndbWsuyyOvlLlWQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966894AbeBPP1T (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 10:27:19 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:52127 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966777AbeBPP1Q (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Feb 2018 10:27:16 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Jan Kara <jack@suse.cz>,
        Ingo Molnar <mingo@kernel.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Huang Ying <ying.huang@intel.com>,
        Matthew Wilcox <willy@linux.intel.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Hugh Dickins <hughd@google.com>, Tobin C Harding <me@tobin.cc>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: hide a #warning for COMPILE_TEST
Date: Fri, 16 Feb 2018 16:25:53 +0100
Message-Id: <20180216152608.1626885-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:yb5R5+63usM4B6KEamRGCh5tRuPeo+GH1DZj5yGyVp3KyXYUEoC
 /skDIhiHCvysV3TgLa6XdffS/o0i4lqhFYYOlfNNo31br7rnnHNnuHVd+5LZ8nDN/x/mqNQ
 Tfu1dXgqHpDVGcYPTpBUklZILd+Cp44qH4b4HLGd00NNBg4iQGgUB+m4ipA0LB3Ft5lABve
 jNRk4+USCqYp9m4oz+vpA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DGst4t+wn/g=:zu7CAG9xor2VIeKiU1DhgD
 ikoNVI2efljRjaLgVfCZ6mRf9R4eLzNyGQi7tthkBxZzq+N0awC0zr75iLNLYj31YNid+1qhc
 As69gmYB9prL+QFcf/0tqMUDgsZNWVCiLkFEKUe2NW/NZ1sRw/YY9Z8OnCeHeoUI8yphMU1AT
 wAKOHCoHTCcOOlcgafMPNT8llQy9MF4WZKxt+NsvBJxZIwvFE2AszW/z+24pIKwyV9l/6R0E4
 04yglI+REVr5ac10Mzz44M6vQJCmCS5fAL56lDXRG7V6CTJehYKKjptWupSWgn9PMOp7wyhpw
 WB7XxFF2v/+w7ZFOi+IFgNZsNJ6j9+ZDC9c+ogR5INPDK2jHOhO8Dk+FiqaJWLlhIy5PLsDgQ
 HYrFGpdVAt5Qx0d8Jh36YtGoMb41ECYTOtZ1PSqQhLVhK/paRYgytijDdon5rFyN7OuXH7yDr
 EdexvQQYWCVNAbFcbAfCzBbuJQsjHOlZhxfprFQPfzPbVLxoloS6ec/0xBSJmCAmzHEuQRwJ4
 nbd0cnl+A4Xe3r4TlQ3CErw9XLVB+6IOHBCz1AlgQkHyxkTKZ6N/Z4ccQ1LFK084K1F9F385Q
 rl+0TgE2dK7oP2KUhxOem3YsHCrCTmEeXtaAxh2IyXwhKIv+7VskBLefMhmd+gFo7nEF9KTdf
 yMZodcDATQ0JZhnumWnGMt+GKEZCKgjv399gldDH/TnsL46WrclihEGBe9Br6JtV4KJ3FKHWB
 mPLWj+6xKcO24wLjML3Cg2AXKGB6GFxYAv05+g==
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We get a warning about some slow configurations in randconfig kernels:

mm/memory.c:83:2: error: #warning Unfortunate NUMA and NUMA Balancing config, growing page-frame for last_cpupid. [-Werror=cpp]

The warning is reasonable by itself, but gets in the way of
randconfig build testing, so I'm hiding it whenever CONFIG_COMPILE_TEST
is set. The warning was added in 2013 in commit 75980e97dacc ("mm: fold
page->_last_nid into page->flags where possible").

Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index a728bed16c20..fc7779165dcf 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -81,7 +81,7 @@
 
 #include "internal.h"
 
-#ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
+#if defined(LAST_CPUPID_NOT_IN_PAGE_FLAGS) && !defined(CONFIG_COMPILE_TEST)
 #warning Unfortunate NUMA and NUMA Balancing config, growing page-frame for last_cpupid.
 #endif
 
-- 
2.9.0
