Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3953AC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E24CC21A6E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZGPkGAit"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E24CC21A6E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387716AbeHFSu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:50:59 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52397 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387689AbeHFSu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:50:57 -0400
Received: by mail-wm0-f66.google.com with SMTP id o11-v6so14383188wmh.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 09:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5fRpq50lZXJwhRR4cll4FW2BMrTPAWBgy5AakciCwzI=;
        b=ZGPkGAitVZH43xaGKInnHdd7n/tyNFXUzL/qaHmZCe6+KqfeJS77EJC8jpTGmiU2SO
         FzBsG36dBCTrIkzWu7kBkjDSJ5fbo9HzHHpwULu2+NoF4YKnPx2mMKqPQ6pAqaU+lAht
         KS8yf0vS/2EMM6y6c5ON02j5qVjYR1ZgccetnnSEPi1qy0nKoCNXeGe3MBLWUTVcG4y5
         ZfZSGga8z9m37aTIH9e8f0b1iTeoQe63qTqsPyBHuvsvnOwmUUef0zRMpeqgFq8qOZTE
         KCQcpTxFLAh5tLjD/wxtGyP600A9uQuSjuRPT2mpi2rpLX/7Y0KGnc5Icm5Qoz0w3r+s
         oyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5fRpq50lZXJwhRR4cll4FW2BMrTPAWBgy5AakciCwzI=;
        b=th4bZqfdno/hc2VKcHqX+lUmej3Onyp8q/Ia5z5X1RL1XuNd/oWxrGqdlBWXjfZ/qo
         LznUZfiLQ9UKoZjhDPaYaBljXP9WziaA7YqzCKsYBBeQs87M+U4wvR/O+0panV5fAWep
         A/MDGiO9IPfyRwdnA92ZSNHBj6BHDYQacZNSypZ8+dVN9rkk4ItQxKbcyehzoaNpL8SM
         1Od7gU9gYqfFUWIT6qeBSfdrs4wqV08E00/bux6rH4FsY/CD0IwbQ2S9DhNiplAP1Kwd
         GjI5pvutkr/JDG+3ZuHtEHQz06/JNE8OUS9LISDiQBbmuoi1MnaevKJuGFp8atjOWwdk
         hl5g==
X-Gm-Message-State: AOUpUlER0tyyQ5V3bJuw6mhRXg2zFwWXwZJu4Cvtr2Hod1Xavw7rXbUG
        hVhwXtzc3XOvgxkZ8TK+lVJbSg==
X-Google-Smtp-Source: AAOMgpfY8aYVRq098HPSl5HcnHIV9H6zFUoOXHqCl8eBn+piyFbVnG/gEtDm0yEYaeKPInUxDQL8Gg==
X-Received: by 2002:a1c:4405:: with SMTP id r5-v6mr11514009wma.4.1533573662204;
        Mon, 06 Aug 2018 09:41:02 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id 66-v6sm16385790wmw.34.2018.08.06.09.41.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 09:41:01 -0700 (PDT)
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v5 06/10] arm64: untag user address in __do_user_fault
Date:   Mon,  6 Aug 2018 18:40:41 +0200
Message-Id: <d22f893405349d7d26d67161f9577eabfee27214.1533573460.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <cover.1533573460.git.andreyknvl@google.com>
References: <cover.1533573460.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In __do_user_fault the fault address is being compared to TASK_SIZE to
find out whether the address lies in the kernel or in user space. Since
the fault address is coming from a user it can be tagged.

Untag the pointer before comparing.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index b8eecc7b9531..89033d992d28 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -313,7 +313,7 @@ static void __do_user_fault(struct siginfo *info, unsigned int esr)
 	 * type", so we ignore this wrinkle and just return the translation
 	 * fault.)
 	 */
-	if (current->thread.fault_address >= TASK_SIZE) {
+	if (untagged_addr(current->thread.fault_address) >= TASK_SIZE) {
 		switch (ESR_ELx_EC(esr)) {
 		case ESR_ELx_EC_DABT_LOW:
 			/*
-- 
2.18.0.597.ga71716f1ad-goog

