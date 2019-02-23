Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408FCC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04FF420855
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550956145;
	bh=fmUKV/h5yU4nfDJHbnTdcMTU/9sU76ZMNnAYl4EzbIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dm1H6xToaISCXXjNKRv1vCiITLKBK2xsPnuaUCayHN0Q+u4xb9lmEPxOsEi7C4YyK
	 6Yk45NQ/fzkXiPp5nGHTODd88RiUxP4KKwJV7F00TwjOTasW8nR6PCPj0+6SiqLNHv
	 18nCY155UtnI0AWdQDmnRIpJDzM9/EYH14H3SQgo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbfBWVJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:09:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:44534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729403AbfBWVJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:09:00 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC8A420855;
        Sat, 23 Feb 2019 21:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956140;
        bh=fmUKV/h5yU4nfDJHbnTdcMTU/9sU76ZMNnAYl4EzbIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZcrA4iPdsDtxULz07lrh2qc4hdbiPQ3dJesjmRB4pvfLlwmPDp6OKE5iQmVy1lezQ
         nXsWfJBNnYv5ZIvAE2YykBvpo+k2CwmzooYk0bBRR/ykwGy+kw99ZFQUyIfN8WBEIi
         wJf4j+NzJiLWkGVpR7cZrNzhNhXYp90F46+qb+6A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Max Filippov <jcmvbkbc@gmail.com>, Sasha Levin <sashal@kernel.org>,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH AUTOSEL 4.14 14/45] xtensa: SMP: mark each possible CPU as present
Date:   Sat, 23 Feb 2019 16:08:04 -0500
Message-Id: <20190223210835.201708-14-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210835.201708-1-sashal@kernel.org>
References: <20190223210835.201708-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Filippov <jcmvbkbc@gmail.com>

[ Upstream commit 8b1c42cdd7181200dc1fff39dcb6ac1a3fac2c25 ]

Otherwise it is impossible to enable CPUs after booting with 'maxcpus'
parameter.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/xtensa/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/kernel/smp.c b/arch/xtensa/kernel/smp.c
index c9fc2c4f71b3b..80be6449c497e 100644
--- a/arch/xtensa/kernel/smp.c
+++ b/arch/xtensa/kernel/smp.c
@@ -83,7 +83,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 {
 	unsigned i;
 
-	for (i = 0; i < max_cpus; ++i)
+	for_each_possible_cpu(i)
 		set_cpu_present(i, true);
 }
 
-- 
2.19.1

