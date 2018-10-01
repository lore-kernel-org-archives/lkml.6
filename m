Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC931C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B7F2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EKUGJjaZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96B7F2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbeJAHUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:20:00 -0400
Received: from mail-by2nam03on0136.outbound.protection.outlook.com ([104.47.42.136]:2896
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729960AbeJAHQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:16:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Cd+xM8DFNIybrXkwQ0/XyeF2epE4lYG8OrqQ9wJ2Ek=;
 b=EKUGJjaZjfXwVv1X6UH+cvS4F92pn7WC0HxQP7E0W4tEyzqgdIRJ7E35LyPzpJGbTjFeDLilCa+EAYPt37ziNWYhvhQaY/zc3yI2WNZLvSi6F+dqEipRKoq7jw4/kjkQT7JI3jA4rsrg0PS9yzGaXRG8AeDjRau9zY5CL1y5feI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0165.namprd21.prod.outlook.com (10.173.192.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.5; Mon, 1 Oct 2018 00:40:42 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:40:42 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Julian Wiedmann <jwi@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 22/26] s390/qeth: don't dump past end of unknown
 HW header
Thread-Topic: [PATCH AUTOSEL 4.9 22/26] s390/qeth: don't dump past end of
 unknown HW header
Thread-Index: AQHUWR9iGx8EBdjP4USFveMUgs9oPw==
Date:   Mon, 1 Oct 2018 00:40:42 +0000
Message-ID: <20181001004026.147201-22-alexander.levin@microsoft.com>
References: <20181001004026.147201-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004026.147201-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0165;6:sUODQppoNMbGpu4WPullwI7San1P4o19lA5mWwif5jf0qzvVTrr/xsX8yEn7Lpoj4V1CdM/s6P7y6JfSVZTz4/K94coAXcg1J6UnwbhbK2D18lJw+N2sJR6hVbitKBC6POF7ERxqBr2MpnpMiCDw7qscelGsu+E+O5Ax0mZkFvn0XiAdU2jvy8krWoJUHaTFDw8ywght2eLMvegfCTfcICuluMP7UxSDF+atM1Hc+JM/oPrEOO7e3knIY5lZdmDxB7heFXIU40Yj4ihC4Y0dGJbVpMF7DkfENm3/s4vA2Fal8t9ClCLXPPEgt0o3cy7DwF6OkZOxfT+7ypQk1OMLGj+hAB+qQM9+zY14OzqyEpXi13ZbD/pwPm+O5ob/uCkKQTWVvScxEm4k2NXv0scU0m3Y6PUpxe5PBbf+97lqACiHM5TQyi93JrU+ikg7NUTJXSii96cYF+7KSAfKCQduqg==;5:01G14pnyKWpIXiRlxPDFR3n0MOtaS2jaBqnIHbUIv/L5PM3QP4WpL3iBoDCa7eksFgR1hISCtG2DNNCIOWNTNOWnObHJtlz3ic8kE6GnrNidbYBJZzyzvmEwWzUqKASZrk2jVOUzpOUrJGMPT8E0OlON4ECIt+NR0+WZWVvLmj8=;7:XcLC6XCcFaB7XYudxFOOtDmTP7Rwqj1Bczw0us1oSHStNxDH1+6oZYdS8Gl9qzvUwTVckJk7xjy7dFHF6ET1ZgGDWYFPnCCyknVlEtCXv8RQylofgp506Eogj7lpF8618mtw8SL+zsrzuZJMd44itfn4pnO80UckFDw/AwhYmIv+U1MMKgaCA6E35R3QFujAArZ1SomNfrKsrzyZlgLDGDWKUdMRTjzV3qirzQYawHQui/Vm19h5+9eitT8tuNWM
x-ms-office365-filtering-correlation-id: ecfcc9eb-2af4-484e-6e3b-08d6273684c3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0165;
x-ms-traffictypediagnostic: CY4PR21MB0165:
x-microsoft-antispam-prvs: <CY4PR21MB016539E5154E7316F4AF30A3FBEF0@CY4PR21MB0165.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(104084551191319)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0165;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0165;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(396003)(366004)(39860400002)(199004)(189003)(476003)(2616005)(256004)(217873002)(486006)(6486002)(1076002)(11346002)(446003)(86362001)(97736004)(2900100001)(3846002)(6116002)(2501003)(110136005)(478600001)(54906003)(2906002)(5250100002)(6436002)(8936002)(316002)(53936002)(14444005)(81166006)(81156014)(68736007)(5660300001)(99286004)(8676002)(10290500003)(26005)(6346003)(4326008)(86612001)(6506007)(305945005)(106356001)(7736002)(76176011)(6512007)(72206003)(102836004)(25786009)(105586002)(107886003)(186003)(14454004)(71200400001)(34290500001)(71190400001)(22452003)(36756003)(66066001)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0165;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 9BCzqegnTHMoDexSqPCUUtgGYXNj6C6f5BjH5U/Yl8PFEJaq73WtMezMdwuzcraeFLF3Ny8K8Eoh1/xZtajedkbc9xhwOOCzGvnqzYiJwQ5GGCmU0V2h4xd9VVfJn6vXB+Z0TT2v/lqeRK8h6HSwHALGsqt0FrxnRe5bQPQydwDRk/EoJa2fplYoUGJKwwJ5mLjI+zBBihNP4JqVuZ5U1EveLqM5Zvu65N5GZDVPpiplG9+yKPLn/xbpIcUMy7iGqmJE5ISfl6HEciToW+51p820zlRxPQQt4FJbDBXXg5/lqXNNhqHLyVg6eJR/6JyGi3suBh+0Smoe6H6SF4tGQcKPYoSqd7tcUR1eYU+cmaE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecfcc9eb-2af4-484e-6e3b-08d6273684c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:40:42.7780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0165
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
index e94e9579914e..58404e69aa4b 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -491,7 +491,7 @@ static int qeth_l2_process_inbound_buffer(struct qeth_c=
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
index 4ca161bdc696..efefe075557f 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1836,7 +1836,7 @@ static int qeth_l3_process_inbound_buffer(struct qeth=
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
