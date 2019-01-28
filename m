Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56337C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E3A21741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="JyxWGiII"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387561AbfA1RGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:06:07 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25454 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730676AbfA1RGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 12:06:03 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1548695124; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=alEQ4zJfeCZ4UQqw9v1lK4JV0M3TTw2Oinbo8pa6lSerJxzJ8AFRUU6dPM5nk2Xja8dNZJ1qcaV9Zn9wyYxMO1XAqURkCQFMwLawnPrdDEnQ6Ntd+kak1fD+2OPfR+ex/jpZJBMb0KIagHsHozNihRidCk92gz0gV2s2mQ01yxk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1548695124; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=oZgIgn9QDXAw5zWal5B3+Omj25n3YyuTlmq33EDirhU=; 
        b=I6n81v1TpvSRt0EUPusMlvd/QrhaGahaJyEYN9nau+E0aWFmh5DHocejpArw85/SpFCj+a8fqdFBJCA+6NArpzoHU+RMt+5tfBpnCkfeLiM3q9J76VdeOOQSclttaay3ZIXplDFq73R338yHZA4OlLz5qJYlPdWXY8Vu8NY2oxM=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=m25kjzoxgfOpxboCYf0lxp300Htui+2QOSqzYtBh0mD/JRhh/7HDPAYDicT5WvX4FsoRIS49Sdr8
    2tJLSWAidiLDawUM+1lar++RyFLAb4SzsCMcZ9mbPeXnTtNnBCbZ  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1548695124;
        s=default; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; l=902;
        bh=oZgIgn9QDXAw5zWal5B3+Omj25n3YyuTlmq33EDirhU=;
        b=JyxWGiIIslx3y9Dw307AwaZDr+IjvcfkXgM63z7Kbsx66nSnbEIfryco2hLfZ7t0
        wsRYUuugJ4QPNhuKNY6w7LwlU009TOAvjaO4yAeh4+wsbBO7qPFFi11V2muaOxOHiwv
        w/Qp2G6jCuVjnK4CTfFFTU1XF72YTe8omDvUSwms=
Received: from localhost.localdomain (171.221.112.7 [171.221.112.7]) by mx.zohomail.com
        with SMTPS id 1548695122662237.8915911120481; Mon, 28 Jan 2019 09:05:22 -0800 (PST)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        paul.burton@mips.com, gregkh@linuxfoundation.org, jslaby@suse.com,
        mark.rutland@arm.com, syq@debian.org, jiaxun.yang@flygoat.com,
        772753199@qq.com
Subject: [PATCH v3 2/2] Dt-bindings: Serial: Add X1000 serial bindings.
Date:   Tue, 29 Jan 2019 01:03:49 +0800
Message-Id: <1548695029-11900-3-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548695029-11900-1-git-send-email-zhouyanjie@zoho.com>
References: <1548667176-119830-1-git-send-email-zhouyanjie@zoho.com>
 <1548695029-11900-1-git-send-email-zhouyanjie@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the serial bindings for the X1000 Soc from Ingenic.

Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
---
 Documentation/devicetree/bindings/serial/ingenic,uart.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/ingenic,uart.txt b/Documentation/devicetree/bindings/serial/ingenic,uart.txt
index c3c6406..24ed876 100644
--- a/Documentation/devicetree/bindings/serial/ingenic,uart.txt
+++ b/Documentation/devicetree/bindings/serial/ingenic,uart.txt
@@ -6,7 +6,8 @@ Required properties:
   - "ingenic,jz4760-uart",
   - "ingenic,jz4770-uart",
   - "ingenic,jz4775-uart",
-  - "ingenic,jz4780-uart".
+  - "ingenic,jz4780-uart",
+  - "ingenic,x1000-uart".
 - reg : offset and length of the register set for the device.
 - interrupts : should contain uart interrupt.
 - clocks : phandles to the module & baud clocks.
-- 
2.7.4


