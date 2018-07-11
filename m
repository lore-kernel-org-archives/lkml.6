Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF20C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 099852089B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dominion-thruhere-net.20150623.gappssmtp.com header.i=@dominion-thruhere-net.20150623.gappssmtp.com header.b="kS/JXsnP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 099852089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dominion.thruhere.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbeGKHfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 03:35:47 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46425 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbeGKHfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 03:35:47 -0400
Received: by mail-ed1-f68.google.com with SMTP id r17-v6so18429289edo.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 00:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dominion-thruhere-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TvQsmLXUmvKaAG2GhOopk2GfVRelLi17c9uBYgW4+40=;
        b=kS/JXsnPgDiIcYCSE1619WuSHKXXwPm79HFBJT0q8EeZMdjSDDU4U9+eCZCkEGn7BO
         1/kl+gAiuVbGSwxkFn93ZALa6184Zz40xTzZqAX0JQgwoP1Vr+IvKf015sX+NfnbbzCi
         RXHGejhjK2W+Izavjs6dInVRvPzIqJEMrFSCuiTVtCLiyhHa03rV/zBdOwaN0emW+4WD
         R5ZSI1td5V45Lgdyzyp/ITcq7CPn8iMLYt+jsjl/HxTKocnzB+/DpKVbQtDeFP6seXnQ
         SfypqHJ8d1mn9vBx8RTb5avCgXKuW/RgMS3YFGMuX8RaofR925rNGoiGb0NM4+2OBQSn
         wyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TvQsmLXUmvKaAG2GhOopk2GfVRelLi17c9uBYgW4+40=;
        b=FHNsvfvZceJ5Z6k4Bj6migKgrPQixl/gGGbdJPAPWxeUxKKGPBUccHHwYIWY6wrcas
         NQg/AsBYEUNQ0DJwY2IZMGhGRTo6uxHGbYeBy+lMm4UjamxnHVsZPN1LyNyTi6VdXjGQ
         8K1EMXJmyp10fkwt7BFga0hIZwEf7Ve2WgWcl+qP6LokZzdR60uIJ5MUvj6eRb/ytCwE
         DLfNxn2efdwJ4W91xgCqEUdHOKvackiZZVL1Fp3pGNT093Bsh6lLOKL668cgr/c2keZ1
         IrrjH/10EBqBWfT+4GCzmzCXh6iu5E0Wc0nS8DqOB/ox+UbrHkMXDn9uAIDx2ng2fB0c
         eZcg==
X-Gm-Message-State: AOUpUlFBL1xsrvPccgZPi+8TyAnRsRUIo5Hax691XEYR3xphh4ZZI9rO
        lCjc7X7eHj7xv2bS3KUBDc5r1w==
X-Google-Smtp-Source: AAOMgpdEsJaZri4P31NynC33bYHgQDo5hV0AjKa4vnpo28lIokqc/5NR2jj68Hqlpq2Xq8SiVGRyrA==
X-Received: by 2002:a50:88e6:: with SMTP id d93-v6mr5237023edd.74.1531294372126;
        Wed, 11 Jul 2018 00:32:52 -0700 (PDT)
Received: from localhost ([82.163.40.65])
        by smtp.gmail.com with ESMTPSA id r5-v6sm8772755edp.60.2018.07.11.00.32.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 11 Jul 2018 00:32:51 -0700 (PDT)
From:   Koen Kooi <koen@dominion.thruhere.net>
To:     linux-omap@vger.kernel.org
Cc:     Koen Kooi <koen@dominion.thruhere.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        David Lechner <david@lechnology.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        SZ Lin <sz.lin@moxa.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: Add vendor prefix for Sancloud
Date:   Wed, 11 Jul 2018 09:32:28 +0200
Message-Id: <1531294352-27385-2-git-send-email-koen@dominion.thruhere.net>
X-Mailer: git-send-email 2.0.1
In-Reply-To: <1531294352-27385-1-git-send-email-koen@dominion.thruhere.net>
References: <1531294352-27385-1-git-send-email-koen@dominion.thruhere.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for Sancloud Ltd.

Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
---

v2: No changes
v1: Initial submission

 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 7cad066..c7aaa1f 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -314,6 +314,7 @@ rohm	ROHM Semiconductor Co., Ltd
 roofull	Shenzhen Roofull Technology Co, Ltd
 samsung	Samsung Semiconductor
 samtec	Samtec/Softing company
+sancloud	Sancloud Ltd
 sandisk	Sandisk Corporation
 sbs	Smart Battery System
 schindler	Schindler
-- 
2.0.1

