Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52698C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 04:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14B12214DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 04:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUPRq5jf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14B12214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbeJQMCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 08:02:02 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40124 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbeJQMCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 08:02:02 -0400
Received: by mail-pl1-f195.google.com with SMTP id 1-v6so12011692plv.7;
        Tue, 16 Oct 2018 21:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Kc+LGXTJP5a4OW4ukBBIrmohxIG9LELyhLeP+KjgoWo=;
        b=gUPRq5jfy2fJgD4zf7ZzNippxJImfWQsgEzg1jiYDK+Uk0/DEHNZJw028CQvf/jJwr
         YbWTMDqjCfrTm17tlkOI2EbG5m+sbYNv4vz+/RcILYdcOXRLfZdTeEQ9bat51Q5gkINe
         tXGzaVmtvJkqnvZnVhhg6Yb3SmBSc2eJ31U6LEUwCFB/rMyMN6C/naEJFtliTT8Pa/Ip
         MZfxI5ODrLYxkXdqsMBlCdZKdBK6u95jIjLh6u7Z5Q9pwjDYNVfw+Xe+DPVaGfzbX7kv
         p5J3hnEIK9ylPUGU7yHWS1jWdt6H1CPtBtTGSc3l23HRCklDQSm5tQUXIxSEpJkfIGxK
         w22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Kc+LGXTJP5a4OW4ukBBIrmohxIG9LELyhLeP+KjgoWo=;
        b=KMfTi9b2tV0lQysbe77884NFGK1H0SytD5LqtWYhf8Cbs6a9falsZKSKzP2tlW3RbP
         F+KE+DlWYtiHM9/ESvlqIS/J0HsxBVVC/tRZF84KcrPuY6ucmAbcn1hjKZSw48py2E62
         X8cTvWJpc/s2dPi3Fh5UZpdXGFWB9wnMV7Hq1tgPSnh3D/+QYEiOYwInnZjKJwmT/jut
         fV+Th0Jh4jgrdw8N6NinLHs5xoqJXkD9ZLJyL84wFT5zJoZPvg8z6Lv5wm0iOjzBBsEV
         mMwBh/nw1nhr4o6vHXbuuV90WcHZOZWB31KVwUiab1kyThAl39MN0r0OT2XyQYMQr8N8
         wk+Q==
X-Gm-Message-State: ABuFfohfL3OUcHsOtwJ2ctyhdBWel+OqEwGdQ3zXfmrJKRTI/Aoq/q8e
        WioS+QGluxpbOKKrG+gZf6M=
X-Google-Smtp-Source: ACcGV62v5bwUTZjkcuET4xC/ScQgOcQ8rRtoJLHEL9vfrH9ZIibEe7XC8FahxCVTLR+5708/nZFNOQ==
X-Received: by 2002:a17:902:20c5:: with SMTP id v5-v6mr24111365plg.62.1539749301822;
        Tue, 16 Oct 2018 21:08:21 -0700 (PDT)
Received: from Pilot130.192.168.0.22 (211-20-114-70.HINET-IP.hinet.net. [211.20.114.70])
        by smtp.googlemail.com with ESMTPSA id i21-v6sm20998554pgj.55.2018.10.16.21.08.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Oct 2018 21:08:20 -0700 (PDT)
From:   "sudheer.v" <open.sudheer@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Russell King <linux@armlinux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Jiri Slaby <jslaby@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Michael Moese <mmoese@suse.de>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Cc:     "sudheer.v" <open.sudheer@gmail.com>,
        Sudheer V <sudheer.veliseti@aspeedtech.com>,
        ShivahShankar Shakarnarayan rao 
        <shivahshankar.shankarnarayanrao@aspeedtech.com>
Subject: [[PATCH] 4/9] Documentation-DTbindings-DMA-controller-of-AST2500
Date:   Wed, 17 Oct 2018 09:41:01 +0530
Message-Id: <1539749466-3912-5-git-send-email-open.sudheer@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539749466-3912-1-git-send-email-open.sudheer@gmail.com>
References: <1539749466-3912-1-git-send-email-open.sudheer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: sudheer.v <open.sudheer@gmail.com>
---
 .../devicetree/bindings/dma/ast-uart-sdma.txt      | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/ast-uart-sdma.txt

diff --git a/Documentation/devicetree/bindings/dma/ast-uart-sdma.txt b/Documentation/devicetree/bindings/dma/ast-uart-sdma.txt
new file mode 100644
index 0000000..e770df2
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/ast-uart-sdma.txt
@@ -0,0 +1,23 @@
+* Aspeed Direct Memory Access (DMA) Controller for AST25XX
+
+
+* DMA controller
+
+Required properties:
+- compatible : Should be "aspeed,ast-uart-sdma"
+- reg : Should contain SDMA registers location and length
+- interrupts : Should contain SDMA interrupt
+- dma-channels: number of DMA channels in DMA controller
+
+Optional properties:
+
+Example
+                        ast_uart_sdma: uart_sdma@1e79e000 {
+                                compatible = "aspeed,ast-uart-sdma";
+                                reg = <0x1e79e000 0x400>;
+                                interrupts = <50>;
+                                #dma-cells = <1>;
+                                dma-channels = <8>;
+                                status = "disabled";
+                        };
+
-- 
1.9.1

