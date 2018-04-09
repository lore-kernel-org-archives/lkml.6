Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523234831-2-8839313482475506065
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523234830; b=NNhCcDpRvMCoxeZOK8YkhkIafPL9CjUv6rJFkny72XTp0iI4Vb
    XFpfOxBZMVdKxMLMsTangwtBykimpZrued+0TdJzMK81JpBn60gQthYu+GvJml5H
    Z9tj4eTU7Dv4Rbks+Z0FNgfleV3bZaQJkzcM/qVsKbuq48725NqVK382l0u+fRIt
    XrUE+AqEcZbIFjrMsfIDpXEDMLugNWPk834WkgFUhGRy35Ne7Vm+AvK1vfs0cyus
    Dfqtetadr6LjDqaroGMDGdqUbVp3tH32pI8f0TnT541hUE+piMGzuFiRSUmImHvx
    0Cd2lUd5oc78yz3dNxnqW2HVoofVlFBPwRIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234830; bh=UY08JEnKmx
    XbYrfUEzg72J6wmNAFultreEZQEqyN3Eo=; b=frVxpyGzm4y0T4/CYBXRGVrh6x
    SvwJlKeBzh0d3X7KfV/UcMDzsZ07TPQP6OoG1Dlt1y2K5dx0t8CkvHTgS4ok9ebR
    zlZmYHOGIQLKFZPRB9eBffr5T0UTuSw8fCxNzefhfqEAquTOxWX4ZtE5Ev19vu1/
    XobupgrqscCU5aC7ZL5OwRLE7a4jvpruxB2IYBtHT42G1WuvBSQLZCllh3bBngkC
    ZTj3HLlmeNJ9ss+rdr/mg9v0yMa9oJSpAeWsvwJBhiYNgxe5bjUxaAzPpzEqjHUM
    ngrlXREK4VeTN5pfoKX2ZcYWo35KzSk1bZ3PVSw7KruDo9lXBcG7zh0AnchQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RC0y2nl/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RC0y2nl/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK24bXItpGxaanMqZLrZtbV42uZxS41Bgiu6YVeFgNH0wqknv65wxZIWOqs+I/HrCAaiykbgKQE20adY7L3JksWxn9cE+uszucO6WLg4XlW2teLrWD3E
    5iDX3PfPIBqN/WmaMMbRe88F5hOll6fgW7TUvf2MCuiiPGaIhf3RkC7M7E0goLqjND7pGWNwWJbPuBzvKiAfI40N3HQ9qMl0e2TJrRukj/8p0reMLegMrHK7
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=CbDCq_QkAAAA:8 a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8
    a=o-1mH1Emnmi-EsdI7UUA:9 a=wPNLvfGTeEIA:10 a=1qrBK16LubpBFNPVNq2M:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755274AbeDIArH (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:47:07 -0400
Received: from mail-sn1nam02on0104.outbound.protection.outlook.com ([104.47.36.104]:21151
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756501AbeDIAmO (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:42:14 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 081/101] RDMA/mlx5: Avoid memory leak in case
 of XRCD dealloc failure
Thread-Topic: [PATCH AUTOSEL for 3.18 081/101] RDMA/mlx5: Avoid memory leak in
 case of XRCD dealloc failure
Thread-Index: AQHTz5uFSnTd3HAY50ynDBIPib6+fw==
Date: Mon, 9 Apr 2018 00:41:39 +0000
Message-ID: <20180409004042.164920-31-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1062;7:T1SsTUPg25PTd2zGk2fq4QBz7BK4dXRT+OHZooG9Ik9Ks2B59AWNIcbQjddTTUwbf/yYn0kjD0qXMBdQoXoyEYpsx8jWyqUciu7MVYvq1m0YlMlNMtstqfDB+joAaan/8hmGDOmXblYM02d4WsEeL6obcB9/x9Nm36+R1ltV2MPUsvEIf7ZNvHGrYGnZPr9argT398FSTi4eQhOr8H2U/TOb70uB18H1E4vt9gmChtDp9fkyb6JUWGZQfDiZWZsF;20:E0Q52J2QjhtzOIhRuqEJ4YskAV20NoT/C/QFaIUcsHLi1rZgShWUnXxMLBayStIe9k1QCimK96ZS+wqVBMvKjT7M88Km+H2BLpE/VY53lE6zTnWkh7YFsTxzY0uHbQMxf4+VlJU3q+2VChTrjX5JuDTGbLHsPFSkc0KGer0iYGw=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9516e48d-d2c5-4436-0ace-08d59db2bba2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1062;
x-ms-traffictypediagnostic: DM5PR2101MB1062:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10626AF468053B0D3190CB3CFBBF0@DM5PR2101MB1062.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1062;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1062;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(39380400002)(396003)(346002)(199004)(189003)(68736007)(6512007)(316002)(486006)(6486002)(6666003)(54906003)(5660300001)(110136005)(102836004)(14454004)(99286004)(36756003)(86612001)(72206003)(105586002)(97736004)(106356001)(2906002)(22452003)(1076002)(2900100001)(10090500001)(6436002)(3660700001)(6116002)(3846002)(305945005)(59450400001)(86362001)(66066001)(10290500003)(3280700002)(5250100002)(25786009)(8676002)(81166006)(8936002)(7736002)(478600001)(476003)(81156014)(26005)(4326008)(186003)(2501003)(107886003)(6506007)(2616005)(76176011)(11346002)(446003)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1062;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Y2hJ/1gvfeE6s+6TpP65o/lwyR5P3eA78WAt/GLzLJHMDx0WUfZD/edbWtym2y7LpC5h7T0VjQY6XKplljVsYFOMupOvSO7e6nXAdnkHmm6vvVFTTTocPPRNPEFg1WXntEsn0QRAR2N0OttNc8coJ+Gg8mK0EBLMTJkuq1xe6Kuc2qExvXTxiA4O2HWWbY+kV6EWxBySk8TGkR5Edr8qpNN8/MZe59fA4rp2Ic9HGeImjv/qN2fKbHEiPeW7OLZtWuhtu3FmQjq7aCAGvljeIVzRAiGHt7J6n3lnaDJPXzHEerh8+8nwX54B699hjUvQX4TjUvbdGtCaysKCbGY5DtFQ36YfmFqDPzHDIOHSeFr25mQOC8TcsSGD2L43BvlgJ1vOPr7iftzH6fGQ/LWwCeftklOfT3Ce8CF83blZriU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9516e48d-d2c5-4436-0ace-08d59db2bba2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:39.4709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1062
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Leon Romanovsky <leonro@mellanox.com>

[ Upstream commit b081808a66345ba725b77ecd8d759bee874cd937 ]

Failure in XRCD FW deallocation command leaves memory leaked and
returns error to the user which he can't do anything about it.

This patch changes behavior to always free memory and always return
success to the user.

Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
Reviewed-by: Majd Dibbiny <majd@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/q=
p.c
index e261a53f9a02..8a531b5159c3 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3028,12 +3028,9 @@ int mlx5_ib_dealloc_xrcd(struct ib_xrcd *xrcd)
 	int err;
=20
 	err =3D mlx5_core_xrcd_dealloc(dev->mdev, xrcdn);
-	if (err) {
+	if (err)
 		mlx5_ib_warn(dev, "failed to dealloc xrcdn 0x%x\n", xrcdn);
-		return err;
-	}
=20
 	kfree(xrcd);
-
 	return 0;
 }
--=20
2.15.1
