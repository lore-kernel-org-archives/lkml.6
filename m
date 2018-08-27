Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA30C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 15:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E8C9208B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 15:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HQhdg2On"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E8C9208B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbeH0TZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 15:25:37 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40588 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbeH0TZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 15:25:37 -0400
Received: by mail-ed1-f66.google.com with SMTP id e19-v6so10786659edq.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 08:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=c3VT5omGK/izHzrk1qG+6Wjt5RPSt905/uxgI+8ob10=;
        b=HQhdg2OnAaejArAa/vuCrEN8NLLjpQ8HN6zbQzT0Fu3iLtjRA5YsrLKTVi7E3TDdp9
         aHw1WlkyiVJdz7le0t1JdimDTA7clO5TvFpXnG3zZ87FF+GnkZHZYKaoxmoo/0cdzDOu
         2CAX6lqzXUeKnRgCd30YD1OXR2CnldU7GM8+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=c3VT5omGK/izHzrk1qG+6Wjt5RPSt905/uxgI+8ob10=;
        b=CD4oR4oMRSWZxx3rfqlltdTpO1SWrTfTMghufQPNCOYGVxO5+QzD+EUbuXg+6rE/Yb
         HE+MMePJmjekgCfUV2HkkEOV4QEVhY44hcvtN8Ph6HCRw2NWy8MOaeThF1LwyZJR9Wea
         e+VcQ0mi4kLO7bvxAc40IkWWncqSduNPizCGaXDuEHjuIN4uELKwzIAmm+mABOju6IZQ
         IOGyUVgUjYrTXzWnTfFP5e0uV0Q5GSaMY2+1SxT4MAdxBOI6CMv5+D7mktQjgBAYRJLd
         ADqI9wRWnaKIeSxnuJMMAMfakFeOqqxxzpw0WXdQk4c3YP+rPv9BuRMl9XbyOjMzhV84
         ZWcg==
X-Gm-Message-State: APzg51BPRxdlmV/+8pS/6OJ5NBB7Jdqs4ivO5JJyj5ZpYpFkMbZ7DAP3
        cc0XuTXRXmxUcttx5corsyDdEw==
X-Google-Smtp-Source: ANB0Vday9e4Wt2rfJL2OoTnw6rCjy2DVN3xDGjWS4HwUDpKusIaWcZK2qhXWvdvLvpCOBV/ZQJXVXA==
X-Received: by 2002:aa7:c5cd:: with SMTP id h13-v6mr17244447eds.27.1535384308461;
        Mon, 27 Aug 2018 08:38:28 -0700 (PDT)
Received: from rev02.home ([2a02:a212:9283:9800:24b9:e2d6:9acc:50dd])
        by smtp.gmail.com with ESMTPSA id r44-v6sm8852984edd.87.2018.08.27.08.38.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 08:38:27 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, linux-arm-kernel@lists.infradead.org,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, jeff.lien@wdc.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 0/2] crypto: arm64/crct10dif - refactor and implement non-Crypto Extension version
Date:   Mon, 27 Aug 2018 17:38:10 +0200
Message-Id: <20180827153812.6763-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current arm64 CRC-T10DIF code only runs on cores that implement the
64x64 bit PMULL instructions that are part of the optional Crypto
Extensions, and falls back to the highly inefficient C code otherwise.

Let's provide a SIMD version that is twice as fast as the C code even on
a low end core like the Cortex-A53, and is time invariant and much easier
on the D-cache.

Some performance numbers at the bottom.

Ard Biesheuvel (2):
  crypto: arm64/crct10dif - preparatory refactor for 8x8 PMULL version
  crypto: arm64/crct10dif - implement non-Crypto Extensions alternative

 arch/arm64/crypto/crct10dif-ce-core.S | 314 +++++++++++++++-----
 arch/arm64/crypto/crct10dif-ce-glue.c |  14 +-
 2 files changed, 251 insertions(+), 77 deletions(-)

-- 
2.18.0

tcrypto speed tests on a 1 GHz Cortex-A53:

C version
=========
 0 (   16 byte blocks,   16 bytes x   1): 3302652 opers/sec,   52842432 Bps
 1 (   64 byte blocks,   16 bytes x   4):  612125 opers/sec,   39176000 Bps
 2 (   64 byte blocks,   64 bytes x   1): 1272473 opers/sec,   81438272 Bps
 3 (  256 byte blocks,   16 bytes x  16):  162127 opers/sec,   41504512 Bps
 4 (  256 byte blocks,   64 bytes x   4):  280237 opers/sec,   71740672 Bps
 5 (  256 byte blocks,  256 bytes x   1):  367349 opers/sec,   94041344 Bps
 6 ( 1024 byte blocks,   16 bytes x  64):   41142 opers/sec,   42129408 Bps
 7 ( 1024 byte blocks,  256 bytes x   4):   88099 opers/sec,   90213376 Bps
 8 ( 1024 byte blocks, 1024 bytes x   1):   95455 opers/sec,   97745920 Bps
 9 ( 2048 byte blocks,   16 bytes x 128):   20622 opers/sec,   42233856 Bps
