Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D67C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B809D20672
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="gCovotu/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B809D20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbeLITwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 14:52:11 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:40638 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbeLITwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 14:52:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=References:In-Reply-To:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jHur/0DcADJElvJOFWNdoWcttvGPl9RlDEFdjxZvDzw=; b=gCovotu/5QGPvuygPh8Yf0+qK
        nM6aE8+ESiDDMLOfoqkoH+v9sbi9W6j1zGOfa3hxO9Y7c+YTPS17lQTUX4DGMo2B5XALLF0cjdoLl
        Ek6dn4Ouva+lP2hv0YTPQ0mU8I8r2vuNpiuuUNwVCHg8o9DGsTOFzyIu2OLVFDFZu0Yws=;
Received: from p200300ccfbead7001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:fbea:d700:1a3d:a2ff:febf:d33a] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gW57V-0008Jw-Be; Sun, 09 Dec 2018 20:52:05 +0100
Received: from andi by aktux with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gW57V-0001NR-3l; Sun, 09 Dec 2018 20:52:05 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     johan@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2 3/5] dt-bindings: gnss: add w2sg0004 compatible string
Date:   Sun,  9 Dec 2018 20:51:48 +0100
Message-Id: <20181209195150.5192-4-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181209195150.5192-1-andreas@kemnade.info>
References: <20181209195150.5192-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add w2sg0004 compatible string since devices without wakeup
pins are now supported.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Changes in v2:
 - reordering of entries
With the original order there was a
Reviewed-by: Rob Herring <robh@kernel.org>

 Documentation/devicetree/bindings/gnss/sirfstar.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gnss/sirfstar.txt b/Documentation/devicetree/bindings/gnss/sirfstar.txt
index 648d183cdb77..f4252b6b660b 100644
--- a/Documentation/devicetree/bindings/gnss/sirfstar.txt
+++ b/Documentation/devicetree/bindings/gnss/sirfstar.txt
@@ -12,6 +12,7 @@ Required properties:
 
 			"fastrax,uc430"
 			"linx,r4"
+			"wi2wi,w2sg0004"
 			"wi2wi,w2sg0008i"
 			"wi2wi,w2sg0084i"
 
-- 
2.11.0

