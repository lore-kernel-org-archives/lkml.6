Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D432BC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93EFD208B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="euqUl/Di"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93EFD208B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbeH0Wqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:46:32 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39712 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbeH0Wqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:46:31 -0400
Received: by mail-pf1-f194.google.com with SMTP id j8-v6so4807pff.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 11:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:in-reply-to:references:cc:from:to;
        bh=NRuwUtVI5Nhrh22lLgFjtatIUZsR068rUFandrjX9T8=;
        b=euqUl/DiBe59NRzcEUf1IEf6n0H590wFyNzcjgLAxKAXF7BEBKob/bH0x1sFVoGrQz
         q8k0D7OWAkaFYMXTD82Gc+T49fbRdM1Ddh+7vLVrUo5wa+oM2ljCzCdRoKSI8o9zn4yJ
         JZ7Cpm21G1NKv5IDuDITu27FLQsaDrJEp2qoPrD0bnlsF6eYe1Xd/qXrFLWNnYmDiUUc
         dpGY9RKCcCDTJ8RQdZXX2XxzO8hyL0Q1TaVHgSHddanpJ+0sUbaGJtCgOf6rfT0/6YdA
         QwcQIFLtb38oyB9ltciBsqp8SilSqW7Z+EZG1g2f3rl9bRP7KNwc+S0Rd2xuAFv5uNAN
         wH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :cc:from:to;
        bh=NRuwUtVI5Nhrh22lLgFjtatIUZsR068rUFandrjX9T8=;
        b=XvRI2b8Odf/KlAhalgmGl/F8pmPiBy3pLHZHclaUv4gJvDmLjYvq0TBUrb2q34gjn9
         ImkzA3c/LuP/GZEv5OVS3mct4Rs2Nul3FETBgEXZ9T+teUtcFpRKvtWf9cg7btRboOT/
         pPAiqMBXO1fdNwrlhzTEGMrUExSCKQJsY9bMwjAnzCjGlQrD7Ll44QpbnDRPt3OJ/G3+
         NB/k5c0JXx4rUlCn2lP+saGKYPoLD5ZqICyJiq/F+G4SnPEcu4HUo2/8d8H1tB/rilFS
         TGrv+3OR6xFxveaXwrtwA/O5Lf5ngG2ZYv0ZV6mGSilWDBce76MgHw3uyuaRp88eY15+
         umZQ==
X-Gm-Message-State: APzg51DtDAb3/NUHBX6gV81hSEuJdhw2QfufMgeYlHdJx6//tnvsMnQq
        1GH6loXefw87uYujnDwfzIuyJg==
X-Google-Smtp-Source: ANB0VdYhl7EfDUhOJsC4TdjrYqfa4R5QhEDLsu/xeN+npnMl+8xPl3LDQ8WeMr/ZpdIrBV36H0QSKQ==
X-Received: by 2002:a62:c60e:: with SMTP id m14-v6mr15670866pfg.40.1535396322087;
        Mon, 27 Aug 2018 11:58:42 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id 83-v6sm14446pft.40.2018.08.27.11.58.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 11:58:41 -0700 (PDT)
Subject: [PATCH 2/8] RISC-V: Don't set cacheinfo.{physical_line_partition,attributes}
Date:   Mon, 27 Aug 2018 11:42:37 -0700
Message-Id: <20180827184243.25344-3-palmer@sifive.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180827184243.25344-1-palmer@sifive.com>
References: <20180827184243.25344-1-palmer@sifive.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        jason@lakedaemon.net, marc.zyngier@arm.com, atish.patra@wdc.com,
        dmitriy@oss-tech.org, catalin.marinas@arm.com,
        ard.biesheuvel@linaro.org, Greg KH <gregkh@linuxfoundation.org>,
        jeremy.linton@arm.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:      linux-riscv@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are just hard coded in the RISC-V port, which doesn't make any
sense.  We should probably be setting these from device tree entries
when they exist, but for now I think it's saner to just leave them all
as their default values.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 arch/riscv/kernel/cacheinfo.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
index 0bc86e5f8f3f..cb35ffd8ec6b 100644
--- a/arch/riscv/kernel/cacheinfo.c
+++ b/arch/riscv/kernel/cacheinfo.c
@@ -22,13 +22,6 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
 {
 	this_leaf->level = level;
 	this_leaf->type = type;
-	/* not a sector cache */
-	this_leaf->physical_line_partition = 1;
-	/* TODO: Add to DTS */
-	this_leaf->attributes =
-		CACHE_WRITE_BACK
-		| CACHE_READ_ALLOCATE
-		| CACHE_WRITE_ALLOCATE;
 }
 
 static int __init_cache_level(unsigned int cpu)
-- 
2.16.4

