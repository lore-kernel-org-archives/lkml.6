Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F215C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB1D2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dY+b/KK6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDB1D2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbeIGFPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:15:11 -0400
Received: from mail-sn1nam01on0109.outbound.protection.outlook.com ([104.47.32.109]:39556
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729136AbeIGFPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UhswHcj2u1TRo6nJmvXLxGCDBRxj/LrEC5Z45T9G4U=;
 b=dY+b/KK6Z5o+YGidmkGf8jhMLaEeLrOm6aws0ThcoG+diUBwYOPKEqQyT9/G24vbng14IfnysFl/HtZtISfmOIqQSDWddFjKNpXdmC0BLH1q+zCSek3VlSzGoN1t8jxuIbac6V4ozc5kcg0xMV6Vme3+LJhdf5VUIDzhfOJ0mUs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:36:59 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:59 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Oder Chiou <oder_chiou@realtek.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 59/88] ASoC: rt5514: Fix the issue of the delay
 volume applied
Thread-Topic: [PATCH AUTOSEL 4.18 59/88] ASoC: rt5514: Fix the issue of the
 delay volume applied
Thread-Index: AQHURkLU10pvzoKVeEeUcJuCovye/g==
Date:   Fri, 7 Sep 2018 00:36:34 +0000
Message-ID: <20180907003547.57567-59-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:h8VTQgVB2GFHgAyW6zYhtn/7dzV0kUhW7RN35wy172tmBl2+c7xsMsGgQ7/5KI5XyuDs4hUdC9aliRbo9UTS1W2UsjKbcfvNI3OOAQYtS6z2NSFCPpbUie7r9htmxKI54SOC2cfH8KReGd2BMichrCXrf46B/syR0yWdyCO+blWRWGj1fYy+k/JEHIBkIfsH6zbYQFjKn7QvGcFFsKug5dB/SDqItHvtiK8Av4AlqeMcq5RbkgxFAzRCfnu9DQHI4ObyVnjsZ04H32T1rAR/PiU0fSYaV/VMMqTYq534A+7/dc1Jh1MN97R7q0F9URePYapqFJapI05yvnPidM1NALmRR+/AEK8dmJiWVdGB/lu3tBj6x8A3UwUmBBYX3ukxiLP+sGPvtAbV94V0Gz8vJTwAra/BnQC8+ylu7w+OcRe5R6KlGZkQV/hsiHZrafQBHJ3FD6nDhzWnUj20yVJ4cQ==;5:yUmPMh3INwbYyZLfp6wKwT1VLohrHSw2One9MZlMYlH4ybc2F3JL/FXWfLWk6/x+jBHqCO/UlBFAoWG7uwRLvmIr2iXI6IRwON9nGrZ0Bivn4Ds7pqeVUR0t6+94mSajnfqOmwZz7j1I8xzMK3GDG58IYEStwxJQpJBRSx5xgsA=;7:gXDnScqz07nM5seg+u0ZPWi/hwzTKYHO782EyhGqdTc2VHqR80zJng0QXkmqNkhnvF7AqBGWKZvAhZ1N8hvL026+SO743ZLC2xhsLagDqdvHUcLOnm6XkOoUqSwp4600Ck8SyKcEk0YtX1Xu5C5nuoBe3waUW4wTS1U9XnRia6ToawFvNfI0yEaVlQgSotbR+hR/9IPSHOpJa5XTP9vtIoi3MZzA2s4u3ApoqEU7yDDT/wWRFxSKDUhVyXh33Gvz
x-ms-office365-filtering-correlation-id: 1ef97966-0053-4129-b24c-08d6145a0590
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0469C1CBE3C6C19165A4AAE6FB000@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(136003)(376002)(199004)(189003)(25786009)(446003)(316002)(86612001)(54906003)(76176011)(86362001)(110136005)(256004)(6486002)(10090500001)(26005)(2900100001)(476003)(2616005)(102836004)(5250100002)(22452003)(186003)(6506007)(11346002)(53936002)(217873002)(66066001)(4326008)(575784001)(486006)(6512007)(107886003)(2906002)(8676002)(105586002)(72206003)(99286004)(1076002)(6666003)(68736007)(2501003)(7736002)(10290500003)(106356001)(305945005)(14454004)(6116002)(3846002)(5660300001)(36756003)(478600001)(81166006)(6436002)(97736004)(81156014)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xNVpDcVJ6Pqgo+qc429NkqDYjKK4QoySYHpNP2PHmD44QufpouENHlx5vxyfl7o67EwqDZPeFrc4eE6LcG89nMT1Timqq4X5p2KgBjdi0XWSb1zMYLWUzmJ8CQlvNU19/ZaxNWb4UDph4oal1LDVWhjtpdmWCL0ld05PldpfR/E7cNPl7AMgXcmC4sdbgt3vLqRCO+EMSd/aLqckWGWOrLL1dQ3HQbaPSErCcGOy5W2IWgD13sHuUcsTHHV8PE0TIDhakEPbc7SqYBL4bGZ5rOD6fyPufeJ1BQUccf61aaGIkw9FHo2YJ6bWaIevT5LAU5ZSH4tDAF9f/3Y8U4A7Um9rj3DywuBdImm4JQDvTZs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef97966-0053-4129-b24c-08d6145a0590
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:34.9821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
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
index 1570b91bf018..dca82dd6e3bf 100644
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
