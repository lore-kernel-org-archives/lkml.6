Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74164C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2783621A84
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmpC+WCk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2783621A84
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933795AbeFUVJG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:09:06 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:36675 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933364AbeFUVJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:09:04 -0400
Received: by mail-yb0-f196.google.com with SMTP id x128-v6so1765429ybg.3;
        Thu, 21 Jun 2018 14:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/sM4r41VWieTiLT6QX4AaZ/Qohry7aao7yZcwf6mqEw=;
        b=FmpC+WCk/57a6O1nbVMd1BhP1zFaTsgqYRaJoJuwxT8I6M+QABGRifY//X2UoRdn8V
         /tHogBvVm5UX/AZxZnXM7D6QJrnnz4c/pxl531AryaER9DFDb1eEvQXO5o3OHADQIJd7
         WNNzWyudU+aEe4LZbSiRdTLSYP6ficSKTxMrtIQPN34Miu/okDHvyhz5/N64c4pxSNUA
         PLnzYDL15FGX5nGl8DaXsDZV5qQ0ItDqjOnMvXX3wpZ1oJV87vm4qnY/kf4X8Ha/u7nz
         AIg4Ca1DYvL7KPipE0uerp98PV2rCghUSgUqYVFrVcnBTDD57lDdv7TeQ4tGS7bLNkFX
         lAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/sM4r41VWieTiLT6QX4AaZ/Qohry7aao7yZcwf6mqEw=;
        b=Tie+KMPkzbaDRffFvn1au5yEolIEaNhOVyJmQms2MBT+K8fU2ahQjglkB/lejliWSv
         9z6TlO48X/KCASFZmMTdn6jz2g4wV32jay0BnyrUlQJg9B73nJnnejNmSv/PvQLDTkc3
         SEKG278EJghFjMWeUjEFJGmzuUnn+/WwAnHkNhoLrCEPcfNSuR8Fgm6v3p6r/LU1eGc1
         J+bRhdr6AKW4cD23VNK5AdJLrVjLQST4ncPsGVb0nP+sgl/e8n9aPJhiqu5ZQWekkknA
         T4Xmw8uE6sG+5EyVGU7iQXFOfd6bc9wRIhn+q2ibbIpt5y+rM75wyTTVJJj2ZinX61DB
         D1wA==
X-Gm-Message-State: APt69E0mQJSBzaR6NxlBDqF/5DINgLW3a9tgtakfMVTbclDqpw8GxyHL
        2EDZW3kQFKejr9ut08sTGeM=
X-Google-Smtp-Source: ADUXVKIewxO29njxnW9On5oOnDfi3dXMpJslNlpQozMsI8cxA7axl+llqhyYw1BJcGj0djpPUcx0gA==
X-Received: by 2002:a25:b611:: with SMTP id r17-v6mr13601434ybj.102.1529615343468;
        Thu, 21 Jun 2018 14:09:03 -0700 (PDT)
Received: from localhost ([72.188.97.40])
        by smtp.gmail.com with ESMTPSA id m62-v6sm2101989ywf.87.2018.06.21.14.09.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 14:09:03 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     jic23@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, fabrice.gasnier@st.com,
        benjamin.gaignard@st.com, robh+dt@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mark.rutland@arm.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v7 09/10] dt-bindings: counter: Adjust dt-bindings for STM32 lptimer move
Date:   Thu, 21 Jun 2018 17:08:57 -0400
Message-Id: <4bf9f5233a46e0dc195c27be19b76687448c17ff.1529607879.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1529607879.git.vilhelm.gray@gmail.com>
References: <cover.1529607879.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabrice Gasnier <fabrice.gasnier@st.com>

The STM32 LP Timer counter driver now resides under the Counter
subsystem. This patch adjusts dt-bindings to account for the STM32
lptimer driver move.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 .../devicetree/bindings/{iio => }/counter/stm32-lptimer-cnt.txt | 0
 Documentation/devicetree/bindings/mfd/stm32-lptimer.txt         | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/{iio => }/counter/stm32-lptimer-cnt.txt (100%)

diff --git a/Documentation/devicetree/bindings/iio/counter/stm32-lptimer-cnt.txt b/Documentation/devicetree/bindings/counter/stm32-lptimer-cnt.txt
similarity index 100%
rename from Documentation/devicetree/bindings/iio/counter/stm32-lptimer-cnt.txt
rename to Documentation/devicetree/bindings/counter/stm32-lptimer-cnt.txt
diff --git a/Documentation/devicetree/bindings/mfd/stm32-lptimer.txt b/Documentation/devicetree/bindings/mfd/stm32-lptimer.txt
index 2a9ff29db9c9..fb54e4dad5b3 100644
--- a/Documentation/devicetree/bindings/mfd/stm32-lptimer.txt
+++ b/Documentation/devicetree/bindings/mfd/stm32-lptimer.txt
@@ -16,7 +16,7 @@ Required properties:
 
 Optional subnodes:
 - pwm:			See ../pwm/pwm-stm32-lp.txt
-- counter:		See ../iio/timer/stm32-lptimer-cnt.txt
+- counter:		See ../counter/stm32-lptimer-cnt.txt
 - trigger:		See ../iio/timer/stm32-lptimer-trigger.txt
 
 Example:
-- 
2.17.1

