Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B60EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C63B82085A
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550956275;
	bh=gJyBleHa3FOXZR9ZsIXeTLTuGKWVCxVbTQ8Y7LJEn/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ITbfGDgUyhxvBPj63DickWAl5pDp53PlKtpJ0qyAZY6cGGE1SZOIHZXHIXewKsgBF
	 3yTfTXl/QdPXupubn/n8UboqWaXd/mo9+uE6AlDl0rPiee4w5AwQbbgp0gl0Qesgxe
	 IPMRdFYXhcHWHdemAwFNkTAKMtO5W0+Q/7jjKKwU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbfBWVLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:11:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:47446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729898AbfBWVLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:11:07 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCB5620880;
        Sat, 23 Feb 2019 21:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956266;
        bh=gJyBleHa3FOXZR9ZsIXeTLTuGKWVCxVbTQ8Y7LJEn/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IXpT8B4q9tCpx62x5c5SaGwAgsvmGcAtVZ+DNWO+4xvdlnkwutlHJrfQrtXUOwazt
         ldArc7+ZWRysOHD0tkRWVAGOLnBErYp6uF37EKxh+U7sBztGHDEodElAjmUcEG/kMT
         9H+wBWDGyAhkjCK5CXxCniMi9Qm5XspBJjjfeJ+Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Max Filippov <jcmvbkbc@gmail.com>, Sasha Levin <sashal@kernel.org>,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH AUTOSEL 4.4 10/26] xtensa: SMP: mark each possible CPU as present
Date:   Sat, 23 Feb 2019 16:10:31 -0500
Message-Id: <20190223211047.202725-10-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223211047.202725-1-sashal@kernel.org>
References: <20190223211047.202725-1-sashal@kernel.org>
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
index 545144d1431d5..0e34c1ed4aa8f 100644
--- a/arch/xtensa/kernel/smp.c
+++ b/arch/xtensa/kernel/smp.c
@@ -80,7 +80,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 {
 	unsigned i;
 
-	for (i = 0; i < max_cpus; ++i)
+	for_each_possible_cpu(i)
 		set_cpu_present(i, true);
 }
 
-- 
2.19.1

