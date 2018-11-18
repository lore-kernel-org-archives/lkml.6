Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E90C04EBC
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 21:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C95542086A
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 21:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="dZjpG6rY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C95542086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbeKSITw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 03:19:52 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:52524 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbeKSITv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 03:19:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=References:In-Reply-To:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=z+Ds3s897+fweyQEgihLBGDMWvHpep1NWdknRSnMxDo=; b=dZjpG6rYnFSwpZkSLMbJeR/by
        hzCu5ZvxIgT97WH/f7ksNXK2dm9UCSBmT0sX0rrjdRsmBDDM/qhx7vFuOPqDAzT5pLYW1ZQSNwgRO
        EFpz4V2TaIQwE3V2Htkx6Ixn3zpYGuCuAWfdUh5SkxXGGelIybNKo6BD5VwA5Z4Hejp3g=;
Received: from p200300ccfbe8ca001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:fbe8:ca00:1a3d:a2ff:febf:d33a] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gOV56-00078B-Dx; Sun, 18 Nov 2018 22:58:16 +0100
Received: from andi by aktux with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gOV56-0003DE-4k; Sun, 18 Nov 2018 22:58:16 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     johan@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 3/5] dt-bindings: gnss: add w2sg0004 compatible string
Date:   Sun, 18 Nov 2018 22:57:59 +0100
Message-Id: <20181118215801.12280-4-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181118215801.12280-1-andreas@kemnade.info>
References: <20181118215801.12280-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add w2sg0004 compatible string since devices without wakeup
pins are now supported.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 Documentation/devicetree/bindings/gnss/sirfstar.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gnss/sirfstar.txt b/Documentation/devicetree/bindings/gnss/sirfstar.txt
index 648d183cdb77..1be7597ae884 100644
--- a/Documentation/devicetree/bindings/gnss/sirfstar.txt
+++ b/Documentation/devicetree/bindings/gnss/sirfstar.txt
@@ -14,6 +14,7 @@ Required properties:
 			"linx,r4"
 			"wi2wi,w2sg0008i"
 			"wi2wi,w2sg0084i"
+			"wi2wi,w2sg0004"
 
 - vcc-supply	: Main voltage regulator (pin name: 3V3_IN, VCC, VDD)
 
-- 
2.11.0

