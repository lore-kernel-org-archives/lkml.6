Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1171329-1520492643-2-10759340931134733166
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ensv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520492643; b=Me9mGsddrJLO4zA8MENA2f0D2CTSjCQvjPWPZBVqv35i9Vl
    CceKPtJGHnpEWmm8fA0CRgBRR0mIFNtrJayf2tUFxtJQQpSLsHKQ/Hb3e55efaeR
    VWUUhX7Fgw92e9qPY2RgdrEHcsCHQQ/IzEsKMwYteu5BIBn30hteVSM14B2/cjYC
    wWpNqIBRtWwP7CdN13OYFPuEn/v+A6m91aQbo17f8+Hxacc/dtJPjB0+U7K+PzwF
    nsqaHoJnCYRDnZ4Ojo675ASkAsQTwsB+QUrZdH+NwSQM3V7GPdAnwM1UMPRyClMj
    H7K/IeQHyNGbiyPjR/8ScKEyuxMTxJf6EANGiQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520492643; bh=lD3cGE
    ExF2nBGPyjdg3ED3KPpiIbAqcnWLBgwyqQTao=; b=mb2yLGiZmNPjtCHC+m7gew
    Vu1Ts6JdxblCmKZfmbPYMEI8SSYPv4r6QLyRCx3CzmbmsUhFvbUg0XTj5IVwQ9yN
    X85tRtNPaTl7/Y6ejgfwcs149c7srpe/VXYZsafkWpyptvTrYia0GTVUe19Opkv2
    69le81ZwJ0aWWqqnFwx/xy3CERbYcGNn1GqSki0Aw2s08SVFI37Z6W7GXSDlCMw0
    VoE6tKtkr/VhhS58VrAo9kIANiduS0kCzSk8U7gRPXF4Gyq/VxLcFo+9XnesH+zU
    pmsEl0iOnoPJowIuwrSi++/BAePEm4cIkIpGkUsGoBn0i2cv8F9Dto+3ov2+4mGQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MYp5H8NJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MYp5H8NJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755303AbeCHE5G (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 23:57:06 -0500
Received: from mail-bn3nam01on0137.outbound.protection.outlook.com ([104.47.33.137]:61760
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755212AbeCHE5D (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:57:03 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Kedareswara rao Appana <appana.durga.rao@xilinx.com>,
        Kedareswara rao Appana <appanad@xilinx.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 31/78] dmaengine: zynqmp_dma: Fix race
 condition in the probe
Thread-Topic: [PATCH AUTOSEL for 4.15 31/78] dmaengine: zynqmp_dma: Fix race
 condition in the probe
Thread-Index: AQHTtpnJf/YJaXAlGUqd0r50PHxRTQ==
Date: Thu, 8 Mar 2018 04:56:15 +0000
Message-ID: <20180308045525.7662-31-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1111;7:fx+soB8CaxBCPJoKunzydZiDu5/H1nLhAPXKGCEQmChxxMK/ZCANSa+PZWjEzH2z8jvf8yTxptrum6nCuekNeDLcZmfbni5vXHh2sAxqVyuz5PQiU4Id5wG6Qm36C4U+Vjwq2BA8V8FXcyfAVPafqcujXT5MPR5X00mxHhxcGevlc3lIkA0qJP83gkWmQgAnZztPmTkJgELiLlUndNMlU6lIUTWGvuSpuMPJOKQSiZ2ao5r/84hm2xSQbuQvsXN3;20:ARs5W/Z/Yl41igG8VHKMSd2o3/wLAIlesWFlSdcxzSaabSq5624OtqMIicDMVvPP5bJTlT/lZeZcQpFuHzsGOIRgDn1AJCNKHBzu7jbVEiJ+W4AcPPy3npwIKQxXccX6a+ylMySYzh+X2j9QnBi3Kw6bOUjyyiwVdYMpXnukp/A=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a688d44b-93bd-4298-e5b0-08d584b107ce
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1111;
x-ms-traffictypediagnostic: DM5PR2101MB1111:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1111DC1CA7FBEB810BAA4778FBDF0@DM5PR2101MB1111.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(192813158149592)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1111;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1111;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(396003)(376002)(39860400002)(366004)(199004)(189003)(86612001)(22452003)(99286004)(7736002)(54906003)(305945005)(86362001)(5660300001)(66066001)(6512007)(81156014)(14454004)(53936002)(2900100001)(10090500001)(1076002)(110136005)(107886003)(575784001)(6116002)(6436002)(3846002)(72206003)(36756003)(8666007)(102836004)(316002)(3280700002)(3660700001)(478600001)(106356001)(6486002)(76176011)(6666003)(8656006)(81166006)(10290500003)(4326008)(2950100002)(97736004)(25786009)(59450400001)(105586002)(8676002)(26005)(2501003)(2906002)(5250100002)(8936002)(186003)(68736007)(6506007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1111;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: reqhLLOr9Szo373pf8obxLlgFw6SKWFLfrM2/HEzqUn4KuTjpBCS07GKVMbbXRIDu8O3FOZdmhQ3NlEoPFoUlun6YecfY6oUFmClTEafu7AMOhqphSsKU2xQIathxFjsTAYDfZGngR7fpsFXcb4N0+HEsN+PW61DZIX0gSex+zi6tK22QcCHrXuoel0L05qUNDKfuD2qi9KU9xsCTsW147l8wyRKwGbsbAT7hbxsiiyZbv9YZM4iFOGeCIyvFRpFQJlm+qERivh8oH/ae2gPc4FiBP+bAbmKljFax6Alu0jfNjyVJpp6qbQB61HE8cU5uBxbV2iSOKO6bkAKIomEkg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a688d44b-93bd-4298-e5b0-08d584b107ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:15.0374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1111
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Kedareswara rao Appana <appana.durga.rao@xilinx.com>

[ Upstream commit 5ba080aada5e739165e0f38d5cc3b04c82b323c8 ]

Incase of interrupt property is not present,
Driver is trying to free an invalid irq,
This patch fixes it by adding a check before freeing the irq.

Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/dma/xilinx/zynqmp_dma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dm=
a.c
index 1ee1241ca797..5cc8ed31f26b 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -838,7 +838,8 @@ static void zynqmp_dma_chan_remove(struct zynqmp_dma_ch=
an *chan)
 	if (!chan)
 		return;
=20
-	devm_free_irq(chan->zdev->dev, chan->irq, chan);
+	if (chan->irq)
+		devm_free_irq(chan->zdev->dev, chan->irq, chan);
 	tasklet_kill(&chan->tasklet);
 	list_del(&chan->common.device_node);
 	clk_disable_unprepare(chan->clk_apb);
--=20
2.14.1
