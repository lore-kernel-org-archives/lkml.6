Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42DAECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73F3E20693
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="mJMaq/gX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73F3E20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731529AbeIQIhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:37:47 -0400
Received: from mail-sn1nam01on0093.outbound.protection.outlook.com ([104.47.32.93]:10176
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731249AbeIQIcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:32:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zaPbrz2+m0dvkkyQvg5BVElxLeKXajIMOzUI3le5WM=;
 b=mJMaq/gXBWOmvGh5853iaK7MT8L0K5Mx5gHKBOPLm3FIe8HI2lUI4HZMZT0bC1p4cIIKa2utQUxtjo2ti0M1O4+MkBJXYDySTg0Gny8BBN03rTv3shEP8GBwyTgWNlkknt4OaqBZ8Rl4Cz6amJRQQ4a0BCJnW0ENnoABtjzIOes=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0759.namprd21.prod.outlook.com (10.173.192.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1164.5; Mon, 17 Sep 2018 03:07:12 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:12 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 30/43] media: tm6000: add error handling for
 dvb_register_adapter
Thread-Topic: [PATCH AUTOSEL 4.4 30/43] media: tm6000: add error handling for
 dvb_register_adapter
Thread-Index: AQHUTjM96+0WtEX7Kk6A7q0ce7GTOw==
Date:   Mon, 17 Sep 2018 03:05:08 +0000
Message-ID: <20180917030445.484-30-alexander.levin@microsoft.com>
References: <20180917030445.484-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030445.484-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0759;6:v9xD5rDYYepxAKwhHoZADuFcgdO8zLong3U57lCcKHTUHRbHveYEriXuQ95yvVkaOACSxw3KbvgytRMTPD6W1azfCQ1B3kiae5siws6ccKeIBX2sbPCco1vUoJCZZ5Z9n+npqpwb8oZbIsi20pft/6mObpxAtgaV++gxSGI7GH9iU989JR535Jju17TZNLV8yxqlRtzZue6ci2BIYLF4RfFeTx+k+ukO4bPXCV/NsdjuwDZbOBS6K2UGO1IvNJonI0EgNxsNetDy1vKBUoyCzj2UM3KVHqvCX2QQvvSTNpdzwCVSyrHwgxo8eWU/uoU33VDH2RuJGJDmwfLtrwcgPXDKqFJmirdBwM1AMbYbNDbY45ysOtW+iGExJdIC70wfhdSjwg8+YhSQ7NVxo8lsK7GnQAs6j6D+4bGcQDVrE8HIEE4JKlJXFcadbYA3LHj+7DjvtHSuj0GdLEuX2I61Ig==;5:miCTTHm0yL4Rm+yop7BHlA1rra6xM76uRNuJ3INFXtXHU+jh/YWSY1aJVRVldwGKBicftGnjN0wN9ItPafo/NuJh++SZTX6R/o8WxMcGQjNv8PMJuIPZngyyVPHjd0YmYL3kEBcj9PIKiT/QNG+6I/NvaJt47wUbvUgPbhyVXwg=;7:ees1xEgMMDu1x1JzctHEmK4XFZcelnmI+tI8Y3gUkK+T5sFVwF74A1eP4nbsU39vjLZ5zYml/kMfF4W11HxfC0LM+ZofYWrAc53HpayRfmBCu1Ls6udSl2jvnEpGdjDhxF7bpBWnayORlc9RpIpXKytIGWnN5zcJVBxZMoYt13D5q+Uw3q+ikAmYDVvquuD2fzkLlf+aL8I2/oL4p6spDJTU+EimgzIRI3Dp2XYEirhclcDvN4Eto59o/xH5P4Ft
x-ms-office365-filtering-correlation-id: 3109166a-7fbe-4bbf-75dc-08d61c4aaa3e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0759;
x-ms-traffictypediagnostic: CY4PR21MB0759:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0759EF3E5C397F5D3783DA00FB1E0@CY4PR21MB0759.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(95692535739014)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0759;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0759;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(39860400002)(366004)(189003)(199004)(2501003)(2900100001)(305945005)(7736002)(5250100002)(6436002)(5660300001)(53936002)(1076002)(86612001)(6512007)(2906002)(6116002)(3846002)(6666003)(6486002)(86362001)(97736004)(10090500001)(26005)(54906003)(256004)(106356001)(102836004)(25786009)(99286004)(105586002)(6506007)(446003)(478600001)(10290500003)(72206003)(11346002)(217873002)(66066001)(68736007)(107886003)(4326008)(76176011)(36756003)(486006)(2616005)(476003)(316002)(14454004)(186003)(110136005)(22452003)(8936002)(8676002)(81166006)(81156014)(39060400002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0759;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ndjc1MJ29B6g6DxjMjF/LqPUtDw3wT8A1IVwo2cBjhsQ40+zYF7dZTl762JSPhCzNcga/QMRqZLRaSamwynl73eAQkRTU63tT/sMf5eXMa7NYHSz2PR06/I9s9MlPfe7Iqw4Wowtfh50lJM5OltuwyrzrNy2p08oFsET+dSwJH/jyBpYxbpkkYiF8YnH6j6AtUa94ussbohWcACVe6dMeuQDtcpKFOl2AxxxeLcW+la0LkCaMejSAJWMNKUqC4E4e/W2SAvaVruyqBpfpbF817o2hyktteTAwDNONd2ShJAC8HoI6d93NzIJNjAWkSfAOAOgsyV++SVtKgHNO0pkRuUnRugJmtPbUCbv+Sn5UO4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3109166a-7fbe-4bbf-75dc-08d61c4aaa3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:08.3360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0759
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhouyang Jia <jiazhouyang09@gmail.com>

[ Upstream commit e95d7c6eb94c634852eaa5ff4caf3db05b5d2e86 ]

When dvb_register_adapter fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling dvb_register_adapter.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
[hans.verkuil@cisco.com: use pr_err and fix typo: adater -> adapter]
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/usb/tm6000/tm6000-dvb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/usb/tm6000/tm6000-dvb.c b/drivers/media/usb/tm60=
00/tm6000-dvb.c
index 095f5db1a790..4f317e2686e9 100644
--- a/drivers/media/usb/tm6000/tm6000-dvb.c
+++ b/drivers/media/usb/tm6000/tm6000-dvb.c
@@ -275,6 +275,11 @@ static int register_dvb(struct tm6000_core *dev)
=20
 	ret =3D dvb_register_adapter(&dvb->adapter, "Trident TVMaster 6000 DVB-T"=
,
 					THIS_MODULE, &dev->udev->dev, adapter_nr);
+	if (ret < 0) {
+		pr_err("tm6000: couldn't register the adapter!\n");
+		goto err;
+	}
+
 	dvb->adapter.priv =3D dev;
=20
 	if (dvb->frontend) {
--=20
2.17.1
