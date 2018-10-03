Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98815C64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 604EB205C9
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ryFmLg+W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 604EB205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbeJCM1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 08:27:08 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35880 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbeJCM1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 08:27:07 -0400
Received: by mail-pf1-f193.google.com with SMTP id b7-v6so1116002pfo.3;
        Tue, 02 Oct 2018 22:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=8QtZ6jt/6CJYMtPMbl8SC/kfMWABE44lEN682mSBBk0=;
        b=ryFmLg+WtWVm/ZllFbDu6a018nOGqPhqNJ6EpieZLYGygICSPpaHr94/LO5YDLzqYu
         FqT2Jy9a1wFzvEfGv1hkJmFIMoH5dLsTpDeQZouFq5pWqBORq6V0O7a2QkFIDGr7fKOz
         qyYvYhYzzSETFQVn2elFP6kUreI5SIPtZ4Ok9UoUZps60ATwVe9jbJeFCFYxCqOWr2R+
         jMrcUQluc+LdQ51Ss2IxRUWM6l2hTPHIQLlzmsuoF54lraml1J06tBAsyisCzooRGPHw
         Au//4XIca1qm1YmZbfW66VXrntnpuws042aw3Sk+2bmLebw/oc8QMVWDjBQlSFOlFoZs
         42iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=8QtZ6jt/6CJYMtPMbl8SC/kfMWABE44lEN682mSBBk0=;
        b=LVCEka51PAsh6kJeiaRQ+alS1OK7eF4eUOiVv2bUSc/NIhrKJ3MMUro2CH4DVIfvjZ
         ZQGRETXKAW72SootVBQWIWktAOyo5xb29vtO6h45qBXbKm99XfRBBMp9jZ8UXtTPkRGG
         oHczUINd8qWMpIO0BTR7N6kVPGo9N2KFbjYqzsYDVTrqBQOFyzpjDyAXjItvTqnICT6h
         /GbKjaDzXwGx/cIWHc3rwFSkOPkjvQLGiKt/IrzzCL5+NrNNiFh3rKKEQDFeOAaDnFOk
         WcvEi8TyWxYaxxrtNuJZ9F0Ks7i1Deb2Ho+9wOGU0xhCoirty5n1B2wMQ1u2+qcyLCqf
         diLw==
X-Gm-Message-State: ABuFfohhFEROd3JklOxSIFHYZ1RQaLltCm3ZwFwGbq8NdsRl/4M0Wt7I
        STe/a8HB6gC6yiQ0OL03at4=
X-Google-Smtp-Source: ACcGV60G+PsoSmKyGKSMigCzdkziNvEbtqBhwVp9x1uewRnQhjYGVJ+8WElYAtnPLlQPpGgi6hfDag==
X-Received: by 2002:a63:d444:: with SMTP id i4-v6mr16866887pgj.194.1538545217389;
        Tue, 02 Oct 2018 22:40:17 -0700 (PDT)
Received: from E570.localdomain (c-24-21-68-121.hsd1.or.comcast.net. [24.21.68.121])
        by smtp.gmail.com with ESMTPSA id 19-v6sm735133pft.97.2018.10.02.22.40.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 22:40:16 -0700 (PDT)
Received: by E570.localdomain (Postfix, from userid 1000)
        id 1EC3C1643D0; Tue,  2 Oct 2018 22:40:16 -0700 (PDT)
From:   Lance Roy <ldr709@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Lance Roy <ldr709@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH 14/16] netfilter: Replace spin_is_locked() with lockdep
Date:   Tue,  2 Oct 2018 22:39:00 -0700
Message-Id: <20181003053902.6910-15-ldr709@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181003053902.6910-1-ldr709@gmail.com>
References: <20181003053902.6910-1-ldr709@gmail.com>
Reply-To: Lance Roy <ldr709@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lockdep_assert_held() is better suited to checking locking requirements,
since it won't get confused when someone else holds the lock. This is
also a step towards possibly removing spin_is_locked().

Signed-off-by: Lance Roy <ldr709@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
Cc: Florian Westphal <fw@strlen.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: <netfilter-devel@vger.kernel.org>
Cc: <coreteam@netfilter.org>
Cc: <netdev@vger.kernel.org>
---
 net/netfilter/ipset/ip_set_hash_gen.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/ipset/ip_set_hash_gen.h b/net/netfilter/ipset/ip_set_hash_gen.h
index 8a33dac4e805..e287da68d5fa 100644
--- a/net/netfilter/ipset/ip_set_hash_gen.h
+++ b/net/netfilter/ipset/ip_set_hash_gen.h
@@ -15,7 +15,7 @@
 
 #define __ipset_dereference_protected(p, c)	rcu_dereference_protected(p, c)
 #define ipset_dereference_protected(p, set) \
-	__ipset_dereference_protected(p, spin_is_locked(&(set)->lock))
+	__ipset_dereference_protected(p, lockdep_is_held(&(set)->lock))
 
 #define rcu_dereference_bh_nfnl(p)	rcu_dereference_bh_check(p, 1)
 
-- 
2.19.0

