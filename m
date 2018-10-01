Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF674C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82F9020666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Fiksn6Th"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82F9020666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbeJAHPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:15:30 -0400
Received: from mail-by2nam03on0114.outbound.protection.outlook.com ([104.47.42.114]:28569
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728942AbeJAHP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:15:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjzAildGQZDty8EJd+2BJl+wbduIUqkrhQu4tOdv52Y=;
 b=Fiksn6Th6OXFJJP3DuF9gZVTpsK68hGRJi4TTMMWhgeOGrCcWM/qfbLrbyq4O/1JalEDELnWCMn+or4kSz4z8W5iaRJaGVxm14Iyl15sWpqrHcFbW6K48Q2GMLC6+9W6bxDMoBgdYKZcbQ6h6f260KUsE/SO80JogcKLamEk7NU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:40:19 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:40:19 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Julian Wiedmann <jwi@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 33/37] s390/qeth: don't dump past end of unknown
 HW header
Thread-Topic: [PATCH AUTOSEL 4.14 33/37] s390/qeth: don't dump past end of
 unknown HW header
Thread-Index: AQHUWR8tFW0v63gjhUC/iHsrsuvy7w==
Date:   Mon, 1 Oct 2018 00:39:13 +0000
Message-ID: <20181001003850.147107-33-alexander.levin@microsoft.com>
References: <20181001003850.147107-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003850.147107-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:Ei+wAIMlC1qqxKdrM00qtUJ5p+BFkz05zwUJ9mpdgBq0jF6vHq+azPm05gzfPvZqGnhE0r7EGzo8A2KM7Lo6+ieo+YFNOdOCsJENdm1NFrtzW+wrNcW3cmSpqZ/UHwlTaKHgJGvCpNlPc51Au7mBsIfxXneipUf8L991Ig0u1ce5PNLnvGS3YEo8kLNB2yjWtWfC0vi5+hHWpnGo18/oqFwQd/1234IuMF1ccYoM6iZwW9J2si3te6zanbE9zRkJS2HIcC3hCL4PfqPTBWUtXN4Xfy4MZUMSiL0Lb7WLLU/iZIUlNQw6pF+8jDCOGCnMMeaxBIZ167MSJDPFl6tQhfpFUHDjC59JkysAzCQ66vUGW/LQAsiVZf4LsV4jFqYE/gF/agYXDxzsG6P6p2Pi993RT7Wxnr8ndDxyxcMmj3LA90a+rogtk9MNvt+sApEaIbZxZap66qJaoZBckw9bDA==;5:hhhhRZS0zdSoMQSwNe9YsJdJl6v9RTWLxvhOwfCBhGvcKG2TyomgtavcWwKW/cryjR/qcsOJdPVeoCGwlorbY86oweDuXhqmkCuTUON8FK9pjRyvj6q7s2AS2JJY4vEWG0NgW4ZU38ky7r7Z9nIo/mOWh70r7VEcVmX3PDmhW1U=;7:EYu8QU0vgUQ4rhagbgSzzbndeRmL0ktD+SXf3+3AEkzid1A5PbK21rCz1RyIk3c+sGIqQJ0xXj5W21YXysfO/J8rv0XxfOf92sevlnj5pOLRt0JAtcjYUFOnZDsfD2MvncTMqdQamKOVR9K23r0DszKe+PXOZmeSO31+PpSKVcgCw/ilVGxyFuOcqglxexFl6XuKPGmjPnoZdA1Jxt2gwokhD8CiU6Lfr8mf9kQ8IsaeomoysEHq5ZiYxtokUuRo
x-ms-office365-filtering-correlation-id: e5f72452-fb20-4163-2d72-08d6273676ef
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
x-microsoft-antispam-prvs: <CY4PR21MB01209512E6FF7DB3BAA73F2BFBEF0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(104084551191319)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(346002)(39860400002)(376002)(199004)(189003)(86362001)(8936002)(6436002)(99286004)(6512007)(305945005)(76176011)(2616005)(68736007)(53936002)(34290500001)(186003)(10090500001)(105586002)(106356001)(86612001)(6486002)(81156014)(81166006)(8676002)(71200400001)(36756003)(54906003)(5250100002)(2501003)(26005)(110136005)(97736004)(6346003)(6116002)(3846002)(1076002)(5660300001)(102836004)(71190400001)(107886003)(2906002)(486006)(6506007)(2900100001)(4326008)(6666003)(66066001)(446003)(11346002)(14454004)(7736002)(476003)(25786009)(14444005)(256004)(478600001)(72206003)(10290500003)(316002)(22452003)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: EjMoAiiSUdHlaj4v1XDlClLSkKPEmb9L1CaprMnsG4GTfmNPkKGIpWRupAohF4MPt7mMLnHEM70o56iWHd1nmIXbuueiZPzpABgqjKjsUvgykbdxWJ3LHmoSpZjigzLv1lHoCFerFW7+TehM0OSu0OJUwSQpYYLoXnI9jNlaHJe9lLEiLIqAcb33D0/wVuUkVsstNuVKOMrYx0vaUjl6fqd4StMUU7kzRyJYIMsaHshNie5zN0ATBmOgiXQ4IatxKOjqjm/18S/m/sbpUPvkeDmz/T7CO9hUqDtL4X0bcj7wrxvdeXb+deEoOoGIbkWqpJyVWVVXnadSOfWi2pt+iVrFZJDHl2+Br2PLW88LWLU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f72452-fb20-4163-2d72-08d6273676ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:39:13.5681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julian Wiedmann <jwi@linux.ibm.com>

[ Upstream commit 0ac1487c4b2de383b91ecad1be561b8f7a2c15f4 ]

For inbound data with an unsupported HW header format, only dump the
actual HW header. We have no idea how much payload follows it, and what
it contains. Worst case, we dump past the end of the Inbound Buffer and
access whatever is located next in memory.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/s390/net/qeth_l2_main.c | 2 +-
 drivers/s390/net/qeth_l3_main.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_mai=
n.c
index 521293b1f4fa..11ae67842edf 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -484,7 +484,7 @@ static int qeth_l2_process_inbound_buffer(struct qeth_c=
ard *card,
 		default:
 			dev_kfree_skb_any(skb);
 			QETH_CARD_TEXT(card, 3, "inbunkno");
-			QETH_DBF_HEX(CTRL, 3, hdr, QETH_DBF_CTRL_LEN);
+			QETH_DBF_HEX(CTRL, 3, hdr, sizeof(*hdr));
 			continue;
 		}
 		work_done++;
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_mai=
n.c
index 1c62cbbaa66f..cd73172bff47 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1793,7 +1793,7 @@ static int qeth_l3_process_inbound_buffer(struct qeth=
_card *card,
 		default:
 			dev_kfree_skb_any(skb);
 			QETH_CARD_TEXT(card, 3, "inbunkno");
-			QETH_DBF_HEX(CTRL, 3, hdr, QETH_DBF_CTRL_LEN);
+			QETH_DBF_HEX(CTRL, 3, hdr, sizeof(*hdr));
 			continue;
 		}
 		work_done++;
--=20
2.17.1
