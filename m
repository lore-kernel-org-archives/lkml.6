Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523243916-2-16272620237290487629
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523243915; b=RZEyK+97Af3BoVi/YdJDHeJUuilpiZNT8yZgFBcilWFBbtHVsM
    PI7ciaqMPXig9e4ZjywtXx2WakClKy+CdhI+bJ602ODOgq8h0PkRMMaPi3lZkEVw
    gnBy8j//+ySaZou3ekorHxTzLjOW12G8XXQ29U8Ofk/vsYsZGAfsiJdl4TBGWH7Z
    eKyvr3PGibqHFdjkf+t4a2lH8z4Va8eUzfPTa9XpUS+p/UN4aX3Pa2Ys2xjuG5iT
    SNpvkzUnMvhQqxYNzaAUl7bPTZ5uFy2Jb1CqqnYIm1m1WnVh7qQ2aY4pVDu48ZUx
    8Fy3KeHV0ppK1x5ykL3qxLr/S9QLFfJrowrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523243915; bh=CQIuigrT2K
    J1iJX21XyZM1ZXbVfFM6rRFBsbInirkjw=; b=NmCAflAvoyMmMcuMTiaMuoug0U
    JcPs3xR0ksTA+OxpxHFP0pxpphYItuH4qtO+9Aa3pGq7VSzMm4y1s51EJbiQuRgg
    zW8vABkMF4hW9/q1/LOWVJZbXirlCTCLe52fuLg92bx9qj2NSpTAHPOOvh3HEWp6
    v+il7xB9CxYSuC8CUqzTXVT0/a+jNRmWQc0wGtr7dS5jPvWHWk1RP4yJP8kdD8Cx
    r8trDCpXOIkKgVR3mssH1DT6TU4uJPDf2sw3qsiny3seETurkP8usMRsihuSDqOD
    C2sALhLXG0G+4dhMQnxSn1HQg5EeCo3/HcuGeNiiWDYDCZyz/4hZVCRr1LXg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=en4stN0Z x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=en4stN0Z x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFAaLL2Lf/H09HVAWYq7jU06TMIVhfckhLHqyMAoznm0/GLE36j4vRDg0Rrr00hMev0dZpkHqjF+duzFKDPCrIi7Fd+kH4pUVLCJzJ9mP7rdijkX5zSw
    Ac7CYRxqgsJ1C3VE02/5ru2xZGIYxj/dx3bG0iNA1extIQGZ2lRaDD+J9W3AWyjM2w4bwvT/5akKEZvNIp01Jt0EAH6sx7GrX/KSTEf+tuQoHed/p2CdXfHw
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=CbDCq_QkAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8
    a=JVvUqpJ-mWS3NIAVSs8A:9 a=wPNLvfGTeEIA:10 a=1qrBK16LubpBFNPVNq2M:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751662AbeDIDSc (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:18:32 -0400
Received: from mail-by2nam03on0112.outbound.protection.outlook.com ([104.47.42.112]:27929
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754863AbeDIAXd (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:23:33 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Parav Pandit <parav@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 057/161] RDMA/cma: Check existence of
 netdevice during port validation
Thread-Topic: [PATCH AUTOSEL for 4.14 057/161] RDMA/cma: Check existence of
 netdevice during port validation
Thread-Index: AQHTz5iSWgd9fh3Y2UKKbXYtN/ubrA==
Date: Mon, 9 Apr 2018 00:20:32 +0000
Message-ID: <20180409001936.162706-57-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1080;7:i3KGbP1l8OZL2x8lpk6TpF5NfFv2PaDKfAYOCa78itGUlG//T9KlWMgqUNC5MoPJT6QS9Cy1BV6K4mDPj2rODBnwLfPsMSLDaAvSepzs9ClZDW68I/lqzeqjGBb0w8DvWq8J+Apv9MRuLgjWfwXxtMh9fc7RPLbwJBjkGmKpaUiklnGLWrLzlaqv0x26PLfzRqy6WTJIXk5UFGWL41Cdpotca0AAPQF/5yxlOw3UJAN4ZB2b5TZBOOiMMLr9XuJS;20:PEV/qnSk9xNqO3EdfYeweDwCmoQQAqsG3DnY2IcDvXeJoszqnelpnh/xXJ1JkGQsmPK+0BFhy9ww4mc1O32CvrRD+eIhmYDxD5w7GeA3wN2kAcy6DBj4cFeYFtD/Xql+WXBYaDiyC5oX8ERUWNxwfVDd5ww23EuwyJA1ZkJu3AA=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: f441c515-0ed4-4529-5ade-08d59db01f91
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1080;
x-ms-traffictypediagnostic: DM5PR2101MB1080:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10800EBAF30C56AA61DE4D0DFBBF0@DM5PR2101MB1080.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1080;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1080;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39380400002)(366004)(39860400002)(199004)(189003)(2501003)(5250100002)(8936002)(10090500001)(5660300001)(3660700001)(446003)(107886003)(14454004)(36756003)(6436002)(476003)(3280700002)(2616005)(11346002)(4326008)(53936002)(6512007)(22452003)(305945005)(10290500003)(316002)(102836004)(2906002)(6116002)(66066001)(6506007)(3846002)(7736002)(486006)(54906003)(110136005)(186003)(72206003)(26005)(1076002)(105586002)(2900100001)(6486002)(97736004)(478600001)(81156014)(81166006)(86612001)(8676002)(106356001)(99286004)(86362001)(76176011)(59450400001)(68736007)(25786009)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1080;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Y7DHsAsfew2u5kk1p49uKuLG5yOY5p0etptI7bTYEFjOT+9DKB8P2ejK86sPTypZGVaEQwj1Ow6SdJ01Mq6DOV4+h5q7J7AtXAu54TvZUnHTthMbbk755/xHBY1pIJZPqtwaOVgXo9PniTElmITSTbLmwKSV/o0z8BsF6wvha4eAd+0mrbMnf+tf2xHbfCZSFf/BqqLQT0V8bU/cFRjX2f3oMDVcQ3auNASzAx+ejq0qTOZ9TeHsAHHHbIuxFDCP5jim5TFtsgfPb84TkLpB6r1VkLO6porlEqjE4axz0OOzowjznp17cAhvTn6HrlvE0CW8oCoYEUpxGYicyVO4N7Ngh0rYcxCyxIBSi6XKFpyGkhrAPkrWe0KdR4UAANHIK2NKRuuzaHHZSc8oGUrU4NypskXyekirn3t0J4os2LA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f441c515-0ed4-4529-5ade-08d59db01f91
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:32.6599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1080
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Parav Pandit <parav@mellanox.com>

[ Upstream commit 00db63c128dd3daf38f481371976c24d32678142 ]

If valid netdevice is not found for RoCE, GID table should not be
searched with NULL netdevice.

Doing so causes the search routines to ignore the netdev argument and may
match the wrong GID table entry if the netdev is deleted.

Fixes: abae1b71dd37 ("IB/cma: cma_validate_port should verify the port and =
netdevice")
Signed-off-by: Parav Pandit <parav@mellanox.com>
Reviewed-by: Mark Bloch <markb@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/core/cma.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 6cae00ecc905..2cd9671366b0 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -624,11 +624,13 @@ static inline int cma_validate_port(struct ib_device =
*device, u8 port,
 	if ((dev_type !=3D ARPHRD_INFINIBAND) && rdma_protocol_ib(device, port))
 		return ret;
=20
-	if (dev_type =3D=3D ARPHRD_ETHER && rdma_protocol_roce(device, port))
+	if (dev_type =3D=3D ARPHRD_ETHER && rdma_protocol_roce(device, port)) {
 		ndev =3D dev_get_by_index(&init_net, bound_if_index);
-	else
+		if (!ndev)
+			return ret;
+	} else {
 		gid_type =3D IB_GID_TYPE_IB;
-
+	}
=20
 	ret =3D ib_find_cached_gid_by_port(device, gid, gid_type, port,
 					 ndev, NULL);
--=20
2.15.1
