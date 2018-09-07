Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7143AC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 166212083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="MNq+hTo1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 166212083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbeIGFPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:15:46 -0400
Received: from mail-sn1nam02on0135.outbound.protection.outlook.com ([104.47.36.135]:30237
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726596AbeIGFPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ghoh32rku5DFQ99FT3FgasNN111B4Tw7IA2KwACxKuA=;
 b=MNq+hTo1UyF/O3dkJWjQOlrh2c529MBHc1xjXi+NNpRbMWzWEAFiPCMgFVE2fgmA7wafgJ/7qSTtNYj0yNZD8kKIevUOm1aIK5H6T6CAQFiy1eNaZTS6qP1qRUkXw42VQ2jU9o/DaSrhJ2bzLgWmluaOFgLCom/DxFCfoj/7oCc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0118.namprd21.prod.outlook.com (10.173.189.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Fri, 7 Sep 2018 00:37:34 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:37:34 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Bhushan Shah <bshah@kde.org>, Brian Masney <masneyb@onstation.org>,
        Andy Gross <andy.gross@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 71/88] ARM: dts: qcom: msm8974-hammerhead:
 increase load on l20 for sdhci
Thread-Topic: [PATCH AUTOSEL 4.18 71/88] ARM: dts: qcom: msm8974-hammerhead:
 increase load on l20 for sdhci
Thread-Index: AQHURkLZ8zp1mEN2iUeKDMP2y54Sug==
Date:   Fri, 7 Sep 2018 00:36:42 +0000
Message-ID: <20180907003547.57567-71-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0118;6:y6Iji3Cp058S4asXSa7YUxoYxIyHBXtr6D81VdNJ7vhxU3xtTZWsnAyZt60p2/0OQEwVqoRrjpAemxe/1Iz6DmEF7DJtmPDoK0AZI/iMEcS2nqLDUNe0BQvM4tlMU8Wil4CmMDGfjc76l5ZmOXnZYZ7Ge5xgcz2VsTJ3EurZyQQHo3Gl2gfaOeNWEkJMGaohGeplivh8atEA2c4GQzwDntH8za0YOYWlcTFcgn2uYUL2qw6OOViy16F4FgQhgMqBtD/ZSIGlq/z8KvTk5NpI+7xw7pnTUiHvCCDRFXetP3Wlzjdcs6DQInMGDLwtUpwzAad6tJI/9S0aPV+7KQwvyhle4iewCEGexpNRCZE+Bhwf/zsTl5uVbHzEvI2OR4HGFxKr8nYjF6DuIMIF3P/KhvCgkdoYkQr/Lkmy+elsGxx5Um0enIwcrRpfyLBuxqIVOU4xE+T3EIoslOJRvXl+yQ==;5:oGs1zKUm3nGTGsYoj8HoC5VHQiqWhjmgzkpTBeSJTUEYYJ04cu0DQNwbOKmIAlrwCo4j8/Izew18gSXmveU3M7IhXJXV0SY6B+GMhxur+fADMUTYmbf94V2W+mi3Y9b1V5rTqKXZYsfyS+7bMvdHUn8TkkeCjWBY9v9/aM8Se1U=;7:M2bXXgKosrYvN9EuMMm9vJQots1cILfu2Sk7l9kwQ6Q4ZX73fnTe+GQ5HZ/0Rduzue6ybp7/onSgkWKfDSctWuY3Yyyp9GYCF2vCassO8ioe+s6ZQG72ktPu7RsvRDmQL1qx7AATHPn03CB9Pja8TB/G+oH7qdPdrTGDs1RNnJ2mS0DBzwP+xBTWzojjV6i0y3VFrsJLGh2uAtDHSu9SGJrU4VDjnhwoXPEKw3TU/cA/LitHnc8pvBztabhq5iBT
x-ms-office365-filtering-correlation-id: 8a5b8410-8430-4957-beff-08d6145a1a96
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0118;
x-ms-traffictypediagnostic: CY4PR21MB0118:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB011833390FD84AD794C75F98FB000@CY4PR21MB0118.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0118;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0118;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39860400002)(136003)(366004)(189003)(199004)(97736004)(2900100001)(53936002)(316002)(86612001)(25786009)(86362001)(575784001)(2906002)(6512007)(68736007)(110136005)(54906003)(107886003)(4326008)(10290500003)(14454004)(81156014)(81166006)(66066001)(8936002)(8676002)(478600001)(6116002)(3846002)(72206003)(305945005)(7736002)(1076002)(106356001)(105586002)(36756003)(99286004)(186003)(26005)(5250100002)(14444005)(446003)(6666003)(256004)(217873002)(10090500001)(76176011)(5660300001)(6436002)(11346002)(6486002)(6506007)(102836004)(2501003)(22452003)(476003)(486006)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0118;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Jy2QXqgybiQW9Po3xPEd5O5TWTudgsYlbcwGOiFMNLqdekYa5O/XLbtZGy7aKX+U3jwH5QNSINJUpBQSTWetS+XurAVoYEAKsQNdWGmRCsceicwwMieAfSBVmEtXzdypfna3Udgk9QUbXtjtyDHpaYNnkI8LK+q5ByZkrwmmUXTRwxAk2ZyPG20Ad9TroAidzIVSVUzffW7pWyCRy2Fe2vVnvYNNQkKAtvVfrehW2p0p5F02Z4ihBUGZ8zmVBY01L3ryu+mCn3539WcOw2IKqZ9J2XNNKkx7U1mxJZVCs3y1f3Ml4pI2f6BiefSObrl6ZSDO/Mv1tjSovk/iKD+PLRVCFBPJj2K4A2XGztd0yrk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5b8410-8430-4957-beff-08d6145a1a96
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:42.4723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhushan Shah <bshah@kde.org>

