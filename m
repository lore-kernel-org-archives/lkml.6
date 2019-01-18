Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC896C5ACD5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 20:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91D0820657
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 20:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="AmJIAYTM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbfARUQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 15:16:25 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52524 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729399AbfARUQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 15:16:24 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0IKGCOg028182
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 12:16:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=vwT35l5+pMLsRLaZ18FkUjx4EzTzPudM14b8nkHYqvU=;
 b=AmJIAYTMbCaMVTgEl9OyJVS4+P+vEpRTT60IsjAyWjoOfUyqdO8Zlk1209JZSSBGvdT1
 PsqkrxT1PFYT6R5s3H7t6d1HGdZacihNpWm3luTP8/7moFvg6wlxESnFphvQ/UILnkUp
 yrejmYj6Fr7hpB7mm5qC8kZx0q7BzsLihYs= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2q3k070kam-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 12:16:23 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Fri, 18 Jan 2019 12:15:51 -0800
Received: by devvm4117.prn2.facebook.com (Postfix, from userid 167582)
        id 5D8387CDA887; Fri, 18 Jan 2019 12:15:49 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Vijay Khemka <vijaykhemka@fb.com>
Smtp-Origin-Hostname: devvm4117.prn2.facebook.com
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC:     <vijaykhemka@fb.com>,
        "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v2] dt-bindings: aspeed-lpc: Make parameter optional
Date:   Fri, 18 Jan 2019 12:15:47 -0800
Message-ID: <20190118201547.640173-1-vijaykhemka@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-18_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory-region and flash phandle is not a required parameter, it is
optional to describe in device tree and needed only use basis.

Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
---
 Documentation/devicetree/bindings/mfd/aspeed-lpc.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
index 34dd89087cff..d28c4e117611 100644
--- a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
+++ b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
@@ -135,6 +135,9 @@ Required properties:
 - clocks:	contains a phandle to the syscon node describing the clocks.
 		There should then be one cell representing the clock to use
 
+Optional properties:
+These below properties are optional to define.
+
 - memory-region: A phandle to a reserved_memory region to be used for the LPC
 		to AHB mapping
 
-- 
2.17.1

