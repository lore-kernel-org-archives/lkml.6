Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB069C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB3F2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="lH3FWAcs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AB3F2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730560AbeIGFSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:18:04 -0400
Received: from mail-by2nam01on0136.outbound.protection.outlook.com ([104.47.34.136]:26290
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729273AbeIGFSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Edf9HNtILqEJL0WSi60LQUB5VithkPXSlwSqJrodkA=;
 b=lH3FWAcseCo3+1G18pgKpSVZxbpmTKhckxSRxbskONc+igcGY9x/wbQ6wUxG4F5OHmsfLiNhUTItmu/9qck0788EfJAOl53gb+Tv9oLoR4qc4FxkKVkZ2o8Dl5Zpq91zuvhTkTjlu8ffGnhjrQp8AFoaWbaVIEsNgAOqTXEwfas=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0757.namprd21.prod.outlook.com (10.173.192.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1143.1; Fri, 7 Sep 2018 00:39:02 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:39:02 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Oder Chiou <oder_chiou@realtek.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 45/67] ASoC: rt5514: Fix the issue of the delay
 volume applied
Thread-Topic: [PATCH AUTOSEL 4.14 45/67] ASoC: rt5514: Fix the issue of the
 delay volume applied
Thread-Index: AQHURkMEgdVG8qgLeUiw+xhOeGaisw==
Date:   Fri, 7 Sep 2018 00:37:55 +0000
Message-ID: <20180907003716.57737-45-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0757;6:khV0QiYkEoNBRRSmlOtLce4HW2IiKH9cXzrG+Kwwmha0eecunX+XTcfqoIQSq6AUx0Clg+2V5s9LCohwdIONPako2zwTKxm0VqKwrJAvAMxE28lXTwxB8J+a/f8m9XVHDCUfPB7UCiRlfouV1MR/i6jnvfnSgBR1/woqvQkrjIwhau0GVLZ/0MvTd/t6Wg0ulMvnRpaueC3tA9GSAR9415aU2EWwlPUI2J9np5s7RRKqTegLuaVIiLXmv39feqwUotuF0RjO/oKWzx6tekytbSEA0lKFSJgz0UWc3gjKOoApiCIJExeO1ulYph5Oc+6fIN2xWpfQwLZ8r+tsgPQbG1irnJQp3/Jz+ohDHu2fXQQH1sGYneZbNXZPqhvZa2hvzz+6Rh70kq4dz7m0THyJ1ogUwr9VRiUDrTiGpcydvYu4c0RMuP29LxHtZtmOOzNNA3SB28Ol6n29Pi8XnjFB8w==;5:NzpbQKXLm1ikseoHQ/1T+3otQga22f80FjKcrera9wTlOICQapNAhuW/VMaZMBcrzb9R9MZVObCdgAmoBuijjJFiU1hq0HAzICx7RSB0FQrTTPDj1YyXWZ76UbgE/L2ZeuXyv/+3HN92NVB07osBN+Q3TtONefQ2hdbkVzzuOto=;7:mOyAUEQUIygTxDqrubxxJx5bTEZ3lJlE5XRyeNX0nwXwnR2JIJfTNmnehycnu/7ZDegBYnIxokb4mA/jsahcqSxSWwDS+YUzIWI49qIJNvANOgH6OQB94xnUn5qwV12UN6+3/iKvDQ3iXa7bNO23h9X0QfjlhIdXjxz6Y+M2hsJIJG/NCRz0jfs0blUR3EsltXP6zXO/TmXYjL8MsQGTTpjmfzCzvoiYq1d9cVUmLnuwlemspGuhYpBI55Yawffb
x-ms-office365-filtering-correlation-id: 8be64037-eaac-4f52-7954-08d6145a4ebb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0757;
x-ms-traffictypediagnostic: CY4PR21MB0757:
x-microsoft-antispam-prvs: <CY4PR21MB07576435BDE93EBDC0ACC198FB000@CY4PR21MB0757.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0757;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0757;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(8936002)(3846002)(81166006)(86612001)(6666003)(5250100002)(81156014)(486006)(99286004)(6486002)(106356001)(10290500003)(107886003)(256004)(26005)(11346002)(14454004)(446003)(76176011)(6346003)(5660300001)(10090500001)(110136005)(2616005)(66066001)(186003)(476003)(72206003)(2501003)(54906003)(575784001)(316002)(6436002)(86362001)(97736004)(53936002)(22452003)(6506007)(102836004)(8676002)(6512007)(2900100001)(68736007)(305945005)(7736002)(217873002)(6116002)(1076002)(25786009)(2906002)(36756003)(4326008)(105586002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0757;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: MrOQCbixrnU0r0QrNhgfO3CJv8PRGJeZEney8vT3vu5D5vNBNfJHpzABDU6SijjqyMKhvz/tIJ2QfCSQA+Fb+5RDgAHrFV/AmXMEfflaAeoj1eBqisTbJTrDSJ6s8+sj8Z143V8/OYWkEtwLUfQslLJ8bMkb6EeRab0oibd91jW0jz9StetmF3hEqiaoqf/cxsBR140KSJeLvf9RGhh4isWj+Yx7HsCnnyxsE48wgQ64uRkmS44fDz4l+5rh3T9LRlhSW0ePWdsx3QuGBRwO90ZC9JF1nUnEszVc60MP2WtRxtJXW9VSDNJ/3Bxf5D/xyVpDY8lTTHjMr2gelFHhI7UCGzExkeq23psrhMMWO7s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be64037-eaac-4f52-7954-08d6145a4ebb
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:55.0176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0757
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oder Chiou <oder_chiou@realtek.com>

[ Upstream commit d96f8bd28cd0bae3e6702ae90df593628ef6906f ]

The patch fixes the issue of the delay volume applied.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/soc/codecs/rt5514.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index e52e68b56238..1bfc8db1826a 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -64,8 +64,8 @@ static const struct reg_sequence rt5514_patch[] =3D {
 	{RT5514_ANA_CTRL_LDO10,		0x00028604},
 	{RT5514_ANA_CTRL_ADCFED,	0x00000800},
 	{RT5514_ASRC_IN_CTRL1,		0x00000003},
-	{RT5514_DOWNFILTER0_CTRL3,	0x10000362},
-	{RT5514_DOWNFILTER1_CTRL3,	0x10000362},
+	{RT5514_DOWNFILTER0_CTRL3,	0x10000352},
+	{RT5514_DOWNFILTER1_CTRL3,	0x10000352},
 };
=20
 static const struct reg_default rt5514_reg[] =3D {
@@ -92,10 +92,10 @@ static const struct reg_default rt5514_reg[] =3D {
 	{RT5514_ASRC_IN_CTRL1,		0x00000003},
 	{RT5514_DOWNFILTER0_CTRL1,	0x00020c2f},
 	{RT5514_DOWNFILTER0_CTRL2,	0x00020c2f},
-	{RT5514_DOWNFILTER0_CTRL3,	0x10000362},
+	{RT5514_DOWNFILTER0_CTRL3,	0x10000352},
 	{RT5514_DOWNFILTER1_CTRL1,	0x00020c2f},
 	{RT5514_DOWNFILTER1_CTRL2,	0x00020c2f},
-	{RT5514_DOWNFILTER1_CTRL3,	0x10000362},
+	{RT5514_DOWNFILTER1_CTRL3,	0x10000352},
 	{RT5514_ANA_CTRL_LDO10,		0x00028604},
 	{RT5514_ANA_CTRL_LDO18_16,	0x02000345},
 	{RT5514_ANA_CTRL_ADC12,		0x0000a2a8},
--=20
2.17.1
