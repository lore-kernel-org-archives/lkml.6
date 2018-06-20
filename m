Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1588DC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A63A820652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XV3NvB5C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A63A820652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754601AbeFTI6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:58:18 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42671 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753386AbeFTI6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:58:15 -0400
Received: by mail-pl0-f66.google.com with SMTP id w17-v6so1398725pll.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 01:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wElC+6eKHQkuOe8WYHn7P9GC2l4DIa8zoz906BcyAM4=;
        b=XV3NvB5CaUFlgH/vE0DO03YqwLyrGbQAm78A6iK8/AsCyt4FchQFehJ2rUG4apPbQS
         99/TaYQxMtw08ghA1xj7pxKd85UNn74HHV8xmhc57Y54VRrpBspMbutCMXDyoyfoyxNp
         jKddXiSMAKjQgi7V4ut11mZbXB0CQS8dSdLamEMhzRCHATwgb7GRlfJOATUer819JYWz
         pDLGMHnRDOIE4ugZkeD8TkcNS3q46KfigVi+GI3fCMhu7I8M1zDdP+Y9i46zbGvQrJie
         AHyy5BM5XBA2Rtq0NVgyT+nWhi8YHnGXuseHgVattDziZ2JkVpZ1MUVqgnvavSWoEv1A
         tWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wElC+6eKHQkuOe8WYHn7P9GC2l4DIa8zoz906BcyAM4=;
        b=LLgaa/dwuQwvHKzJtuU82j6CTtSJXp/W4Pk8xXKSATl2KzOo+2MfPfgGvqa7lDTm6K
         KjXciuzvFkccA2mMrMabVQnrpdozAe39j6jA3zn8A2rJMODtScwktHTygPGF9XajNZ5T
         afwDzQ0T6SL91ADkmMlY6jovyuRoxf2cKbVLFcY1JUhLunF40ZYUoirLKuVyvxKZl316
         nrYufiMJ5wRGBAkmypRhdXQL+G4zVlTmy8AKFgbT68W4VJu4ZJMz7CzxAo22Wqa6myuT
         H//w4DEN9ZvmKQWuciHjoIa0zLBbOjbAkgdDyfZIjmtPJjpKyHlXLDR2uHG7mzHVnZKW
         40EA==
X-Gm-Message-State: APt69E1XMYvLjmiAXxQ9pVSOY5bMCr/pp1uO1aYeqB8sCpWg7yNbkG1y
        8Z/SVZaaYvSHBOdNALmC3Bs=
X-Google-Smtp-Source: ADUXVKLo9IRP0bH3I+2dbkkHumFzYz/NT3gDO9VaYlsvwcsMwBrIG+v+43eqDeAQra1pebXSbCzhmQ==
X-Received: by 2002:a17:902:9344:: with SMTP id g4-v6mr22770028plp.10.1529485094909;
        Wed, 20 Jun 2018 01:58:14 -0700 (PDT)
Received: from toy.corp.qihoo.net ([104.192.108.9])
        by smtp.gmail.com with ESMTPSA id i65-v6sm5350257pfd.17.2018.06.20.01.58.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 01:58:14 -0700 (PDT)
From:   Jun Yao <yaojun8558363@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        ard.biesheuvel@linaro.org, james.morse@arm.com,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: [PATCH 0/1] Move {idmap_pg_dir,tramp_pg_dir,swapper_pg_dir}
Date:   Wed, 20 Jun 2018 16:57:54 +0800
Message-Id: <20180620085755.20045-1-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves {idmap_pg_dir,tramp_pg_dir,swapper_pg_dir} to .rodata
section, which makes KSMA more difficult. At the same time, it is more
concise than the previous patches[1][2]. As James Morse suggested[2],
this patch updates swapper_pg_dir through the fixmap entry.

[1] http://www.openwall.com/lists/kernel-hardening/2018/05/31/1
[2] https://patchwork.kernel.org/patch/10449589/

Jun Yao (1):
  arm64/mm: move {idmap_pg_dir,tramp_pg_dir,swapper_pg_dir} to .rodata
    section

 arch/arm64/include/asm/pgalloc.h | 19 +++++++++++++++++++
 arch/arm64/kernel/vmlinux.lds.S  | 32 ++++++++++++++++++--------------
 arch/arm64/mm/mmu.c              | 23 +++++++++++++++++++----
 3 files changed, 56 insertions(+), 18 deletions(-)

-- 
2.17.1

