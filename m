Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523244572-2-11525135017014016548
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
    1523244572; b=XPYbDT3JvEdAtKMJ8JDv2t0SvlkhWwTP8arXmjN+oOw3gybhYA
    j7F0s49nHoauWBmuTXhIRPvtVJrmwQ9/nySqpzmmf/1lgu3H/5y7HX3pKAOFKPxz
    8RMiHin0BwcKQmqJ6C1pKLA6zXRugHZYdXNgShWhhM+Q6ZAzs0i4i4j6jmxhn7i+
    b8kXlyfYcyCsocigEBnrgBj/MdB3QZVcKQ3YmSTOY4hMZP9SEsqf8FgSXNAr0Vly
    d/s0rBrufuYx8vZcKYWPsU85C9SWJ/Pn1XQ2b+9nDfYqd2hbVqdjPCiUxCPCyHqO
    qUHlvnaI8T6TsE16lcYyhcqQtaZwcOqL6fQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244572; bh=OWzkcyqpOL
    pe1xva8JunD0AdS4TZrIY49YLqvbasfc4=; b=w+DGgbHR2DJf+fvYq0jOX4F6ZJ
    mR2hrXgN6oQgwtielpxDCBtRmbFeYN9A3goEwZ3FHTU/JeMwHQshOwH4f/EXFR89
    JBLVpKGhIocKyw30pTKzyFvMaZfuSyi93XwtKpgKu8TAdmYWp7x8fCGJfJaTV39x
    0YP1Zv1qMQS/e1UiWBkgwte5flnTT+iwbH6f5a+rr3OssBDiUrE79Lh7+03WjwJp
    Gt/6cAUzWjE0rcvJBf2HOIGvdEdwWVqwxKxGVKMAXtC5lMqIqnh4v0tELLb6nB3w
    RdMX1h40PpLjm43DuOCI8loYH7gCYFnDvjDTEJ5wVh5+ZiFcwZOgS/0Xd4Pg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cFILCPXe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cFILCPXe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBCd0M6cAAhASchCHEDEPrR+QK/fwW3be9wCMz6+tgYHHi8JgKjwOcbYke0zWUh7GdIJ19MbPlkfgIBLU+4LelhfyWNxmPJHhBKzWEQ10ZJWkUxZH3i4
    yCvE75FqfVWzH/rSNQOdHDLstU9D5l0AiYtgkcOYkI4MHxa2mBDiOFPO7eycqU5HPBpH3rkEtuMu6CQXkZ8mE1o3F6yb27mtMuHes410AYNc6KcXe5lfswLl
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=CbDCq_QkAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8
    a=BBROd9RWG3xPrVqXB44A:9 a=Ul8nGyFTCcDEiJre:21 a=1ULK97AI4iHuZmK5:21
    a=wPNLvfGTeEIA:10 a=1qrBK16LubpBFNPVNq2M:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752646AbeDID32 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:29:28 -0400
