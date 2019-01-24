Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185B7C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF9C218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYh9Hs0t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbfAXV4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 16:56:14 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39575 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728209AbfAXV4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 16:56:10 -0500
Received: by mail-pl1-f195.google.com with SMTP id 101so3515143pld.6;
        Thu, 24 Jan 2019 13:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F84PAI+75VUX/KMglw8qztuoEw6BYBveewCWq7jVO+Q=;
        b=AYh9Hs0tyH2BfFmwn2iuBWeogjMp3q5sW4FKmd/JzFSbshzY9wTxQr2XNWirQFyqoO
         V1ySSS9R6rV0tZ8HaRadap3X11Z1Y+tWaJsCghrxGxdz7GsS3l4jXxaUoI4djTn3eKWb
         AUUGXq04dGsW/Wiij/EhhPXfy+iAjsVddGQAZOFoN9TLSRPQ4ikhF5xgzqlfi4FCG6Ii
         N5muYcFoaU3+e9oDOhpmdw5avcX4mA0UL94V+OdYrHLLpNafMRWzwTligk0zH0wFafHg
         b2rtR5q+sJSbM40r+0o7EGXnll7G1dci6ByRsb0PPiB6EBS+VICvmMWo9kr4ktRBLc1O
         Mzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F84PAI+75VUX/KMglw8qztuoEw6BYBveewCWq7jVO+Q=;
        b=YToc2FMxgmAfFNp8QvzGEdFfWCKLeCQ7B3aCXoPdxhBTuuDghHNFkOYmixo8olywTP
         abwtfsFsvdkgLbnCb8DsL2BkhnlNzbfITLF04DYJkDeyZ8STQyB5eTQs8WwPKMDSM1yL
         t1DmoCrXiGn2lvk+EPrHVCXlv9Kbx0FHGRzL4T3HAzwr2sDFTnRshBIi2R3uNDF1h59O
         xv/H1RyMl9HKqpoNPS2a8I7iDyDTh+zc+r0q7LRnuFqN7liQ85ess5HDGI9cBqX87ypA
         K/NFJNfQHL0/7l4cyfQdgXiJn42BuPE6K+OAWsKdL3E7ZYA/B/UbUVFabLWZQxvui/hh
         /EZQ==
X-Gm-Message-State: AJcUukcPTKbfv3LVak2T/DetLaxBpZVqbIQ3L1dakyW2CUr1ukkvUEcD
        nq2R6aL3LzO+m+0zuHX95gw=
X-Google-Smtp-Source: ALg8bN4TtBsjgkRmqcfSp6XbG3H+h5/Bcw7NFXe7kP1R8rxie4zNUztsaFgqiTRqW+4+a7cpRf7zeQ==
X-Received: by 2002:a17:902:b18b:: with SMTP id s11mr8212540plr.56.1548366969725;
        Thu, 24 Jan 2019 13:56:09 -0800 (PST)
Received: from localhost.localdomain ([147.46.240.179])
        by smtp.gmail.com with ESMTPSA id g26sm29122593pfh.61.2019.01.24.13.56.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Jan 2019 13:56:09 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     paulmck@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        SeongJae Park <sj38.park@gmail.com>
Subject: [PATCH 2/2] locking/memory-barriers/kokr: Update Korean translation to replace smp_cond_acquire() with smp_cond_load_acquire()
Date:   Fri, 25 Jan 2019 06:55:48 +0900
Message-Id: <20190124215548.4991-3-sj38.park@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20190124215548.4991-1-sj38.park@gmail.com>
References: <20190124215548.4991-1-sj38.park@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Transalte this commit to Korean:

  2f359c7ea554 ("locking/memory-barriers: Replace smp_cond_acquire() with smp_cond_load_acquire()")

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
Reviewed-by: Yunjae Lee <lyj7694@gmail.com>
---
 Documentation/translations/ko_KR/memory-barriers.txt | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
index 4a6cf4d..db0b9d86 100644
--- a/Documentation/translations/ko_KR/memory-barriers.txt
+++ b/Documentation/translations/ko_KR/memory-barriers.txt
@@ -493,10 +493,8 @@ CPU 에게 기대할 수 있는 최소한의 보장사항 몇가지가 있습니
      이 타입의 오퍼레이션은 단방향의 투과성 배리어처럼 동작합니다.  ACQUIRE
      오퍼레이션 뒤의 모든 메모리 오퍼레이션들이 ACQUIRE 오퍼레이션 후에
      일어난 것으로 시스템의 나머지 컴포넌트들에 보이게 될 것이 보장됩니다.
-     LOCK 오퍼레이션과 smp_load_acquire(), smp_cond_acquire() 오퍼레이션도
-     ACQUIRE 오퍼레이션에 포함됩니다.  smp_cond_acquire() 오퍼레이션은 컨트롤
-     의존성과 smp_rmb() 를 사용해서 ACQUIRE 의 의미적 요구사항(semantic)을
-     충족시킵니다.
+     LOCK 오퍼레이션과 smp_load_acquire(), smp_cond_load_acquire() 오퍼레이션도
+     ACQUIRE 오퍼레이션에 포함됩니다.
 
      ACQUIRE 오퍼레이션 앞의 메모리 오퍼레이션들은 ACQUIRE 오퍼레이션 완료 후에
      수행된 것처럼 보일 수 있습니다.
-- 
2.10.0

