Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 2PDtDRwzGlv5UAAAmS7hNA
	; Fri, 08 Jun 2018 07:42:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A845F607E4; Fri,  8 Jun 2018 07:42:07 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArQrN9nG"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 04041607A4;
	Fri,  8 Jun 2018 07:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 04041607A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752853AbeFHHmB (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 03:42:01 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44163 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751195AbeFHHl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 03:41:57 -0400
Received: by mail-pf0-f193.google.com with SMTP id h12-v6so6207017pfk.11;
        Fri, 08 Jun 2018 00:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xDOsFM1m8LjIPXzr05DKGgzHN2YIgV5IvXvx/lwPYAw=;
        b=ArQrN9nGN4jFspIIvE/gpvQJLlLTcYhrhs9ktzGd6LtB0RPqmzDkuodojC88xH4UnU
         fn1R0PIA4t4fTaZ46Nz0JfeRK1DHJitJzQgdazPxog6z5ZTubSSEf47xR2Z6hfd+J5cw
         6ItHxhEX7HRQ4cF5IlO6ycMBA3n4BrBMgODu4ecqnJkrNagrI7As3bARq91oK1dR4wO8
         C8P8DDw3BYf6J2rTHfEpXph/KIyqw6IzSq5ktemrtEIakwICtqkUHgajZhSmUyAqD9fP
         i6bYOc0gL9UWuFQcODnKgRW39EMhtGzRmNL6Z99FQD/zG6tXCEYbidtLRV7ZIqj/1V/v
         Z6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xDOsFM1m8LjIPXzr05DKGgzHN2YIgV5IvXvx/lwPYAw=;
        b=cyIZMJtewvhjV3ItlWSJqvlCl22hrn961dDXOT/Zt2krKCi4bI9dR3DVfsE4AAYnmn
         t3qE806VDbQSWR/S7Ck+5LUYyL0R654LVyTOoMiqDxSniJHZevoLBkb3MclkxVDnQINg
         zT6nCGaPWXyGcZLQcxXN1DLSoSKUKlMshfGLgHg/HcOe9bK8fLpJIjW7dK7K3G5MKOro
         st0P1GPzmiihS/yGfz3OiSfwC4+32BR+JsvXRN1XFod6b7Z32I4zbaSz8TDKhnRr/4gV
         jbdxbkY++MQFCCb/ZghEJV75wcW0+X6fk13bmpY55vWIP7kSfO7NI2j8nD84lCw62QbY
         PiXw==
X-Gm-Message-State: APt69E0j/8ZbDdXNr8Kuuxfd12V9HXkXy7+qhXhBSdVCXVE0idLCmj4Z
        p7wj1tdW8hcb9l/2I8IcIAQ=
X-Google-Smtp-Source: ADUXVKK/Nswi8+lgoYyBh1aEOWobXgClAUQJCOnzm3JtqwkwLeSoOfp/bMfSAmjod+8iemuabwjrmA==
X-Received: by 2002:a63:b147:: with SMTP id g7-v6mr4253600pgp.379.1528443717363;
        Fri, 08 Jun 2018 00:41:57 -0700 (PDT)
Received: from ct7host.localdomain ([38.106.11.25])
        by smtp.gmail.com with ESMTPSA id m9-v6sm97679408pff.41.2018.06.08.00.41.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 00:41:56 -0700 (PDT)
From: Jia He <hejianet@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jia He <hejianet@gmail.com>,
        jia.he@hxt-semitech.com, <stable@vger.kernel.org>
Subject: [PATCH v2] crypto: arm64/aes-blk - fix and move skcipher_walk_done out of kernel_neon_begin,_end
Date: Fri,  8 Jun 2018 15:41:44 +0800
Message-Id: <1528443704-26850-1-git-send-email-hejianet@gmail.com>
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
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: <stable@vger.kernel.org> # 4.17
---
v2: cc stable
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
