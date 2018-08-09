Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7325C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 744E02238C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S86C41Sx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 744E02238C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbeHIVrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 17:47:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46241 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbeHIVrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 17:47:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id h14-v6so6067882wrw.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 12:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GuTtM2nMrJ4Dauv6kbJ/TNvmQSeA8vc6xmRa98AW0qs=;
        b=S86C41SxOkkA8LBqFkpGV082ZyZNGC5QXHiWw3T1sDHhydoGXq5vi07VfyMKChS7Sv
         Iz5d45gyPejwEm//MqYruIpmrVBNH48A3qms4bWpdTCqCleD9znCNyEiox0DrAuzXVNg
         RmyODypNQp4LL9JXBxYdGfunCTrPLSe2taxfSQavGRSj1pwjmn8u6GTECTagwyUTHx9X
         s1hfaOhM086GaejmBTAL5KQbzL4Z7liCLMyQkqZQeXkNkfu4Cn38T7tpr8Av/auJ2rj4
         4k/Bv3rIHlS8YHxntefOQYqOaUepl2oJX4KlBAZWMyTy+fUp8E9uyScz3vDUpmWoEMCI
         Is9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GuTtM2nMrJ4Dauv6kbJ/TNvmQSeA8vc6xmRa98AW0qs=;
        b=PX4gUlTJOkOeg0r0U5Ebr2Vqo82qsfAgLfEOQKKWQWV3KXrhV6y5KDs48Hlqtrvqmt
         2tJjDiLiUp04tDwwL1hhh4zCt+E8vNU6e0Sm//TOwkSzTczfLbyvbWQTcaOQ2EKwdE3e
         k2QlrJyBopE7/snLGbzR1iMKU+7YYjPRT868jsjSJL+q/0lOTeG7oWG5hDVlU+67w91j
         +knWtx2bj1ulr834bgAwnQq9Eimhsw4FMqX4l+2bB6rRT9EWvNA26IVOOiFQHpxcj1C3
         KBoPcgq56H5tR86W/k1ViUvsd74I5Ap+B6e96trZXjWqbHmL2KilM1FMsmqXGoshDWEK
         hkBw==
X-Gm-Message-State: AOUpUlGodtTl5iI+lPselFqhdLl2KIOV1lrxaSLWNaAQKtRdWNV/We3z
        tz4b/ePVK16k5UMgNn300ydeAA==
X-Google-Smtp-Source: AA+uWPxhKq2oJvxj9GKtDLnX44F7dLpq6UJjkmFDNe3axY/KVJQUX9aqWFA6v9GYuLkDRiiBufCDGg==
X-Received: by 2002:a5d:4007:: with SMTP id n7-v6mr2348121wrp.258.1533842493247;
        Thu, 09 Aug 2018 12:21:33 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id o14-v6sm14738797wmd.35.2018.08.09.12.21.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 12:21:32 -0700 (PDT)
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sparse@vger.kernel.org, linux-mm@kvack.org,
        linux-kbuild@vger.kernel.org
Cc:     Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Vishwath Mohan <vishwath@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v5 11/18] khwasan, mm: perform untagged pointers comparison in krealloc
Date:   Thu,  9 Aug 2018 21:21:03 +0200
Message-Id: <3fbf2a591009f1b9743e82a51ec09019eb054c10.1533842385.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <cover.1533842385.git.andreyknvl@google.com>
References: <cover.1533842385.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The krealloc function checks where the same buffer was reused or a new one
allocated by comparing kernel pointers. KHWASAN changes memory tag on the
krealloc'ed chunk of memory and therefore also changes the pointer tag of
the returned pointer. Therefore we need to perform comparison on untagged
(with tags reset) pointers to check whether it's the same memory region or
not.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/slab_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index a99a1feb52c4..e17ed1573d08 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1513,7 +1513,7 @@ void *krealloc(const void *p, size_t new_size, gfp_t flags)
 	}
 
 	ret = __do_krealloc(p, new_size, flags);
-	if (ret && p != ret)
+	if (ret && khwasan_reset_tag(p) != khwasan_reset_tag(ret))
 		kfree(p);
 
 	return ret;
-- 
2.18.0.597.ga71716f1ad-goog

