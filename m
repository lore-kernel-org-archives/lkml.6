Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E75DC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0441827E08
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BtOwTi8S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0441827E08
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936680AbeF2OCh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 10:02:37 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:40126 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936662AbeF2OCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 10:02:35 -0400
Received: by mail-pg0-f66.google.com with SMTP id w8-v6so4051082pgp.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 07:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uvosgf1N9qtGxuTqtWVf314atLsMKNgXkNX+PFJWIEg=;
        b=BtOwTi8SZ5Zdw44f+OHljBuo5QTixt4B6M4XLNtGqbWWZryS4fSRp1W16Vk/onn7xL
         sTZgRTsAKUah8X5P9ACqMnuIqiYAO2dULGQ09Y7zQIWYXIk8mJP7GzF1b5P14p1VxN2H
         wIevw27bI4UPskzi6gTUxwNzybOROW/Fh3sYJkgNJXlBOOZbnNqlZcGpj7vbNzrLo/+7
         fAUoe2dc3goyLrAGU3X7JuHLzXt5Ll2b6Krp+rwZTOaxFV4hCr2MQv3F4ZhldSvZulnW
         mIWS7BSXgMETBaOB0x9Y0q2BCbaACgLJ+rS12wwFdOki3F0XApVCP/eIs8uFpcIfTHrf
         aVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uvosgf1N9qtGxuTqtWVf314atLsMKNgXkNX+PFJWIEg=;
        b=jaRx129bVXnrLCQvJcTfkaIHzu81Zj87CqayDbqFX/pBZG15QrDyfMjxWHtq2OWuE3
         DJlYh0UXQNgSav6TkN/T07oZVZ3ND4u6l+ZLti1Db8iAHIUoxoTgNQFJcvpp2QiXM2Fe
         S6NuL69RqQ62kqMSzuXZA4E1uoRwwAgIzHJq6/F4vcEZrmOa/ek52CHgiZ/8gMo3Eu4k
         FDe4BN0UcDZGb8Z3ULntuiXa2VqyNXC4TKHNaVpraaZOptAXrBz1+I4DloYEu+1LBqCg
         8Cexqjk33aEMoy47kTaqLGno3SUSQb3jYE2R+y5w4SQhCRXHV6a0ThQuXEOONv7+M8GN
         OJpA==
X-Gm-Message-State: APt69E0wlANm1U7gtmOkQUNN2BxTKIYPwKSzBzNTO76t17m8ag8joRyq
        /7Rd3WnWW6Qejm4oDA35uDVfOA==
X-Google-Smtp-Source: AAOMgpfWU3mOSkcge8aysMCz/fqJzVgO7PoraqP3SShv2ewf/C8YDgDIfDNXtx4PYutfqvGKbU9hgg==
X-Received: by 2002:a62:484d:: with SMTP id v74-v6mr14736989pfa.256.1530280954093;
        Fri, 29 Jun 2018 07:02:34 -0700 (PDT)
Received: from shakeelb.mtv.corp.google.com ([2620:15c:2cb:201:3a5f:3a4f:fa44:6b63])
        by smtp.gmail.com with ESMTPSA id z25-v6sm1193111pgu.53.2018.06.29.07.02.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 07:02:32 -0700 (PDT)
From:   Shakeel Butt <shakeelb@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Greg Thelen <gthelen@google.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Peter Feiner <pfeiner@google.com>, stable@vger.kernel.org
Subject: [PATCH v2] kvm, mm: account shadow page tables to kmemcg
Date:   Fri, 29 Jun 2018 07:02:24 -0700
Message-Id: <20180629140224.205849-1-shakeelb@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The size of kvm's shadow page tables corresponds to the size of the
guest virtual machines on the system. Large VMs can spend a significant
amount of memory as shadow page tables which can not be left as system
memory overhead. So, account shadow page tables to the kmemcg.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Greg Thelen <gthelen@google.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Peter Feiner <pfeiner@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: stable@vger.kernel.org
---
Changelog since v1:
- replaced (GFP_KERNEL|__GFP_ACCOUNT) with GFP_KERNEL_ACCOUNT

 arch/x86/kvm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index d594690d8b95..6b8f11521c41 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -890,7 +890,7 @@ static int mmu_topup_memory_cache_page(struct kvm_mmu_memory_cache *cache,
 	if (cache->nobjs >= min)
 		return 0;
 	while (cache->nobjs < ARRAY_SIZE(cache->objects)) {
-		page = (void *)__get_free_page(GFP_KERNEL);
+		page = (void *)__get_free_page(GFP_KERNEL_ACCOUNT);
 		if (!page)
 			return -ENOMEM;
 		cache->objects[cache->nobjs++] = page;
-- 
2.18.0.rc2.346.g013aa6912e-goog

