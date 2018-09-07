Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66FEC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7840B2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LRIhg1yy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7840B2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730936AbeIGFTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:19:33 -0400
Received: from mail-cys01nam02on0134.outbound.protection.outlook.com ([104.47.37.134]:20941
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728144AbeIGFTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:19:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2//vgmNU+CvuYTovZKA0aMDMs0bAi/Rxt/0x3xg66k=;
 b=LRIhg1yySAnV8sPk5x9u8bKko/vRVjO907ZBzQ9CWJTdm6AUCpr6w2W7Flh88rfhjmYxdrzXFVfc3nFcrCAnokQ6TWIhQemBaJANvAx7+Kqtza7tTdfkcGi9kG8mIjlMXmTLX06H53gPq8MQ+d0ilPevAvXBp203K/gWcTHAuhE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0694.namprd21.prod.outlook.com (10.175.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:41:21 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:41:21 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Bhushan Shah <bshah@kde.org>, Brian Masney <masneyb@onstation.org>,
        Andy Gross <andy.gross@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 36/43] ARM: dts: qcom: msm8974-hammerhead:
 increase load on l20 for sdhci
Thread-Topic: [PATCH AUTOSEL 4.9 36/43] ARM: dts: qcom: msm8974-hammerhead:
 increase load on l20 for sdhci
Thread-Index: AQHURkMhSyHWHVnfyU2QjoWbstxvkA==
Date:   Fri, 7 Sep 2018 00:38:43 +0000
Message-ID: <20180907003816.57852-36-alexander.levin@microsoft.com>
References: <20180907003816.57852-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003816.57852-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0694;6:hLCb88Ru3U4QX6EeCTjgmbXvY+jsMV2gloeu7Hme2CpR1/zsDCupQVkEoBTWeScE31AG7+mKElWD4UPlNs9Dz06P5GQYqB2U9/pebfiOcf/D3JzGhPobZaVn8kn27LhMqIk4mq6IY0Soft/WyKCs2SyxNmz/3H2VbLVpUuNknQ6lHXP2EPKh4eYRgUaPH4XOMW4Af1v6p9Rr01MuGdxevK6Q1+KWlyigG6oLSIvKKU+Oq/6+I3lT8gKPhWg5EZEo1o9YKey6cl7kzKlVQ6WJPDqd0SqOdfnGk4mTUrUH+pWGuvuApolx1QHnM6/BBOSC+yLeVyWC0r2v3BFMO3+9WSUsGg4mGVSZUE1cKj8g9QqMZhOyeogIQgt5fZp3gCXWV7qSSigSKRtwzxfUqrMfy7TFjiMtAFPW4ebwFkmRN3WUp4eA+gWBnjqFtqkEVHXZJJJ2RdALkcFrcr5W9rn80g==;5:cfJndxTgKCgsO2muN12bNcZZHvl+oL91FYjs/yL1YfuZ0H+3RtBldyYUJtmO8mMCXLM7dBnb1L2EKrkJECIeHquERFihGRB7ojFwC4uTo5lX0csyM7PYwMyvrhKu2TFMSYJyaLNEorS7ySClqqpCDT1A75D52gYqr9OsH4Mx7/U=;7:YmrxbDbMPoLCnjYJkocM4YiSun/aa/hao4TorJRuQVpDvfLZvNQM67EjL5nCz8pmHBk4VGu1c/jXr7L/OkraEh01kszBNCMgnr80N0udJ1zJcZGhxGhnqXqhFakSIRZANKNVCXdEBBMC2uIp7xUSxP/gk0r7p7mR1ormYofk5p8UqaVNsrlnySqcr/Spe+r0qUuwEyYUL7UKlao4xxgvWphWbLhU4uN3UxV0BeJyvF2KRWquZdMNdBJl6Jrt8mF+
x-ms-office365-filtering-correlation-id: 8e768eea-10e7-4b19-bb73-08d6145aa1c3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0694;
x-ms-traffictypediagnostic: CY4PR21MB0694:
x-microsoft-antispam-prvs: <CY4PR21MB0694ED6D15F95BFC07230C2DFB000@CY4PR21MB0694.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0694;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0694;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(366004)(136003)(346002)(189003)(199004)(2906002)(575784001)(186003)(86362001)(6666003)(110136005)(107886003)(54906003)(36756003)(25786009)(4326008)(256004)(14444005)(2616005)(6506007)(6486002)(6346003)(6436002)(6512007)(446003)(476003)(11346002)(486006)(86612001)(2900100001)(5660300001)(102836004)(26005)(66066001)(53936002)(68736007)(7736002)(81166006)(81156014)(8676002)(10090500001)(8936002)(6116002)(3846002)(99286004)(105586002)(76176011)(106356001)(5250100002)(22452003)(14454004)(316002)(1076002)(2501003)(305945005)(217873002)(97736004)(10290500003)(72206003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0694;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 14bAIaSsdZopR+I6mlNqET8NmB2bO2jYLll/X50Fc7IVR9yKbtlc2LhaUxsOexQyvsH/eFffiChp0S7P954mSqBjHt9GN7cFXCZIyzc3drFimKWq+0Y4i8283j7L03I6Bc9WnYJUEdh7Yjd2fm5Hz0Oo4uPm6Jn4CpsvjR7SYZpnRhORncszEi7uGPWw/F+3XVE7e/Xglg45091LnbJBzl0e2ks1pTB+cTYq8vyqSznF//uxE7HpMlYV/j++GCUuHitY5b1s3uL9f03NxR7hmKqgcfpoGp0yeuhDm42i5MwLNuhcHqV/al6f2QlM5i2AbylYpBUhtv3cdva7CE44Huj57NPzb5sPPQaMPZ0sbAo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e768eea-10e7-4b19-bb73-08d6145aa1c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:43.9333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0694
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
index c0fb4a698c56..386b93c06a8c 100644
--- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
@@ -188,6 +188,8 @@
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
