Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3550853-1523233501-2-16164496092899802523
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233500; b=lIPjDcnzZhmxKQCs+usZuWecBJSZBi+mAxP301gZYA9C7WUJOA
    za7e2Bao86FAGYA1H8H/7zjBe/H2BlCkypE5P7R8WHmx1QFZMR7bLnnpuigxnAU7
    JxKWSsyI5Rn2HyfQoZwGrOCdk5+mSthkg3r4xY0KPzWfFpuDgPj9Rjn6roSwMwZh
    pJ3GkCWjp0zv39Kx88uV5M8BKtTNJCjWi8Ci0Ln40ppWwqhF4cs8hxlnsSS7lI86
    OUeg2O3qH/SXF9SrUtnJKb11sMBIZwrtWmKBQpoNAKCazmzJBZpHx2TigCdM/Awo
    7J0luvtKNzeTthG9L3xo70oZsw4+0SNzgSvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233500; bh=GjWGL5IhGs
    NewobI5DImcoVHlCkQxO8f1Cl8wCWSUiQ=; b=cleU6RUWPF3VosjGRnwo0c17Zb
    rQGBSDu2Sfnjqxo8jlXBIvQgSSJokz9Sgz5qoiuBGsyQJrFsuCHqDmALX1iKUtb/
    XWyz+esVZ6PbMVx739RGiYs7CgdgyDgOadSuWKkuJmANaL8CDD8Cn617E4DJooKW
    yQ9wieqN7XWTGyJfIILzj99FvQ5ZaQ0yauVM/ejBDGjSEOuIA9FjDVLQn4OKpr+Q
    PGe/PndTMB5FpEkJ5bbkOLR98SrNIgZmwud40EbcO3OW+ejW9yUuuZp/YSk1BFOf
    5dSVDablZhDIKya1kWeQCt/5EcrpolPs/1TUVWNOFdaUKZ7BnCRh6XixZIQA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fXH9N0HP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fXH9N0HP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOZCw8Lv64L5P/22AQozIoVU7Ce4b48vAJbDvC9ACjwNTpkMf5JiTjGLv/GYT9wXShuGzJJPWKTgcEoAYxqbtePCGg/ZSC/bDIsstU4yi9RcdiccBMyy
    GxyOedVO1452/8oOAtg45nXu2N/wdjoNljGgr4K7uw4wprEqMnHTHl7ERODLwNDsx39eEsQNqEGRDwc82DU4+ZIxyhQDJm/pLpBECQaoHmBDe6YhgC7l0+Hv
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=CbDCq_QkAAAA:8 a=yMhMjlubAAAA:8
    a=geKbhglIVC9Ed6RPsPcA:9 a=Akj6RQGVVerGVnmW:21 a=QWiI4MkX-kuNEcfG:21
    a=wPNLvfGTeEIA:10 a=1qrBK16LubpBFNPVNq2M:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755114AbeDIAY6 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:24:58 -0400
