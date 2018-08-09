Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E602C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 16:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB8A021EB7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 16:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k+lSTCXy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB8A021EB7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732556AbeHITGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 15:06:32 -0400
Received: from mail-qk0-f201.google.com ([209.85.220.201]:34159 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732384AbeHITGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 15:06:32 -0400
Received: by mail-qk0-f201.google.com with SMTP id y130-v6so6337597qka.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 09:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=TjA5wnEFuRDk/CXAWSG8FBrlJT0B776bpMTiXw/12KI=;
        b=k+lSTCXy/3lN31gyL+j1l5uBeUGDwrVfUENi8nmOITfzYrjgK/JOzdiOPxk0fe1vnc
         w0lFu2wtW2u1SJRfuoz29CnuA0ula/mk480UHMyqX+O/ja9V0gdEYtXvZ13Wc9YDz+HI
         Cp6sKgLxcAGrWO7itByv3UJ8Sk+LGXh0c+HLDbxbzf0suBgGW+A4gqVkUvgKe4zOHeTZ
         F+0JiwuX0SKUrxSCnzrCR0CqdMClyufeykqmAbx4o8O3KNkGOibjAzSFb78WEjQs2Hc8
         zZzsxh1SHuqbToQ+Ghx+QJ5iQ8hx/XdfC2p7VW39v5yJJnSq+/rlUYEcKw1P2+XZQZ2E
         lQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=TjA5wnEFuRDk/CXAWSG8FBrlJT0B776bpMTiXw/12KI=;
        b=IahHRTSs5M6/3yONqvTamuyn/CC7G3jDI3+y8bSF0EEZ58bs3LRUh8xSOIBCNepRah
         7Z4DX0e9TOZKNpzaWUOImyNCSq30wIRj31y65O+ILnE0QcOTcDRzvrbkdZRf10kAbH06
         Igke/6oong3Dik5LYc6FPa4+a5lJh/EMMfhZT/4zNPVXaBTLMJmiH3PXczgDyFlaBUee
         /VS08RtfqjJeTEWTLDx3MdOs0E5lx+gF35xx9KM2j7l02rd7xi6VHK3WRpcLQpLw1/XU
         OYwcdSPjpz/kmmdYkmRnfLSlWquJA5LBB46Xl/AumRQfsMTBtXDLsV4rmh5S48t2FWuc
         cr1A==
X-Gm-Message-State: AOUpUlEzrjCdWktUq71YuX4njKN68HFndcyLAZH0z4LsKhvZq0uYmL6A
        ZbaaKWD+7HYico+f8n1GiJclaSTVwYqwg5Xwh/tbIcL15+lRzl/mYDT8+BkSFyx5USvSP4rpK8j
        hWTb2ME02/PU/lQH718lhfN6F6HawVHJTW0Mfr9ALKD9Tzqr6MBFoX0MZsGMnSjHuyRQJbLaraG
        18EA==
X-Google-Smtp-Source: AA+uWPxn/+6i3Nu/5OQLij0HrOrirxSWAquCVDLq6BzeHbgB4j0F9gc57VyPVofKGIXbf7eAUvJpeWOjtmlAFnU=
X-Received: by 2002:a0c:c306:: with SMTP id f6-v6mr1426877qvi.14.1533832850183;
 Thu, 09 Aug 2018 09:40:50 -0700 (PDT)
Date:   Thu,  9 Aug 2018 09:40:42 -0700
Message-Id: <20180809164042.210675-1-astrachan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH] efi/libstub: arm: support building with clang
From:   Alistair Strachan <astrachan@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Stefan Agner <stefan@agner.ch>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with CONFIG_EFI and CONFIG_EFI_STUB on ARM, the libstub
Makefile would use -mno-single-pic-base without checking it was
supported by the compiler. As the ARM (32-bit) clang backend does not
support this flag, the build would fail.

This changes the Makefile to check the compiler's support for
-mno-single-pic-base before using it, similar to c1c386681bd7 ("ARM:
8767/1: add support for building ARM kernel with clang").

Cc: Stefan Agner <stefan@agner.ch>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-efi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Alistair Strachan <astrachan@google.com>
---
 drivers/firmware/efi/libstub/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index a34e9290a699..91339d13f2a1 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -13,7 +13,8 @@ cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ -O2 \
 
 cflags-$(CONFIG_ARM64)		:= $(subst -pg,,$(KBUILD_CFLAGS)) -fpie
 cflags-$(CONFIG_ARM)		:= $(subst -pg,,$(KBUILD_CFLAGS)) \
-				   -fno-builtin -fpic -mno-single-pic-base
+				   -fno-builtin -fpic \
+				   $(call cc-option,-mno-single-pic-base)
 
 cflags-$(CONFIG_EFI_ARMSTUB)	+= -I$(srctree)/scripts/dtc/libfdt
 
-- 
2.18.0.597.ga71716f1ad-goog

