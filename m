Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1171329-1520492104-2-1819309924317795158
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520492103; b=SVPWFfQ2pmBQvvPW8NFWSlz5YM00JyhGlt4V3O4L4+aOKTJ
    jhne+BqJpQ3V8eUoG6wXqCe4Umbr4ZPRUkJcqtq2fF/QM8UpomXw5FCg7RFgnpIn
    nzzyQdrFEip2czp6n7B44m01hwe5ZArWIoBCtAR4D7FrATGcu8ZihMGs+2VY08UN
    v0pedvkyUg9Uc01DxGYBAPLOcgOyHFha8rSfT46fGkrpGlZHIrdeA3gxcGuUlNJD
    epirLuP+GbQSJrXPK5q66bVUq+1ty1M2xvyUzU2c7evGVnqBtZZb19Gnw8NzVtiY
    AmFT48EJviMMGPgVKKC9RILIoH3xGLcZCriD0Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520492103; bh=pkP5yY
    JZ17iYadu0i3frzTB94XRXLPilV0u4DVPP0Jo=; b=eJT3vzMlwTf4OYFEUnyqzu
    NV3TIXu9OJF07aURmKGSEjU97EAQi91xbvDlJdYgduIuDfRCbamy9p3hj6SVOGmZ
    LibUG4ZdToEku8Q62xZohYHHHp7TC0FWucJ+zMF3nDfp1lCQPgYG3e9L9sBaOmHm
    FxsByy1n+sTaocoSydzKNuKNxcDtLPZpXA2Z6ND82raqLfplmHj0DRMNLJOj9v+I
    oVRa7v+COdnBYbDjODSUWguWHd8xvYYMb+4OWE11Z2VGYMyzV3RIAyXIs2lgdcn5
    Ept9viXbUg4PYgWeYAvlXdg8gTqwCTWcj3Ehu9jKIbUql4We7mRLtat2XzrmniJQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=a+HArQjB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=a+HArQjB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935210AbeCHE6E (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 23:58:04 -0500
Received: from mail-sn1nam01on0120.outbound.protection.outlook.com ([104.47.32.120]:33969
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935138AbeCHE57 (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:57:59 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Anton Vasilyev <vasilyev@ispras.ru>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 69/78] RDMA/ocrdma: Fix permissions for
 OCRDMA_RESET_STATS
Thread-Topic: [PATCH AUTOSEL for 4.15 69/78] RDMA/ocrdma: Fix permissions for
 OCRDMA_RESET_STATS
Thread-Index: AQHTtpnTJfHIa4NrA0SdGiyq18j3Gg==
Date: Thu, 8 Mar 2018 04:56:32 +0000
Message-ID: <20180308045525.7662-69-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0888;20:U2dBYaaFWPgZRn6mf4c+oDx6o5b1jbUDhzyLOcnmW4C+57FZlVJ1T1HdwQKNzzvAHCCEwkaxn25SDsnm6LS+u6SBCghoPR4WCYGoOpUJhd8e1qRgEPLP+gzqz54LW4HIJBiQ6odMBWEzNWuQRaC/SxlrzFXQk5DfjG2sLNx8exU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a16aeb86-79ec-43b3-70b2-08d584b128d5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0888;
x-ms-traffictypediagnostic: DM5PR2101MB0888:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0888C192B7A6D59822E9C723FBDF0@DM5PR2101MB0888.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0888;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0888;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(376002)(39380400002)(396003)(189003)(199004)(6116002)(99286004)(2950100002)(6512007)(6666003)(10290500003)(36756003)(5660300001)(106356001)(1076002)(22452003)(3846002)(4477795004)(97736004)(316002)(53936002)(68736007)(105586002)(4326008)(25786009)(54906003)(478600001)(2501003)(186003)(66066001)(76176011)(3280700002)(86362001)(14454004)(2900100001)(5250100002)(110136005)(305945005)(7736002)(72206003)(3660700001)(6436002)(2906002)(26005)(6486002)(10090500001)(8676002)(81156014)(107886003)(81166006)(86612001)(6506007)(59450400001)(8936002)(102836004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0888;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: RuCWhtIlh1Y9qOietgh6SEaO2mTj16+LO5yADenwUgJ7CwtZ9GTTzxlSv5VRDfY+VKHitaF8nUa8IRB8goYdQoO+jGyPvyDX57KfjZloGwsq941siRvi1VbIbfozo2pUD3EibsiQhX3LP8fdNA6aHnMbydB6uaRNitxgwAnxa7jELRDw2PNgClADigBKisIfH1qmk0OyVn5ZWPsHCV55zHiijAsGFEcKzOycHbttvaHrUS1NoD+9J3lIUv6hSMj3IPtm4vW+/ZQ+pkF4X6rLIlIvo5YRp/q3TxkDJmbwPlsv17ago8dyGiQeJwrcZTmTsUnAqud7NuUKMakqwwMUaw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a16aeb86-79ec-43b3-70b2-08d584b128d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:32.0683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0888
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Anton Vasilyev <vasilyev@ispras.ru>

[ Upstream commit 744820869166c8c78be891240cf5f66e8a333694 ]

Debugfs file reset_stats is created with S_IRUSR permissions,
but ocrdma_dbgfs_ops_read() doesn't support OCRDMA_RESET_STATS,
whereas ocrdma_dbgfs_ops_write() supports only OCRDMA_RESET_STATS.

The patch fixes misstype with permissions.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
Acked-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/ocrdma/ocrdma_stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_stats.c b/drivers/infiniba=
nd/hw/ocrdma/ocrdma_stats.c
index e528d7acb7f6..fb78b16ce671 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_stats.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_stats.c
@@ -834,7 +834,7 @@ void ocrdma_add_port_stats(struct ocrdma_dev *dev)
=20
 	dev->reset_stats.type =3D OCRDMA_RESET_STATS;
 	dev->reset_stats.dev =3D dev;
-	if (!debugfs_create_file("reset_stats", S_IRUSR, dev->dir,
+	if (!debugfs_create_file("reset_stats", 0200, dev->dir,
 				&dev->reset_stats, &ocrdma_dbg_ops))
 		goto err;
=20
--=20
2.14.1
