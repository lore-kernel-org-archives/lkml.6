Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523236241-2-14714465505067858883
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
    1523236241; b=t/RVAww0FzpPjSj9DsoAD94ZGsmCFv6z47PfbX5NtoiEx39C8P
    v3DSBc03ptuYYSt7DiseIVYBJkR1Z0suV9piiRGd1h951Evc3piIJZhiDbN9QgQ1
    ajuue8GPImOltA1QTt0QbVJVs1lDg4dnfAGhja51PTf55jnuqb2cYIWFtouUREEu
    0qHDEOsNkYIvy08PwmsNys34h1a9o81UIOVaO0iDwwOfbjJBahLyvnTdpIS+5amw
    a/O920YPa0VbhDQpV0tYKpU1feiwN2rRXAwSKxexbE/QNyCrF/0GPm5JR0SoA4cD
    UNA8kC5f/17eYWbgBhV5qVSHFhppfpE8Uhyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236241; bh=HcOdACT5gz
    HK7Zlnf+Ax4jP6xJKV1Mo+fUD7nRCkJAY=; b=PW8ot9q+YZES7G3BriMHBGzrRi
    H8hdigyh7PjI/JXScx1OnaMTrd2VVv/EFeqZsx6pieXvxC/WQS35Q4VS5I4MJJOS
    +wXog3MWFPYj48uoAEeKb26HAiJjjRH5wyWJhrhKtnvZVzrZJe0GLyUbRGRmQ6LR
    pEnaXGL/u+q9H5BU4xttLM3z0iRbSCNeswqP0r+faaHr7D73MdvnSe0ahhbPaupz
    cJrUQ32kPXtfCHhEYlcP+9UpZkAlncmiyDiReCihfKbmnwcIBSmQZwUtJrlxXN6k
    s6dKkSao+1PXMne7pBXWg8IGp+Dgkx2rojAMGrYHoovsOU1ZUxzSfVmvjzjA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WYlFSNSS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WYlFSNSS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPqe75Ymw5Y7GW0ieWb3rC0f2bGkZiiu2iMWy1Uw2MbPqmdeuptveRii64zYgMDF5JVZTp6OC/InXOhGP4q+0mThqOWpyfpXK08Wthp5x/CTun0+NgVy
    mxsFz0knLnqO/hjdwg1cT25QmQu0Y1kd2UqGJepsGAUFdlSiq2JpwQVhM+tVDdY0tdfjTfcuWYyZj3rVNW08P/RcJCJ0ifg6Psft1gc5TNTITUn9hTsGUTRJ
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=CbDCq_QkAAAA:8 a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8
    a=aHWjHDCVnQwbqpGisv0A:9 a=wPNLvfGTeEIA:10 a=1qrBK16LubpBFNPVNq2M:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933013AbeDIAiq (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:38:46 -0400
Received: from mail-co1nam03on0137.outbound.protection.outlook.com ([104.47.40.137]:26752
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933001AbeDIAin (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:38:43 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 134/162] RDMA/mlx5: Avoid memory leak in case
 of XRCD dealloc failure
Thread-Topic: [PATCH AUTOSEL for 4.4 134/162] RDMA/mlx5: Avoid memory leak in
 case of XRCD dealloc failure
Thread-Index: AQHTz5nSkU7OVF3j9k+vDYfv/3oelg==
Date: Mon, 9 Apr 2018 00:29:29 +0000
Message-ID: <20180409002738.163941-134-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1095;7:Ivsmwdg0aH9BNqp4XYyo/GGzuRJg5pgZHVoHdQJsAiJI0r1BBaVpb1PSQK8SCaQlqVrdNVSZwiJzZG8SeROIhhUWx2jRCyJWaVsaC5qkqG2QaQqno9Ps2RPHg/GqWBpmAeVRjobbJjEIk/ZNDcAz4OggmSZPzKeTSj6VO30A7ov8r6Pm1Ped/114FlEFRcaf8cpI1jko91R4l4ceKiZvFcssa4SIzvm3fVwRXE9Y3I1bJ5fEXBt8I9+FBxpDBltO;20:DnM20j1546p/KAaEFXYMkyDEiu+SW2wZxh0ZQg/88VUune85f0XwPPVot5If84tggHLzV+EYijSlJW67yQNrk2hMK+42sYo44UnaiX2lQsk53+1MIJS4524Wrnb8suIcKdfwYCLDFr8Z911xunuaSuWOFOopN+3ZDdiayfC0iwg=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2f358f2d-3016-4369-c035-08d59db23c4f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1095;
x-ms-traffictypediagnostic: DM5PR2101MB1095:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1095EC8EFB88A41767A7C185FBBF0@DM5PR2101MB1095.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1095;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1095;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(366004)(396003)(39860400002)(376002)(189003)(199004)(26005)(10090500001)(476003)(105586002)(86362001)(107886003)(11346002)(446003)(2616005)(102836004)(76176011)(6512007)(97736004)(36756003)(6666003)(6506007)(8676002)(59450400001)(99286004)(4326008)(10290500003)(81156014)(86612001)(81166006)(186003)(486006)(2900100001)(106356001)(1076002)(72206003)(478600001)(305945005)(8936002)(25786009)(3660700001)(7736002)(68736007)(66066001)(110136005)(316002)(54906003)(3280700002)(2906002)(3846002)(6116002)(6436002)(53936002)(6486002)(22452003)(2501003)(5250100002)(14454004)(5660300001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1095;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: CBCQ5F1SDXLbx8QOeJSKGz850dYo47mpviguClcUJ8lLCzcDICSjBMwd2c3vbYdOIMPAgjW5grraHSt4LARciVDssSIKNcRk5i1mMKptHO7A+EigHLBoMC6GYE47qx9q383aplhva5sPb4OL7Y2XF+Iz+/lw5dvrqqmBTn4lskDrecaAllhpAArggqYUlqdyxlOiPnO/OJpg+SVHBN8rhRRLTSbIh8BoTA0ckqfmfqkXWeuXIbGfjtKhxgLSyLQlvQTN2QOgK3NBMkxHhjfOW/qVXJsZatckxoiv78dk83ni3HO00VZ1z5xUG15IU4DRxVGw0Y5oWoMIxw3oIKnXvV6ojVr6mBRy4cBUMH2LnSg8X2+JHy5xNGL+wIaynbv+VxHEJ15XMI/l1CXwWY3fNZyGwCwcAF1wuG0z47jIjVM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f358f2d-3016-4369-c035-08d59db23c4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:29.8338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1095
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
index cfcfbb6b84d7..3d3952ab013a 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3157,12 +3157,9 @@ int mlx5_ib_dealloc_xrcd(struct ib_xrcd *xrcd)
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