10 ( 2048 byte blocks,  256 bytes x   8):   44421 opers/sec,   90974208 Bps
11 ( 2048 byte blocks, 1024 bytes x   2):   47158 opers/sec,   96579584 Bps
12 ( 2048 byte blocks, 2048 bytes x   1):   48095 opers/sec,   98498560 Bps
13 ( 4096 byte blocks,   16 bytes x 256):   10318 opers/sec,   42262528 Bps
14 ( 4096 byte blocks,  256 bytes x  16):   22265 opers/sec,   91197440 Bps
15 ( 4096 byte blocks, 1024 bytes x   4):   23639 opers/sec,   96825344 Bps
16 ( 4096 byte blocks, 4096 bytes x   1):   24032 opers/sec,   98435072 Bps
17 ( 8192 byte blocks,   16 bytes x 512):    5167 opers/sec,   42328064 Bps
18 ( 8192 byte blocks,  256 bytes x  32):   11152 opers/sec,   91357184 Bps
19 ( 8192 byte blocks, 1024 bytes x   8):   11836 opers/sec,   96960512 Bps
20 ( 8192 byte blocks, 4096 bytes x   2):   12006 opers/sec,   98353152 Bps
21 ( 8192 byte blocks, 8192 bytes x   1):   12031 opers/sec,   98557952 Bps

PMULL 64x64 version
====================
 0 (   16 byte blocks,   16 bytes x   1): 1663221 opers/sec,   26611536 Bps
 1 (   64 byte blocks,   16 bytes x   4):  496141 opers/sec,   31753024 Bps
 2 (   64 byte blocks,   64 bytes x   1): 1553169 opers/sec,   99402816 Bps
 3 (  256 byte blocks,   16 bytes x  16):  132224 opers/sec,   33849344 Bps
 4 (  256 byte blocks,   64 bytes x   4):  458027 opers/sec,  117254912 Bps
 5 (  256 byte blocks,  256 bytes x   1): 1353682 opers/sec,  346542592 Bps
 6 ( 1024 byte blocks,   16 bytes x  64):   33557 opers/sec,   34362368 Bps
 7 ( 1024 byte blocks,  256 bytes x   4):  390226 opers/sec,  399591424 Bps
 8 ( 1024 byte blocks, 1024 bytes x   1):  832879 opers/sec,  852868096 Bps
 9 ( 2048 byte blocks,   16 bytes x 128):   16853 opers/sec,   34514944 Bps
10 ( 2048 byte blocks,  256 bytes x   8):  201626 opers/sec,  412930048 Bps
11 ( 2048 byte blocks, 1024 bytes x   2):  437117 opers/sec,  895215616 Bps
12 ( 2048 byte blocks, 2048 bytes x   1):  553689 opers/sec, 1133955072 Bps
13 ( 4096 byte blocks,   16 bytes x 256):    8438 opers/sec,   34562048 Bps
14 ( 4096 byte blocks,  256 bytes x  16):  102551 opers/sec,  420048896 Bps
15 ( 4096 byte blocks, 1024 bytes x   4):  226754 opers/sec,  928784384 Bps
16 ( 4096 byte blocks, 4096 bytes x   1):  323362 opers/sec, 1324490752 Bps
17 ( 8192 byte blocks,   16 bytes x 512):    4222 opers/sec,   34586624 Bps
18 ( 8192 byte blocks,  256 bytes x  32):   51709 opers/sec,  423600128 Bps
19 ( 8192 byte blocks, 1024 bytes x   8):  115508 opers/sec,  946241536 Bps
20 ( 8192 byte blocks, 4096 bytes x   2):  169015 opers/sec, 1384570880 Bps
21 ( 8192 byte blocks, 8192 bytes x   1):  168734 opers/sec, 1382268928 Bps

PMULL 8x8 version
=================
testing speed of async crct10dif (crct10dif-arm64-ce)
 0 (   16 byte blocks,   16 bytes x   1): 1281627 opers/sec,   20506032 Bps
 1 (   64 byte blocks,   16 bytes x   4):  351733 opers/sec,   22510912 Bps
 2 (   64 byte blocks,   64 bytes x   1):  959314 opers/sec,   61396096 Bps
 3 (  256 byte blocks,   16 bytes x  16):   91002 opers/sec,   23296512 Bps
 4 (  256 byte blocks,   64 bytes x   4):  256833 opers/sec,   65749248 Bps
 5 (  256 byte blocks,  256 bytes x   1):  490696 opers/sec,  125618176 Bps
 6 ( 1024 byte blocks,   16 bytes x  64):   22952 opers/sec,   23502848 Bps
 7 ( 1024 byte blocks,  256 bytes x   4):  127006 opers/sec,  130054144 Bps
 8 ( 1024 byte blocks, 1024 bytes x   1):  168461 opers/sec,  172504064 Bps
 9 ( 2048 byte blocks,   16 bytes x 128):   11496 opers/sec,   23543808 Bps
10 ( 2048 byte blocks,  256 bytes x   8):   64000 opers/sec,  131072000 Bps
11 ( 2048 byte blocks, 1024 bytes x   2):   84752 opers/sec,  173572096 Bps
12 ( 2048 byte blocks, 2048 bytes x   1):   89919 opers/sec,  184154112 Bps
13 ( 4096 byte blocks,   16 bytes x 256):    5757 opers/sec,   23580672 Bps
14 ( 4096 byte blocks,  256 bytes x  16):   32129 opers/sec,  131600384 Bps
15 ( 4096 byte blocks, 1024 bytes x   4):   42608 opers/sec,  174522368 Bps
16 ( 4096 byte blocks, 4096 bytes x   1):   46351 opers/sec,  189853696 Bps
17 ( 8192 byte blocks,   16 bytes x 512):    2884 opers/sec,   23625728 Bps
18 ( 8192 byte blocks,  256 bytes x  32):   16105 opers/sec,  131932160 Bps
19 ( 8192 byte blocks, 1024 bytes x   8):   21364 opers/sec,  175013888 Bps
20 ( 8192 byte blocks, 4096 bytes x   2):   23299 opers/sec,  190865408 Bps
21 ( 8192 byte blocks, 8192 bytes x   1):   23292 opers/sec,  190808064 Bps
