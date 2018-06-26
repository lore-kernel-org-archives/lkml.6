Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5115C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 03:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1F026480
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 03:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mg4zLm9U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C1F026480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965329AbeFZDYN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 23:24:13 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38780 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965262AbeFZDYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 23:24:11 -0400
Received: by mail-pg0-f65.google.com with SMTP id c9-v6so6983502pgf.5;
        Mon, 25 Jun 2018 20:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nSozZzW9YlkqFfLi3lzzRph6fsYZs37KqVjC1SjsBNc=;
        b=mg4zLm9UeNgGqB9trG4f6h9+gopFX7NFuLs+HHiDy+OOGBp4Jn+P+vgn/xN5xs7J90
         wyxatgSDk20l6nkMbPmpqD6bZl7X02mNLl99Q41LmNJdekT9pI3khsJ9SP+t2/CtugLa
         v31c/WBwqmFS4BoMtgFnTHXJi9ei8UwtjtKGDcvHQeOswCTtVWe7+coJJypjXWhiPRs8
         RN5iFL9pu/+1oVaSA32g7o6g+c2Auapt5bCcKCMRQ9gARny2PUdZCvmcvIWS+ZSI9a70
         6UKX2NP21cY+9uEXoAtreK90JggtW4GpENV9aYGPVVN4ofldhPP/n3+u3yNo1jILcCvk
         Gy8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nSozZzW9YlkqFfLi3lzzRph6fsYZs37KqVjC1SjsBNc=;
        b=YXADxluBeh9pfcaPtZdfaab7RkU/BqNCUIGVSHiKMHbivZHymAR1aFlf0Dz/heb55M
         bAuAO0xD/WYQRXZFpx6mAWuWtCEvIC0TzZTHhGR1jQp9td6iuy97gFV2W4IGUvl8jF9b
         dqdpkXOsNADywtmqJ8lBAS4mimMmIm8Y3Jt4RCDBOQ9XNrrXev1fXezvaHYqV5tjJWVY
         TNpQPULPbJFQrwjEOLeNhMjJqOdkIHX/6ZzLtiUw3dD0IzmhQ8bqtyPJnk4TYyWrGoli
         +pX2ik0eWE1QLbcG2I9hU4qoh0QdUm2J7tWPD2u9vqkR640AbgdlKCOgDKK1aefr2JXG
         Vjqg==
X-Gm-Message-State: APt69E1PzWA2uOJuyEgIGSWu9SMnAaJIHByZ3uIw8RCQGzQ4m6gyDMU1
        0LdsJRrboXlsBRc0JBdCg3IdDtjz
X-Google-Smtp-Source: ADUXVKLonkxiRvJEHFV9dRsuMvL0/ueqRSH6V7HVNRiWNG/95Qf6bx3piN5oqLfMzPu74GkKCtjHZQ==
X-Received: by 2002:a65:550d:: with SMTP id f13-v6mr12470021pgr.180.1529983451342;
        Mon, 25 Jun 2018 20:24:11 -0700 (PDT)
Received: from localhost.localdomain ([147.46.241.218])
        by smtp.gmail.com with ESMTPSA id e81-v6sm769426pfb.62.2018.06.25.20.24.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Jun 2018 20:24:10 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     byungchul.park@lge.com, paulmck@linux.vnet.ibm.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, SeongJae Park <sj38.park@gmail.com>
Subject: [PATCH v2] locking/memory-barriers.txt/kokr: Update Korean translation to fix broken DMA vs. MMIO ordering example
Date:   Tue, 26 Jun 2018 12:24:01 +0900
Message-Id: <20180626032401.3493-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <alpine.DEB.2.20.1806261218490.1528@hxeon>
References: <alpine.DEB.2.20.1806261218490.1528@hxeon>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Translate this commit to Korean:

  5846581e3563 ("locking/memory-barriers.txt: Fix broken DMA vs. MMIO ordering example")

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
---
Changes since v1:
 - Apply comments from Byungchul Park
 - Rebased on v4.18-rc2

 .../translations/ko_KR/memory-barriers.txt         | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
index 921739d00f69..523e11070109 100644
--- a/Documentation/translations/ko_KR/memory-barriers.txt
+++ b/Documentation/translations/ko_KR/memory-barriers.txt
@@ -1891,22 +1891,22 @@ Mandatory 배리어들은 SMP 시스템에서도 UP 시스템에서도 SMP 효
 		/* 소유권을 수정 */
 		desc->status = DEVICE_OWN;
 
-		/* MMIO 를 통해 디바이스에 공지를 하기 전에 메모리를 동기화 */
-		wmb();
-
 		/* 업데이트된 디스크립터의 디바이스에 공지 */
 		writel(DESC_NOTIFY, doorbell);
 	}
 
      dma_rmb() 는 디스크립터로부터 데이터를 읽어오기 전에 디바이스가 소유권을
-     내놓았음을 보장하게 하고, dma_wmb() 는 디바이스가 자신이 소유권을 다시
-     가졌음을 보기 전에 디스크립터에 데이터가 쓰였음을 보장합니다.  wmb() 는
-     캐시 일관성이 없는 (cache incoherent) MMIO 영역에 쓰기를 시도하기 전에
-     캐시 일관성이 있는 메모리 (cache coherent memory) 쓰기가 완료되었음을
-     보장해주기 위해 필요합니다.
-
-     consistent memory 에 대한 자세한 내용을 위해선 Documentation/DMA-API.txt
-     문서를 참고하세요.
+     내려놓았을 것을 보장하고, dma_wmb() 는 디바이스가 자신이 소유권을 다시
+     가졌음을 보기 전에 디스크립터에 데이터가 쓰였을 것을 보장합니다.  writel()
+     을 사용하면 캐시 일관성이 있는 메모리 (cache coherent memory) 쓰기가 MMIO
+     영역에의 쓰기 전에 완료되었을 것을 보장하므로 writel() 앞에 wmb() 를
+     실행할 필요가 없음을 알아두시기 바랍니다.  writel() 보다 비용이 저렴한
+     writel_relaxed() 는 이런 보장을 제공하지 않으므로 여기선 사용되지 않아야
+     합니다.
+
+     writel_relaxed() 와 같은 완화된 I/O 접근자들에 대한 자세한 내용을 위해서는
+     "커널 I/O 배리어의 효과" 섹션을, consistent memory 에 대한 자세한 내용을
+     위해선 Documentation/DMA-API.txt 문서를 참고하세요.
 
 
 MMIO 쓰기 배리어
-- 
2.13.0

