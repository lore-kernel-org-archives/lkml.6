Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1326EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 07:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C831B208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 07:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbHrfVZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C831B208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389162AbeKPRbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 12:31:53 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42777 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbeKPRbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 12:31:53 -0500
Received: by mail-pf1-f193.google.com with SMTP id 64so6500009pfr.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 23:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qZYQj4gI/wGmag7K5YfqxCRA0UcBFavQGf1Z3vF8+Ms=;
        b=mbHrfVZKfMVA17QhPRrvLpphZ0tfcmOxmFploNOXle2q96gHtJXEcbxm6W/nFZbl+D
         Op9Myv+cbG52JOVzcHaRxAfRvVQ3usK+NPgxaCqd2vQcGGkH2sem1dcwiPvwTMytPrQ4
         B7neCok+g/dyAFQvcH5prIZAjHlJUIjCaCVFG5HUTOCyEGQtC9SOpWUXvuXxRSKv6xQK
         HoInhmTnEdw3FBEHaRdMrRpxrBhBMqISyWD8r4i0DUDNH1q7rT0iLtSg8m7hmVaLtjo5
         pffZJiVohnlEu6bOzFlH3IP3R9P861yZ9rAy9Twy+90BICK3ON/rCHoSrx3qWGX3xiEa
         JM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=qZYQj4gI/wGmag7K5YfqxCRA0UcBFavQGf1Z3vF8+Ms=;
        b=HJwyU94L0ty3YZYxRMQRTLw/yC1ymHoe06g6X4hAsK8Xs+hFS/etvFRquQp6iuGVgW
         0B+ZvtLVPVB5b2eEvBSDOMTek+xmY/lBXMCv3qhRVMJd1xSU+p9725QnRwioMOomvdTh
         6Y3A7A4TYNl4XE8Tk/yRU+nD5bGk0ZP8Av9psXJpmeLKHQantZpSF+AqRGXye1cPfZqK
         cUXkN7cZAgO7MxM2O8/ucgnHZjKQNoaEnnaaJD36JH2wf9GHPoG+6w/YjX/P1bVPiiKV
         cgxh7TblZ9KqvHupSzcnXaxYCr9G8R+kQmPpyz1mGx5qfKAEkiajzMJ+n7Opvravq2st
         KSjg==
X-Gm-Message-State: AGRZ1gIvkSe09V12y/ElEa87tMfVpOvqeUBO4G4X/bzpkLrlVdh3o5cR
        ofmV5pFoBokBNppXSCVhtHs=
X-Google-Smtp-Source: AJdET5feOkLxp/Hi0zdvivg8fDW9Bmpgj8zl255VxOUBXDcNnveIucuLq29jZbuWVwJxtegpuGpf3A==
X-Received: by 2002:a62:401:: with SMTP id 1-v6mr9726953pfe.156.1542352843088;
        Thu, 15 Nov 2018 23:20:43 -0800 (PST)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:0:7630:de9:f6f2:276f])
        by smtp.gmail.com with ESMTPSA id e9sm13974637pff.5.2018.11.15.23.20.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 23:20:41 -0800 (PST)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH 0/6] zram idle page writeback
Date:   Fri, 16 Nov 2018 16:20:29 +0900
Message-Id: <20181116072035.155108-1-minchan@kernel.org>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
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

Minchan Kim (6):
  zram: fix lockdep warning of free block handling
  zram: refactoring flags and writeback stuff
  zram: introduce ZRAM_IDLE flag
  zram: support idle page writeback
  zram: add bd_stat statistics
  zram: writeback throttle

 Documentation/ABI/testing/sysfs-block-zram |  32 ++
 Documentation/blockdev/zram.txt            |  42 +-
 drivers/block/zram/Kconfig                 |   5 +-
 drivers/block/zram/zram_drv.c              | 435 +++++++++++++++++----
 drivers/block/zram/zram_drv.h              |  18 +-
 5 files changed, 438 insertions(+), 94 deletions(-)

-- 
2.19.1.1215.g8438c0b245-goog

