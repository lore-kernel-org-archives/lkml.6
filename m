Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BDBC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B46920854
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="oIIzS7rM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbfAVHmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 02:42:10 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44718 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfAVHmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 02:42:09 -0500
Received: by mail-wr1-f68.google.com with SMTP id z5so26047680wrt.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 23:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=3q+zgz6TINUxYhFX1orF5+LYZH6pS39Bhg/MHhk1L1o=;
        b=oIIzS7rMWpoMElcWe0PrZB2F4IUehKPk3t2bLeUHfJFqwbH4j1IlQfz4mORdU53e/T
         GRPmx+oHjQGPmvInitOfthq0mKScUFy+Vw9lDH65laQxCplcUT3wTlUTBAEoFahMtCeu
         PTzrhaOmRdoLbc3VCDFn+yO790V8VcJcDnzZ0PP4FEzVbvfA9kHPbJKVuSLMJYr7JvZn
         W4RO2YzXHwViW2H2yRIz5KgE7+lMdLipknPjhcNPzlX6sl481RCBf0oveUTjVEi0RhyB
         7QDl+iM0gUJlp6gFTxA2lr26trRIA1wstVKbYTcvj8sdmQc5VJC3CRqzypUTlDDylitw
         jntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3q+zgz6TINUxYhFX1orF5+LYZH6pS39Bhg/MHhk1L1o=;
        b=I0XXBUKCQ5UDswzcliX9BdZQMfwjGC27Fw77CfTBulw693pcHJCUusyQCX1tFERbZ7
         0w3L/uWv2bsCZ7YL/J066w19k+085A/S3jG7UUWQUDb4XSmMZs0xXz/Li66VcTk3TUaY
         F/p9W6kEq98sA24Hf6PmIppTEUU8HMsYHX60xM9NFd9zMH7xCiNSAS0jeb79jpZ2xTyk
         w11W/UYhIKTLM2mcqrf8UepJH1KJq5i2iesKFPV465hOd16eeoUl/cGNZUViypSDNDwW
         gDGuiUsw5kCqQLj83RJLHPugSxSObD/Sq6dWJ05GPlpY+Mt+MxZ2jGUDnRDKtif2L8Gk
         hZOg==
X-Gm-Message-State: AJcUuke/bELGZCbqDV4Roi2sWf1SufTBj9Bd4LfvJLwS5PDWD9NHbUCr
        kKzroIM6NJP9AGoefXNU+bRlJQ==
X-Google-Smtp-Source: ALg8bN4B/ztsU9j5CtXhKggmiW6wHQvc8WNFHrUXJarGtzUhan47tiOp+uFAv3G/aBbYul59ySIscA==
X-Received: by 2002:adf:e5d0:: with SMTP id a16mr31211145wrn.89.1548142927945;
        Mon, 21 Jan 2019 23:42:07 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id t199sm36969294wmt.1.2019.01.21.23.42.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Jan 2019 23:42:07 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     benh@kernel.crashing.org, mark.rutland@arm.com, mpe@ellerman.id.au,
        paulus@samba.org, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2] powerpc: build virtex dtb
Date:   Tue, 22 Jan 2019 07:42:00 +0000
Message-Id: <1548142920-11219-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I wanted to test the virtex440-ml507 qemu machine and found that the dtb
for it was not builded.
All powerpc DTB are only built when CONFIG_OF_ALL_DTBS is set which depend on
COMPILE_TEST.

This patchs adds build of virtex dtbs depending on
CONFIG_XILINX_VIRTEX440_GENERIC_BOARD option.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
Changes since v1:
- squashed the two dtb into one make line
 arch/powerpc/boot/dts/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/boot/dts/Makefile b/arch/powerpc/boot/dts/Makefile
index fb335d05aae8..1cbc0e4ce857 100644
--- a/arch/powerpc/boot/dts/Makefile
+++ b/arch/powerpc/boot/dts/Makefile
@@ -4,3 +4,4 @@ subdir-y += fsl
 
 dtstree		:= $(srctree)/$(src)
 dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
+dtb-$(CONFIG_XILINX_VIRTEX440_GENERIC_BOARD) += virtex440-ml507.dtb virtex440-ml510.dtb
-- 
2.19.2

