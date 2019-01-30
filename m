Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1620DC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D98E82184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="b3T6Vhou"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731015AbfA3NQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:16:13 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25458 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfA3NQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:16:13 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1548854125; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=QJQMZk4Wz+NTCNpCZwrd0WFBHT74qPiNS2xbjf0VF/mYcoLsJgsPg4ktKiY/4hNPRitJ7M+CTBB2WXzQPaRQorOHla2ZVDBHWr4YnrJS3tnGTxOTOQh1KwS+N7BPdaiUqAdzznBv/aVYlyQMSBoQ3Kb4yQKuWQwSFT63VHdx/0M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1548854125; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=pLCrqxlzDG7EbqBrfzQMxkdKY42dewHOXwqfmcwB+Cc=; 
        b=QsNDaVswPUGxBahO+hQ3GjQRYpy8od5TsrJWfBQzCxLGdRJYaa8+U4qX3UwIp7tQc+S6K05Rr73g8XIEFub8jyf5KsQpOrWVxX/BmTOUyoBPnsamuI0EyuPTl3zF9jKOOL5qqSGk6WdgTrEvLmGh4L5gz95Adds1XJeauD3KGGU=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=gYaGFqQqjIo9S3J3MQzg3fStJVXXpyqYgitTMRGyckY00X91ojbtf7FRs0FjN/+5lvl54SdvFONM
    +x++r/J7+duaVaF5qwjOB6HWsX2fflzRyEEk+Fweceu6DKW9A+j7  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1548854125;
        s=default; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; l=982;
        bh=pLCrqxlzDG7EbqBrfzQMxkdKY42dewHOXwqfmcwB+Cc=;
        b=b3T6Vhoun0bmfv0LCxPb0E7qWxQCkRdeibunDzacoa53V4YogCsDzIHEgkEPYkAd
        5rVBRqlGhytLLoNYLdxGBrngdVmdEQA/jUg9dk+otX6IaGSgOEae9ekDzJlQy8Hfb6o
        /0+AQm8cUbUK4P8bSx/d98xxBcKcQ6IjdvSRfnzY=
Received: from localhost.localdomain (171.221.112.7 [171.221.112.7]) by mx.zohomail.com
        with SMTPS id 1548854116789837.2517901828285; Wed, 30 Jan 2019 05:15:16 -0800 (PST)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        paul.burton@mips.com, ralf@linux-mips.org, jhogan@kernel.org,
        robh+dt@kernel.org, ezequiel@collabora.co.uk, paul@crapouillou.net,
        mark.rutland@arm.com, syq@debian.org, jiaxun.yang@flygoat.com,
        772753199@qq.com, ulf.hansson@linaro.org, malat@debian.org
Subject: [PATCH 1/2] dt-bindings: MIPS: Add doc about Ingenic CPU node.
Date:   Wed, 30 Jan 2019 21:14:03 +0800
Message-Id: <1548854044-56483-2-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548854044-56483-1-git-send-email-zhouyanjie@zoho.com>
References: <1548854044-56483-1-git-send-email-zhouyanjie@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dt-bindings doc about CPU node of Ingenic XBurst based SOCs.

Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
---
 .../devicetree/bindings/mips/ingenic/ingenic,cpu.txt    | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/ingenic/ingenic,cpu.txt

diff --git a/Documentation/devicetree/bindings/mips/ingenic/ingenic,cpu.txt b/Documentation/devicetree/bindings/mips/ingenic/ingenic,cpu.txt
new file mode 100644
index 0000000..38e3cd3
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/ingenic/ingenic,cpu.txt
@@ -0,0 +1,17 @@
+Ingenic Soc CPU
+
+Required properties:
+- device_type: Must be "cpu".
+- compatible: One of:
+  - "ingenic,xburst".
+- reg: The number of the CPU.
+- next-level-cache: If there is a next level cache, point to it.
+
+Example:
+cpu0: cpu@0 {
+	device_type = "cpu";
+	compatible = "ingenic,xburst";
+	reg = <0>;
+	next-level-cache = <&l2c>;
+};
+
-- 
2.7.4


