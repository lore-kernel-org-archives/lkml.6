Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id AKDqGggqGlvHGgAAmS7hNA
	; Fri, 08 Jun 2018 07:05:32 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EC374608BA; Fri,  8 Jun 2018 07:05:31 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tzvIDeax"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4FD96601C3;
	Fri,  8 Jun 2018 07:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4FD96601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752734AbeFHHF1 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 03:05:27 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46746 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752061AbeFHHFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 03:05:20 -0400
Received: by mail-pf0-f194.google.com with SMTP id q1-v6so6155154pff.13;
        Fri, 08 Jun 2018 00:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LHL0UECHJ24BrLTz8hu3oQlxD3ARE+CVXen9dRGUPRg=;
        b=tzvIDeax9YO1xtwwbN6Ys2jI9OTdCFRbIExsfLpHLY3kj7yX6/jioZ/Y8pDLbxDs3/
         RUwU3y4Ph0HtA2h8AEpCEOrpA77KLMNodBsAjEkkKf0QFrNjRZ5FuFW7iB6qgMaXfkwm
         h10uc0AtK4STjJa8e6i8kjVfCBVZklCQVBYb6gwL4YQW+5mjjBcCuJGiKRsxwcVadSRe
         fLQsCcHECzEFBbUJyDBwzOzj+JUXb2Vw2wqHmFJes79/hxO4seaImoWPFZ/NtuXbt61v
         vU/bTMF4cWlRVvnfjlvkZddUm5OLNvnYVQ9HOPmMP3TDU7+T8rN1Qar0WhyDH6zNO4Da
         pSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LHL0UECHJ24BrLTz8hu3oQlxD3ARE+CVXen9dRGUPRg=;
        b=XadtRgFAIK4JB05A/OMyoyzTgpZmHbHoBCVGgpNmSjLbaOBTPytfVvIUaktQMlfJeh
         G+inAGwOJj9BR7EBTrGTeQ9kvudpef+/f43+nbiag/EIGCQ/5aj1rEUiDrBePHUKuw4l
         VpyeXDVxmid8Eh77E4EVVIRCMs51kkLogEXSjQ6kRO5lCVw/3JujJqY1VvfH3oLLq2zz
         xrgb8QNvxLcSg/WtTkas8xEWiL5PuZi+WCctF0bp+PwNSi+0NSaG8Hq89vwvjOXa2QmE
         kCxLr9o2/PNS9ft6lyz1hVsE8L11HqQYQJN8fqGN4FR1v2XOgYeJjeEHxLri19RxzQg+
         ZkEA==
X-Gm-Message-State: APt69E3K3li/BfpFMFQjjN5kSVCKNSUpaJQAokZ6e0FW89oNb82h/sH/
        lR9s1WpE9y/Rbx2TCAPxEqU=
X-Google-Smtp-Source: ADUXVKKbqWudQils/l2NgsbWJ1GbH/YRZHcVKxaACvswuyOj6hdCjhaSyL06Pv1RjmDu3mnnHIK2Xg==
X-Received: by 2002:a62:b02:: with SMTP id t2-v6mr4803492pfi.36.1528441520242;
        Fri, 08 Jun 2018 00:05:20 -0700 (PDT)
Received: from ct7host.localdomain ([38.106.11.25])
        by smtp.gmail.com with ESMTPSA id v27-v6sm12400836pfi.23.2018.06.08.00.05.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 00:05:19 -0700 (PDT)
From: Jia He <hejianet@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc: linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jia He <hejianet@gmail.com>,
        jia.he@hxt-semitech.com
Subject: [PATCH] crypto: arm64/aes-blk - fix and move skcipher_walk_done out of  kernel_neon_begin,_end
Date: Fri,  8 Jun 2018 15:05:02 +0800
Message-Id: <1528441502-26425-1-git-send-email-hejianet@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a arm64 server(QDF2400),I met a similar might-sleep warning as [1]:
[    7.019116] BUG: sleeping function called from invalid context at
./include/crypto/algapi.h:416
[    7.027863] in_atomic(): 1, irqs_disabled(): 0, pid: 410, name:
cryptomgr_test
[    7.035106] 1 lock held by cryptomgr_test/410:
[    7.039549]  #0:         (ptrval) (&drbg->drbg_mutex){+.+.}, at:
drbg_instantiate+0x34/0x398
[    7.048038] CPU: 9 PID: 410 Comm: cryptomgr_test Not tainted
4.17.0-rc6+ #27
[    7.068228]  dump_backtrace+0x0/0x1c0
[    7.071890]  show_stack+0x24/0x30
[    7.075208]  dump_stack+0xb0/0xec
[    7.078523]  ___might_sleep+0x160/0x238
[    7.082360]  skcipher_walk_done+0x118/0x2c8
[    7.086545]  ctr_encrypt+0x98/0x130
[    7.090035]  simd_skcipher_encrypt+0x68/0xc0
[    7.094304]  drbg_kcapi_sym_ctr+0xd4/0x1f8
[    7.098400]  drbg_ctr_update+0x98/0x330
[    7.102236]  drbg_seed+0x1b8/0x2f0
[    7.105637]  drbg_instantiate+0x2ac/0x398
[    7.109646]  drbg_kcapi_seed+0xbc/0x188
[    7.113482]  crypto_rng_reset+0x4c/0xb0
[    7.117319]  alg_test_drbg+0xec/0x330
[    7.120981]  alg_test.part.6+0x1c8/0x3c8
[    7.124903]  alg_test+0x58/0xa0
[    7.128044]  cryptomgr_test+0x50/0x58
[    7.131708]  kthread+0x134/0x138
[    7.134936]  ret_from_fork+0x10/0x1c

Seems there is a bug in Ard Biesheuvel's commit.
Fixes: 683381747270 ("crypto: arm64/aes-blk - move kernel mode neon
en/disable into loop")

[1] https://www.spinics.net/lists/linux-crypto/msg33103.html

Signed-off-by: jia.he@hxt-semitech.com
---
 arch/arm64/crypto/aes-glue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/crypto/aes-glue.c b/arch/arm64/crypto/aes-glue.c
index 253188f..e3e5095 100644
--- a/arch/arm64/crypto/aes-glue.c
+++ b/arch/arm64/crypto/aes-glue.c
@@ -223,8 +223,8 @@ static int ctr_encrypt(struct skcipher_request *req)
 		kernel_neon_begin();
 		aes_ctr_encrypt(walk.dst.virt.addr, walk.src.virt.addr,
 				(u8 *)ctx->key_enc, rounds, blocks, walk.iv);
-		err = skcipher_walk_done(&walk, walk.nbytes % AES_BLOCK_SIZE);
 		kernel_neon_end();
+		err = skcipher_walk_done(&walk, walk.nbytes % AES_BLOCK_SIZE);
 	}
 	if (walk.nbytes) {
 		u8 __aligned(8) tail[AES_BLOCK_SIZE];
-- 
1.8.3.1
