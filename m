Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9189C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 23:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AADEF2077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 23:53:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AADEF2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbeIFE0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 00:26:11 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33087 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbeIFE0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 00:26:10 -0400
Received: by mail-oi0-f66.google.com with SMTP id 8-v6so17183779oip.0;
        Wed, 05 Sep 2018 16:53:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XtO99ev5ZPrjQnIQO8qkEa/mf4JvNHskYGW2nsqC7Sc=;
        b=offPPfX5+5tRw8iJsk0lK7cmJJqv2Ba+3HtKBWUWhm1fR3LCiBsPFLQHNogRsAD1Ct
         840XmBkZXAl01oFbXalInlnii++Ei00lR7rMZf+euN4DWhilejC7hpRYJU00FHR4UThv
         W+gspS7ar4kYqsmQkCDnH8iAqRCVpyZsmGV08Pn8OvpgtukZ/dpM8OTxaLPTHncRfh3y
         gNRJQ9nS204bXcasSZgYJLEjjtzpqY1HxfcuiwI26XEij7r9gWvryy3OS5qHLvCxUSIg
         uIDynQi/HFcUjsv340LCDd4O8SL0x2cha4TQDBQDPd0N8VDNamWCAHQf/92o31AeeadC
         q8kA==
X-Gm-Message-State: APzg51CFNvlt08hOzBthHWdkqQgvRS9OMVUUlLPgWQrNeAhp/rqmdIg1
        paEcwvTmE9jeMOHOZyW5QCjrkDQ=
X-Google-Smtp-Source: ANB0VdawK98ICdASZKgzpBduv353s0Kqnos1tj9D9w8DZr8viQlaCfeYpM543iMFC2A4G7LmYovfCQ==
X-Received: by 2002:aca:3606:: with SMTP id d6-v6mr99007oia.327.1536191617539;
        Wed, 05 Sep 2018 16:53:37 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id h186-v6sm3860624oib.55.2018.09.05.16.53.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 16:53:36 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 7/9] powerpc: enable building all dtbs
Date:   Wed,  5 Sep 2018 18:53:25 -0500
Message-Id: <20180905235327.5996-8-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180905235327.5996-1-robh@kernel.org>
References: <20180905235327.5996-1-robh@kernel.org>
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
Please ack so I can take the whole series via the DT tree.

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
