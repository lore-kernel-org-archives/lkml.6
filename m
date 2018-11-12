Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9910C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7713D214F1
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o1HdLUjz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7713D214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730641AbeKLOMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 09:12:50 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43362 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730481AbeKLOMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 09:12:50 -0500
Received: by mail-pl1-f196.google.com with SMTP id g59-v6so3652736plb.10;
        Sun, 11 Nov 2018 20:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N5qjw6CuQ5e2lq25QqVD+oGeRhNwxs80XW3IRlwgeLU=;
        b=o1HdLUjzFqvZtU4jSRoKydCuFebeDzUQFCGUgwZ9AXAs4lORQEhz+cIEtFfHGnD0Ue
         mMr3BPzr/GBk7gONJpjP0XKwV6TdkFEBs12yZBlkhESAk4EC2+1WiEslvZKOco80iAbL
         GB+QtTEp/R+I7/7V5h07vMvblwaLtiSi2vadpEMDdtQHMYiNdwQBifgMYTdrmXxDldpn
         4uYBjP70FJB1u5khP9RS1mC7JUvvPL+h5meI+VFpuuyWlqQQqjKMdSxirHEGxgsStppp
         TD7xuaWJjaglu7WGjk3IDrnGOwRbc4vIy23Qj2g7N58ND8M+heks3HHXI+VBp0dwcCVT
         cJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=N5qjw6CuQ5e2lq25QqVD+oGeRhNwxs80XW3IRlwgeLU=;
        b=f0XGm4rBeWvS3xOHUsbfc0t4CdXcEh/9+XGCcXDRKyg6Wg9SQYNlN+NjTaMhllIFne
         W9liWTBdi93Jjhj0qu3Dud7bExJnRh0IxdUp2TPwAvcbazXbvdW9qSOkza2rxS82YSTJ
         VwC0Th1pO+z4Gk4D1zyM7MbaJeTHh3NHDEf8LORMmjN4VI5O3E1TpbDnfulbto2W3UYm
         7v8LUIBKVndKpQbv42bWdrvmNFAzT55vBimEvZO+xRghwTQNtkWpHcemiClDfC4LqxXE
         x68+BjyYWNrGUV06ZuZbOehHhnRh/ttROPwuYKhHxAWT6Fz5GU+WdOEwu2rYo/J1x91x
         +uUg==
X-Gm-Message-State: AGRZ1gJw9zK0iMzmo16VE7Qzoei15NxBHpqZ/y5CJYmykoH9mjKc8p9n
        LwH7GPthlt/Ns/JCosyxjX4=
X-Google-Smtp-Source: AJdET5cXkYwxp0ns2celIWIhHN1DWh5HBgcUElxlwxGUfpOEW/t0FxTKd89VzxBDhWTbVKaguUajNw==
X-Received: by 2002:a17:902:2863:: with SMTP id e90-v6mr17862946plb.244.1541996488823;
        Sun, 11 Nov 2018 20:21:28 -0800 (PST)
Received: from aurora.jms.id.au ([45.124.203.15])
        by smtp.gmail.com with ESMTPSA id y9-v6sm15588958pfe.152.2018.11.11.20.21.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Nov 2018 20:21:27 -0800 (PST)
Received: by aurora.jms.id.au (sSMTP sendmail emulation); Mon, 12 Nov 2018 14:51:20 +1030
From:   Joel Stanley <joel@jms.id.au>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Daniel Axtens <dja@axtens.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/2] powerpc/boot: Fix cross compiling with clang
Date:   Mon, 12 Nov 2018 14:51:14 +1030
Message-Id: <20181112042116.5271-1-joel@jms.id.au>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2: rebase on "kbuild: consolidate Clang compiler flags"

These patches allow clang to cross-compile the powerpc boot wrapper.
The boot wrapper constructs it's own compiler flags as it may not be
built for the same arch as the kernel.

The powerpc64le kernel builds natively with clang and with this patch it
can cross compile too.

Joel Stanley (2):
  Makefile: Export clang toolchain variables
  powerpc/boot: Set target when cross-compiling for clang

 Makefile                   | 1 +
 arch/powerpc/boot/Makefile | 5 +++++
 2 files changed, 6 insertions(+)

-- 
2.19.1

