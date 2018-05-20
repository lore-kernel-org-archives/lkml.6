Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751513AbeETIA6 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 04:00:58 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34649 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751292AbeETIA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 04:00:56 -0400
X-Google-Smtp-Source: AB8JxZpkAAvXYQ5U80vqcRwDuSO/opqPXr49zJnEFa7eiubz+4iyRUUK6KhNEfe3nJtVgd17CqVhGA==
From: Varsha Rao <rvarsha016@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Nicholas Mc Guire <der.herr@hofr.at>
Cc: Varsha Rao <rvarsha016@gmail.com>
Subject: [PATCH] x86: platform: uv: Remove extra parentheses
Date: Sun, 20 May 2018 13:30:12 +0530
Message-Id: <20180520080012.8215-1-rvarsha016@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove extra parentheses to fix the extraneous parentheses clang
warning.

Suggested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Varsha Rao <rvarsha016@gmail.com>
---
 arch/x86/platform/uv/tlb_uv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/uv/tlb_uv.c b/arch/x86/platform/uv/tlb_uv.c
index b36caae0fb2f..b96d38288c60 100644
--- a/arch/x86/platform/uv/tlb_uv.c
+++ b/arch/x86/platform/uv/tlb_uv.c
@@ -615,7 +615,7 @@ static int uv2_3_wait_completion(struct bau_desc *bau_desc,
 
 	/* spin on the status MMR, waiting for it to go idle */
 	while (descriptor_stat != UV2H_DESC_IDLE) {
-		if ((descriptor_stat == UV2H_DESC_SOURCE_TIMEOUT)) {
+		if (descriptor_stat == UV2H_DESC_SOURCE_TIMEOUT) {
 			/*
 			 * A h/w bug on the destination side may
 			 * have prevented the message being marked
-- 
2.17.0
