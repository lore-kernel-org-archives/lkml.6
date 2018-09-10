Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71B2C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77A7920880
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:04:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77A7920880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbeIJT6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:58:46 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:37447 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbeIJT6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:58:46 -0400
Received: by mail-oi0-f66.google.com with SMTP id p84-v6so40746957oic.4;
        Mon, 10 Sep 2018 08:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bfCjKvj/Rt0QdLyRoM+SklnSQ45TvYZysCa41HzJYLU=;
        b=HpZ11fdm0L3hK7T2c730vlRYHfpHjXXMdv3GOSRB7l9GJleUppSAlBDKjUaxBqsp3h
         QfDT/gH/Q+2ak4/z5EVgClJDVukSPCBPtpeDkSD5txwJKX4LoBwiDldU8zIfqPuf28fd
         8ulJ5YbFdcveXmjA9A/eJ9Z+a10+MV0Bb9wUeFjz0mF8LAEGUh3RZdye2F7sYtfbk0pu
         3znuItpc4r8U6yrQoOgFxIDh0a9m8OfJEXHooz8zE7Uw2qTDisDeID7qE0Z9pg5EhiXI
         1wbeWsEGswNEQcSccUvTJjqkYPj8gXkBRWlAVGM+G3+JoEmTAEwirv0qM767GSUoEi0z
         L3TQ==
X-Gm-Message-State: APzg51AFQurMMa6yRslr0N008N3fAm3Wn3s3Vag4foR/rkvI5+jeHmvj
        waskJO/eeCRgl9v3khJnxwZ4Xok=
X-Google-Smtp-Source: ANB0VdaoQqh64KEDK/3hsxCkOBKINFBaBYQLj6dbRU0cxgxk1YeWMEUoTnjJaHW2+B8/P7CXjoalnQ==
X-Received: by 2002:aca:57d4:: with SMTP id l203-v6mr24246520oib.329.1536591855275;
        Mon, 10 Sep 2018 08:04:15 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id k85-v6sm49465631oiy.2.2018.09.10.08.04.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 08:04:14 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 7/9] powerpc: enable building all dtbs
Date:   Mon, 10 Sep 2018 10:04:01 -0500
Message-Id: <20180910150403.19476-8-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180910150403.19476-1-robh@kernel.org>
References: <20180910150403.19476-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the 'dtbs' target for powerpc. This allows building all the dts
files in arch/powerpc/boot/dts/ when COMPILE_TEST and OF_ALL_DTBS are
enabled.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/powerpc/boot/dts/Makefile     | 5 +++++
 arch/powerpc/boot/dts/fsl/Makefile | 4 ++++
 2 files changed, 9 insertions(+)
 create mode 100644 arch/powerpc/boot/dts/fsl/Makefile

diff --git a/arch/powerpc/boot/dts/Makefile b/arch/powerpc/boot/dts/Makefile
index f66554cd5c45..fb335d05aae8 100644
--- a/arch/powerpc/boot/dts/Makefile
+++ b/arch/powerpc/boot/dts/Makefile
@@ -1 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
+
+subdir-y += fsl
+
+dtstree		:= $(srctree)/$(src)
+dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
diff --git a/arch/powerpc/boot/dts/fsl/Makefile b/arch/powerpc/boot/dts/fsl/Makefile
new file mode 100644
index 000000000000..3bae982641e9
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+
+dtstree		:= $(srctree)/$(src)
+dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
-- 
2.17.1

