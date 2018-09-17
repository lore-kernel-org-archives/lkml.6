Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EF7ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB43208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Cq6Bu4RP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBB43208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730898AbeIQIbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:31:44 -0400
Received: from mail-by2nam01on0102.outbound.protection.outlook.com ([104.47.34.102]:24891
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728988AbeIQIbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0HbEgGVFCJnLepIvhxB4MjJQmW9+VsC6il810kNeN4=;
 b=Cq6Bu4RPNB4Ibw3N7vCfvaO2e/dimX0uQzhY4JY2i307OgXUdjx36kM9r47vzAZO9jELBF3M9N16jfK0HUFhOwNBktDrfGnxiucMDsZuUlK0ul4TxNbC1NnpN7GNrH+ihQxcS5EEU5XIK0yclssY9rJoVjJWvrON8lkcbX7O0eE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0757.namprd21.prod.outlook.com (10.173.192.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1164.6; Mon, 17 Sep 2018 03:06:19 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:06:19 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 37/57] media: tm6000: add error handling for
 dvb_register_adapter
Thread-Topic: [PATCH AUTOSEL 4.9 37/57] media: tm6000: add error handling for
 dvb_register_adapter
Thread-Index: AQHUTjMYtL+oeWzPcEiafsp7rC50mA==
Date:   Mon, 17 Sep 2018 03:04:06 +0000
Message-ID: <20180917030340.378-37-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0757;6:mhDT3XNiLTtCOGb2eKhh3A0msi6F7Ir/jnnTw9DSzvzAVNW6nT2PKq1yy3dYvSO0sZGT+CJuPYBD5fvMDMUay55OFGe665FGC2myyATOSGMMHB2T77xOAcitRcnhP3iRHp2RFgWCbI3an10aqSO/U5U/+t92SGbPoa4y3phXKUrKjy/HdRkYa0gUTpRBPfcTualKkbeAOgvCymcFdsBGH9r84ZrHbTlL2CdSNzMo1lLLafsRBS3BS9akJtMEoQeDs3II/E2exRkl2fNtScC327ZK24D4Cesp8WdVj1MHVH562qQ2OOwiEsWMsu9e7MMkmqz6AzKqxUgRpIwN9ZOQjblv+S1yRJYkHt+XOGxg3Lkexe86P03Bj/jZ8KkbzusNRdKNMymr4kGtSoukoWnrvaBjWruvbDUsuLksNKJb9SjcBFgrvRGFrR2fzZVwHBIrWgxVVxP9qridxtnylRsNYA==;5:6rzlrBAhMU7ntNk54HPahXqMmuNJVr44gV2axqrlqRvjwq6CKkVyf1qTfOCA3MBdqQt146BEJHhH0uj+1xOoCQK9DY9TFD0mQ/+eXcugUf5+7f+0EeDwRlwtk/fB9/oCQBF4s67etrIy4kP6aC/tJQT+xQgtPqLIOH1wKHHwJDM=;7:p6omOw7v4e+qVFJoi82msY2iaYS+kV47A3QMgPhS4FeWevfKfiRAlOWiinfDuYKeWD/lOouyXaycDTUv0sGDqYBDc3m6nx3ZXB7qWY8c9+bKImKo+IJ46mlqnmaO/m9gGkMMG5XW0hQct1khwilI1IrhmKy74kyerpjWuwmlTrT9po3EDfvPDd0ACKo+OJ9qLxv5KYG4jzaOHR9YhbWKtgofIBvfiC33KIB72C5Te4uO7n4CmA8TzavEqN+EY1GQ
x-ms-office365-filtering-correlation-id: 4e291a06-9a94-44bf-d491-08d61c4a8a9d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0757;
x-ms-traffictypediagnostic: CY4PR21MB0757:
x-microsoft-antispam-prvs: <CY4PR21MB075708779A75F7AB91C35805FB1E0@CY4PR21MB0757.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(95692535739014)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0757;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0757;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(346002)(376002)(396003)(189003)(199004)(8936002)(68736007)(476003)(10290500003)(446003)(53936002)(11346002)(6512007)(486006)(86612001)(6436002)(1076002)(256004)(6486002)(2616005)(81156014)(81166006)(7736002)(8676002)(217873002)(478600001)(305945005)(3846002)(6116002)(86362001)(4326008)(106356001)(66066001)(186003)(36756003)(99286004)(76176011)(102836004)(107886003)(26005)(2906002)(5660300001)(110136005)(54906003)(10090500001)(22452003)(72206003)(2900100001)(316002)(14454004)(97736004)(105586002)(6506007)(25786009)(6346003)(6666003)(5250100002)(39060400002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0757;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: HfyWsL9pbCMc+Cz6CRrvT4+wz/Ba4WDNbVz4kKeCCj2S5DRYZ6sujQ3M/QIgxNbinziOFBovjDiBR1nzDPnn2qh2ubo/z/tra2qT9WzaMP5rJKXs3njJoeD4vrRGdDoOFtGCxlOW1JFMYW3I4Dswjk1Lv812ju4BVgWNRiRS3TmyOs8CA5AdWbEhaOVGoCXlfziHIKnKey9hXzE2NYEk+8juVTPr235dowWRdpVJBVbDTI6+tfgeq6HctO5EcMNlP6CZfWPxnJ9S1IVere3p6fi0lmal1lDqMeis4VLECej4hvWC2MFtoiU5+vFQXGXvo8RmFVE3ZANcydM5yeVqveE9OfiigelTye1FVTrHF3Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e291a06-9a94-44bf-d491-08d61c4a8a9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:04:06.1334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0757
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
index 0426b210383b..ee88ae83230c 100644
--- a/drivers/media/usb/tm6000/tm6000-dvb.c
+++ b/drivers/media/usb/tm6000/tm6000-dvb.c
@@ -273,6 +273,11 @@ static int register_dvb(struct tm6000_core *dev)
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
