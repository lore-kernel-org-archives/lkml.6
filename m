Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2656AC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E8B2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="GCe5lUSY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730428AbfA1Rcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:32:32 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25445 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbfA1Rca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 12:32:30 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1548696689; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=Ad8O/IKz6iUsuVFaGI9JxB+J2e+/sn2NZ7HxVYDaAojYNr/3NRAieVeq4jy4DFv18upWzANRIAQPUi67OhsNqZX3hjWp+fP0uDwdIU1r/mAE+QRiPSG63V9BeorDaGGSCoPSCWumLTdN3CYeWdn3rM/fgP9UPfa/1kUGPTCI4PY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1548696689; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=tlUMz/9XyBzyNUGs+f98DBJkkC8vBaUq0Vz9AV1qX7c=; 
        b=g8OT7gLFWB0ZOcszNFCk93RMtq2i8B0QlbtrBeOGVaChDLPpnSCkH7ffLtXSTyYKWjCPyApmGUDqkw8UY6PPod0cV3KfSqGIKACNzY8NQEXq7dUMoCbN4SUH+juHc6tJ/CZGZ8D3p6Aqc3U3w2hNHbCfY3kasHjkDKul9JDKhV0=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=E2FzBMcIFv28LFCXnwAIq07IcgV7B2ikVvGA8C+6zoGlYIcM01Zge9kR+IX/IaXipEwgqjRXU2lc
    FRXdMJykMFjOLhuCNrzePSj/j66di/VE3IPsAsjEtoHqhyFqze+b  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1548696689;
        s=default; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; l=890;
        bh=tlUMz/9XyBzyNUGs+f98DBJkkC8vBaUq0Vz9AV1qX7c=;
        b=GCe5lUSYdsYNBZy6uoZNIXHm3YhMyWP86aiakQnjb+T1Ns47MTlNdMce/PsdgF6s
        4N+NY8BcplIl+3Oq27WrUjsR5l+NMlHqNxTQVp5oOd96iQE5/FzCEGv3PIKRA5UerzL
        9mFeuVHfCWCZRatHvQz1Mr41DgvkLOtDQww9ptog=
Received: from localhost.localdomain (171.221.112.7 [171.221.112.7]) by mx.zohomail.com
        with SMTPS id 1548696688032977.7950250734209; Mon, 28 Jan 2019 09:31:28 -0800 (PST)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        paul.burton@mips.com, mark.rutland@arm.com, syq@debian.org,
        jiaxun.yang@flygoat.com, 772753199@qq.com
Subject: [PATCH 2/3] Dt-bindings: RTC: Add X1000 RTC bindings.
Date:   Tue, 29 Jan 2019 01:29:58 +0800
Message-Id: <1548696599-53639-3-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548696599-53639-1-git-send-email-zhouyanjie@zoho.com>
References: <1548696599-53639-1-git-send-email-zhouyanjie@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the RTC bindings for the X1000 Soc from Ingenic.

Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
---
 Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt b/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
index 41c7ae1..7ce0018 100644
--- a/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
@@ -5,6 +5,7 @@ Required properties:
 - compatible: One of:
   - "ingenic,jz4740-rtc" - for use with the JZ4740 SoC
   - "ingenic,jz4780-rtc" - for use with the JZ4780 SoC
+  - "ingenic,x1000-rtc" - for use with the X1000 SoC
 - reg: Address range of rtc register set
 - interrupts: IRQ number for the alarm interrupt
 - clocks: phandle to the "rtc" clock
-- 
2.7.4


