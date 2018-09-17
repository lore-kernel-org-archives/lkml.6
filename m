Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2F5ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C820208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="g4E+uKhQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C820208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730386AbeIQIr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:47:58 -0400
Received: from mail-eopbgr710093.outbound.protection.outlook.com ([40.107.71.93]:31768
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730226AbeIQI3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KY9Yo7BLxoYEWreiqXGngIsp03YTMYna7enh3Ru4NFs=;
 b=g4E+uKhQAWncLeLiHoIPpagQlaKXQhfYZl4QC6QGuj6Qmetkzi3gW4BzKsbDwW+qNWbhm6kohEiH8tUohbGkiaaMyrKgR78Xx1iEHoSQqR5VxVnokwOPEmtVq9BQ+UmsWELN/PesAfab1XCnNHUfnRdWIUw2e4OI5JWd3WoILvI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Mon, 17 Sep 2018 03:04:17 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:04:17 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Vasily Gorbik <gor@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 45/87] s390/scm_blk: correct numa_node in
 scm_blk_dev_setup
Thread-Topic: [PATCH AUTOSEL 4.14 45/87] s390/scm_blk: correct numa_node in
 scm_blk_dev_setup
Thread-Index: AQHUTjLsSoovxhifnkm0/QagLT/wzg==
Date:   Mon, 17 Sep 2018 03:02:51 +0000
Message-ID: <20180917030220.245686-45-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0776;6:AcqGN3sNRMXjkBU92x9J+H0eEP2p0m5UQy7ro8BXdk8BIn2QlFMU3LkO+axBbZg23Bxpak5tHyt/TsQgh6UayAcMXuXLwmHpE+rzEYHuN1Qwb4w4lmZu1Hh6zuQp1oMe8crRghZA6AVOhMSZm8God4TlrsM5KKrZB16+Bc8feBSJ5nnsoUUeHstLjRKzrQXo7pjfetEX9rInt5KTDE/YmaL16ZSO4Fp4Dz3CDYYEkpsKRCSLAsifU4vsgjVWDfCOG1xfaKNIlhXNfGsaUsf9A0WNshBHyx1DYlcHiXFFtbXcmOIz9Q+PR6Yq9d5Vi9HUh1Si8BUQp2ANN/VRulxLMutLc4w1eJlJFlt8ETnj/ngO7q8LZ3oTGi79Rx0pQqQC9Cn8giJIA8VCgLOQCciFBa/9HcdLbepfIv/5HybxfHlAtjsAr7zpPH5/XAWDzWrjN0SFTcPi8Ved/RzA5C7Cgg==;5:f7a9hEqerJAI33D/pL4PZvC13t9Qt4AA4s4ywwph/i9dBoujXDnI7auMoeEMHy2G4D9AJrgz1doX1bRBRecen0mgnW/mn8Ay5j/rGWRxjXHSPjDRdqe+TaSoAtgD3xbtdoNH2B63lOWauL28sORhMQ0wllCxwbbg0d3dR4ieZ2c=;7:9HK5pq6sBCsfknZdc4N4YBFRNIf7I5uOM7s9U2/MuY8V3kArSpthx1jji3Q3Trv2p4cpZi9u4FR748v4hMSDwBHtGttDngr4eJ/yPw0ve2sM1cqx3Bchk20hq3bEYWwVudhEsDqyYRc0fxtGmBjtUHmj8nH1QQ/GI09Riq3emayJrazDgCN8c/ZGWjGMyHx2dNZkYIkifdfYtCix3mZUuaomyXUuHUmH+jHjhE9yhCKtB9KnG1IVraqf3kEgN8ny
x-ms-office365-filtering-correlation-id: 16f80771-d053-45a4-27e5-08d61c4a41a0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0776;
x-ms-traffictypediagnostic: CY4PR21MB0776:
x-microsoft-antispam-prvs: <CY4PR21MB0776D60250963C9B0D3A9F48FB1E0@CY4PR21MB0776.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(104084551191319)(190383065149520)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0776;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0776;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(346002)(376002)(396003)(199004)(189003)(5250100002)(53936002)(72206003)(14454004)(102836004)(478600001)(4326008)(6346003)(2501003)(25786009)(6666003)(10290500003)(110136005)(54906003)(6436002)(66066001)(8936002)(316002)(107886003)(76176011)(2906002)(217873002)(6116002)(3846002)(22452003)(14444005)(6506007)(486006)(5660300001)(7736002)(2616005)(11346002)(446003)(97736004)(476003)(6486002)(105586002)(81166006)(99286004)(186003)(81156014)(575784001)(2900100001)(8676002)(86612001)(68736007)(86362001)(26005)(36756003)(305945005)(256004)(106356001)(6512007)(1076002)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0776;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 9lV65gLQ/juu0Gdq3YsN59YYcUGG7oIqjHazpd5V5pp6B4bfNVTIT0VLmbZLmXuDcekUOdZ1thMTSNT0ekhaNJ/H4kL/TmBvkgBg8zZQm2xnVz4BNaJOe7Feb5JH24Ti0H9tKbAI6VUNOIseDddzuenUmhWObcih7e6WekAxFIyXJoTZRn+LTCFs8RG9+iBf4k5YmJuh+KGiRf6kkDdZ1vc4N8z47mVztZ0qr4vQn+i3slfGfLumaThhNNAud+Y8+QT5PFEtKMszw0I37UsK7qfK+zbzGYDGpcFORysZF21WWTTpWXSdt2JWVmOYdizJqshwkVpzPUMsjTh6cB8dzMARP5YniSM/Pt49t55bgbY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f80771-d053-45a4-27e5-08d61c4a41a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:51.8530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0776
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Gorbik <gor@linux.ibm.com>

[ Upstream commit d642d6262f4fcfa5d200ec6e218c17f0c15b3390 ]

The numa_node field of the tag_set struct has to be explicitly
initialized, otherwise it stays as 0, which is a valid numa node id and
cause memory allocation failure if node 0 is offline.

Acked-by: Sebastian Ott <sebott@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/s390/block/scm_blk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/s390/block/scm_blk.c b/drivers/s390/block/scm_blk.c
index eb51893c74a4..5c944ee76ec1 100644
--- a/drivers/s390/block/scm_blk.c
+++ b/drivers/s390/block/scm_blk.c
@@ -454,6 +454,7 @@ int scm_blk_dev_setup(struct scm_blk_dev *bdev, struct =
scm_device *scmdev)
 	bdev->tag_set.nr_hw_queues =3D nr_requests;
 	bdev->tag_set.queue_depth =3D nr_requests_per_io * nr_requests;
 	bdev->tag_set.flags =3D BLK_MQ_F_SHOULD_MERGE;
+	bdev->tag_set.numa_node =3D NUMA_NO_NODE;
=20
 	ret =3D blk_mq_alloc_tag_set(&bdev->tag_set);
 	if (ret)
--=20
2.17.1
