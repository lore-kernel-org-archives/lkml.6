Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF9AC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 21:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B5120657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 21:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsgI6GcH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9B5120657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbeKBGIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 02:08:41 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43837 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbeKBGIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 02:08:40 -0400
Received: by mail-lj1-f193.google.com with SMTP id g26-v6so18067071lja.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 14:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=axIt/JsyqaW8BlUNcu2AIWVALAuZYz1u2D+F7P8WTrA=;
        b=GsgI6GcHqnFsoNAvAHQbxqnC6AoC14LVJuzYLyilppcsSsA5n+/oDd1h35zgsnxw0u
         t9cSxXFYtRmI8OhMbBVd2r1UV5SwUMqu2lxIPzhYFNPylIAsEpQ9XtzqjY3p+xaQ9H3n
         Cc92x+6SjCRTIsVnBOzeVRzZX6p3eYeBHhSCb8mJtXwrhCLWx+kGfSSDeBmTdv4S+d3e
         HTO8IJ9U0iR4D3guZbRLFUtRDXOyf85233T4FFg9Jh0uWKC73aySrlq6y429LlbqQLoY
         JW41Nt0TEENwISIrlU8thduROKrv2N6l3N8YwrXVqSoHTLmYgenxAaAW/dpI+dyK21on
         APjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=axIt/JsyqaW8BlUNcu2AIWVALAuZYz1u2D+F7P8WTrA=;
        b=gduLdu6ZxpFZ0nlHBZDabzub23Gna9I7SsqwZt3zkyVdhXGktOKz+6J70yB9b3ECTL
         TAS9Pgx2FyM9XvTUZmmb1DYKb6eTue55SXFf4aY1kV2+ZG30euhiLPSPV/oA5AccF+nt
         kYTm00+fLwhjOsQHKLg5EJopuq0nz81Yi+kRkC63sR4t4Tu5E7wnf2k52f+9fb/HJHvt
         IUmn/R2SzR2g8slcKFUYmhUM4ZmmdwE8fbvGvdSAAuDVvdp3Zs19LwEZ6jIThxxsJj55
         s+LJNyhqcKk6OtfHqSizOjNwdLNX5jmDCU2J7t/nWSzBSyR6SWbgDNAMTiCyX8j+rPxc
         DySw==
X-Gm-Message-State: AGRZ1gL3rkq6Er9sQ0wVfnsIHvFtj+ZPZbihrRHxu8fXCW6o4db31YB4
        EPwFXel5eAKW7DlkdbgJk84HujLybxM=
X-Google-Smtp-Source: AJdET5dH28BOQi8TC3vBQEY+Mos7wnpe5EB+fjk8lkTdKpBozC3JBvlz4SG7JWz8JI7xn0bJRWl4/g==
X-Received: by 2002:a2e:9c08:: with SMTP id s8-v6mr5053873lji.149.1541106242031;
        Thu, 01 Nov 2018 14:04:02 -0700 (PDT)
Received: from octofox.cadence.com (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
        by smtp.gmail.com with ESMTPSA id r76-v6sm100922ljr.83.2018.11.01.14.03.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 14:04:01 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 0/4] Xtensa fixes for v4.20
Date:   Thu,  1 Nov 2018 14:03:45 -0700
Message-Id: <20181101210345.9076-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the following batch of fixes and cleanups for the Xtensa
architecture:
The following changes since commit 35a7f35ad1b150ddf59a41dcac7b2fa32982be0e:

  Linux 4.19-rc8 (2018-10-15 07:20:24 +0200)

are available in the git repository at:

  git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20181101

for you to fetch changes up to 960b82c383d38fea4439e4182b5be4352a6048e2:

  xtensa: clean up xtensa-specific property sections (2018-10-30 01:28:56 -0700)

----------------------------------------------------------------
Xtensa fixes and cleanups for v4.20:

- use ZONE_NORMAL instead of ZONE_DMA;
- fix Image.elf build error caused by assignment of incorrect address
  to the .note.Linux section;
- clean up debug and property sections in the vmlinux.lds.S.

----------------------------------------------------------------
Christoph Hellwig (1):
      xtensa: remove ZONE_DMA

Max Filippov (3):
      xtensa: add NOTES section to the linker script
      xtensa: use DWARF_DEBUG in the vmlinux.lds.S
      xtensa: clean up xtensa-specific property sections

 arch/xtensa/Kconfig              |  3 ---
 arch/xtensa/boot/Makefile        |  2 +-
 arch/xtensa/kernel/vmlinux.lds.S | 36 +++++-------------------------------
 arch/xtensa/mm/init.c            |  2 +-
 4 files changed, 7 insertions(+), 36 deletions(-)

Thanks.
-- Max
