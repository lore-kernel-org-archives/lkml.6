Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523245512-5-1551305519370250805
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523245512; b=CZ4GOPwMOkRlaF9dnkZ/b7vXsWInwP6aGs9N/Ukmj4sNfInEJY
    hJBgaTZAF3Bq6aLidzY3zEBEQMzbbxPWArIuhCXPjF8ljycZXJkMcPhxYI2SUC49
    qZa68O9nEm/4FmwRzrUfOkgVokJADUQXnwBb3TrFF7Hfq+OM8L/gsBDxgvbifowR
    Rf8eE2z9edVFzDmDZtzFA9AF813nfH5BnkyOEuog3C7udFMsfTtPYPR1PxD7GLA6
    G6lQDdBUAhRdt3RZCAYqkJM68JhF6mGPM7jHBStx1NL2CPSdSDMvuyIlrdpK9FQg
    il5ilQ1QJBqiGuM0LA93IqgU+M1RXbsFI24w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523245512; bh=PA8C4wbsGJ
    qVqVMnaukWNliNiTWFfj6vG4BFNTNVkac=; b=LPNvADwk+CNMYGYUBHKLm6EXBq
    WdAW6qQvnuKFT+fVXTkDajAFghmid2qxi4XQxto09bzQWfS1omgkCCT+y9+Y+wlT
    ln+WkELnxgZ4b/KReRvx7+6uaaiUB6JUR7KybZNkZ7Ej6aXcWaf1uK01poLaxPes
    TJBagO10IxTRnY7R/hIe8whVLrEwzSoMuEc8JXLVGtncPMvTYjpApo8RpkeY63Qy
    oGIn4Vgsa9m5v3+azmRX0lazL5fCRWKo3btfxgdLDoDpzB9/bFLt5/PSRbJ879uq
    7IIT/7WfRFxITvek97MYg19vnKmhcrB3XxvLYiIbbJY9RmCQ0zUpbSZpRgrg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=crhxuT8x x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=crhxuT8x x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDWkUudbF5ympQe2eUbVDNhWPFspNa79eoCBeklAwKVWNsxI2EpJdqzVLCrKiXp5Z+wGsz8SWTQEOO84ryCBfzFdRJ3xV/sQHxRVLZDIpNohRLzFIfga
    e2l+YHQKYpU3RnFWSNUDewVQWrLZzEQmDg9C564Aemm7LvE5A5kY/LRiiOYQEuiAkHH6d/+YfaHsS7mRKaR9F5XrTY5BBST+n5YkAXVzcF81j0NLJK2vq8vS
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=CbDCq_QkAAAA:8 a=yMhMjlubAAAA:8
    a=geKbhglIVC9Ed6RPsPcA:9 a=Akj6RQGVVerGVnmW:21 a=QWiI4MkX-kuNEcfG:21
    a=wPNLvfGTeEIA:10 a=1qrBK16LubpBFNPVNq2M:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754645AbeDIDog (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:44:36 -0400
Received: from mail-cys01nam02on0118.outbound.protection.outlook.com ([104.47.37.118]:44776
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754210AbeDIAUU (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:20:20 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Don Hiatt <don.hiatt@intel.com>, Sean Hefty <sean.hefty@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 134/189] IB/core: Map iWarp AH type to
 undefined in rdma_ah_find_type
Thread-Topic: [PATCH AUTOSEL for 4.15 134/189] IB/core: Map iWarp AH type to
 undefined in rdma_ah_find_type
Thread-Index: AQHTz5hMaipE4RP3gkaj7HNpmUp5LA==
Date: Mon, 9 Apr 2018 00:18:34 +0000
Message-ID: <20180409001637.162453-134-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1110;7:eF+Kyz43klmAgyrM9haRsiPz1udQmjp/QfE6kTuUG7N+9waIWeJl20SP59ueG+9bmBf5Z+IyVx+echGhyTyZf66ARk9gk+FUoy6MR9WDdS3GjhXyaz+BH1kxroYhfbKoOnTvpqXuA5fw8F9FJHiWH67ojynBOW0pTdPXb4F6qCm2QHG7kIBNwtuolyw/R3d6xIXAlhnmjszebqkUx9PDqVr+ZGu9kx9XNGIDJ98nlg2/bvEkUpwCuV6DkVyuiQ+S;20:jJdyiVbWi0rRpOKmW4/v+f1kGvYpYtb9rOEfga4jAZl4ljjgvX2sEhjjyoTBHDzOOEQvhAeE10nNVZPFtTCfHQfrSryGR6MT/2zzrO6SrXfTSF/gKbG16roTksrlj02sxbqL8HL9iWl/QslZBeYfkwy7vGt7IGjWPyee0F2eiNc=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 31f10f33-fcb4-4367-2c8d-08d59dafa9a0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1110;
x-ms-traffictypediagnostic: DM5PR2101MB1110:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR2101MB11104C70B387F19FFEF86CF7FBBF0@DM5PR2101MB1110.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1110;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1110;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39380400002)(39860400002)(199004)(189003)(5660300001)(478600001)(86612001)(3846002)(6116002)(106356001)(6486002)(72206003)(25786009)(10290500003)(8936002)(6436002)(76176011)(2616005)(6506007)(2900100001)(97736004)(486006)(26005)(36756003)(10090500001)(81166006)(8676002)(81156014)(102836004)(2906002)(99286004)(11346002)(476003)(3660700001)(66066001)(6512007)(575784001)(86362001)(53936002)(105586002)(186003)(5250100002)(14454004)(22452003)(6666003)(2501003)(446003)(7736002)(316002)(1076002)(110136005)(3280700002)(54906003)(68736007)(107886003)(4326008)(305945005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1110;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Ftz51Gtrhwy7JgN4lQMDR/mvt38DFkgZL4fsxoTQMKxmNALCckhusGSG89AQ6sID6iaf9zbpSaUKBr6SSCiDvgdhwzliX1qAYwSCRSNBhQ5AjLMNLfCV8mG91Mi1tg1XVuFpJr0b26RX7ZqGsndaouwUyccFpB4FP5y/L8hPRq8qvieReT1q0efrP5yTGxYwmkXscQIhC9FrWIr2T3T74Iz1WlEv+kmKJoDWTNxOD2Vgmy6ffw9LWbcbJ3LdlspLAOZmy5SAWPxG/P1Ze0kRce/eL4a/Uy0A4s34jk7KN+imrsD+iuMZIT1VhwlpjU8kv0A7CFGFvPwwl5r2d1C/3ViKB+fSJkIkRx5+LAIzKCKpSlhY7be7yNrsVLDW1R/XtmJOL66oOfc2KWttnfkxYxvc5CjOq/1bNHCON6ICVZE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f10f33-fcb4-4367-2c8d-08d59dafa9a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:34.7223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1110
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
index 20ebf9061962..411776de40e7 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -878,6 +878,7 @@ struct ib_mr_status {
 __attribute_const__ enum ib_rate mult_to_ib_rate(int mult);
=20
 enum rdma_ah_attr_type {
+	RDMA_AH_ATTR_TYPE_UNDEFINED,
 	RDMA_AH_ATTR_TYPE_IB,
 	RDMA_AH_ATTR_TYPE_ROCE,
 	RDMA_AH_ATTR_TYPE_OPA,
@@ -3789,17 +3790,24 @@ static inline void rdma_ah_set_grh(struct rdma_ah_a=
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
