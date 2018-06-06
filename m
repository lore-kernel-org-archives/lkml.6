Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3AB9A60764
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752122AbeFFLnw (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 07:43:52 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57721 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751856AbeFFLnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 07:43:51 -0400
Date: Wed, 6 Jun 2018 04:43:29 -0700
From: tip-bot for Varsha Rao <tipbot@zytor.com>
Message-ID: <tip-cce2946b9b30a9b31a18de737d5010c08076e77f@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, der.herr@hofr.at,
        lukas.bulwahn@gmail.com, rvarsha016@gmail.com, hpa@zytor.com,
        mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, der.herr@hofr.at,
          tglx@linutronix.de, rvarsha016@gmail.com, mingo@kernel.org,
          hpa@zytor.com, lukas.bulwahn@gmail.com
In-Reply-To: <20180520080012.8215-1-rvarsha016@gmail.com>
References: <20180520080012.8215-1-rvarsha016@gmail.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/platform/uv: Remove extra parentheses
Git-Commit-ID: cce2946b9b30a9b31a18de737d5010c08076e77f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  cce2946b9b30a9b31a18de737d5010c08076e77f
Gitweb:     https://git.kernel.org/tip/cce2946b9b30a9b31a18de737d5010c08076e77f
Author:     Varsha Rao <rvarsha016@gmail.com>
AuthorDate: Sun, 20 May 2018 13:30:12 +0530
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 6 Jun 2018 13:38:01 +0200

x86/platform/uv: Remove extra parentheses

Remove extra parentheses to fix the extraneous parentheses clang
warning.

Suggested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Varsha Rao <rvarsha016@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Nicholas Mc Guire <der.herr@hofr.at>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lkml.kernel.org/r/20180520080012.8215-1-rvarsha016@gmail.com

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
