Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5D5C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6819120672
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="U1EUqIbq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6819120672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbeLITwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 14:52:14 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:40654 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbeLITwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 14:52:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=References:In-Reply-To:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=N6GWq2hr3m1Vv8mL0bUfbcsq1gt9cz6i8H7ysbzXvao=; b=U1EUqIbqOYQB7I62qVGILDXVH
        vsoJ6/UfriDSZE98jKGPpBqDmytqq8fs6r4SHLoeqkmCnC+vp+4VYghx3xWQxWr+dkrLloYjQZBTN
        HAT7l7ZpveJMe0+0u0z2L7N0nOYRQQANkgwJMR+2ws1ICewq8n/I0wE1UFQ1NT92WFl2Y=;
Received: from p200300ccfbead7001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:fbea:d700:1a3d:a2ff:febf:d33a] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gW57W-0008KE-NZ; Sun, 09 Dec 2018 20:52:06 +0100
Received: from andi by aktux with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gW57W-0001NX-Fi; Sun, 09 Dec 2018 20:52:06 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     johan@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2 5/5] dt-bindings: gnss: add lna-supply property
Date:   Sun,  9 Dec 2018 20:51:50 +0100
Message-Id: <20181209195150.5192-6-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181209195150.5192-1-andreas@kemnade.info>
References: <20181209195150.5192-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add lna-supply property.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Changes in v2:
 - reordering
Original order had a
Reviewed-by: Rob Herring <robh@kernel.org>

 Documentation/devicetree/bindings/gnss/sirfstar.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gnss/sirfstar.txt b/Documentation/devicetree/bindings/gnss/sirfstar.txt
index f4252b6b660b..8d24f37ea1ba 100644
--- a/Documentation/devicetree/bindings/gnss/sirfstar.txt
+++ b/Documentation/devicetree/bindings/gnss/sirfstar.txt
@@ -26,6 +26,7 @@ Required properties (SPI):
 
 Optional properties:
 
+- lna-supply		: Separate supply for a LNA
 - sirf,onoff-gpios	: GPIO used to power on and off device (pin name: ON_OFF)
 - sirf,wakeup-gpios	: GPIO used to determine device power state
 			  (pin name: RFPWRUP, WAKEUP)
-- 
2.11.0

