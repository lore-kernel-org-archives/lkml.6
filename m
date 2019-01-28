Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC200C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A8DB21738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="cw1tZHfU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfA1N7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 08:59:30 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25453 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfA1N73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 08:59:29 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1548683926; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=Ktw4ay7iaBdY9WukDzyAgFoMfRZL0VQLNFOD01vaKGQboHuliqDimq/f5y7Qngf4qcWHTehiRTA9dJ6yzz7qrGhAektBI1AdcEsBZV6X2BOoLpIpN7NSMyUe22jfMXgK8/gUCjuQb8gyLoEDTPpv5XJ06PqbA9qkX9tuoTmeiY8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1548683926; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=6c85eo1+rpTKeHmS6CYmp7FTc9wE6zW/vlreIvgtLgk=; 
        b=kun0oO1RR9RO+Q3sIc8H6Xy9BKzYcA4qDBt2rfuEvPmusXoNT+ZuUAiPR2f0MjuGw23MXGN09ucosysXoCxlzskOCUQas7CQ6AnbYvEYlSAgl186KmJn8PXB5CT5rKSyoabDAI32YGEhWiow6zSy/3+SEgNRu6tzeLYxunsItCo=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=HKa8O0Z9q6bBvYcp4vMEDLNlcjY3TjYnywOKScGh1Qj/8sLe9Xk1UPp2tzN6mlpbMdJcaDcznWIj
    gRcenyEPoGwn3lFcOixV3fbtoftO5bHIMuFAjS2A3Ysam/dlRsWy  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1548683925;
        s=default; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; l=926;
        bh=6c85eo1+rpTKeHmS6CYmp7FTc9wE6zW/vlreIvgtLgk=;
        b=cw1tZHfU0dZqE/WuOZVD8aMj90LQzdw75VuRTS+XD9jdk/eqgz73NW3aG8lICW4Y
        qQ1FPjdP3d793Y8H5iqBSFeV6U0jqAf8uWfwocwGDdkejoBZ8Z6iB6+8SX09HqbCZvF
        1b8+pIsSFlEHoDyqz3MoutVqSdB0T2C6NkEVoR88=
Received: from localhost.localdomain (171.221.112.7 [171.221.112.7]) by mx.zohomail.com
        with SMTPS id 1548683923289218.71861885306748; Mon, 28 Jan 2019 05:58:43 -0800 (PST)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        paul.burton@mips.com, gregkh@linuxfoundation.org, jslaby@suse.com,
        mark.rutland@arm.com, syq@debian.org, jiaxun.yang@flygoat.com,
        772753199@qq.com
Subject: [PATCH v2 2/2] Serial: Ingenic: Add X1000 suppor for the UART driver.
Date:   Mon, 28 Jan 2019 21:57:01 +0800
Message-Id: <1548683821-120924-3-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548683821-120924-1-git-send-email-zhouyanjie@zoho.com>
References: <1548667176-119830-1-git-send-email-zhouyanjie@zoho.com>
 <1548683821-120924-1-git-send-email-zhouyanjie@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for probing the 8250_ingenic driver on the
X1000 Soc from Ingenic.

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


