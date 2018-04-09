Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523237014-2-5536444096087531155
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
    1523237014; b=ZE7nZHSdiHLQARGZQ/CQJLohP1Kgjg+RpEvPighlzeuQLvSY5c
    D6HFggLZdwcs5mUyHqvylc/rmYzcNPNbu8gM0g+6wKTXetDWLaVSTRQQ1TDZEVnA
    JpjO9AI16hQ5n4Se7EYK9KOcyzc1B7P6mHvNzx6629Rj0Ufg53LVxM8poujuZcXF
    1ZGzv5Lw0+tPe3iuE4SdpZ8Utht2MS4apCmiJnk5UJ/Lle8L3qQfRJ5GANgM0Son
    g4VYuPtJ2vSaafdc/lGFTZkWRt2CrcjixnlbhdgL0HrLweZ+lM62JlJpbomibn8y
    zYVG3r4Uo6GUK5ZpS9gSznUuyJeh+zmwiSyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237014; bh=Ww7WZLg7js
    92jqhPsD5ejt2LzZ1VFddbmwo260T83RI=; b=T8goNLHvnzybS7QYyomlGQjWz0
    cF2QpYBi2xvjZsmPQyqig2UZkAFPxx9zK9Z/2kQdDkBkePdGmlFb3Hfs5EWwEnDu
    ErKLv0ovEGzHLk3sJ2J+1sjetCn2RdC2X4FScc7qkYCDHSpdw2gy57TLVXFCPfvI
    6cCM58XH4fwoODmGIRrqzm12Y7yfRdbvPtxrSpNokWQtYY6fnNiJ+HKNVa2oZpNB
    gGRcu19lna+DHCIjkIfxr2OdnRoQXB2LQd7J+Mmi5irhLzDlgPURJx7JXMqqO1k5
    UU+QUIuAtjzchR5R74KiZhVRFaUB4ODkVCsYzSTlguxeWT0lYXhsxaN0Sr+g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XwqfVULM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XwqfVULM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFb7gvPl0oXCi92lc84e590a+vRrDyBGHYwC22Uw5l6CrOm6d2IuRq1RaeKyl7xqWT4C0MZsZAnk4zUEy8bDjDfPrWH0pXh1fRS4w6Mrdm6dFf9P+3UA
    LzdCHojA87DcxdEXvCmblIJd6BbaZ/7SrVHiBD+EhzHsPx5Qm/aPs/XtObYSXlHRntGtt2KQT/GAXKi8JRKU7dlHfnuJ7QgdWlcU4TP/5UDUn10cBQJreZSQ
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=CbDCq_QkAAAA:8 a=yMhMjlubAAAA:8 a=iU4TNklKuN5JFk1He9wA:9
    a=wPNLvfGTeEIA:10 a=1qrBK16LubpBFNPVNq2M:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932460AbeDIBXC (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:23:02 -0400
Received: from mail-sn1nam02on0113.outbound.protection.outlook.com ([104.47.36.113]:53303
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932724AbeDIAhD (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:37:03 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Gal Pressman <galp@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 076/162] net/mlx5: Fix driver load error flow
 when firmware is stuck
Thread-Topic: [PATCH AUTOSEL for 4.4 076/162] net/mlx5: Fix driver load error
 flow when firmware is stuck
Thread-Index: AQHTz5m0d2GaOHRQ3U2bS0cd9yuidw==
Date: Mon, 9 Apr 2018 00:28:39 +0000
Message-ID: <20180409002738.163941-76-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:ygPnIE/QO5I/0QcZ6/5mCC0MXbzR+SvomeHN7j7ikLHgi+/Lq5KxAl7BOBJOfLEA19EqzmvC49fOD2MaVlj4uMTrKplvB3Zum3q2oOn/PhuOMKZSKAimWWpEFhmqlnw1hpWnEUwxOIW2UlsEtrjvXTq0tMRk4JuyJhIFUT0HH178CkJtT18QOWXRRbePKYTQus1DVIfK/BJN62+j1WDiobzfYxBSN0fu7ZMTGuxZV691HWWCTVxH35e7zwQnkY8p;20:1Pu5BoepWR0tBoPempBaBnPRiuZkrujzy5eYkUKqJOaQiFTIQKoNI9T1QNOahJguhOKdrvGUmqBVArOQP7xduqABWfzVGiIoitZnZ36qdGyA1XnJxoGIbIZ1TApk5jFMnOGlNwL3w1sWKRgkV7gYkTMP6SnsoLCSb25LN4tyUdo=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: c316415e-1396-42bc-35b1-08d59db20120
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB088560E682E4B778BA9AC804FBBF0@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(376002)(39860400002)(366004)(346002)(199004)(189003)(66066001)(3846002)(6116002)(59450400001)(86362001)(305945005)(10290500003)(6436002)(5250100002)(3280700002)(10090500001)(3660700001)(6506007)(2501003)(107886003)(446003)(53936002)(11346002)(2616005)(26005)(76176011)(7736002)(478600001)(476003)(81156014)(25786009)(8676002)(81166006)(186003)(8936002)(4326008)(97736004)(102836004)(99286004)(14454004)(36756003)(6512007)(316002)(2906002)(22452003)(68736007)(54906003)(110136005)(486006)(6486002)(6666003)(5660300001)(2900100001)(1076002)(72206003)(86612001)(105586002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: kqSGtRZMCQtvzkKe7mR4ymIaIJ1/QnZRllaufUvyO3/Uxzt0OkVXcvqZx8umJcIrrLWCQhiUhFoShCb+WlipDzE2ImapvzdAuK8cjGnvDIQp9RIrCQbk2swXXTHQe6P5shjWluRfBdw6c7HEh3E/oJ4WcArW8WKOELldWKKEET8mhRvp2zs2GOKZAn0m+MSVTkJvYGeVqdDA4RbxChpudkN2i5w2c9iFFiCl9b2HQg7fV0Vbul3PT5I1gQzDP8wBTQ/dv8nNxNgymJVLAGw7uEml6nCKJeU4JtXQ1vpeQDpfIZxLP+ZLlQ+NpsAE+ji6O5riE2TKpG6PvingUONhtNLEvkPnU+4cD68kNeexDBMrrvf9MrYnGa+pzULGn3GerBAcyTZYaYBhxCKbWe8BP8SyoUOlzcJWd4FjhRlfXHg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c316415e-1396-42bc-35b1-08d59db20120
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:39.2864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0885
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Gal Pressman <galp@mellanox.com>

[ Upstream commit 8ce59b16b4b6eacedaec1f7b652b4781cdbfe15f ]

When wait for firmware init fails, previous code would mistakenly
return success and cause inconsistency in the driver state.

Fixes: 6c780a0267b8 ("net/mlx5: Wait for FW readiness before initializing c=
ommand interface")
Signed-off-by: Gal Pressman <galp@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/e=
thernet/mellanox/mlx5/core/main.c
index f5c1f4acc57b..e9636c0117c7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -941,7 +941,7 @@ static int mlx5_load_one(struct mlx5_core_dev *dev, str=
uct mlx5_priv *priv)
 	if (err) {
 		dev_err(&dev->pdev->dev, "Firmware over %d MS in pre-initializing state,=
 aborting\n",
 			FW_PRE_INIT_TIMEOUT_MILI);
-		goto out;
+		goto out_err;
 	}
=20
 	err =3D mlx5_cmd_init(dev);
--=20
2.15.1
