Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75289C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B70F214C1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSr3bP50"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B70F214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbeLERyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:54:08 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33746 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbeLERyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:54:08 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so20642055wrr.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 09:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xb9ECD3pNEGkoUfMI/2UPdjGrLKV78cyJ8sXz0lD43Q=;
        b=mSr3bP5077qrLQ4DbEjkq9wbJqLmnlE5pkdk75rs8iDgQG4QJtXAryNCoxSgWaXusy
         mS5d3s/KW8VhWIbNfYb2VeWgBA7/KNjTHrFJjjptBaxUwvYyFuiJfIv4DbegnUh+afej
         TRRGDI4zbsM649lBDrG0fbeLK8SbGL+QxpkQ+7ZkNWjKx7JiwjuGhMciDzn7zGkZ6dvR
         DpSqE4NPbFL3AKuBOhtCOD7WgAtnFR4I8WiH4Dl7JFrl0HieLnGimA8vYEoDOisdXhoG
         HWEcf0VNmZaHFpnlLlyBHCF66eCZfck4qgbFKH5XTs7GYK5rwxiKU90Bq6SpKuKmejbo
         EqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=xb9ECD3pNEGkoUfMI/2UPdjGrLKV78cyJ8sXz0lD43Q=;
        b=kM/TlzDhL3HLLVjQm5YrDRS2CrD90BuY0+FloIACHXM3T+fUXDGLRyF95PTuLK8E7i
         FGbllaRr33wERPB1iAVhWaK1mdKXURrN3k6WTplayV5ceN2N8gozQ+qotGDPsQr0vQs3
         /89Qipil9UqoAQfSCh1Eg6c1S0MOcbd+tkbU7ozBZHdCrwG1ivJV9ME5zHlQtrvgymCU
         /EdrIqDjngVG4e1ev8RaxdE/9q9AQqIVp/MnoxGQYGis+e8eC7fRcF+B2C24JP+9eeVb
         tvXwp1HRHRxdltH0s6zj2xaDW7TS285xFgPARYsgbE8vZ8IqYHLYggb4OpvUVMyg0iEt
         dOtg==
X-Gm-Message-State: AA+aEWYW3k4PQYX/bF7ZHVtwTbpVr8RYiVlqFhgPXZVtWkrnstHpPrL8
        KJbQ/xHPUoBxM/fW1EKaCgQ=
X-Google-Smtp-Source: AFSGD/Uwhk0ULfWzKfTBh6xXIRrT+cXc3gogBW4Rf5qwjr4IlwnYtsRpd8ThNhiyVgAA7bSyDH23Iw==
X-Received: by 2002:adf:fe8f:: with SMTP id l15mr21596357wrr.313.1544032446560;
        Wed, 05 Dec 2018 09:54:06 -0800 (PST)
Received: from macbookpro.malat.net ([2a01:e34:ee1e:860:6f23:82e6:aa2d:bbd1])
        by smtp.gmail.com with ESMTPSA id k135sm21061725wmd.42.2018.12.05.09.54.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 09:54:05 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 3960611409E9; Wed,  5 Dec 2018 18:54:04 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] powerpc/32: Move the old 6xx -mcpu logic before the TARGET_CPU logic
Date:   Wed,  5 Dec 2018 18:53:55 +0100
Message-Id: <20181205175355.14787-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204205345.9514-1-malat@debian.org>
References: <20181204205345.9514-1-malat@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code:

  ifdef CONFIG_6xx
  KBUILD_CFLAGS          += -mcpu=powerpc
  endif

was added in 2006 in commit f48b8296b315 ("[PATCH] powerpc32: Set cpu
explicitly in kernel compiles"). This change was acceptable since the
TARGET_CPU logic was 64-bit only.

Since commit 0e00a8c9fd92 ("powerpc: Allow CPU selection
also on PPC32") this logic is no longer acceptable after the TARGET_CPU
specific. It currently appends -mcpu=powerpc at the end of the command
line, after any TARGET_CPU specific:

  gcc -Wp,-MD,init/.do_mounts.o.d ...
    -mcpu=powerpc -mbig-endian -m32 ...
    -mcpu=e300c2 ...
    -mcpu=powerpc ...
    ../init/do_mounts.c

Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Fixes: 0e00a8c9fd92 ("powerpc: Allow CPU selection also on PPC32")
Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg142315.html
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v2: As suggested by Christophe rebase onto next-test

 arch/powerpc/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 40bbeeeb5b4a..4b16588c920f 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -30,6 +30,10 @@ endif
 endif
 endif
 
+ifdef CONFIG_PPC_BOOK3S_32
+KBUILD_CFLAGS		+= -mcpu=powerpc
+endif
+
 ifeq ($(CROSS_COMPILE),)
 KBUILD_DEFCONFIG := $(shell uname -m)_defconfig
 else
@@ -241,10 +245,6 @@ KBUILD_CFLAGS	+= $(call cc-option,-fno-dwarf2-cfi-asm)
 # often slow when they are implemented at all
 KBUILD_CFLAGS		+= $(call cc-option,-mno-string)
 
-ifdef CONFIG_PPC_BOOK3S_32
-KBUILD_CFLAGS		+= -mcpu=powerpc
-endif
-
 cpu-as-$(CONFIG_4xx)		+= -Wa,-m405
 cpu-as-$(CONFIG_ALTIVEC)	+= $(call as-option,-Wa$(comma)-maltivec)
 cpu-as-$(CONFIG_E200)		+= -Wa,-me200
-- 
2.19.2

