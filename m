Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAF4C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3959320837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ZXQwgAyw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3959320837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933161AbeFUId4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 04:33:56 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45957 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932883AbeFUIdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 04:33:13 -0400
Received: by mail-wr0-f195.google.com with SMTP id o12-v6so2189067wrm.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 01:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7lF4x2vtlGSkWKHXoiVhzRcXhIM4ky5Jr7w07v8Qsrw=;
        b=ZXQwgAyw23JhO9sUsjTKQEqB5svUWV/YitQEOLCDiz5peZTOLUaR34p6zqlWOMqevs
         DS2UMJZbg4ckdYr6Z9c+uy04qQi8jk2XdEXUEoNw8dGbjgJWf+l33D3tTCUb45/YeEMf
         aaboFqNh8JsNhXy1uG8XVT4nqktkaXx6ZzSllpfzBVUiH1IQikZX6g0maq5YNzMDmdyJ
         A+PQjvNAWqv0+XjTT96uoasQBrraQJbK3r9hIwBRIUhXWCsBxxvy2kifmqNTyH5/T9t2
         KdL9RgCIPl1OFbXN705Usr6Olus4cwbFkINcynnzYlaV5Qq+/sLxucTgjgqZo6TzoOWb
         re4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7lF4x2vtlGSkWKHXoiVhzRcXhIM4ky5Jr7w07v8Qsrw=;
        b=px7yzG2A2VR29/qLoDfSWQDlMRm2OMrQ8MkVnjCFyUxYXNa20PTDTzZjuTwOg+162Z
         AZ3JENl0xoJxuA+IMS2laLjkqEJ76Y7rw06kJRFJGRY1iQSM02iKwDXDrUaPq/cjQ5gH
         IbrsqlBSuhodWuCgZkrNzTOKJh/VeOD7QJ9zPeSeru/SLIlH14FY0WzqyT2QQUHvAxiS
         f/loeUBlEMQs7YHV0FvGBZMWDUQ0rECTP1bZGJY1I/Od4PHO2S26En5iO329n80sMZIO
         XSLupw7qq1qLmZb7GuqHMBLNe0ZPwh2i8E9l1likPaneH7eLu8/eynoV6d7Z8ykWNWRi
         HQfA==
X-Gm-Message-State: APt69E1WIOlDqe2ETDtUnP8JiEidLWFJ7D4KnpblV54IzXjSt9hHTERu
        D0is9u9KeZnyd++0yrlBdE/gxQ==
X-Google-Smtp-Source: ADUXVKLSYBSF9za1eErPxWkkl5u0hcdjpz3sHl2zvCeND704vOiZj3+cTgy96JB4YpIF8b5/kTznAA==
X-Received: by 2002:adf:890a:: with SMTP id s10-v6mr4675384wrs.122.1529569992392;
        Thu, 21 Jun 2018 01:33:12 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-1-7080-22.w90-116.abo.wanadoo.fr. [90.116.249.22])
        by smtp.gmail.com with ESMTPSA id r123-v6sm6062754wmb.21.2018.06.21.01.33.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 01:33:11 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [RESEND PATCH 3/3] powerpc: dts: use a correct at24 compatible fallback in ac14xx
Date:   Thu, 21 Jun 2018 10:33:05 +0200
Message-Id: <20180621083305.5322-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180621083305.5322-1-brgl@bgdev.pl>
References: <20180621083305.5322-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using 'at24' as fallback is now deprecated - use the full
'atmel,<model>' string.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 arch/powerpc/boot/dts/ac14xx.dts | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/boot/dts/ac14xx.dts b/arch/powerpc/boot/dts/ac14xx.dts
index 83bcfd865167..0be5c4f3265d 100644
--- a/arch/powerpc/boot/dts/ac14xx.dts
+++ b/arch/powerpc/boot/dts/ac14xx.dts
@@ -176,12 +176,12 @@
 			clock-frequency = <400000>;
 
 			at24@30 {
-				compatible = "at24,24c01";
+				compatible = "atmel,24c01";
 				reg = <0x30>;
 			};
 
 			at24@31 {
-				compatible = "at24,24c01";
+				compatible = "atmel,24c01";
 				reg = <0x31>;
 			};
 
@@ -191,42 +191,42 @@
 			};
 
 			at24@50 {
-				compatible = "at24,24c01";
+				compatible = "atmel,24c01";
 				reg = <0x50>;
 			};
 
 			at24@51 {
-				compatible = "at24,24c01";
+				compatible = "atmel,24c01";
 				reg = <0x51>;
 			};
 
 			at24@52 {
-				compatible = "at24,24c01";
+				compatible = "atmel,24c01";
 				reg = <0x52>;
 			};
 
 			at24@53 {
-				compatible = "at24,24c01";
+				compatible = "atmel,24c01";
 				reg = <0x53>;
 			};
 
 			at24@54 {
-				compatible = "at24,24c01";
+				compatible = "atmel,24c01";
 				reg = <0x54>;
 			};
 
 			at24@55 {
-				compatible = "at24,24c01";
+				compatible = "atmel,24c01";
 				reg = <0x55>;
 			};
 
 			at24@56 {
-				compatible = "at24,24c01";
+				compatible = "atmel,24c01";
 				reg = <0x56>;
 			};
 
 			at24@57 {
-				compatible = "at24,24c01";
+				compatible = "atmel,24c01";
 				reg = <0x57>;
 			};
 
-- 
2.17.1

