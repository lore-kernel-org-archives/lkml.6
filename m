Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4110486-1521766762-2-3247896299115437841
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521766762; b=WjgB01y0g/JDg2g+/w06i1d7PHLAnlr4OF1WGrW770enttQ
    DXqywNKBNYp2lns3xxhZfSg7TvUItrIO2eVq2HBHw0fAz0AbsQMyRKpJK5o2lPVA
    2UhQEKobZcV9xHViK3cfPeAm65W/Lr+zimoyNWN4Gl9kbSDN8173e7Xc3wlI3ZCF
    Nth7j2RJzX72vCI+93bJpBRZVtj+vK3KXfkUR8Wi3sCTlAvI6GlFlNMw2XdLO+hs
    Met4wgHkcSKPXnwCtlYgCrTSOc9UonyM5vDm+oPfqlwmp1zcD3wUS3I+1tHmgb0s
    3ONz/qTMS0CL0x+QaOvuar79gbhSD7t0UYHrOcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521766762; bh=DbLzConcB/wmanEPKc2FYyfbc8eEkeU4uEzaBIyGhns=; b=q
    N+2J9SZcgYjhrCdLtvAwx1c4BzMJC+5Mcw98nQq6NSAkSB6jtwKgFDP2G4sPw9+9
    GHEJGMIJ91iUIOLe+x+bV/oqU4yQQ2A11ISQw0DlNo/3hCcQYHktdFoywamTJK48
    5YElicAUaIX8OjdXEsWwEsCfRw5d+Q2LxEBWLA4sLRRuwlNFvutsrqzMQ2cTxHHk
    G6QfnyyUzH33/Yg1i7Z24oFn7KJ9Z79ZbyWYxyM7QtBlNGuLaqVnRdvXFpzzHr9m
    54CRm08hNfxRB2u+4BSTxWm30KPGyAA272xpx4yRcgHHhJYo+Xz0BdqUbtv5/UQA
    U2zDmzahOmoyY9nGqB70Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751899AbeCWA7F (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 20:59:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40360 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751719AbeCWAzu (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 22 Mar 2018 20:55:50 -0400
From: jglisse@redhat.com
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        stable@vger.kernel.org, Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Evgeny Baskakov <ebaskakov@nvidia.com>
Subject: [PATCH 02/15] mm/hmm: fix header file if/else/endif maze v2
Date: Thu, 22 Mar 2018 20:55:14 -0400
Message-Id: <20180323005527.758-3-jglisse@redhat.com>
In-Reply-To: <20180323005527.758-1-jglisse@redhat.com>
References: <20180323005527.758-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jérôme Glisse <jglisse@redhat.com>

The #if/#else/#endif for IS_ENABLED(CONFIG_HMM) were wrong. Because
of this after multiple include there was multiple definition of both
hmm_mm_init() and hmm_mm_destroy() leading to build failure if HMM
was enabled (CONFIG_HMM set).

Changed since v1:
  - Fix the maze when CONFIG_HMM is disabled not just when it is
    disabled. This fix bot build failure.
  - Improved commit message.

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Acked-by: Balbir Singh <bsingharora@gmail.com>
Cc: stable@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Evgeny Baskakov <ebaskakov@nvidia.com>
---
 include/linux/hmm.h | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 325017ad9311..36dd21fe5caf 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -498,23 +498,16 @@ struct hmm_device {
 struct hmm_device *hmm_device_new(void *drvdata);
 void hmm_device_put(struct hmm_device *hmm_device);
 #endif /* CONFIG_DEVICE_PRIVATE || CONFIG_DEVICE_PUBLIC */
-#endif /* IS_ENABLED(CONFIG_HMM) */
 
 /* Below are for HMM internal use only! Not to be used by device driver! */
-#if IS_ENABLED(CONFIG_HMM_MIRROR)
 void hmm_mm_destroy(struct mm_struct *mm);
 
 static inline void hmm_mm_init(struct mm_struct *mm)
 {
 	mm->hmm = NULL;
 }
-#else /* IS_ENABLED(CONFIG_HMM_MIRROR) */
-static inline void hmm_mm_destroy(struct mm_struct *mm) {}
-static inline void hmm_mm_init(struct mm_struct *mm) {}
-#endif /* IS_ENABLED(CONFIG_HMM_MIRROR) */
-
-
 #else /* IS_ENABLED(CONFIG_HMM) */
 static inline void hmm_mm_destroy(struct mm_struct *mm) {}
 static inline void hmm_mm_init(struct mm_struct *mm) {}
+#endif /* IS_ENABLED(CONFIG_HMM) */
 #endif /* LINUX_HMM_H */
-- 
2.14.3