[ Upstream commit 03864e57770a9541e7ff3990bacf2d9a2fffcd5d ]

The kernel would not boot on the hammerhead hardware due to the
following error:

mmc0: Timeout waiting for hardware interrupt.
mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SDHCI REGISTER DUMP =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
mmc0: sdhci: Sys addr:  0x00000200 | Version:  0x00003802
mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000200
mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000023
mmc0: sdhci: Present:   0x03e80000 | Host ctl: 0x00000034
mmc0: sdhci: Power:     0x00000001 | Blk gap:  0x00000000
mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
mmc0: sdhci: Timeout:   0x0000000e | Int stat: 0x00000000
mmc0: sdhci: Int enab:  0x02ff900b | Sig enab: 0x02ff100b
mmc0: sdhci: AC12 err:  0x00000000 | Slot int: 0x00000000
mmc0: sdhci: Caps:      0x642dc8b2 | Caps_1:   0x00008007
mmc0: sdhci: Cmd:       0x00000c1b | Max curr: 0x00000000
mmc0: sdhci: Resp[0]:   0x00000c00 | Resp[1]:  0x00000000
mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
mmc0: sdhci: Host ctl2: 0x00000008
mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x70040220
mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
mmc0: Card stuck in wrong state! mmcblk0 card_busy_detect status: 0xe00
mmc0: cache flush error -110
mmc0: Reset 0x1 never completed.

This patch increases the load on l20 to 0.2 amps for the sdhci
and allows the device to boot normally.

Signed-off-by: Bhushan Shah <bshah@kde.org>
Signed-off-by: Brian Masney <masneyb@onstation.org>
Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Tested-by: Brian Masney <masneyb@onstation.org>
Signed-off-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/arc=
h/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
index 4dc0b347b1ee..c2dc9d09484a 100644
--- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
@@ -189,6 +189,8 @@
 						regulator-max-microvolt =3D <2950000>;
=20
 						regulator-boot-on;
+						regulator-system-load =3D <200000>;
+						regulator-allow-set-load;
 					};
=20
 					l21 {
--=20
2.17.1
