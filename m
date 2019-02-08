Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA060C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 06:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6DC521917
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 06:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfBHGCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 01:02:55 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45021 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbfBHGCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 01:02:54 -0500
Received: by mail-qt1-f195.google.com with SMTP id n32so2680984qte.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 22:02:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=4TWEnsjFZc+x/iliDyqlNVeoR4Cp1nM7bHEA3rt3bG0=;
        b=hu2Kos4h8UMuG1/EkfG6G70dXOxuIWr5F/H/3ZGWWIb9PgmjMAe+9dGgh+tYmg6Dsm
         y470HCNT+Kqs0uZ/NxOmIVTCx0Qqkg7c93S5FbN92L3qgivAvFPcooh9W0H1EoARpGpH
         2NtOteBa7X4QIxXXu85ux2G/2MGzojkYACSGICHQ2F37cZzA2yCk71ER/TBRc1V79x8d
         QTuA32inqv9WU6kLWlo4Cw7j+XvYUEI7VFwz+b2rd/djN+vVA3WRMWFx01UPN0E+q1n3
         KhUcBgcpyl5U8Q7b5PzSTO50UuZvWEOyFdQxnAPkDDpa7MpqYKm2NmvAhhOBm9skAXVz
         2AWA==
X-Gm-Message-State: AHQUAuaAz+J6B+zkS7ocb7TVhotZUmfepUmlwvUSYrwHt+r1ZMTDX5ng
        v7DlhciFX9LmJvEVRC+Akuqc9uiRkO2MNA==
X-Google-Smtp-Source: AHgI3IYq0R8Dc5p6CXxF2JykQ4IByMGVe2kkXNrbXJb2SycUPpEYJMJ0LG0wbZRVDE3XoXY3jo/KWA==
X-Received: by 2002:a0c:ae30:: with SMTP id y45mr14664005qvc.145.1549605773536;
        Thu, 07 Feb 2019 22:02:53 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id 8sm1973603qtr.7.2019.02.07.22.02.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 22:02:52 -0800 (PST)
Date:   Fri, 8 Feb 2019 01:02:51 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 0/3] generic asm: mman cleanup
Message-ID: <20190124142448.23243-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have MAP_SHARED, MAP_PRIVATE and MAP_SHARED_VALIDATE on all
architectures, it probably makes sense to de-duplicate these
and put them into a common header.

Please review and consider merging though the generic tree.

Build tested on x86 only. Has been in linux-next for a while now.

Michael S. Tsirkin (3):
  x86/mpx: tweak header name
  drm: tweak header name
  arch: move common mmap flags to linux/mman.h

 arch/alpha/include/uapi/asm/mman.h     | 4 +---
 arch/mips/include/uapi/asm/mman.h      | 4 +---
 arch/parisc/include/uapi/asm/mman.h    | 4 +---
 arch/x86/mm/mpx.c                      | 2 +-
 arch/xtensa/include/uapi/asm/mman.h    | 4 +---
 include/drm/drmP.h                     | 3 +--
 include/uapi/asm-generic/mman-common.h | 4 +---
 include/uapi/linux/mman.h              | 4 ++++
 8 files changed, 11 insertions(+), 18 deletions(-)

-- 
MST

