Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE3CC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 23:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B1632077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 23:54:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B1632077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbeIFE0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 00:26:30 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34326 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbeIFE0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 00:26:11 -0400
Received: by mail-oi0-f66.google.com with SMTP id 13-v6so17210408ois.1;
        Wed, 05 Sep 2018 16:53:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JV1ND1kmyaoPMqhR4VNx9a7L+yWo3L8dGbC1wHZQ/to=;
        b=mWw2MFVxzS3Mib7Vf9VmwMhjQt6GMRP4tuM3hFD3IsI+p1AJmEa4igA8tdA5EdMLz6
         OInltYtggyUc9r38bOOPw4BpIIPFru3B0yw3DN1vCXtB/In1X8h+cDrdB/kn479YUdEy
         Cgy3BFRB+q2y3KBCcuCmwXHyhY06PPf7TLCvtzSfJCDtGD5fWvAwgMil6lBnRq/DhIU+
         z6QLogf8HEoQ/to2utsU/Gs9Gp5jsySt0sgkZlODlPt422lPbLjmUZSVgeVZW5jaTCcx
         nJfzVHi08if1d2vD/96wHA39jBV8q6cGMuEapW8hgUwACqteIuMwK/RVw/99tdR/Qc0x
         frcw==
X-Gm-Message-State: APzg51DQKVNXtt0Atszz7CfcEbR7oOm2Vjz+QN9bQAx/U7qY//N6iaNy
        OZ60B0MVUZSoik2qLetwtETT5FY=
X-Google-Smtp-Source: ANB0VdZRYO2bw5wEt5qjIXUY2BR0qhO2PT5Jl4KotQMnAv2EDvHSfToNERdi6rPoTB6zHkWlHogvaw==
X-Received: by 2002:aca:d946:: with SMTP id q67-v6mr127379oig.212.1536191618563;
        Wed, 05 Sep 2018 16:53:38 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id h186-v6sm3860624oib.55.2018.09.05.16.53.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 16:53:37 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org
Subject: [PATCH v2 8/9] c6x: enable building all dtbs
Date:   Wed,  5 Sep 2018 18:53:26 -0500
Message-Id: <20180905235327.5996-9-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180905235327.5996-1-robh@kernel.org>
References: <20180905235327.5996-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the 'dtbs' target for c6x. This allows building all the dts
files in arch/c6x/boot/dts/ for enabled platforms or when
COMPILE_TEST and OF_ALL_DTBS are enabled.

Cc: Mark Salter <msalter@redhat.com>
Cc: Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
Cc: linux-c6x-dev@linux-c6x.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please ack so I can take the whole series via the DT tree.

 arch/c6x/boot/dts/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/c6x/boot/dts/Makefile b/arch/c6x/boot/dts/Makefile
index fd937f781d16..f438285c3640 100644
--- a/arch/c6x/boot/dts/Makefile
+++ b/arch/c6x/boot/dts/Makefile
@@ -5,6 +5,12 @@

 DTC_FLAGS ?= -p 1024

+dtb-$(CONFIG_SOC_TMS320C6455) += dsk6455.dtb
+dtb-$(CONFIG_SOC_TMS320C6457) += evmc6457.dtb
+dtb-$(CONFIG_SOC_TMS320C6472) += evmc6472.dtb
+dtb-$(CONFIG_SOC_TMS320C6474) += evmc6474.dtb
+dtb-$(CONFIG_SOC_TMS320C6678) += evmc6678.dtb
+
 ifneq ($(DTB),)
 obj-y += $(DTB).dtb.o
 endif
--
2.17.1
