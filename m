Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD856C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 20:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C4724F88
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 20:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUGBLgf0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66C4724F88
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934985AbeF0Udx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 16:33:53 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34214 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754776AbeF0Udv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 16:33:51 -0400
Received: by mail-qk0-f196.google.com with SMTP id b66-v6so1795790qkj.1;
        Wed, 27 Jun 2018 13:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EXdbWNARllK+7Bxiv1fIM3gnYt6advk1WEgKn866F2A=;
        b=MUGBLgf0zfqTqOiInUAgYQbTpEhvKX+WxlLwNONgYOakSUuTKVZZZkUSiD3fIQNmiI
         NpF6y5EhuZISbtmY0UAp65Df/X6RvzAckgFcxr+nwWkPLUtzsNSgQ7GcZgLvJFco5LNG
         N+pUQ5r/VCb23F3DCqXtburOVWdh/1agXTRIgZ7Vm4oO2tV2G2rX2rv43fx9OD8dVk7h
         1GuB+GGXA64SfwDiSAnfhjQuShQHbKMAKT/DnrqO7czNxZZyyagnlV+rwClABrmEgQBb
         ZRuIgeh8W8asoNkwG9UhYk+0XgQP2OLUk6pJ7aU2bpFhkQIR/FT/YdTQALp52sE8R/np
         SAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EXdbWNARllK+7Bxiv1fIM3gnYt6advk1WEgKn866F2A=;
        b=fCFFBuFCUAPaHDaOvg4Wl1/rOebQxSWKqOVCNHHogQWX+lS931egF3k7MlMXtGYDdx
         xRFOLK/HL78Pb+OwTh9nhPXEJ6IP6GDlWZ1WxypPqUh/h38ijgRKNnR08sYTCyJR9aca
         BsNElHGrzpARQJ/VaGKtw7kk8OUHcCXiURK9hc6l83l+46fwyhJ5qlQP18CKtyhC4IfA
         F9DYOw7GghwDQHA7JjFqugKHxnAbC+eYfjyu8LxLE2biiIzlWuMlW8VdrPTPiyPgVCGy
         IMm6CWQn4Eu2RaSCEKEBJoLUpHAhI2riNyWmRezuQMtJ/E/4khxm5SZ7jNKephedXaLu
         tmhw==
X-Gm-Message-State: APt69E2Qs0uGj+JgHjvm4bnO/xUsux5DBqZLf/ki8VrxqkHWnzE2TgIA
        PoDIW19Dp2dwwITUtbFcafU=
X-Google-Smtp-Source: AAOMgpdxVHd3IeAhMG7RHDabuuePoastEEb+6qYT+oowjLYYyGRAmII8zl97gY9MtOYwqOOpvdu+EA==
X-Received: by 2002:a37:8c02:: with SMTP id o2-v6mr6325285qkd.322.1530131630894;
        Wed, 27 Jun 2018 13:33:50 -0700 (PDT)
Received: from localhost.localdomain (186-106-194-183.baf.movistar.cl. [186.106.194.183])
        by smtp.gmail.com with ESMTPSA id q49-v6sm4276655qtc.33.2018.06.27.13.33.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 13:33:50 -0700 (PDT)
From:   Luis Araneda <luaraneda@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jani Nikula <jani.nikula@intel.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "David S . Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Araneda <luaraneda@gmail.com>
Subject: [PATCH] dt-bindings: Add vendor prefix for AsusTek Computer Inc.
Date:   Wed, 27 Jun 2018 16:33:15 -0400
Message-Id: <20180627203315.348-1-luaraneda@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"AsusTek Computer Inc. is a Taiwanese multinational computer
and phone hardware and electronics company headquartered
in Beitou District, Taipei, Taiwan." - Wikipedia.org

Website: https://www.asus.com

The prefix is already in use by at least 5 ARM boards

Signed-off-by: Luis Araneda <luaraneda@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 7cad06619..09101914a 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -41,6 +41,7 @@ arrow	Arrow Electronics
 artesyn	Artesyn Embedded Technologies Inc.
 asahi-kasei	Asahi Kasei Corp.
 aspeed	ASPEED Technology Inc.
+asus	AsusTek Computer Inc.
 atlas	Atlas Scientific LLC
 atmel	Atmel Corporation
 auo	AU Optronics Corporation
-- 
2.18.0