Received: from mail-bl2nam02on0137.outbound.protection.outlook.com ([104.47.38.137]:3548
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754597AbeDIAWE (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:22:04 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Parav Pandit <parav@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 008/161] RDMA/core: Clarify rdma_ah_find_type
Thread-Topic: [PATCH AUTOSEL for 4.14 008/161] RDMA/core: Clarify
 rdma_ah_find_type
Thread-Index: AQHTz5h3ACwzo7BYhkil1rIZ5pxTwQ==
Date: Mon, 9 Apr 2018 00:19:47 +0000
Message-ID: <20180409001936.162706-8-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0936;7:8OxIvI8Y+OMv/+YyVx8aBXAH07o74gvGd9Yw6y8KRVdciviAuigRirvuZOEMUJfCz6wRcRCoFBaB/lTWGgvCFQZnuj+1RCTaKqQwYcIEcv2N9mAOomvxhLL89DS1ZxvSpNTIbCRPMmd3xoKs6eFolbZ9/MImju9GJ9tUjWUfxJ61TihmzL0N6U/Ip1fj3xm8ksdEATt/Xj/qpZALpFBqy3YUn27hV7/WPjQJmUYS+tKp4qyarbF+zMxB+sLAYYeS;20:ZLiWYmg9fLf0D5/vDQnQW9p0xBqYAJC+e4+226c9nYYeJczWgy4WEIcUuRT6opt0WguIi0RyOngXjP7wXNWj79LCimr2XL7JwywtgIrZNjGTezgbiHBRa8rqcZZmzaM88faQxCu99UihSoHuAB+Slo95ytKRO2ZmGCROzJWivak=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0c1321df-ec36-4503-818f-08d59dafe859
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0936;
x-ms-traffictypediagnostic: DM5PR2101MB0936:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0936CFAB640B4B7901B46671FBBF0@DM5PR2101MB0936.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0936;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0936;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(396003)(376002)(366004)(199004)(189003)(3660700001)(36756003)(2501003)(76176011)(10290500003)(2616005)(5250100002)(3280700002)(478600001)(1076002)(72206003)(6436002)(53936002)(486006)(476003)(4326008)(6486002)(107886003)(5660300001)(54906003)(110136005)(102836004)(2906002)(6116002)(3846002)(86612001)(81156014)(81166006)(6666003)(8936002)(305945005)(8676002)(2900100001)(6506007)(68736007)(14454004)(106356001)(105586002)(25786009)(6512007)(86362001)(99286004)(446003)(10090500001)(11346002)(316002)(26005)(7736002)(66066001)(186003)(22452003)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0936;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: eMYBhMUQadyK18bPHBteARVRIukiKsSEzYLyFQ7ByPJaPTNUC+S9dzIJVryKzsmwWRrArRZadgnWOIPLjbtCwwOEw7ov2E4p5lCjZwg3Z1lnj1t9wwKTUDxtHxgZd2vVDXuAMBNPjQBBA0vd5+bLZcegYTD6PYhNwOhMxUdSFdvyHIvLnnNZl4DxXA9D4GyT1AHeq99hT3QEddkj0JKsND5Gvgv3S6y8vQBqfJsD/cjJAuJhV8gq6hpPeC+0TpkpSgQxV96xagrhaJV41LUjUy6gop5iaa+6eJHQWdJkchJ9HWig8EaLxpmh+lrdcmYE90/H9Aa9Ov4T5hbeXrUHUXzuTVpFnxiijPHWfnKHFaD3R3IvWF0W3VOaPAzUT/mYzS4y3b86hESS1Oaqmbt1nYvDQpGmlf76Fi1luaCyvxY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c1321df-ec36-4503-818f-08d59dafe859
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:19:47.5983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0936
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Parav Pandit <parav@mellanox.com>

[ Upstream commit a6532e7139660c103dda181aa5b2c734aa26ed6c ]

iWARP does not use rdma_ah_attr_type, and for this reason we do not have a
RDMA_AH_ATTR_TYPE_IWARP. rdma_ah_find_type should not even be called on iwa=
rp
ports and for clarity it shouldn't have a special test for iWarp.

This changes the result from RDMA_AH_ATTR_TYPE_ROCE to RDMA_AH_ATTR_TYPE_IB
when wrongly called on an iWarp port.

Fixes: 44c58487d51a ("IB/core: Define 'ib' and 'roce' rdma_ah_attr types")
Signed-off-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 include/rdma/ib_verbs.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 6533aa64f009..a9fae49a1883 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -3766,8 +3766,7 @@ static inline void rdma_ah_set_grh(struct rdma_ah_att=
r *attr,
 static inline enum rdma_ah_attr_type rdma_ah_find_type(struct ib_device *d=
ev,
 						       u32 port_num)
 {
-	if ((rdma_protocol_roce(dev, port_num)) ||
-	    (rdma_protocol_iwarp(dev, port_num)))
+	if (rdma_protocol_roce(dev, port_num))
 		return RDMA_AH_ATTR_TYPE_ROCE;
 	else if ((rdma_protocol_ib(dev, port_num)) &&
 		 (rdma_cap_opa_ah(dev, port_num)))
--=20
2.15.1
