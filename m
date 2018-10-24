Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F156AC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 04:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 978F820651
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 04:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvUVYCRW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 978F820651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbeJXMaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 08:30:21 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44471 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbeJXMaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 08:30:20 -0400
Received: by mail-qt1-f193.google.com with SMTP id b14-v6so3786321qtr.11;
        Tue, 23 Oct 2018 21:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bhX8KOvlS7Fej6I2quLrqxEO3r5o2agNCXzVwB9o43A=;
        b=dvUVYCRW20lH9KB599qCaqBJY8GV879Zv4pXOrAKT1gwOnTQtZcPzAags2eZ1unDYA
         pXE4vLCqbP1XtISc8q0urwkBwhRrsXpOcQQWUGN/LlLBMHiF4CV+7I462sK3zWaSUXgY
         bCZLtIjvOIepRljPeof1WgmiLzpRguarLch7joanJjyezKWPyD7FaZK/T7lOJGchvEjt
         9ovIPsKIy2q5YD3DeInCyg/+ha5yQX37mOJqdt/THGwsPYWoJUUuOAIMDngfgDN9aRyn
         nSuUUwRX91VRQnK13Sn++lU87eYMd48gIHMKF/br9sMYLA4QrIFHkSha3pW6+r6PBKGC
         32+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bhX8KOvlS7Fej6I2quLrqxEO3r5o2agNCXzVwB9o43A=;
        b=AUaOavp2znpFKYX5E4c3EZGLiBfH9kzrtDtIopdMlpEGd1+0Xrr2DgbuHvONoHTh0k
         6khp7cS0qduI+yZxObO344SAA2ebpwH8MU9I2Vve9DfrWfqjU5JsA9jTdbeV5q4QG0tF
         YEsEPFP6RVAhWNXlYg/DgMr419rXhAOctn65AYzrnp4gMNTrlSjSWYxmPXtYd3oso14K
         7NKeCLXgUd/39cKLopHzxEdWoUVqUGj+zRBDNwBjMJ3/ubtbsJNmb6cesnvwy+8ksAbs
         u9IpsiR6Abtx3FrcTXZpva9achI3SroDg5XVdLcHT6FMj5XfZEhCWNyRrWRJLpyMEWG7
         pU9A==
X-Gm-Message-State: AGRZ1gJD7H/T508nzaDhDLQYpkY4ceY+LFTJYp/8jLZmfAM++MgG4nxB
        Be4vkGDLVQ8+Ggfo9TWLUek=
X-Google-Smtp-Source: AJdET5cgtOKmKoACIz+QVsIAphH2B7db6UV4BG2w9QZ3pPSjmNMdA4V8b7yRyVAQTyhvYHFUM0dhQA==
X-Received: by 2002:aed:30a2:: with SMTP id 31-v6mr899085qtf.127.1540353842320;
        Tue, 23 Oct 2018 21:04:02 -0700 (PDT)
Received: from localhost.localdomain ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id e195-v6sm3229126qka.2.2018.10.23.21.03.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 21:04:01 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     lkcamp@lists.libreplanetbr.org
Cc:     Leonardo Bras <leobras.c@gmail.com>,
        Borislav Petkov <bp@alien8.de>, David.Laight@aculab.com,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, helen@koikeco.de,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] Adds -Wshadow on KBUILD_HOSTCFLAGS and fix warnings
Date:   Wed, 24 Oct 2018 01:03:49 -0300
Message-Id: <20181024040354.24879-1-leobras.c@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset add -Wshadow on KBUILD_HOSTCFLAGS and fixes
all code that show this warning.

Changes in v3:
- Better Cover letter
- Better commit message for patch 1/5.
- Fixes what should change on patch 3/5
- Removes accent of my second name (better for searching at lkml.org)


v2: https://lkml.org/lkml/2018/10/23/151
v1: https://lkml.org/lkml/2018/10/17/169

Leonardo Bras (5):
  x86/vdso: Renames variable to fix shadow warning.
  kbuild: Removes unnecessary shadowed local variable.
  Creates macro to avoid variable shadowing
  modpost: Changes parameter name to avoid shadowing.
  Adds -Wshadow on KBUILD_HOSTCFLAGS

 Makefile                     |  2 +-
 arch/x86/entry/vdso/vdso2c.h | 13 +++++++------
 scripts/asn1_compiler.c      |  2 +-
 scripts/mod/file2alias.c     | 19 +++++++++++++++----
 scripts/mod/modpost.c        |  4 ++--
 5 files changed, 26 insertions(+), 14 deletions(-)

-- 
2.19.1