Received: from mail-sn1nam02on0136.outbound.protection.outlook.com ([104.47.36.136]:19528
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755111AbeDIAYy (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:24:54 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Don Hiatt <don.hiatt@intel.com>, Sean Hefty <sean.hefty@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 111/161] IB/core: Map iWarp AH type to
 undefined in rdma_ah_find_type
Thread-Topic: [PATCH AUTOSEL for 4.14 111/161] IB/core: Map iWarp AH type to
 undefined in rdma_ah_find_type
Thread-Index: AQHTz5iwZgsn9AY9xU+yc6uUMLtOSA==
Date: Mon, 9 Apr 2018 00:21:23 +0000
Message-ID: <20180409001936.162706-111-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0983;7:Y1u5T5n9zuhZWaEkMZfoq0QU8hZ3M5C762EpKhm4LBKsvwBYg7byarNJTP16jt2JYjSaKK7227ONHdxjX7IbUmqfoPHJv2cWcTtYbGZFlj4CNqQ8m4oZpWczSRhetXQ3q7YQws/BYjdeNMCJnTg0aAE27DYwAwbo8QkfmySlK+y7Pq8cEh+iMoZq2rWiTy4ZowwUO/5M7lKfB42WTEjEIyEVZKWeI13arKb6PJufyyKrSbk+HWz/pU47lfprAZ6S;20:gWCFR8BGXMjCJ5oKGpQlvioNHhhafxcwfemVUrZxozsf0Ia9Y8SHFR/jS30txMN3rVBFbe868c365hhpfmDFFRdCuVXwd3L2pqMb4qYfgKagfBlg1jeV8VSTVMaqjwZiVjQ1rPz8vb3SONR6m06yX1gSWJPxMsvMXx95+w1xIv4=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: bcfb6722-0a74-4a5d-8ac2-08d59db04e3c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0983;
x-ms-traffictypediagnostic: DM5PR2101MB0983:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR2101MB0983C6B588B7873936413D41FBBF0@DM5PR2101MB0983.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0983;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0983;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(376002)(39380400002)(366004)(199004)(189003)(478600001)(72206003)(10290500003)(3846002)(102836004)(6506007)(6116002)(25786009)(6436002)(66066001)(99286004)(54906003)(86612001)(6666003)(105586002)(53936002)(76176011)(316002)(486006)(7736002)(22452003)(3660700001)(86362001)(97736004)(106356001)(575784001)(8936002)(110136005)(5660300001)(11346002)(446003)(81166006)(81156014)(2906002)(8676002)(2900100001)(1076002)(476003)(2616005)(10090500001)(6486002)(107886003)(36756003)(4326008)(2501003)(68736007)(186003)(305945005)(3280700002)(5250100002)(6512007)(26005)(14454004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0983;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: aNz0sHU0OnScnOAoSOQa/bIMumWjVDC5TF3na5KmTiV1NBo+sa3kxRhS8GzK3Z+IlBTxHmS0w+AHDv8OGuSDqGGCT9kxhTUlE2xPeBE8e7+7tfXZ1FLXa+MFd6uSMtdaGEXG8bVnzYniYwE+mbBVtMDclp5JNz911+EPQRmH5Ik+J8+wVLI9USm3LA26Js5cH5YBsT3nFYH4XQyMUPj6JkXLqiiTDQWxcLj/7pJpfG+qF3IBmuyWPXWiPZS4kDqyCmqxQt4ZIy5YtZiIpf4wsjDtBepQmdNFpkNF0aTT/AF92MHjRjXQESw1ryb6rSKKU5sZAIPtq7GTJTIOO+R6zJwtPTlJ40JHnz82D0EPUqs2mZpU0gW4dXYfoJVLBNic9F8sP3qqaH6u+4Qldgq4WTeZjqGQobNG5d3Y5Mj3SRw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcfb6722-0a74-4a5d-8ac2-08d59db04e3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:23.2218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0983
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Don Hiatt <don.hiatt@intel.com>

[ Upstream commit 87daac68f77a3e21a1113f816e6a7be0b38bdde8 ]

iWarp devices do not support the creation of address handles
so return AH_ATTR_TYPE_UNDEFINED for all iWarp devices.

While we are here reduce the size of port_num to u8 and add
a comment.

Fixes: 44c58487d51a ("IB/core: Define 'ib' and 'roce' rdma_ah_attr types")
Reported-by: Parav Pandit <parav@mellanox.com>
CC: Sean Hefty <sean.hefty@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Don Hiatt <don.hiatt@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 include/rdma/ib_verbs.h | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index a9fae49a1883..08f3d8699a27 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -866,6 +866,7 @@ struct ib_mr_status {
 __attribute_const__ enum ib_rate mult_to_ib_rate(int mult);
=20
 enum rdma_ah_attr_type {
+	RDMA_AH_ATTR_TYPE_UNDEFINED,
 	RDMA_AH_ATTR_TYPE_IB,
 	RDMA_AH_ATTR_TYPE_ROCE,
 	RDMA_AH_ATTR_TYPE_OPA,
@@ -3762,17 +3763,24 @@ static inline void rdma_ah_set_grh(struct rdma_ah_a=
ttr *attr,
 	grh->traffic_class =3D traffic_class;
 }
=20
-/*Get AH type */
+/**
+ * rdma_ah_find_type - Return address handle type.
+ *
+ * @dev: Device to be checked
+ * @port_num: Port number
+ */
 static inline enum rdma_ah_attr_type rdma_ah_find_type(struct ib_device *d=
ev,
-						       u32 port_num)
+						       u8 port_num)
 {
 	if (rdma_protocol_roce(dev, port_num))
 		return RDMA_AH_ATTR_TYPE_ROCE;
-	else if ((rdma_protocol_ib(dev, port_num)) &&
-		 (rdma_cap_opa_ah(dev, port_num)))
-		return RDMA_AH_ATTR_TYPE_OPA;
-	else
+	if (rdma_protocol_ib(dev, port_num)) {
+		if (rdma_cap_opa_ah(dev, port_num))
+			return RDMA_AH_ATTR_TYPE_OPA;
 		return RDMA_AH_ATTR_TYPE_IB;
+	}
+
+	return RDMA_AH_ATTR_TYPE_UNDEFINED;
 }
=20
 /**
--=20
2.15.1
