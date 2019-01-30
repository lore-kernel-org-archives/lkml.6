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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED790C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE342218A3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="OqE+F+z8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730899AbfA3NQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:16:40 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25470 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfA3NQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:16:40 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1548854127; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=ixwHy8Vz1wUz52kQcGvzanxJxt7Dc0cbqAZdN2fRReGj6/SJLqsIGHsyDqt2x4lFkaaH249niogwgF8gbWrwTwPk270AwtIRjuudqYJC2ECoDVt2y3j/CwA/ZGahr2hcOThmviU3D4p5u+tnXvNfg31bWJ97sTwCrKBNnWc7Z0w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1548854127; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=IWwCosK24C5ph0LjsBwJCVLTjMI7bSWxouf5emc+fbs=; 
        b=bXTPSTLxR166c2EbcLjqQD7CUFsHotQ2Bs+r6S3hujlpbBO3Gi278uZJugQmzYdr8GYc5kOVwKgk4YS9s9uJ+m+Sx9j3LNPABCJTXwx87SUPl5jWkIOoBASofrJCozRrfzj/qh3DRgav759s2Ie5zOWrpjxjz4UoUhxj1jVqQHM=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=uahffS5OIdRzNqx9aq+yAcdvH5ZfAnWGrtB+hc/so7lsuU7+EUiZp6bW39Mav+4r7xphUM930bQK
    +so6/tHe+2ZdU1NSrTZ5XmoDPxZ/qrwXM/DdsS5taYu2sad/Ku+w  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1548854127;
        s=default; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        l=1229; bh=IWwCosK24C5ph0LjsBwJCVLTjMI7bSWxouf5emc+fbs=;
        b=OqE+F+z8+tAlYedREppjMlz+B9GMA0Qaiw0vTS83/yvhGSIWR/oCv8PFgG0/2p50
        g+R14y1OZt59A8hW74Znga76+GBvjPHdqr9lUukZsvLm4L8cdb87rAzLBwo4/5fc/cb
        1ZSANaIqkJKV2YtQcIq1zLzPnjRlHuTXRFDBYmb4=
Received: from localhost.localdomain (171.221.112.7 [171.221.112.7]) by mx.zohomail.com
        with SMTPS id 1548854122327747.3997723790026; Wed, 30 Jan 2019 05:15:22 -0800 (PST)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        paul.burton@mips.com, ralf@linux-mips.org, jhogan@kernel.org,
        robh+dt@kernel.org, ezequiel@collabora.co.uk, paul@crapouillou.net,
        mark.rutland@arm.com, syq@debian.org, jiaxun.yang@flygoat.com,
        772753199@qq.com, ulf.hansson@linaro.org, malat@debian.org
Subject: [PATCH 2/2] DTS: CI20: Add CPU nodes and L2 cache nodes.
Date:   Wed, 30 Jan 2019 21:14:04 +0800
Message-Id: <1548854044-56483-3-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548854044-56483-1-git-send-email-zhouyanjie@zoho.com>
References: <1548854044-56483-1-git-send-email-zhouyanjie@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current kernels complain when booting on CI20:
[    0.329630] cacheinfo: Failed to find cpu0 device node
[    0.335023] cacheinfo: Unable to detect cache hierarchy for CPU 0
Add the CPU node and the L2 cache node, then let each CPU point to it.

Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
---
 arch/mips/boot/dts/ingenic/jz4780.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index b03cdec..7c0a853 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -7,6 +7,31 @@
 	#size-cells = <1>;
 	compatible = "ingenic,jz4780";
 
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "ingenic,xburst";
+			reg = <0>;
+			next-level-cache = <&l2c>;
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "ingenic,xburst";
+			reg = <1>;
+			next-level-cache = <&l2c>;
+			clocks = <&cgu JZ4780_CLK_CORE1>;
+		};
+
+		l2c: l2-cache {
+			compatible = "cache";
+			cache-level = <2>;
+		};
+	};
+
 	cpuintc: interrupt-controller {
 		#address-cells = <0>;
 		#interrupt-cells = <1>;
-- 
2.7.4


