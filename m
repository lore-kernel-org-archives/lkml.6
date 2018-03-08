Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520491887-2-200856680230383349
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520491886; b=pMhrnc3x2zJFWEAMVQTCIjiH8iw8cI5D8sZY2fGwKh+lEEM
    eftFlMys6OUBXfm7LjI0XgpMIC2QefQUUPj70hCqmBUL/yVEm5jedJnGPSx3aAXS
    n8WRyAYnkmrHBX9n81CmCEtIcgLDA89L2YQQnqZlGN8HG2hII0bcGAdG7sj7UUI+
    gB5Ch9mRR0NTHBSxmtOsRsW4RSQlOUpf4dlRo+plRGh1kl/Mfm1LEcd5mEd+xFOp
    Lmzl54Nuoll+OyF2GKxkaYxadXii6OW48dxCJitokqrR0LqsklibgbSi8OuluX53
    uOXHF2oAi4k3yOJ3B79deKymK7yAS62a36HjNQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491886; bh=Y6ELh0
    P86ejt6XiF64v8XVe4WfWANQd6wm30mPNcRtk=; b=m2w9awc4y1qffxsLJ5hKa6
    XIqAZ7XOpOD1U5YuPegywLLaXLBWMaTpudIXdluw28qdOnLuSgwMTF60liRgGCHQ
    uIFp7tJOZH/PB49TMoHpyq+h3UPRseDxtsD70YvxtXO0/osemJ991sznEsEQ1Obg
    adf/S/L8vlfcj28ugWewO+fwiBEsMIi+nFPUJkHrorL/2FPfv2TI2ctMTI7zf5/z
    lHIPG4f1l1wGP0+nXHMzQ972MnsPgQ0oB6T+yhB4AwV3ijfZG4LXqc/6BBWTRarS
    PDqiTVef6eGUmkNt0MmeyqPwrKoKlxeZvGyrWtvejBMno3nPtMQkE3n91Z1xLPwA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IEY4taAn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IEY4taAn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965022AbeCHGvW (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:51:22 -0500
Received: from mail-by2nam03on0117.outbound.protection.outlook.com ([104.47.42.117]:8510
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965021AbeCHE6I (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:58:08 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Vignesh R <vigneshr@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 78/78] dmaengine: ti-dma-crossbar: Fix event
 mapping for TPCC_EVT_MUX_60_63
Thread-Topic: [PATCH AUTOSEL for 4.15 78/78] dmaengine: ti-dma-crossbar: Fix
 event mapping for TPCC_EVT_MUX_60_63
Thread-Index: AQHTtpnWTCAki6ULD0uVIQbmRoxnVA==
Date: Thu, 8 Mar 2018 04:56:36 +0000
Message-ID: <20180308045525.7662-78-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0936;7:0z3TMfF85//RdsXoE+WZAsks/20bH9MFn5iWa3R4jYBsJ2u6ID9xhOs3ZLKlFy0exT/9mkGt2M2QkYc3/Kz2xrNyQgOVoj8Q26PAXN0vI/sqgDSro/kJCw1t6AJovh9vEahIkFdEFgPXwwQ275B0TNL8JwGFJ/dPlBopF32spoG7UPcgzKssiV+fDRlL9lgt2tB0A4BHa99ci++IUzGFvX2KfBwXkmOjMAp8QGPAanwK1eiFqO3BFQQ3cX4PxrvQ;20:fmKlF/NRnG+/NBjGcYSWAkayAv36HMYf7rX77WlqBnNoBAe5s5Bf/+I7w0RNKa/IWwgqnDU+d1aaJw84c0nLWCRUB6pnnUOirDaN0OZIPxGMvvg7ebtHuQWfLFGZT7/8DbhgBdOP2jJkDDDZsSBwMt9+cST7S5FhoGUoS8IYot8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 18368ccc-1f34-47da-37da-08d584b12b9e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0936;
x-ms-traffictypediagnostic: DM5PR2101MB0936:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB093691707E4ABB5803A671B9FBDF0@DM5PR2101MB0936.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0936;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0936;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(39380400002)(346002)(376002)(199004)(189003)(478600001)(99286004)(6506007)(59450400001)(3660700001)(36756003)(86362001)(54906003)(6116002)(110136005)(2950100002)(102836004)(1076002)(3846002)(6486002)(3280700002)(15760500003)(10090500001)(10290500003)(305945005)(72206003)(6436002)(6666003)(26005)(5250100002)(2906002)(186003)(2501003)(105586002)(76176011)(66066001)(7736002)(68736007)(25786009)(6512007)(106356001)(86612001)(8936002)(107886003)(81166006)(2900100001)(5660300001)(4326008)(81156014)(53936002)(14454004)(97736004)(316002)(22452003)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0936;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: O49AhOHdRz6m+ZbwqATbpH79BtG/QLYG9jBN5zsnH6oNaBVEGmbZ6IkpQozo7FdyL6pMoaMS6ZT7VDhbaJJZG9PSf/3mdOwY2CWqkbSLp0LNWbnr+ZaeFNT2ev7ZBTCxLzsSo8rAUWHMQhiBy+5FunCAbGPVPZBCYdi3D+Xtin1qyVvt2daQgNinPRvi9VHdEsE51RJMDF+6J0NaRkAdwnpjvKRnVcubyecrJruiKiKeHcZoXVPubmFFP0i5nQIAaQvx1YTstBG48tHXhPDcyYfna/nDO3TWvtgtOM0HOi1E66ttNIw4hX7/k4AwqR0Hcflb+D/fhOw72bfZTkjYLw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18368ccc-1f34-47da-37da-08d584b12b9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:36.1341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0936
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Vignesh R <vigneshr@ti.com>

[ Upstream commit d087f15786021a9605b20f4c678312510be4cac1 ]

Register layout of a typical TPCC_EVT_MUX_M_N register is such that the
lowest numbered event is at the lowest byte address and highest numbered
event at highest byte address. But TPCC_EVT_MUX_60_63 register layout is
different,  in that the lowest numbered event is at the highest address
and highest numbered event is at the lowest address. Therefore, modify
ti_am335x_xbar_write() to handle TPCC_EVT_MUX_60_63 register
accordingly.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/dma/ti-dma-crossbar.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/ti-dma-crossbar.c b/drivers/dma/ti-dma-crossbar.c
index 7df910e7c348..9272b173c746 100644
--- a/drivers/dma/ti-dma-crossbar.c
+++ b/drivers/dma/ti-dma-crossbar.c
@@ -54,7 +54,15 @@ struct ti_am335x_xbar_map {
=20
 static inline void ti_am335x_xbar_write(void __iomem *iomem, int event, u8=
 val)
 {
-	writeb_relaxed(val, iomem + event);
+	/*
+	 * TPCC_EVT_MUX_60_63 register layout is different than the
+	 * rest, in the sense, that event 63 is mapped to lowest byte
+	 * and event 60 is mapped to highest, handle it separately.
+	 */
+	if (event >=3D 60 && event <=3D 63)
+		writeb_relaxed(val, iomem + (63 - event % 4));
+	else
+		writeb_relaxed(val, iomem + event);
 }
=20
 static void ti_am335x_xbar_free(struct device *dev, void *route_data)
--=20
2.14.1
