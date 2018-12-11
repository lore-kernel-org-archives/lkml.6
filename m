Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940E5C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67AC220870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:38:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67AC220870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbeLKRif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 12:38:35 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33302 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbeLKRie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 12:38:34 -0500
Received: by mail-pf1-f194.google.com with SMTP id c123so7481321pfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 09:38:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L189s+4lYyDH5hDUG0QHPq+EE4gVCfNBeFJ6BGhUuAI=;
        b=QAXzUg/N/WJSkwOJYu+ZkjA4mevkaKNYPRowgHNY1ZUd1sweTY3/EuG1xTaJRUwmYy
         4OOM/XrwkdklDEC5ohi323H2K4DnelJcPNCLxY6OOtAI8pGlxrGsoww8DZ/lpuaf1DzQ
         r6OJouyL5a6LrdURDjId8BWC3Lbcy7djMm5uLscJic34VM17+X/InJWyFLzACKgHkx13
         YYB99hCD5HShr9Vg30XGUc4o1espfBZ87GTbmcFFfgPK++IEgtTguNOF36PKBsS5ZL73
         z5qIujW9XIcSx142ihxBDNTUNbZs+nNbm1aTPRk6Kf30cNxy8TIVEZZESQa05hAKPtGc
         6eTA==
X-Gm-Message-State: AA+aEWa0lrYhaGKg0NQ+f8o+phT9aV/ZS+D53QbF2NhfD6ntxEDln1+0
        CuhM7rUjO4qDYXBt2JZZnEIxDJGG2Jw=
X-Google-Smtp-Source: AFSGD/XFzdjbXz67WuViL8xa217MhRQVnbJeq4C8D3/46lojjpdwWqLMdYVGTT3NWTfOqy1XbAalcw==
X-Received: by 2002:a63:5c41:: with SMTP id n1mr14698278pgm.1.1544549913622;
        Tue, 11 Dec 2018 09:38:33 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id m85sm22760223pfj.171.2018.12.11.09.38.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 09:38:32 -0800 (PST)
Message-ID: <1544549911.185366.384.camel@acm.org>
Subject: Re: [PATCH v3 05/24] liblockdep: Rename "trywlock" into "trywrlock"
From:   Bart Van Assche <bvanassche@acm.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     mingo@redhat.com, peterz@infradead.org, tj@kernel.org,
        longman@redhat.com, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Date:   Tue, 11 Dec 2018 09:38:31 -0800
In-Reply-To: <20181211171923.GO97256@sasha-vm>
References: <20181207011148.251812-1-bvanassche@acm.org>
         <20181207011148.251812-6-bvanassche@acm.org>
         <20181211171923.GO97256@sasha-vm>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-11 at 12:19 -0500, Sasha Levin wrote:
+AD4 On Thu, Dec 06, 2018 at 05:11:29PM -0800, Bart Van Assche wrote:
+AD4 +AD4 This patch avoids that the following compiler warning is reported while
+AD4 +AD4 compiling the lockdep unit tests:
+AD4 +AD4 
+AD4 +AD4 include/liblockdep/rwlock.h: In function 'liblockdep+AF8-pthread+AF8-rwlock+AF8-trywlock':
+AD4 +AD4 include/liblockdep/rwlock.h:66:9: warning: implicit declaration of function 'pthread+AF8-rwlock+AF8-trywlock'+ADs did you mean 'pthread+AF8-rwlock+AF8-trywrlock'? +AFs--Wimplicit-function-declaration+AF0
+AD4 +AD4  return pthread+AF8-rwlock+AF8-trywlock(+ACY-lock-+AD4-rwlock) +AD0APQ 0 ? 1 : 0+ADs
+AD4 +AD4         +AF4AfgB+AH4AfgB+AH4AfgB+AH4AfgB+AH4AfgB+AH4AfgB+AH4AfgB+AH4Afg
+AD4 +AD4         pthread+AF8-rwlock+AF8-trywrlock
+AD4 
+AD4 Hm, I'm not sure why you're seeing that error (I'm not). We define
+AD4 pthread+AF8-rwlock+AF8-trywlock() in:
+AD4 
+AD4 	include/liblockdep/rwlock.h:static inline int liblockdep+AF8-pthread+AF8-rwlock+AF8-trywlock(liblockdep+AF8-pthread+AF8-rwlock+AF8-t +ACo-lock)
+AD4 
+AD4 All the tests also seem to pass for me. Did you see failures on your
+AD4 end?

What I saw is that due to the typo that is fixed by this patch that linking
of the tests failed and that the error message that was reported because
starting the tests failed made the tests pass due to the following line in
run+AF8-tests.sh:

if +AFs +ACQ(timeout 1 ./lockdep ./tests/+ACQ-testname 2+AD4AJg-1 +AHw wc -l) -gt 0 +AF0AOw then

Bart.
