Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE72C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BB7520837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:35:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BB7520837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbeLGQf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 11:35:56 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38741 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbeLGQfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 11:35:55 -0500
Received: by mail-pg1-f193.google.com with SMTP id g189so1951606pgc.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 08:35:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iSr6Er0PU2MBHeWaCl6zq+BoZitNiCYieXn8aKr/odU=;
        b=nwG26cuUNeqEdYcIrOH/r4vMQCQbgzpQJSpimecBAasBChc5nJMxcWrsxr+SmfpSJF
         J47ooYPnXs3/B2Ii2MrcE+B0lpVtITKTEtxFDQAY88AbmiEVjkwSlsaLjnUKQzZRx5id
         H1IAbIxYGGtMYvoGHWEm1B6W9vU4vrKxqVw1R8yfaAFNWuZ9Ufsr3VWjp5p+q605SJNF
         qSFa1MXEntyZ4jYMaVkMM75Fk5UBPKsF8fCY0Yq84anhcpHcCfUisYQMoqPbUeg16abi
         +9eqEMq/dd33BuGv+CIgtQ4bZRulholI73vU5QIp8Y7TTl1LX8Wwbnq3YWK9upLMitCu
         jjqQ==
X-Gm-Message-State: AA+aEWZSkx3fnx2Cvw7iv5hFPAdv0IhO4JI1/wO4eb9t75EZBuETe4eC
        Hw3Y93gYYU8f1V6jdbHwEzE=
X-Google-Smtp-Source: AFSGD/UZfOozBlm+QD+R2w1793oIYZoL4h9mewSNeGVrGGbxq/66E9rrizYI8f6LG5b/u8kdTKiD6w==
X-Received: by 2002:a63:f141:: with SMTP id o1mr2608204pgk.134.1544200554714;
        Fri, 07 Dec 2018 08:35:54 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id 19sm5584172pfs.108.2018.12.07.08.35.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 08:35:54 -0800 (PST)
Message-ID: <1544200552.185366.311.camel@acm.org>
Subject: Re: [PATCH v3 00/24] locking/lockdep: Add support for dynamic keys
From:   Bart Van Assche <bvanassche@acm.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org
Date:   Fri, 07 Dec 2018 08:35:52 -0800
In-Reply-To: <20181207122329.GA5289@hirez.programming.kicks-ass.net>
References: <20181207011148.251812-1-bvanassche@acm.org>
         <20181207122329.GA5289@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-12-07 at 13:23 +-0100, Peter Zijlstra wrote:
+AD4 I took the first 15 patches for now to shrink the series.

Thanks Peter. Since I would like to rebase the remaining patches on top of
what you have already queued: is what you have queued available in a public
git repository? I had a quick look at
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/ but couldn't
find my patches in any of the branches that have been updated in the last 24
hours.

Bart.
