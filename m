Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=BODY_8BITS,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B75BC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 05:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F32A2086A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 05:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUurrrWq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F32A2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752838AbeFQFQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 01:16:25 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44776 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751579AbeFQFQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 01:16:23 -0400
Received: by mail-pl0-f65.google.com with SMTP id z9-v6so7337337plk.11;
        Sat, 16 Jun 2018 22:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ssc8lkNTgtLYiK6L/sDcTCRW2TNO8kwiCksw2xXO3WM=;
        b=bUurrrWqB2RUCZI0HPJOReJPFDrwS7U1dsJpMI5G2m6RTZSkUd6kSj5kKsHSeluJ/f
         sgid4Cv7/FA8953ATmTX8YHEjXVp858lNt0Vri0I1ZkGo450aXWPGUcX6coBvh3WMAnS
         q2teBz4BhetI+M9p2bxnmvwri3u8MRui3YoAbKXH1AbPrvVBH37JeJPMTVp/PwUy4Zeh
         6DrjQU3ONGX+onPMN4lj3RAnqjHrkCjW6Xkm7vk/X5qHvt0GwvIGw+vMN5va4e6NeSU5
         h7IHlKBK73nh1/fVTTYFCAhEzM87wk4UNkEp4vAh/HrKnZc+vY1LoRzuvfuUzW/Ua4K1
         5f/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ssc8lkNTgtLYiK6L/sDcTCRW2TNO8kwiCksw2xXO3WM=;
        b=j1/tI9E3t1D8tY7EoySROxUN/1OMfpcK5xSY28sO5X2O6VRN9THDMNiNRhEXMCwltC
         d7P7JlZlbCvlVN2Rop27ec7Ob3XCU08BReNV1ChAn8abS5JFJbBWOWFFsnCxSXiWAjqw
         FsBWlLbnLoawxaPHCTCN4kx/myYatFqvVyC/ZYijKJ41meI2ZQxtN4YqUuBerr/7TD+T
         Uo9lPzlH9B9TMkEAFD007C9h0IhACMqfNoXxWPA77Dn1WEqx+cdW6G0swKyKDPiynGoR
         CQNNWWcprZp41di/NZKJFE2dsZdBGv4Ew5SfqYEgIuxn7ZXs4oeAOyMeUnrP3HJKh4mD
         Yzyw==
X-Gm-Message-State: APt69E0HHbMBG3WO0cwvd6/5UoMQ3TGpZfzvr7zP8E4R2HiMtK+EzlrW
        I4oh/WAWnDzycdqT0bb6a5k=
X-Google-Smtp-Source: ADUXVKJqvoHASUKG/jb1QoRMr3pYRrLyx7KhcJIlEt1lkY+n8prXH8BGvTRJUdV+PEqvCBSw1GJ27w==
X-Received: by 2002:a17:902:683:: with SMTP id 3-v6mr8906343plh.291.1529212583132;
        Sat, 16 Jun 2018 22:16:23 -0700 (PDT)
Received: from localhost.localdomain ([147.46.241.218])
        by smtp.gmail.com with ESMTPSA id b74-v6sm27238593pfl.138.2018.06.16.22.16.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Jun 2018 22:16:22 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     paulmck@linux.vnet.ibm.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj38.park@gmail.com>
Subject: [PATCH] locking/memory-barriers.txt/kokr: Update Korean translation to fix broken DMA vs. MMIO ordering example
Date:   Sun, 17 Jun 2018 14:16:08 +0900
Message-Id: <20180617051608.2128-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.13.0
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
 Documentation/translations/ko_KR/memory-barriers.txt | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
index 921739d00f69..ada0a709cce1 100644
--- a/Documentation/translations/ko_KR/memory-barriers.txt
+++ b/Documentation/translations/ko_KR/memory-barriers.txt
@@ -1891,19 +1891,18 @@ Mandatory 배리어들은 SMP 시스템에서도 UP 시스템에서도 SMP 효
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
+     내려놓았을 것을 보장하고, dma_wmb() 는 디바이스가 자신이 소유권을 다시
+     가졌음을 보기 전에 디스크립터에 데이터가 쓰였을 것을 보장합니다.  writel()
+     을 사용하면 캐시 일관성이 있는 메모리 (cache coherent memory) 쓰기가 MMIO
+     영역에의 쓰기 전에 완료되었을 것을 보장하므로 writel() 앞에 wmb() 를
+     실행할 필요가 없음을 알아두시기 바랍니다.  writel() 보다 비용이 저렴한
+     writel_relaxed() 는 이런 보장을 제공하지 않으므로 여기선 사용되지 않아야
+     합니다.
 
      consistent memory 에 대한 자세한 내용을 위해선 Documentation/DMA-API.txt
      문서를 참고하세요.
-- 
2.13.0

