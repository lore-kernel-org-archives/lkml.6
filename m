Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E876C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C22D52083A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="bATWan4i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C22D52083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732624AbeISWIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 18:08:23 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56524 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731668AbeISWIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 18:08:22 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8JGSN6s026729
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 09:29:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=3FSfz0SMePFFobY+QPJQevQqPinMJaseubL3+zFTHB8=;
 b=bATWan4i80WQ2su5NO3lDxa7BsYYy2S4P6e2ehdsB5HI+bO3K3R6uMMr+2sxlYKn96kl
 wCu9G95iC4m/QaWKaUBpu//lsnF97iks4bVoOGX0efDU/F7j1aUfwzQDvW9qXS6RVBYX
 TJQW7X5Bos1enjsOjiqx8bbrOut8W8KoIRM= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mkt0880b5-11
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 09:29:42 -0700
Received: from mx-out.facebook.com (192.168.52.123) by mail.thefacebook.com
 (192.168.16.23) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 19 Sep
 2018 09:29:41 -0700
Received: by devvm4117.prn2.facebook.com (Postfix, from userid 167582)  id
 5F7411755F7F; Wed, 19 Sep 2018 09:29:38 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Vijay Khemka <vijaykhemka@fb.com>
Smtp-Origin-Hostname: devvm4117.prn2.facebook.com
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Thierry Reding <treding@nvidia.com>,
        David Lechner <david@lechnology.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <vijaykhemka@fb.com>,
        "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH 1/2] ARM: dt-bindings: aspeed: Facebook TiogaPass BMC
Date:   Wed, 19 Sep 2018 09:29:16 -0700
Message-ID: <20180919162918.3994257-1-vijaykhemka@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-19_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial introduction of Facebook TiogaPass family equipped with
Aspeed 2500 BMC SoC. TiogaPass is a x86 server development kit
with a ASPEED ast2500 BMC manufactured by Facebook.

This adds an entry of Facebook in Documentation for vendor prefix
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 2c3fc512e746..0520303ee5b8 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -127,6 +127,7 @@ everspin	Everspin Technologies, Inc.
 exar	Exar Corporation
 excito	Excito
 ezchip	EZchip Semiconductor
+facebook	Facebook
 fairphone	Fairphone B.V.
 faraday	Faraday Technology Corporation
 fastrax	Fastrax Oy
-- 
2.17.1

