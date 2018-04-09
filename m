Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523238680-2-10813493022239751178
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
    1523238679; b=hx+gHfImjdi4FCAxAQAX76TAOLR2YPiDHt+4f26Czm8pp915UG
    r5DGAcoQT7irZLBp0E/dhK/xVEFXwSz/c8x5XMcxQp73wnwWAxGhfJhiKjbGPiBo
    rE2z/rgwMjUhFbAdbuRp/e035loLWlxFLD29InuYT3vQN9gToUkzWdsmZO5CgC/F
    xH2fk/UzMy+YmWUQNaB29lPoBtIOpyKJVj5cSSBTkcO8kvX6G7rOVmFSiGvmNNWQ
    kUGSMZthBKU4+qh/HbJjKPoV/4qLR/SnpCN5R7A67nc8W5jTZ5o/nH41OW01rWnV
    yjgBYR9/+W3UIxewM9TFUHbYaJHFzRiP+ddQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523238679; bh=1i2zAa7fcK
    88MkMs1LRtn7SuXmXwQ+ES5VyRtbpE6fY=; b=v+jkvTA+KDXI+mvUCE2uaTR8Mp
    vEDbBpXSIZzt6qGz1feZqMtFtT/zoAYFwP1HWBFPa4hA6FROrQn5Wsl1gvi0T+4t
    xZpIQOw9eAti4aLCJv2M0U9y0TvZEwE+a8PSz65bAs6xwm8DumKW2g19POJSvEv+
    pVyD8O+dtQztbHPuryYpoTmA6oZjzO5M6PY9jnDm7AIqVRWUqFQIfdF7MqtU/JcY
    SUbvOeEsYplZQq4JVX/Qut3qsZBRxsXg8rKj5xLKVnjUDuXrehJA+UQdRD4LDN2x
    5bj+ExvwWpL4feY+j9cLGnsIGGPBEbN3i4OfUw3ffB56fZNcP+2xYYmweRkQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oG49BTht x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oG49BTht x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF30PyEdOTyyfqC1MUXVhtGH55+1dwgObTcoWV0g7ZsuJ3H9wQbtuTduunDMazsHbhbnGH5P0DpI0DtBNpza08Ki4P3+TVJUW6aR5NKm2eXwFNYcx/uV
    gzU7XuHNW/pjXEcp3vcdwrotWPoMTtJk6HLQYrn5XnldCPJA+PJ1NkrvxXbWJIdF8iJ0PrmHWZoNUTnkrt0xI5Ovj5o/B0FaZ2ktvoj5ReYD+1CL12KTz+Ed
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=CbDCq_QkAAAA:8 a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8
    a=o-1mH1Emnmi-EsdI7UUA:9 a=wPNLvfGTeEIA:10 a=1qrBK16LubpBFNPVNq2M:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932340AbeDIAdv (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:33:51 -0400
Received: from mail-by2nam01on0130.outbound.protection.outlook.com ([104.47.34.130]:18358
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932331AbeDIAds (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:33:48 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 249/293] RDMA/mlx5: Avoid memory leak in case
 of XRCD dealloc failure
Thread-Topic: [PATCH AUTOSEL for 4.9 249/293] RDMA/mlx5: Avoid memory leak in
 case of XRCD dealloc failure
Thread-Index: AQHTz5lZqSZaik7B4Um/ZyN9B87M4Q==
Date: Mon, 9 Apr 2018 00:26:06 +0000
Message-ID: <20180409002239.163177-249-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0806;7:J85nSL5w9e81DtSkYoXfOmatm6ad2WiIo/z4WApgBUggxd6XAMo0Vn6eZ/PHuumo8q9PqdMvKlhGamEO7AyzcaNOqU/whqKsYecCCbCXLqh66s2sLvSliCjAcoN+j5+ZU5aDM2a+TQBWO4D6+ySK/F0esuBREqqnhc83QrX61F8fu1BDTnKyqsqGNf9/3K0ORSZp/ylu7E6CBY/VHMUVbVyv/zUTAiOUcsNImxUd/lD6WT4NSY6M0acTXg+qUT85;20:Z3kQlu6SpoSavbRVaf7HAMxRRTCvJkJZJX5Ei2/xb+SRbZBKSHdptpVJODmO8zy7tKWJov1vLAgz9oRBcEsSwiUx3RqpFz9zALb2ao9wSLY66fNfUa66l0PtxjT68rUY5TUzyetbPWd+sCAH7rdvvcik2bE5/jgZzdEM5bS9YRE=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7cd66509-f0e3-4ced-da24-08d59db18e2b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0806;
x-ms-traffictypediagnostic: DM5PR2101MB0806:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0806B876D2418A7D2D87AAAFFBBF0@DM5PR2101MB0806.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0806;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0806;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(366004)(39380400002)(199004)(189003)(2906002)(25786009)(2501003)(10290500003)(476003)(11346002)(446003)(97736004)(5250100002)(68736007)(2616005)(102836004)(6506007)(59450400001)(3846002)(3660700001)(486006)(3280700002)(305945005)(6666003)(99286004)(5660300001)(76176011)(1076002)(186003)(26005)(7736002)(6116002)(81156014)(81166006)(86612001)(4326008)(105586002)(10090500001)(2900100001)(54906003)(22452003)(316002)(36756003)(110136005)(107886003)(8676002)(6436002)(478600001)(53936002)(66066001)(6486002)(6512007)(86362001)(14454004)(72206003)(8936002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0806;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: QriT/0Z1jXusAX+Wn+qlnadj0Ej+RFWWsYfyEltTrffAkQ2Bl7Bz0uHPsKznQTlvt5s+dTVJG6V/K0iB8Ukn1KrtTCetznUmoYjBaqpt+CIBk4vSpcqwjkYgxbawmLVdSE3qcSFZ99nfckiMAKY+tPGAvRMrqEeWSDK25bsFrCxi4gxbBZ32Nt+F+CLGZoySQoABN2f8be5Rl8vha8/b6uQ7kfFLwL6QLTobP3p1ZhxZ14/m3WsDgps917nQLeMETc75TDugl0e6ojwg3+sls3xjycJILLSX7AtTh/Yupd3jdBO9rI00RqkMWjl4uin4hKdy2oKyYlnNSF2BvBJHwbXtGVll0qgVDA4qaUuWo+jEXK5nuCtZ/Lb8ENSoZauvPDrESfwJEJemWqtJ8815Wo4ipjmObDokYyniSiDAf9w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd66509-f0e3-4ced-da24-08d59db18e2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:26:06.8943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0806
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
index 403df3591d29..80ced0372e22 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -4605,13 +4605,10 @@ int mlx5_ib_dealloc_xrcd(struct ib_xrcd *xrcd)
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
=20
--=20
2.15.1
