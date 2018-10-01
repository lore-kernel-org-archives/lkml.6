Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D68C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 329332083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="iMu1amTw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 329332083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729227AbeJAHOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:14:20 -0400
Received: from mail-eopbgr680139.outbound.protection.outlook.com ([40.107.68.139]:29328
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726819AbeJAHOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:14:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kBT5rmvYQinV+xtWxDnpiOhxZGi1/56ObOpJI1kkNE=;
 b=iMu1amTwkMrJxByaReSIhd+8Yzh2riCiuaOgkuuKhTngK9n1YuoSoAmkzOYZdXqHCvrL9dxnmvKjMyPFD6R4ORdkeR6mO6b6MVXS9OCfTmSOo07uiSoqcpBL2bXe/RhO5rUJ5SASghtAjc7mYDdvOBCG1JNkqrusBAWVzym+eEk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0824.namprd21.prod.outlook.com (10.173.192.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:39:05 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:39:05 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Julian Wiedmann <jwi@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 59/65] s390/qeth: don't dump past end of unknown
 HW header
Thread-Topic: [PATCH AUTOSEL 4.18 59/65] s390/qeth: don't dump past end of
 unknown HW header
Thread-Index: AQHUWR8Yz7AD0xOcuUmyqSIyGQU9Nw==
Date:   Mon, 1 Oct 2018 00:38:39 +0000
Message-ID: <20181001003754.146961-59-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0824;6:C9SKAorgyvcY/TEmchGrc2Rn2SMHGST9BR9X77i8Cvj5toxZ6cS4XpVwXPtPmNeq1+rdgGKAXJd8mfwKBIfQtQ57jROYLMsZO/njZ+fBvpaismahhf5ODI5ZxCzRE5vXU7e9aeoshYsg+cM/ynOE2O/OrgXamczneoeQukR1Zc3pIxnxl6GPCvN+FI4LThIdVQ2yFVSX/ch3wmv7sATosBnmPvd0rZa6VaT7rvs4EieUNEkv1jFPKitj4/ZgizZC83tUqgVmufcU5wlg+HS4611edLff28Bn6Kj/PaAYFGdRl9QzzuZQ4DmnOrdDiEQTMQeZya8nC4rdZKBfTYFyL1xItNfHBCBWNW/oJn0kiwb1QfvtZfl8WFkohhBAatlS5d5MPIyvEUenAazuxtE+DWQQ2kNl+A+JftGEkpYyPEBpUw3XALpW33IsG8S3IheUsHUfJ8iVVHhYOel6yh7lIQ==;5:9vnDNPfzfzgoVoI9ZGe+bsFI/5/2DDTY0oELX+K41MXjS5xKBkHlTxBamxAd/nKtrb/g5MjAhzurf1cTNw+/vGoW9XIO4Z4pGAr2kmmdhF4twjIWkY1YHDoRdoeVSPbF+4CVlraYGSmUPbF3iB6nR37UXGv2CHi51zxx7+qeezE=;7:zAiCkv0rqWxWD64Wm4ndFVgHYGoYCS/6ZlMZrePbfXKYD/oYl4qPcMbIlWef0rZfc/zhNYOIyz7+iNiWnxrs3QbQNZqhIccFxaaF0KV53S3Zx0fULOQm0a+rZbuVaifFCwP0Z9eMvMGoinOEvBDHAFRN+DUd0+RMDZ0Nav8oh1dkOO1GwFZ+7Yx/ui9Pdhi+aK/sWKH0Zj1aDpfjuzlTiCBjiwx8im44Txdag2h67hs3P5/8TvXBa+N/pHCl4THO
x-ms-office365-filtering-correlation-id: aa82cdd9-e686-4955-6e83-08d627364add
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0824;
x-ms-traffictypediagnostic: CY4PR21MB0824:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB08249B1F7A4571417F7ED213FBEF0@CY4PR21MB0824.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(104084551191319)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0824;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0824;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(396003)(376002)(136003)(189003)(199004)(256004)(99286004)(86612001)(22452003)(2906002)(25786009)(2900100001)(8936002)(14454004)(5250100002)(36756003)(10290500003)(76176011)(2501003)(478600001)(316002)(68736007)(8676002)(72206003)(305945005)(81156014)(6506007)(110136005)(54906003)(7736002)(10090500001)(81166006)(107886003)(66066001)(486006)(86362001)(575784001)(6486002)(105586002)(11346002)(476003)(446003)(2616005)(53936002)(4326008)(1076002)(6512007)(217873002)(6116002)(3846002)(6436002)(97736004)(34290500001)(102836004)(6666003)(5660300001)(14444005)(26005)(71200400001)(71190400001)(186003)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0824;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: y8t6TvmpXvEuDgVUSMbw1k9dzCAh1vxkE9QzSKgrudn0Pv5UbL5pgW9BB8de1AInlER2h0CEp0vhL/oIJ9D4XFNO2dTQtZuww031iISMfXh4isl/qJAdNTObNXw9duVR5fviduX27utadmXxpfZ6G5hiyOT4to8nmID5M0tg3uoej7hlP+T/eO0vEUy1WxUBKSQ+E8SPklDZ9H+cUljmZmecmCVQU5ipHM4t16pBUSN8biq/6LSOtLEhnEWZN//vXl0ARixZ+6jLw6BfUDrXOOCeF/ltbGOlKjEbA6XoQG79tdTRbZnfuVD9jbtIaP0Fl2BWD8Cz7hbHnrFd4P1EOeB1wi/mnzRJLBZTKI8QKHc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa82cdd9-e686-4955-6e83-08d627364add
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:39.7231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0824
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
index 2487f0aeb165..3bef60ae0480 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -425,7 +425,7 @@ static int qeth_l2_process_inbound_buffer(struct qeth_c=
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
index 5905dc63e256..3ea840542767 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1390,7 +1390,7 @@ static int qeth_l3_process_inbound_buffer(struct qeth=
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
