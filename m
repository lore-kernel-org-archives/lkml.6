Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B36C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 05:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7212520873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 05:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiEEqbx5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7212520873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbeK0QwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 11:52:14 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45299 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbeK0QwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 11:52:14 -0500
Received: by mail-pf1-f194.google.com with SMTP id g62so7798522pfd.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 21:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=soKMUk1qQSKl5Q75m4L8eHM47lAJ7OKo8kCDNdc+vLo=;
        b=aiEEqbx5HM9sga+9Ewi2ZRY2iaX+XTaoH4p1nCr3D0rRXXD5RHGw3OH5q3UsxPPqrz
         5j/QVDDYgpn9PYBpFxp1tWYiUOK7kRUz99Xw2dbmbK6Uhq+G8L99dhC6s2kiddauUfKA
         m7qZ2bob26LbhOJqCg9+yi4gNqAsWLLwfHlbxUQSDodrEE2ya+e9GdFFObscpb0OihD7
         f3+Xp2m1RF/q6Y77brmatBvFOvXwcMc6L/dUVPcy7J1dac8Lb7ubgZWPz3JJXiNnVkJd
         z8moq4oGSs9+nyCaGRLJm7NBBvZTndwFKgy8RcKOvaWE0neqncPd9FkAzfeuhlDLcPFj
         RD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=soKMUk1qQSKl5Q75m4L8eHM47lAJ7OKo8kCDNdc+vLo=;
        b=fmqywl3YQtrFruNpPRP4CfKDSgKXOk5vEDO5/AEWWofyU5AsLgM10rwEfGrbitBIw1
         6MyNiLPSpd+MjXVGXAPhepGyBGCMXSyG9qbeOoMtFn9LKukV+l+ZXO2a+rt1OYM0+zPU
         V0+bszow5gnoaIMg//XJqcwWBXRWkQKYDQJvKZI/FaCOaGoC9cuIZs6Ib6FT8VMqGlm3
         wsHsxtC9gaMpu5DJV2JHRPzKAVJvFgI6WeQV8/l+4G8CILA5wm76RcRKg9fHtruwFVTI
         ZmLi+LsfcpDTcXQ05/E7PbuzD1CKOeoV7hjKOixBZ5AxOMSZSyZWK65S2vnLH4N/yVOE
         GHNA==
X-Gm-Message-State: AGRZ1gJ+kpZFwErTIahP/LsiS9nhJFT4FB44UMhwDk6jdfd1Ae9fGJiO
        Ev9PG6dM9MfnBLkMioVvQNY=
X-Google-Smtp-Source: AJdET5d1wsgc2zsl/On4NgKCUSQa14aHHHLZi5+NtUef+jQnPjErBSU2wLIFTxFuwOkt0amZHbkPEQ==
X-Received: by 2002:a62:2781:: with SMTP id n123mr31980944pfn.138.1543298129395;
        Mon, 26 Nov 2018 21:55:29 -0800 (PST)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id f32sm2580203pgf.80.2018.11.26.21.55.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 21:55:28 -0800 (PST)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Joey Pabalinas <joeypabalinas@gmail.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v3 0/7] zram idle page writeback
Date:   Tue, 27 Nov 2018 14:54:22 +0900
Message-Id: <20181127055429.251614-1-minchan@kernel.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inherently, swap device has many idle pages which are rare touched since
it was allocated. It is never problem if we use storage device as swap.
However, it's just waste for zram-swap.

This patchset supports zram idle page writeback feature.

* Admin can define what is idle page "no access since X time ago"
* Admin can define when zram should writeback them
* Admin can define when zram should stop writeback to prevent wearout

Detail is on each patch's description.

Below first two patches are -stable material so it could go first
separately with others in this series.

  zram: fix lockdep warning of free block handling
  zram: fix double free backing device

* from v2
  - use strscpy instead of strlcpy - Joey Pabalinas
  - remove irqlock for bitmap op - akpm
  - don't use page as stat unit - akpm

* from v1
  - add fix dobule free backing device - minchan
  - change writeback/idle interface - minchan 
  - remove direct incompressible page writeback - sergey

Minchan Kim (7):
  zram: fix lockdep warning of free block handling
  zram: fix double free backing device
  zram: refactoring flags and writeback stuff
  zram: introduce ZRAM_IDLE flag
  zram: support idle/huge page writeback
  zram: add bd_stat statistics
  zram: writeback throttle

 Documentation/ABI/testing/sysfs-block-zram |  32 ++
 Documentation/blockdev/zram.txt            |  51 ++-
 drivers/block/zram/Kconfig                 |   5 +-
 drivers/block/zram/zram_drv.c              | 501 +++++++++++++++------
 drivers/block/zram/zram_drv.h              |  19 +-
 5 files changed, 446 insertions(+), 162 deletions(-)

-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

