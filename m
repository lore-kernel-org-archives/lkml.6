Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7C7C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59262080F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="Aw/KF2ke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbfBHPay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:30:54 -0500
Received: from mail-eopbgr80072.outbound.protection.outlook.com ([40.107.8.72]:31786
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727467AbfBHPax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:30:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AozndM2vMAb8RAzO7PDOnfNNDzmgwMabJDRMECUfDCI=;
 b=Aw/KF2keRPV1hn3V9+vE3xxSMppCqNOJhrJbDp+/wsj0CC/g46JwT2L6wOGl7Qfx9SrgqJHbIHxblAkmGFs+jUHiI0DzbmcYvV9GzOAmnk4fFzETyD6UGjjwPlM9OTHHb+oO+ZZETkoGT2K5gGW6Bk6Yl7wbPObW/yALm9HB1AY=
Received: from VI1PR0601CA0034.eurprd06.prod.outlook.com
 (2603:10a6:800:1e::44) by HE1PR0601MB2266.eurprd06.prod.outlook.com
 (2603:10a6:3:92::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.17; Fri, 8 Feb
 2019 15:30:47 +0000
Received: from AM5EUR02FT020.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e1e::201) by VI1PR0601CA0034.outlook.office365.com
 (2603:10a6:800:1e::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.17 via Frontend
 Transport; Fri, 8 Feb 2019 15:30:47 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.46)
 smtp.mailfrom=cern.ch; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.46 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.46; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.46) by
 AM5EUR02FT020.mail.protection.outlook.com (10.152.8.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Fri, 8 Feb 2019 15:30:46 +0000
Received: from cernfe03.cern.ch (188.184.36.39) by cernmxgwlb4.cern.ch
 (188.184.36.46) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 8 Feb
 2019 16:30:43 +0100
Received: from cwe-513-vol689.cern.ch (188.185.69.206) by smtp.cern.ch
 (188.184.36.52) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 8 Feb
 2019 16:30:43 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>
CC:     <dmaengine@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Federico Vaga <federico.vaga@cern.ch>
Subject: [PATCH] doc:dmaengine: clarify DMA desc. pointer after submission
Date:   Fri, 8 Feb 2019 16:30:38 +0100
Message-ID: <20190208153038.23272-1-federico.vaga@cern.ch>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [188.185.69.206]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.46;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10001)(10009020)(459900002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0601MB2266;H:cernmxgwlb4.cern.ch;FPR:;SPF:None;LANG:en;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d8ac307-d08b-41b4-d193-08d68dda65ce
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(5565046)(2017052603328)(7153060)(7193020);SRVR:HE1PR0601MB2266;
X-MS-TrafficTypeDiagnostic: HE1PR0601MB2266:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0601MB2266;20:dzf/HCCV36l99uORAorUl1HTGai2KRZCZwRxPQ8zraTjgH2ExGc0vyfJnky36UpsMPXdIRilD0POp7F7RkGw2JmHM63Yn4f3likA+9DUFLYNr4f1uZYv22BhJEwbyLyR5Q7edspeX9NhcGf3YmyEHw8Qk8iMBOQarvilf5hOGVmE+/1TpasizbG4znMzohslhNPe+i9UTA/9NBgSlqONdpPUCrSz2sxfcDdOHJWA4xHVaz7D4sX2+wqfpX4xrisfBivNZeTJkkWcMMSdhB7fgw6HQKecMsvt+1/rLpa8hZhkAvnW5P4n0dNzKLQuWPTm1HjtB/8F4pbHh+E91oJdMK11+wAx6Veh2t8ra/oMGLXmGnbXAeyYnj9JZqoBZfdyUNpglnbH2EiiKaI6DwJRn89PchYV5Mas9v4SbNX0TTAOoA0rwLIH0rjA8aSQbbmEYY8Cpw4zxzILr3xLrW2y26dm9q5fGONzz8mi9MjGZtWWfXnhgzXpUAip86oY4RwU;4:VUCYpEV1hSHGWNsF/IMKKWiZMXRUcFclanp0ysCnqwrqnmN/p7TpdEOzTgKoXOmlI5pFmxZNqKYxh5SAxBSCS7oBbjcs4zKPPnQTMyiTHjYOjrizoZmJr/kFgkuyVOyJWhfUyita4lCGjxdey7qaKbMHfavvdnqafPfybZRKbLoAEJ4chqiNHmFZnFmkBrqv1iDQtNiVk6byReA9qoxID5V/W3/n/gDlIP5ZiiwuPCf10dHca4r/7w59RfLe1MjX4k600MnxsxwY7Omni7K3HS5gE3krX40fQyT43E592Y1fdlEHljs4uL3rh5hkqSZB
X-Microsoft-Antispam-PRVS: <HE1PR0601MB2266C071483CFD1091A55B95EF690@HE1PR0601MB2266.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 094213BFEA
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0601MB2266;23:1/CoAFwwtVM4CBledVzTeKoA8m3Ct1/4VA2PHpRGQKn0icdjAyHmkxxpmv3F0VF4UzyVNiZNC6X74s0YDj/B9m5ADZbSb66gUWbBWwpSHlILiN3FIUVaJ6zt5BtKiuS8jQv+/Ek5DHeesXuOwoc6Yp8J8zO95GEL1+yNIk6rFSvhK8LyDBULjg3AcIzyODOt;6:gscHICfK22xdL0yPRpFR6tLA160f6Pdfj3DGDiOBR4+SK/ACMoTyPpjhVm621UH7L882GQPn0IRNzl7sfgCJy4RWESQYC7kmby5sQQtzgjX6/dLnw9pKBLZkBh/u4v8zez/BfENnD0RpppLvEwRkfv9HdZbu97yYC36Lc8JTXc03FLSvE0TGOeMck04p0k4AUyMuef6kuybaECN4nSCc5VM1MX6GUCTMxpW055M3qyMC6hpmYVUtDpLjirHExkkzuvx01EN5lC8HihWl6JTsYkOcOf5MLm381b9k7ZGIQJz6EY/pjWFQ0HZYXc5kDgQCsCedIhQJFCyqxr7zduTiVS/69EoNHf+Ep5HwPtrn46TCSg7xbxz9RnyxAkGWeNXHNK7IFgLH3VOYtT5x1xgqrHfmI7FyqD5h6tjmtrbePALD0MG/wdD2pAx24CLXHpANOINgjGwp5Cz43zOrlitgpQ==;5:sIjpuzWRkjITlnHxrai00ADTdeCLYvjEDya9Vsw9AQ/Aw7t8humXRZbD/uA943MSyCGsVHESbZEfdnksw4VMZEyJvPDlhUR47nscbmcPiMD4C2FOcmox6q9BwYctuDGM//ALouxuPRGovSiXrZ9D/voc88gp9OStt/IRGLRkeedQYt/8QE6o1Fq6zXUVJ+cIiPHDr3I94ETt8fvKtFguVg==
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: /LW/cFJy+8mecrjZbScxMKjlydYOxavverRfbGgWY5WWqmpCveqFZLQ0hHjeTh+WpMmVAYDrBJvZs/B9it6BpIhjNgZbXs7BE6UmVwzt3XuUCaO+0H8/MGI0pmIC7dzIW7k9Aj8sb+mfK5Eg4vSuOnbVlXXzNLJpWPbxD6lyo1itQAerc6AqMRsaLy80T7u/CZRYbfl+wOk441Pp8kceiLSeHws8RwecE9AK9j0cLNgIYPV7pf5bKWlOYfIxsHIyyIUOes56PAFN0SSVbUz37TqWTq2SWoYcxl6clUhBJUkPhI1bBWdehwak+UN874+dUmKqVLxi2ylO/P9QgMw86PSB5tT1F4YE1wXwOrc4R1beza9zG0k55eAaWlg0aXPLwZVi6v7p4gZUC6GjdHzM8oGyUlqdYT9UKKNtO/JO6w4eXMFB+Amq7OwNmC9NbB6MMabQMtUkxpEr4gE07jaf5HRBOiRnFLJHOqAHPKo4OcqbWX8s6zYupCXN2aJBB6k+0Y9jJvR9c8MgXLMhlVRETc4Ua3iDR1ASqoQzLu10Kno=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0601MB2266;7:s9509V4wYMclX96ATCASpFYIQy0ABa46g9Aygp0wqxx1j8CQ0p9m2eDpGgqxYAYUhyA9PkuPdZCu4R2dleIAnLJOSxdwSsZQGAFJESL55tl2OUVUhJvQcC9IPzmd6bUOyJj+mpDlMyP1iA/iINwo/g==
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2019 15:30:46.7561
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d8ac307-d08b-41b4-d193-08d68dda65ce
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.46];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0601MB2266
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It clarifies that the DMA description pointer returned by
`dmaengine_prep_*` function should not be used after submission.

Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
---
 Documentation/driver-api/dmaengine/client.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/driver-api/dmaengine/client.rst b/Documentation/driver-api/dmaengine/client.rst
index fbbb2831f29f..d728e50105eb 100644
--- a/Documentation/driver-api/dmaengine/client.rst
+++ b/Documentation/driver-api/dmaengine/client.rst
@@ -168,6 +168,13 @@ The details of these operations are:
    dmaengine_submit() will not start the DMA operation, it merely adds
    it to the pending queue. For this, see step 5, dma_async_issue_pending.
 
+   .. note::
+
+      After calling ``dmaengine_submit()`` the submitted transfer descriptor
+      (``struct dma_async_tx_descriptor``) belongs to the DMA engine.
+      Consequentially, the client must consider invalid the pointer to that
+      descriptor.
+
 5. Issue pending DMA requests and wait for callback notification
 
    The transactions in the pending queue can be activated by calling the
-- 
2.15.0

