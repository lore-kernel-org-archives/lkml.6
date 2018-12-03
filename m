Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EB1C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 02:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DEE9208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 02:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8agQNgt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DEE9208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725866AbeLCCk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 21:40:59 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35856 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbeLCCk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 21:40:59 -0500
Received: by mail-pg1-f196.google.com with SMTP id n2so5020371pgm.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 18:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=93rXnA9awaNhLhuJ2ig/8rOTGd18UkvaDyn8D72p9gM=;
        b=U8agQNgtl/qgTPj9688Bs5A9c5B7uSV8/vQu+TdGPotAE9LmCisMajy2bGrzJwZf9k
         5cz2F6VyVnfmMX2UEnpQSjb5AWXREE/3EAJBhfi3+AGKFWy/IKRoYbzdffGkIuk+xsLq
         VtBDgJspYYueB7bDGFg6Ug9uKxg55XtsgTZqjXzcZzIIHp5TCsrR5iftPtW57tq7xU2H
         rgSFKtJVjDNjCtO9z7UmNXBBGHfcIN1ovGVdyFMIDoJRUfAg8IN3qrV99xXVJrHeM/vU
         yAzbv5jjpxwgllcFUnUDkS304G/y08tDTNlETNOjxnPATfxYM3fSWYPFXrmG+EhJdoes
         9VWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=93rXnA9awaNhLhuJ2ig/8rOTGd18UkvaDyn8D72p9gM=;
        b=o6UyaNYcBa8zj9d6ivemZQRYuvGSwUnXrgZw5I4LOCWvLexjyOPgV153C/O3UqJnua
         01CRpKO/ZWd8bGQbub/BAOhu7hCyFgAEAlJEVm7Q7NQ6laNvmXHp5y1JuKWLSnRMEW5E
         ZKhvDwgUjl4afGvMzEL962CXTxvCU2T3lKiH/AlM27wnghs21nfsABE1dCV4Oq7I02LB
         XasdGsy94gBxmXj9qVdZYXQRgvtJg2zSVph5B8sy18T42/RTXTszDwIS9MvAMoB+IIKP
         pXu5nNhoY/RjkgrHvGqphPTbbBycCcT8WqxXMAGerjIGVhAFTQE+F16GOe/NRYvamUPe
         nn+w==
X-Gm-Message-State: AA+aEWYgbCFsf6v5g+WyXom0JkgxdpepAXqaCXtJNwLGrQtpOM81IvLk
        9/aRyNYqqIxTf9rcqzIYO7c=
X-Google-Smtp-Source: AFSGD/W6CsGnjgzkmDP5ToOS2bo95iZplzA8WB2BmI80y83lc0Dpe/g7nD/xjM1Y0a6xdlcX7NINZg==
X-Received: by 2002:a63:30c8:: with SMTP id w191mr12205254pgw.120.1543804854429;
        Sun, 02 Dec 2018 18:40:54 -0800 (PST)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id z62sm18805864pfi.4.2018.12.02.18.40.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Dec 2018 18:40:53 -0800 (PST)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Joey Pabalinas <joeypabalinas@gmail.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v4 0/7] zram idle page writeback
Date:   Mon,  3 Dec 2018 11:40:38 +0900
Message-Id: <20181203024045.153534-1-minchan@kernel.org>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
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

* from v3
  - add more words in changelog - akpm
  - clarification writeback limit - akpm
  - fix 4k unit of bd_stat - akpm
  - change writeback_limit interface - minchan
  - add reviewed-by - sergey, joey

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
 Documentation/blockdev/zram.txt            |  80 +++-
 drivers/block/zram/Kconfig                 |   5 +-
 drivers/block/zram/zram_drv.c              | 502 +++++++++++++++------
 drivers/block/zram/zram_drv.h              |  19 +-
 5 files changed, 476 insertions(+), 162 deletions(-)

-- 
2.20.0.rc1.387.gf8505762e3-goog

