Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-25021-1521511313-2-17810780383226719149
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
    t=1521511313; b=ECtM47bS658FWIa2M//7gAbQHMZRNm2G7KUK85V0us/ACfx
    TtBdaSZPCXKsPriVv6DMXUxTxG3guATyXpNsxXLNDktDS+o8TDeZfTn14jOnBzqI
    5eIYaQwNDPtwSLY3EcPzsZ0CKtoecOPfDYI1km7qDRztUA+5KMfHsT/zZCkuPxIe
    fdB3tcdytLNCp1kLj46i3GwGHm2lK3jJ/fyryyQiJoJWHMXh3g5sBvubUTezG6Dj
    0AxPV0XRf5x2PEf9jHsWm93mz/XYjbSo4QiH3eStdfZ7ZueuuoQ/hL4Kk3N3kPRA
    IO9shC278Swpm5orrBYvyFr1QQzk1M2la80h4uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521511313; bh=DbLzConcB/wmanEPKc2FYyfbc8eEkeU4uEzaBIyGhns=; b=A
    rLmiC3a3+dQVHVQOMgUMAez/iYkSqsiRKSLIDPoe+4ubxTsU3tCML70GxfrsHWof
    hNTWHQLa1IiKTjvS5IaAyGvBNT7/8PuDB8RirN9to5QGX91QfegvsMKpWO6WAnSB
    F0JGe1vsOok98wKbru5K7hTOClVgFDTzSmzbp0q22jXVEwuaw87tsosG/w/AoZW3
    KEQ4TJO42XyXAHailjkxux8Qt1ki8GyNgS57NxCrgYmoIl/j2MQXRmqCVBshzIMS
    ZfgDQ7hhgX82oWq7BT/ZlblHRMsavUF6VixumzbLoru8IjwsCe0faWfUvowDoXZ0
    zAC7bTOydMCWFHxoEnNGg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggdegvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhggtgfgshhpjeesthekredttddtjeenucfhrhhomhepjhhglhhishhsvgesrhgvughhrghtrdgtohhmnecukfhppedvtdelrddufedvrddukedtrdeijedpieeirddukeejrddvfeefrdejfeenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeegudehheenucevlhhushhtvghrufhiiigvpedvle
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggdegvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhggtgfgshhpjeesthekredttddtjeenucfhrhhomhepjhhglhhishhsvgesrhgvughhrghtrdgtohhmnecukfhppedvtdelrddufedvrddukedtrdeijedpieeirddukeejrddvfeefrdejfeenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeegudehheenucevlhhushhtvghrufhiiigvpedvle
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752108AbeCTCAw (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 22:00:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45144 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752041AbeCTCAm (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 22:00:42 -0400
From: jglisse@redhat.com
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        stable@vger.kernel.org, Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Evgeny Baskakov <ebaskakov@nvidia.com>
Subject: [PATCH 02/15] mm/hmm: fix header file if/else/endif maze v2
Date: Mon, 19 Mar 2018 22:00:24 -0400
Message-Id: <20180320020038.3360-3-jglisse@redhat.com>
In-Reply-To: <20180320020038.3360-1-jglisse@redhat.com>
References: <20180320020038.3360-1-jglisse@redhat.com>
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
